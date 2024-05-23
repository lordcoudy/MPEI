rjmp main
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop

main:
	;запись
	ldi R16,0b00100011
	out DDRD,R16			; 1 на выход 

	ldi R16,0b11111111
	out DDRB,R16
	
	LDI R17, 0x32
	OUT PortB, R17
	
	sbi PortD, 4
	cbi PortD, 4
	
	LDI R17, 0b00001111
	OUT PortB, R17
	
	cbi PortD, 5
	cbi PortD, 0
	nop
	nop
	
	sbi PortD, 0
	sbi PortD, 5
	
	;чтение
	ldi R16,0b11111111
	out DDRB,R16
	
	LDI R17, 0x32
	OUT PortB, R17
	
	sbi PortD, 4
	cbi PortD, 4
	
	ldi R16,0b11110000
	out DDRB,R16
	
	LDI R17, 0b00000000
	OUT PortB, R17
	
	
	cbi PortD, 5
	cbi PortD, 1
	nop
	IN R21,PortB
	
	sbi PortD, 1
	sbi PortD, 5
	
end main