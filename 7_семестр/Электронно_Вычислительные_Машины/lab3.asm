; А-08-19 Балашов
; Вариант 4
; Адресное пространство 350h, УДС-1, по прерываниям, 6 сигналов

.model small
.stack 100h

.data
	address dw 350h
	count db 0
	startConst equ  350h
	endConst equ 356h
	state dw 0,0,0,0,0,0

    IRQ9  equ 71h

    offset_interupt equ 100h

.code

start:
	mov ax, @data
	mov ds, ax

    cli

    push es      	
    xor ax, ax
    mov es, ax      

    mov es:[IRQ9], offset_interupt     
    mov es:[IRQ9+2], cs         

    pop es      
	sti

	mov dx, address
	mov al, count
	xor ah, ah
	out dx, ax
	mov si, offset state

	org  offset_interupt
		push ax
		push bx
		push cx
		push dx
		push ds
		push si
		push es
		push di

		mov dx,address

		in ax,dx

		mov [si], ax
		inc si
		inc si

		mov ax, address
		inc ax
		mov address, ax

		xor address, endConst
		jnz writePointer

		mov address, startConst
		mov si, offset state

		writePointer:
			mov dx, address
			mov ax, 0
			out dx, ax

			pop ax
			pop bx
			pop cx
			pop dx
			pop ds
			pop si
			pop es
			pop di

			mov al, 20h
			out 20h, al

		iret

	mov ax, 3100h
	mov dx, 00FFh 
	int 21h

end start