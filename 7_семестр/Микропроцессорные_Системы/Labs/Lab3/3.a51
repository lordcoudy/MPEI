; A-08-19 - Brigada 4 - Pozdniakov Kretov Balashov
dseg at 30h

Counter: DS 2 ; Schetchik PWM
DutyCycle: DS 2 ; Time of Delay of PWM
ImpulseCycle: DS 2 ; Time of Impulse of PWM

cseg at 8000h
jmp start

R_W_mas: DB 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h ; R
G_W_mas: DB 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h ; G
B_W_mas: DB 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h ; B

write_command:				; prinimaet na vhod Acum. 
	call wait_bf			; opros bita zanitosti bf  
	mov r1, A				; save acuma
	ANL A, #0F0h			; and 11110000
	mov P1, A				; janisenie v port pervoi tetradi
	setb P1.0				; E=1
	nop				
	clr P1.0				; E=0
	mov A, r1				; vosstanovlenie acuma
	ANL A, #0Fh				; and 11110000
	SWAP A					; obmen tetradami vnutri akkumulyatora
	mov P1, A				; janisenie v port vtoroi tetradi
	setb P1.0				; E=1
	nop
	clr P1.0				; E=0
	mov P1, #0F0h			; tak nado
	mov r7,#0
	djnz r7,$ 
	ret

write_data:					; zapisi dannykh
	call wait_bf			; opros bita zanitosti bf
	mov r1, A				; save acuma
	ANL A, #0F0h			; and 1111 0000
	ORL A, #02h				; or 0000 0010
	mov P1, A				; janisenie v port pervoi tetradi
	setb P1.0				; E=1
	nop
	clr P1.0				; E=0
	mov A, r1				; vosstanovlenie acuma
	ANL A, #0Fh				; and 0000 1111
	SWAP A					; obmen tetradami vnutri akkumulyatora
	ORL A, #02h				; or 00000001
	mov P1, A				; janisenie v port vtoroi tetradi
	setb P1.0				; E=1
	nop				
	clr P1.0				; E=0
	mov P1, #0f0h			; tak nado
	mov r7,#0
	djnz r7,$ 
	ret

Init:						; Inichializachia
	clr p1.0
	clr p1.1
	clr p1.2
	clr p1.3
	clr p1.4
	clr p1.5
	clr p1.6
	clr p1.7

	mov r7, #0 				; while (r7 != 0) { r7 = 0 }
	djnz r7, $
	
	ret

start:
	call Init

							; PWM Cycle
	mov Counter, #127
	mov DutyCycle, #30

							; Calculate ImpulseCycle
	mov r1, DutyCycle
	mov A, Counter
	subb A, r1
	mov ImpulseCycle, A
	
							; if r7 < DutyCycle then port=1
							; else port=0
	mov r7, DutyCycle 		; i
	cycle1:
	mov p1, #1				; Off LED
	djnz r7, cycle1

	mov r7, ImpulseCycle 	; i
	cycle2:
	mov p1, #0				; On LED
	djnz r7, cycle2

	; Repeat N times

	exit:
	jmp exit
end