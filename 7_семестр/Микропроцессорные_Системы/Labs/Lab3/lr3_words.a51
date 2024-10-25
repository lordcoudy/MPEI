dseg at 30h
;White_i: ds 2 ; Element massiva N1
;Red_i: ds 2 ; Element massiva N2
;Orange_i: ds 2
;Yellow_i: ds 2
;Green_i: ds 2
;Cyan_i: ds 2
;Blue_i: ds 2
;Purple_i: ds 2
;Lilac_i: ds 2
;Pink_i: ds 2

cseg at 8000h
jmp start

white_mas: db 	57h, 68h, 69h, 74h, 65h, 0h
red_mas: db 	52h, 65h, 64h, 0h
orange_mas: db 	4fh, 72h, 61h, 6eh, 67h, 65h, 0h
yellow_mas: db 	59h, 65h, 6ch, 6ch, 6fh, 77h 0h
green_mas: db 	47h, 72h, 65h, 65h, 6eh, 0h
cyan_mas: db 	43h, 79h, 61h, 6eh, 0h
blue_mas: db 	42h, 6ch, 75h, 65h, 0h
purple_mas: db 	50h, 75h, 72h, 70h, 6ch, 65h, 0h
lilac_mas: db 	4ch, 69h, 6ch, 61h, 63h, 0h
pink_mas: db 	50h, 69h, 6eh, 6bh, 0h

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
	; case of color
	mov	dptr, #white_mas ; red_mas, orange_mas, yellow_mas, green_mas, cyan_mas, blue_mas, purple_mas, lilac_mas, pink_mas
	vivod:
		clr	a
		movc	a, @a+dptr
		jz 	exit
		call	write_data
		inc	dptr
		jmp vivod
	
	exit:
	jmp exit
end