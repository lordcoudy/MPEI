; A-08-19 - Brigada 4 - Pozdniakov Kretov Balashov
dseg at 30h

Counter: DS 2
CurrentDutyR : DS 2
CurrentDutyG : DS 2
CurrentDutyB : DS 2
StructsCount EQU 10
StructsI : DS 2

cseg at 8000h
jmp start

; ============ ARRAY ==================
SUPER_MAS: DB 57h, 68h, 69h, 74h, 65h, 0h, 255h, 255h, 255h, 52h, 65h, 64h, 0h, 255h, 0h, 0h, 4fh, 72h, 61h, 6eh, 67h, 65h, 0h, 255h, 128h, 0h, 59h, 65h, 6ch, 6ch, 6fh, 77h, 0h, 255h, 255h, 0h, 47h, 72h, 65h, 65h, 6eh, 0h, 0h, 255h, 0h, 43h, 79h, 61h, 6eh, 0h, 0h, 128h, 128h, 42h, 6ch, 75h, 65h, 0h, 0h, 0h, 255h, 50h, 75h, 72h, 70h, 6ch, 65h, 0h, 128h, 0h, 32h, 4ch, 69h, 6ch, 61h, 63h, 0h, 220h, 208h, 255h, 50h, 69h, 6eh, 6bh, 0h, 255h, 230h, 255h

;white_mas: DB 57h, 68h, 69h, 74h, 65h, 0h
;red_mas: DB 52h, 65h, 64h, 0h
;orange_mas: DB 4fh, 72h, 61h, 6eh, 67h, 65h, 0h
;yellow_mas: DB 59h, 65h, 6ch, 6ch, 6fh, 77h, 0h
;green_mas: DB 47h, 72h, 65h, 65h, 6eh, 0h
;cyan_mas: DB 43h, 79h, 61h, 6eh, 0h
;blue_mas: DB 42h, 6ch, 75h, 65h, 0h
;purple_mas: DB 50h, 75h, 72h, 70h, 6ch, 65h, 0h
;lilac_mas: DB 4ch, 69h, 6ch, 61h, 63h, 0h
;pink_mas: DB 50h, 69h, 6eh, 6bh, 0h

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
	; ========== Reset & Init ==========
	call lcdini
	setb P3.2
	setb P3.3
	setb P3.4
	mov dptr, #SUPER_MAS
	mov StructsI, #StructsCount

	; ========== Iteration of Cycle ==========
	iteration:
	clr A
	movc A, @a+dptr
	mov r3, A
	mov A, StructsI
	jz stop_cycle
	clr A
	mov A, r3
	



	; === Output Text ===
	jz output_complete
	inc dptr
	call write_data
	jmp iteration
	output_complete:

	
	

	; === Load Color ===
	inc dptr
	clr A
	movc A, @a+dptr
	mov CurrentDutyR, A
	inc dptr
	clr A
	movc A, @a+dptr
	mov CurrentDutyG, A
	inc dptr
	clr A
	movc A, @a+dptr
	mov CurrentDutyB, A

	inc dptr

	; === Output Color ===
	loop:
	mov Counter, #255
	mov r7, Counter
	iteration_color:
	mov A, r7
	subb A, CurrentDutyR
	jc OnR
	setb P3.2
	jmp nextG
	OnR:
	clr P3.2
	nextG:
	mov A, r7
	subb A, CurrentDutyG
	jc OnG
	setb P3.3
	jmp nextB
	OnG:
	clr P3.3
	nextB:
	mov A, r7
	subb A, CurrentDutyB
	jc OnB
	setb P3.4
	jmp endd
	OnB:
	clr P3.4
	endd:	
	djnz r7, iteration_color
	djnz r6, loop

	setb P3.2
	setb P3.3
	setb P3.4

	call lcdini

	Dec StructsI
	jmp iteration
	stop_cycle:
	jmp stop_cycle
end