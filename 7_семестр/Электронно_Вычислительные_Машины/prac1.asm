.model small
.stack 100h

.data

PortIn EQU 300h
PortOut EQU 301h

.code

start:
xor ax, ax
xor bx, bx
xor cx, cx
xor dx, dx
mov si, 0

engine_1_on:
mov dx, PortOut
mov ax, 00000010b
out dx, ax
mov dx, PortIn
mov bx, 10100110b;
in ax, dx
cmp al, bl;
je engine_0_on;
jmp engine_1_on;

engine_0_on:
mov dx, PortOut
mov ax, 00000011b
out dx, ax
mov dx, PortIn
mov bx, 10100101b;
in ax, dx
cmp al, bl;
je engine_2_on;
jmp engine_0_on;

engine_2_on:
mov dx, PortOut
mov ax, 00000111b
out dx, ax
mov dx, PortIn
mov bx, 10010101b
in ax, dx
cmp al, bl;
je engine_3_on;
jmp engine_2_on;

engine_3_on:
mov dx, PortOut
mov ax, 00000011b
out dx, ax
mov dx, PortIn
mov bx, 10100101b
in ax, dx
cmp al, bl;
je engine_3_off;
jmp engine_3_on;

engine_3_off:
mov dx, PortOut
mov ax, 00001011b
out dx, ax
mov dx, PortIn
mov bx, 01100101b
in ax, dx
cmp al, bl;
je engine_2_off;
jmp engine_3_off;

engine_2_off:
mov dx, PortOut
mov ax, 00000011b
out dx, ax
mov dx, PortIn
mov bx, 10100101b
in ax, dx
cmp al, bl;
je engine_0_off;
jmp engine_2_off;

engine_0_off:
mov dx, PortOut
mov ax, 00000010b
out dx, ax
mov dx, PortIn
mov bx, 10100110b
in ax, dx
cmp al, bl;
je engine_1_off;
jmp engine_0_off;

engine_1_off:
mov dx, PortOut
mov ax, 0h
out dx, ax
mov dx, PortIn
mov bx, 10101010b
in ax, dx
cmp al, bl;
je engine_1_on;
jmp engine_1_off;
end start