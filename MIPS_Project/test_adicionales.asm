; AUTORAS: Carlota Moncasi Gosá (839841)
;		   E. Lilai Naranjo Ventura (840091)

;  Memoria Datos: [256, 1, 8, 0, 0, 0, 0, 0, 0…]

ini: LW R1, 0(R0)		; R1 = Mem(0) = 256		; @0x0	; 08010000
	 ADD R2, R2, R1		; R2 = 0+256 = 256		; @0x4	; 04221000
	 BEQ R2, R3, ini	; no se salta			; @0x8	; 10430000
	 LW R3, 4(R0)		; R3 = Mem(4) = 1		; @0xC	; 08030004
	 SW R2, 7(R3)		; Mem(8) = 256			; @0x10 ; 0C620007
	 ADD R3, R1, R3		; R3 = 256+1 = 257		; @0x14 ; 04231800
	 SUB R1, R3, R3		; R1 = 0				; @0x18 ; 04630801


; F D E M W
;   F D D E M W
;       F D D D E M W
;  			  F D E M W
; 			    F D D E M W
; 				    F D E M W
; 					  F D E M W
; 					    F D E M W