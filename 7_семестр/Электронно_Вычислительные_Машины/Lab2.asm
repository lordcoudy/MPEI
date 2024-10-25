.model small
.stack 100h
.data
my_mem DB 0
IRQ7 EQU 0Fh  						; ������ ������� ������������� ����������� 
									; ������ �������� � ������� ����������
									; �������� �����������
offset_interupt EQU 100h

.code
start:
	mov ax, @data
	mov ds, ax 
	cli								; ��������� ����������
									; ���������� � ������ �������� ����������
	push es      					; ��������� es
	xor ax, ax
	mov es, ax      				; �������� es

	mov es:[IRQ7], offset_interupt	; ������� �������� ����������� ����������
	mov es:[IRQ7+2], cs         	; ������� ���������� ����� ������ 

	pop es      					; ��������������� es
	sti

	mov dx, 37Ah
	in ax, dx
	and ax, 00010000b				; ���������� ���.
	out dx, ax

org  offset_interupt				; ��������� ��������� �������� ������������ ������ ����������
	
	mov dx,37AH						; � �������� ����������
	in ax, dx
	and ax,00011000b				; ���������� ���� RQ � SLCT (������� �����)
	out dx,ax						; �������������� �������
	
	mov dx,379H						; �� �������� ���������
	in ax,dx 						; ��������� ������� ����� � ��
	and ax,01111000b 				; ����, ����� ������ 4 ������ ���� � �������� �������������� 
	mov bx,ax						; ����������� � bx
	shl bx,1						; �������� � ������� 4 ����
	
	mov dx,37AH						; � �������� ����������
	in ax, dx
	xor ax, 00001000b   			; ���������� SLCT � 0
	out dx,ax						; �������������� �������
	
	mov dx,379H						; �� �������� ���������
	in ax,dx 						; ��������� ������� ����� � ��
	and ax,01111000b 				; ����, ����� ������ 4 ������ ���� � �������� ��������������
	shr ax, 3 						; ����� 4 ������� ���� �� 379h ������������� � 4 ������� ���� � ��
	or ax,bx            			; �������� 8 ��� - ��������� �������� ������������
	
	; 5 ���������� ��������� �������� ������������ �������� �����������:
	test al, 01010101b 	; � ���� 0
	jz tact0
	test al, 01011001b	; � ���� 1, 7
	jz tact1
	test al, 01011010b	; � ���� 2, 4, 6
	jz tact2
	test al, 01101010b	; � ���� 3
	jz farjmp1
	test al, 10100101b	; � ���� 5
	jz farjmp2

	farjmp1:
	jmp tact3
	
	farjmp2:
	jmp tact6

tact0:								; ��� ������ �������� � tact 0
	mov dx, 378h					; 378h - ������� ������ 
	in ax, dx						; ��������� ��������� ������ � ��
	or ax, 00000010b				; �������� ������������ ��������� �� ����������� tact0
	out dx, ax						; �������������� ������� ������
	
	mov dx, 37Ah					; 37Ah - ������� ����������
	in ax, dx
	and ax, 00010001b				; ���������� ������, ������������ ������� IRQ (4�� ���) � STROBE (0�� ���)
	out dx, ax						; �������������� ������� ����������
	jmp exit
	
tact1:
	mov al, my_mem			
	and al, 00000010b				; ��������, ���� �� �� ��� � ���� �����
	test al,11111101b
	jz tact7						; ���� ����, ������ ��������� �� ������ ������������� ��������� ��������� ������������

	mov dx, 378h					; 378h - ������� ������ 
	in ax, dx
	or ax, 00000011b				; ��������� �� ����������� tact1
	out dx, ax
	
	mov dx, 37Ah					; 37Ah - ������� ����������
	in ax, dx
	and ax, 00010001b				; ������ IRQ (4�� ���) � STROBE (0�� ���)
	out dx, ax
	or my_mem,00000010b				; ��������� ��������������� ��� �����
	jmp exit						; ������������� ��������� ��������� ������������

tact7:
	mov dx, 378h					; 378h - ������� ������ 
	in ax, dx
	and ax, 00000000b				; ������������ � ��������� ���������
	out dx, ax
	
	mov dx, 37Ah					; 37Ah - ������� ����������
	in ax, dx
	and ax, 00010001b				; ������ IRQ (4�� ���) � STROBE (0�� ���)
	out dx, ax
	and my_mem, 00000000b			; ���������� ����
	jmp exit

tact2:	
	mov al, my_mem			
	and al, 00000100b				; ��������, ���� �� �� ��� � ���� �����
	test al,11111011b
	jz tact4

	mov dx, 378h					; 378h - ������� ������ 
	in ax, dx
	or ax, 00000111b				; ��������� �� ����������� tact2
	out dx, ax
	
	mov dx, 37Ah					; 37Ah - ������� ����������
	in ax, dx
	and ax, 00010001b				; ������ IRQ (4�� ���) � STROBE (0�� ���)
	out dx, ax
	or my_mem,00000100b				; ��������� ��������������� ��� �����
	jmp exit

tact3:
	mov dx, 378h					; 378h - ������� ������ 
	in ax, dx
	or ax, 00000011b				; ��������� �� ����������� tact3
	out dx, ax
	
	mov dx, 37Ah					; 37Ah - ������� ����������
	in ax, dx
	and ax, 00010001b				; ������ IRQ (4�� ���) � STROBE (0�� ���)
	out dx, ax
	jmp exit

tact4:
	mov al,my_mem
	and al, 00100100b				; ��������, ���� �� �� ��� � ���� �����
	test al,11011011b
	jz tact5

	mov dx, 378h					; 378h - ������� ������ 
	in ax, dx
	and ax, 00001011b				; ��������� �� ����������� tact4
	out dx, ax
	
	mov dx, 37Ah					; 37Ah - ������� ����������
	in ax, dx
	and ax, 00010001b				; ������ IRQ (4�� ���) � STROBE (0�� ���)
	out dx, ax
	or my_mem,00100100b				; ��������� ��������������� ��� �����
	jmp exit

tact5:
	mov dx, 378h					; 378h - ������� ������ 
	in ax, dx
	and ax, 00000011b				; ��������� �� ����������� tact5
	out dx, ax						; �������� �� tact2
	
	mov dx, 37Ah					; 37Ah - ������� ����������
	in ax, dx
	and ax, 00010001b				; ������ IRQ (4�� ���) � STROBE (0�� ���)
	out dx, ax
	jmp exit

tact6:
	mov dx, 378h					; 378h - ������� ������ 
	in ax, dx
	and ax, 00000010b				; ��������� �� ����������� tact6
	out dx, ax
	
	mov dx, 37Ah					; 37Ah - ������� ����������
	in ax, dx
	and ax, 00010001b				; ������ IRQ (4�� ���) � STROBE (0�� ���)
	out dx, ax
	jmp exit


exit:
mov al, 20h
out 20h, al
iret								; iret - ������� �� ����������
end