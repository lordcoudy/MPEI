; Var 4, Balashov A-08-19
; Q2i = N5i/4 - N6i
; For(int i = 0; i <=10; ++i); N5, N6 = [-2000; 2000]; K - rand

; Data segment
N equ 10
K equ 5	
cmpMask equ 10000000b				; Mask for negatives
	dseg at 30h					
	vecN5: 	ds 	N*2 			
	vecN6: 	ds 	N*2 			
xseg
	result:	ds 	2				

; Code segment
; r0 - address, r2 - cx, r4 - high, r5 - low, r7 - sign, r1, r3, r6
cseg

jmp start
	org 0100h					
	start:						
		call 	NMem				; Put numbers to memory
									; Prepare to summ all the N5 and N6
		mov 	r2, #N*2			; Cycle (CX in 8086) = 10
		mov 	r0, #vecN5			; Get vecN5 adress to start
		clr 	a	
		clr 	c	
		mov 	r1, #0		
		mov 	r3, #0
		mov  	r4, #0
		mov 	r5, #0
		mov  	r6, #0
		mov 	r4, #0 				; High part
		mov		r7, #0
	
	sumN5:							; Loop for N5			
		mov 	a, r4				; High sum
		add 	a, @r0				; r0h + ah
		mov 	r4, a				; Save
		
		inc 	r0					; Go to r0l
		
		mov 	a, r5				; Low summ
		add 	a, @r0				; r0l + al
		mov 	r5, a
		jnc 	carryPoint5			; carry == 1 : inc sum ? carryPoint

		inc 	r4
		
	carryPoint5:					
		
		dec 	r2					; cx--
		inc 	r0					; r0h next
	djnz 		r2, sumN5			; cx != 0 : sumN5 ? skip


	mov 	r2, #N*2				; 10 numbers to add
	mov		a, r4
	mov 	r3, #0					; 0 if positive
	anl		a, #cmpMask
	jz 		sumN6
	mov 	r3, #11111111b			; 1 if negative

	sumN6:							; Loop for N6	
		mov		r7, #0
		inc		r0

		mov 	a, r5				; Low summ
		add 	a, @r0				; r0l + al
		mov 	r5, a				; Save
		clr 	a
		addc	a, #0
		mov		r7, a
		
		dec 	r0					; Go to r0h
		
		mov 	a, r4				; High summ
		add 	a, r7	
		mov		r7, #0				
		jnc		carryPoint6
		mov		r7, #1
	
	carryPoint6:
		add 	a, @r0				; r0h + ah
		mov 	r4, a

		mov		a, r7
		addc	a, #0
		mov		r7, a

		mov		a, @r0
		anl		a, #cmpMask
		jz		negPoint
		mov		a, r3
		add		a, #11111111b
		mov		r3, a
		
	negPoint:
		mov		a, r3
		add		a, r7
		mov		r3, a

		dec 	r2					; cx--
		inc 	r0					; r0h next
		inc 	r0
	djnz 	r2, sumN6				; cx != 0 : sumN5 ? skip
	; Conversion
		mov 	r7, #0			
		mov 	a, r4				; High summ
		anl 	a, #cmpMask			; Check for '1' in highest bit
		jz 		PrepareDiv			
									
		call	convertToAdd
		mov 	r7, #10000000b				

	PrepareDiv:
		clr 	a					
		mov 	r2, #0				; High
		mov 	r1, #0				; Low
		
	divide:
		clr 	c					
		
		mov 	a, r5				; al
		subb 	a, #N				; al - N
		mov 	r5, a				; Save
		
		mov 	a, r4				; ah
		subb 	a, #0				; For carry
		mov 	r4, a				; Save
		
		anl 	a, #cmpMask			; Check if negative
		jnz 	LeaveDivision			
									
		mov		a, r2				; al + 1
		add		a, #1
		mov		r2, a
		mov 	a, r1				
		addc 	a, #0				; High + C
		mov 	r1, a
		jmp 	divide				
	
	LeaveDivision:					
		mov  	a, r2
		mov 	r5, a
		mov 	a, r1
		mov 	r4, a
		mov		a, r7				; '-' to a
		anl 	a, #10000000b			

		jz 		AddK				; a == 0000 0001 : skip ? convert
		call 	convertToAdd

		mov  	a, r5
		mov 	r2, a
		mov 	a, r4
		mov 	r1, a		
		
	AddK:							
		mov 	a, r2				; al
		add 	a, #K				; al + K
		mov 	r2, a				; Save
		mov 	a, r1				; ah
		addc 	a, #0				; ah + C
		mov 	r1, a				; Save
	
		; Final save
		mov 	dptr, #result		; Get address
		;mov 	a, r7				; '+/-'
		;movx 	@dptr,a 			; Save to mem
		;inc 	dptr				; Next cell
		mov 	a, r1				; ah
		movx 	@dptr,a 			; Save to mem
		inc 	dptr				; Next cell
		mov 	a, r2				; al
		movx 	@dptr,a 			; Save to mem
	
	nop								; As in example

; Const

	N5: dw -1,-2,-3,-4,-6,5,-2000,-2000,0,1	
				
	N6: dw 1,0,0,0,0,0,0,0,0,2000 						

; Procedures
	; NMem - save N5 or N6 to memory
	; Changes r0, r2, dptr
	NMem:					
		mov 	r0, #vecN5 			; Memory address
		mov 	r2, #N*2			; CX
		mov 	dptr, #N5			; Set pointer to start
		mov 	r1, #0		
		mov 	r3, #0
		mov  	r4, #0
		mov 	r5, #0
		mov  	r6, #0
		mov	r7, #0
		N5Loop:
			clr 	a
			clr  	c
			movc 	a, @a+dptr

			; Сначала проверить знак
			; Поместить его в кэрри
			; Прибавить 3 с переносом, если -1, -2, -3
			; Сдвиг обеих ячеек
			; Сдвиг обеих ячеек

			; save high part to r3
			mov r3, a

			inc 	dptr
			inc		r0

			; save low part to r7
			clr		a
			movc	a, @a+dptr
			mov r7, a

			mov a, r3

			mov c, acc.7 			; Carry = 1 if negative
			jnc positive
			; check if -1 | -2 | -3
			; mov a, r7
			; subb a, #255
			; jz add3

			; mov a, r7
			; subb a, #254
			; jz add3

			; mov a, r7
			; subb a, #253
			; jz add3

			; ; skip addition if false
			; jmp division4

			; add 3
			add3:
			clr c

			mov a, r7
			add a, #3
			mov r7, a

			mov a, r3
			addc a, #0
			mov r3, a

			division4:
			; !!!!!!!!!!!!!
			clr c
			
			mov a, r3
			mov c, acc.7
			rrc 	a
			mov r3, a

			mov a, r7
			rrc 	a
			mov r7, a

			mov a, r3
			mov c, acc.7
			rrc 	a
			mov r3, a

			mov a, r7
			rrc 	a
			mov r7, a

			jmp save


			positive:
			mov a, r3
			rrc 	a
			mov r3, a

			mov a, r7
			rrc 	a
			mov r7, a

			clr c
			
			mov a, r3
			rrc 	a
			mov r3, a

			mov a, r7
			rrc 	a
			mov r7, a

			save:
			dec		r0
			mov		a, r3
			mov		@r0, a

			inc 	r0
			mov		a, r7
			mov		@r0, a

			inc		dptr
			inc		r0

			djnz 	r2, N5Loop
			mov 	r0, #vecN6 		
			mov 	r2, #N*2	
			mov 	dptr, #N6

		N6Loop:
			clr 	a	
			clr 	c			
			movc 	a, @a+dptr			; Get 1 bite
		
			; Save
			mov 	r4, a 			; High part
			inc 	dptr
			inc		r0

			clr		a
			movc	a, @a+dptr
			
			; Save
			mov		r5, a 			; Low part

			call	convertToAdd
			; Final save
			dec		r0
			mov		a, r4
			mov		@r0, a

			inc 	r0
			mov		a, r5
			mov		@r0, a

			inc		dptr
			inc		r0			
			djnz 	r2, N6Loop			; cx == 0 : skip ? repeat
									
	ret								; Return from procedure
	
	
	; Convert to additional code
	; Change r4, r5
	; Result = r4:r5
	convertToAdd:				
		mov 	a, r5				; al
		cpl 	a					; Invert
		clr 	c					
		add 	a, #1				; al + 1 (w/ carry)
		mov 	r5, a				; Save
		
		mov 	a, r4				; ah
		cpl 	a					; Invert
		addc 	a, #0				; +C
		mov 	r4, a				; Save
	ret								; Return from procedure
	
end
			