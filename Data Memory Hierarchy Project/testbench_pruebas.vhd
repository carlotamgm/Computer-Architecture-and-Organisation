-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY testbench_pruebas IS
  END testbench_pruebas;

  ARCHITECTURE behavior OF testbench_pruebas IS 

  -- Component Declaration
	COMPONENT MIPs_segmentado is
		Port ( 	
			clk : in  STD_LOGIC;
           	reset : in  STD_LOGIC;
           	IRQ	: 	in  STD_LOGIC; 
           	IO_input: in STD_LOGIC_VECTOR (31 downto 0); -- 32 bits de entrada para el MIPS para IO
	   		IO_output : out  STD_LOGIC_VECTOR (31 downto 0)); -- 32 bits de salida para el MIPS para IO
	END COMPONENT;

          SIGNAL clk, reset, IRQ :  std_logic;
          SIGNAL IO_output,IO_input  :  std_logic_vector(31 downto 0);
          
  -- Clock period definitions
   constant CLK_period : time := 10 ns;
  BEGIN

  -- Component Instantiation
   uut: MIPs_segmentado PORT MAP(clk => clk, reset => reset, IRQ => IRQ, IO_input => IO_input, IO_output => IO_output);

-- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;

 stim_proc: process
   begin		
      	IRQ <= '0';
   		IO_input <= x"00000000";
   		reset <= '1';
    	wait for CLK_period*2;
		reset <= '0';
		wait;
   end process;

  END;
