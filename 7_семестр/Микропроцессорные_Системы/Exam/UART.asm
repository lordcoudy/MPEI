rjmp main
nop
nop
nop
nop
nop
nop
rjmp read_end
nop
nop
nop

main:
	ldi R20, 0x60+32
	out SPL,R20
	
	ldi R16,0b00000010
	out DDRD,R16		; TXD на выход
	out PortD,R16		; RXD на вход
	
	ldi R16,1
	out UBRR,R16
	
	ldi R16,0b11011000
	out UCR,R16
	
	bset 7
loop:
	rjmp loop
	
read_end:
	in R16, UDR
	Neg R16
	out UDR, R16
reti