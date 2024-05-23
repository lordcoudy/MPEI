dseg at 30h
N1i: ds 2 ; Element massiva N1
N2i: ds 2 ; Element massiva N2

cseg at 8000h
jmp start

N1_mas: db 	43h, 0B8h, 0B2h, 2Ch, 20h, 0A1h, 61h, 0B9h, 2Ch, 20h, 42h, 6Fh, 0BBh, 0h
N2_mas: db 	41h, 2Dh, 31h, 32h, 2Dh, 31h, 38h, 0h

wait_bf:                    ; opros bita zanitosti bf               
	push acc                ; sochranili accum
wait_ll:
	mov p1,#11110100b 	    ; C/D=0, R/W=1,E=0  
	setb p1.0               ; E=1
	mov a,p1                ; chteniye starshey tetrady registra IR
	clr p1.0                ; E=0
	mov b,a         	    ; buferisuem starshey tetrady
 	setb p1.0				; E=1
	mov a,p1        	    ; chteniye mladshey tetrady
	clr p1.0		        ; E=0
	mov a,b                 ; buferisuem mladshuu tetrady
	jb acc.7,wait_ll		; proverka bita zanyatosti BF
	pop acc
	ret

write_command:				; prinimaet na vhod Acum. 
	call wait_bf			; opros bita zanitosti bf  
	mov r1, A				; save acuma
	ANL A, #0F0h			; and 11110000
	mov P1, A				; janisenie v port pervoi tetradi
	setb P1.0				; E=1
	nop				
	clr P1.0				; E=0
	mov A, r1				; vosstanovlenie acuma
	ANL A, #0Fh				; and 00001111
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

lcdini:						; inichializachia
	clr p1.0
	mov r7,#0
	djnz r7,$
	mov	A, #28h				; 0010 1000 
							; razryadnost' vkhoda bufera dannykh. 0 – 4 razryada
							; dve stroki
							; razmer matritsy simvolov: 0 – 5 kh 8 tochek
	call	write_command
	mov r7,#0
	djnz r7,$
	mov a,#18h
	call	write_command	
	mov	A, #0eh				; 0000 1110
							; Vybor rezhima otobrazheniya
							; otobrazheniye simvolov vklyucheno
							; kursor otobrazhayetsya v vide chertochki
							; kursor ne viden
	call	write_command	
	mov	A, #06h				; 0000 0110
							; Zadayetsya napravleniye sdviga kursora ili simvolov (ekrana)
							; I\D=1 – sdvig ekrana vlevo
	call	write_command
	mov a,#02h
	call	write_command
	mov a,#1h
	call	write_command	
	ret

start:
	call	lcdini
	mov	dptr, #N1_mas
	vivodN1i:
		clr	a
		movc	a, @a+dptr
		jz 	exit1
		call	write_data
		inc	dptr
		jmp vivodN1i
	exit1:
	mov a, #0c0h						
	call write_command
	mov	dptr, #N2_mas
	vivodN2i:
		clr	a
		movc	a, @a+dptr
		jz 	exit
		call	write_data
		inc	dptr
		jmp vivodN2i
	exit:
	jmp exit
end