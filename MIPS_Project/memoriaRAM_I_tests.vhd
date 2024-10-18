----------------------------------------------------------------------------------
-- Module Name:    memoriaRAM_I - Behavioral 
-- Authors:		Carlota Moncasi Gos� (839841)
-- 				E. Lilai Naranjo Ventura (840091)
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memoriaRAM_I is port (
		  	CLK : in std_logic;
		  	ADDR : in std_logic_vector (31 downto 0); --Dir 
        	Din : in std_logic_vector (31 downto 0);--entrada de datos para el puerto de escritura
        	WE : in std_logic;		-- write enable	
		  	RE : in std_logic;		-- read enable		  
		  	Dout : out std_logic_vector (31 downto 0));
end memoriaRAM_I;

--************************************************************************************************************
-- Fichero con la memoria de instrucciones cargada con diversos test
--************************************************************************************************************

architecture Behavioral of memoriaRAM_I is
type RamType is array(0 to 127) of std_logic_vector(31 downto 0);
--------------------------------------------------------------------------------------------------------------------------------
-- BANCO DE PRUEBAS ADICIONAL:
-- El c�digo se encuentra en test_adicionales.asm
--------------------------------------------------------------------------------------------------------------------------------
signal RAM : RamType := (  		X"08010000", X"04221000", X"10430000", X"08030004", X"0C620007", X"04231800", X"04630801", X"00000000", --word 0,1,...
 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 8,9,...
 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 16,...
 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 24,...
 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 32,...
 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 40,...
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 48,...
 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 56,...
 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 64,...
 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",--word 72,...
 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 80,...
 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 88,...
 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 96,...
 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 104,...
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 112,...
 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000");--word 120,...
 									
--------------------------------------------------------------------------------------------------------------------------------
-- Instruction Memory Map
-- From Word 0 to 3: Exception Vector Table: (@ of the exception routines)
-- 		@0: reset
-- 		@4: IRQ
-- 		@8: Data Abort
-- 		@C: UNDEF
-- From Word 4  (@010): .CODE (code of the application to execute)
-- From Word 64 (@100): RTI (code for the IRQ)
-- From Word 96 (@180): Data abort (code for the Data Abort exception)
-- From Word 112(@1C0): UNDEF (code for the UNDEF exception)
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
-- BANCO DE PRUEBAS PARA EL PROCESADOR BASE: 
-- Incluye nops para eliminar los riesgos de datos y control 
-- El c�digo se describe en Codigo_retardado
--------------------------------------------------------------------------------------------------------------------------------
-- signal RAM : RamType := (  		X"10210003", X"00000000", X"00000000", X"00000000", X"081F0000", X"08010000", X"08020004", X"00000000", --word 0,1,...
-- 									X"00000000", X"04221800", X"00000000", X"00000000", X"0C030008", X"1000FFFF", X"00000000", X"00000000", --word 8,9,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 16,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 24,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 32,...
--									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 40,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 48,...
--									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 56,...
--									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 64,...
--									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",--word 72,...
--									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 80,...
--									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 88,...
--									X"1000FFFF", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 96,...
--									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 104,...
--									X"1000FFFF", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 112,...
--									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000");--word 120,...										
														
--------------------------------------------------------------------------------------------------------------------------------
-- BANCO DE PRUEBAS PARA LAS INT
-- C�digo descrito en Codigo_test_IRQ
--------------------------------------------------------------------------------------------------------------------------------
-- signal RAM : RamType := (  		X"10210003", X"1021003E", X"1021005D", X"1021006C", X"081F0000", X"08010004", X"83E00000", X"04210800", --word 0,1,...
-- 									X"1021FFFE", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 8,9,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 16,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 24,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 32,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 40,...
--									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 48,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 56,...
-- 									X"0FE10000", X"0FE20004", X"08010008", X"07E1F800", X"0802000C", X"08010004", X"04221000", X"80400000", --word 64,...
-- 									X"0C02000C", X"08010008", X"07E1F801", X"0BE10000", X"0BE20004", X"20000000", X"00000000", X"00000000",--word 72,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 80,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 88,...
-- 									X"1000FFFF", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 96,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 104,...
--									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 112,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000");--word 120,...
 																	
--------------------------------------------------------------------------------------------------------------------------------
-- BANCO DE PRUEBAS PARA EL DATA ABORT: 
-- Acceso a memoria no alineado: 08010003 = LW R1, 3(R0)
-- Produce un abort y saltamos a la palabra 96 que contiene un bucle infinito: 1000FFFF = BEQ r0,r0,-1
--------------------------------------------------------------------------------------------------------------------------------
-- signal RAM : RamType := (  			X"10210003", X"1021003E", X"1021005D", X"1021006C", X"08010003", X"00000000", X"00000000", X"00000000", --word 0,1,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 8,9,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 16,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 24,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 32,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 40,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 48,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 56,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 64,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",--word 72,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 80,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 88,...
-- 									X"1000FFFF", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 96,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 104,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 112,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000");--word 120,...					
							
--------------------------------------------------------------------------------------------------------------------------------
-- BANCO DE PRUEBAS PARA EL DATA ABORT: 
-- Acceso a direcci�n fuera de rango: 08017ffC = LW R1, 32767(R0)
-- Produce un abort y saltamos a la palabra 96 que contiene un bucle infinito: 1000FFFF = BEQ r0,r0,-1
--------------------------------------------------------------------------------------------------------------------------------
-- signal RAM : RamType := (  		X"10210003", X"1021003E", X"1021005D", X"1021006C", X"08017ffC", X"00000000", X"00000000", X"00000000", --word 0,1,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 8,9,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 16,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 24,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 32,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 40,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 48,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 56,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 64,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",--word 72,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 80,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 88,...
-- 									X"1000FFFF", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 96,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 104,...
-- 									X"1000FFFF", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 112,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000");--word 120,...	

--------------------------------------------------------------------------------------------------------------------------------
-- BANCO DE PRUEBAS PARA EL UNDEF: 
-- Instrucci�n con c�digo err�neo: FFFFFFFF = �?
-- Produce un UNDEF y saltamos a la palabra 112 que contiene un bucle infinito: 1000FFFF = BEQ r0,r0,-1
--------------------------------------------------------------------------------------------------------------------------------
-- signal RAM : RamType := (  		X"10210003", X"1021003E", X"1021005D", X"1021006C", X"FFFFFFFF", X"00000000", X"00000000", X"00000000", --word 0,1,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 8,9,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 16,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 24,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 32,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 40,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 48,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 56,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 64,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",--word 72,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 80,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 88,...
-- 									X"1000FFFF", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 96,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 104,...
-- 									X"1000FFFF", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --word 112,...
-- 									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000");--word 120,...										
-- 																										
signal dir_7:  std_logic_vector(6 downto 0); 
begin
 
 dir_7 <= ADDR(8 downto 2); -- como la memoria es de 128 plalabras no usamos la direcci�n completa sino s�lo 7 bits. Como se direccionan los bytes, pero damos palabras no usamos los 2 bits menos significativos
 process (CLK)
    begin
        if (CLK'event and CLK = '1') then
            if (WE = '1') then -- s�lo se escribe si WE vale 1
                RAM(conv_integer(dir_7)) <= Din;
            end if;
        end if;
    end process;

    Dout <= RAM(conv_integer(dir_7)) when (RE='1') else "00000000000000000000000000000000"; --s�lo se lee si RE vale 1

end Behavioral;


