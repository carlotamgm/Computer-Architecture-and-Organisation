; AUTORAS: Carlota Moncasi Gosá (839841)
;		   E. Lilai Naranjo Ventura (840091)

; PRIMER PROGRAMA DE PRUEBA: suma de los componentes de un vector
		beq r1, r1, ini													; 0x0	; 10210003
		beq r2, r2, halt												; 0x4	; 10420017
		beq r2, r2, halt												; 0x8	; 10420016
		beq r2, r2, halt												; 0xC	; 10420015
ini: 	lw r1, 144(r0)		; r1 = 8 = total iteraciones				; 0x10	; 08010090
		lw r2, 160(r0)		; r2 = 0 = resul acumulado					; 0x14	; 080200A0
		lw r3, 176(r0)		; r3 = 1 = sumar iteraciones				; 0x18	; 080300B0
		lw r4, 192(r0)		; r4 = 4 = sumar posiciones en memoria		; 0x1C	; 080400C0
		lw r5, 160(r0)		; r5 = 0 = posicion en memoria				; 0x20	; 080500A0
		lw r7, 160(r0)		; r7 = 0 = num iteraciones					; 0x24	; 080700A0
buc:	beq r1, r7, fin													; 0x28	; 10270005
		lw r6, r5			; dato										; 0x2C	; 08A60000
		add r2, r2, r6		; acumular resultado						; 0x30	; 04C21000
		add r7, r7, r3		; pasar de iteracion						; 0x34	; 04673800
		add r5, r5, r4		; pasar de posicion en memoria				; 0x38	; 04852800
		beq r0, r0, buc													; 0x40	; 1000FFFA
fin: 	sw r2, 128(r0)		; guardamos resultado						; 0x44	; 0C020080

; pruebas Scratch
		lw r4, 240(r0)		; r4 = 268435460 = Scratch(1)				; 0x48	; 080400F0
		lw r1, r4			; r1 = b									; 0x4C	; 08810000
		add r2, r1, r3		; r2 = b + 1 = c							; 0x50	; 04231000
		lw r3, 256(r0)		; r3 = 268435464 = Scratch(2)				; 0x54	; 08030100
		sw r2, r3														; 0x58	; 0C620000
		
; pruebas dir no alineada y registro interno
		lw r0, 5(r0)		; dir no alineada => error					; 0x5C	; 08000005
		lw r2, 224(r0)		; r2 = 268435456 = Scratch(0)				; 0x60	; 080200E0
		lw r1, r2			; leemos registro interno					; 0x64	; 08410000

halt: 	beq r0, r0, halt												; 0x68	; 1000FFFF
		
; MD(0) = 0
; MD(1) = 1
; MD(2) = 2
; MD(3) = 3
; MD(4) = 4
; MD(5) = 5
; MD(6) = 6
; MD(7) = 7
; MD(32) = resultado
; MD(36) = 8 = num sumas
; MD(40) = 0
; MD(44) = 1
; MD(48) = 4
; MD(52) = dir error
; MD(56) = 268435456 = Scratch(0)
; MD(60) = 268435460 = Scratch(1)
; MD(64) = 268435464 = Scratch(2)

; Scratch(4) = b
; Scratch(8) = resul suma

; SEGUNDO PROGRAMA DE PRUEBA: gestión de un load-uso
Reset: 		beq R1, R1, INI		; 0x0		; 10210001
IRQ: 		beq R1,R1, RTI_IRQ	; 0x4		; 10210004
INI:		lw R31, 0(r0) 		; 0x8		; 081F0000
Main: 		lw r1, 4(r0)		; 0xC		; 08010004
			add r2, r1, r2		; 0x10		; 04212000
			lw r3, 8(r0)		; 0x14		; 08030008
RTI_IRQ: 	rte					; 0x18		; 20000000

