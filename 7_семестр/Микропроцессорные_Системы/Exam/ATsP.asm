rjmp main
rjmp ADC_ready
nop
nop
nop
nop
rjmp timer_0
nop
nop
nop
nop

main:
	ldi R20, 0x80
	out SPL,R20

	ldi R16,0b00110011
	out DDRD,R16			; 1 на выход 
	ldi R16,0b00100011
	out PortD,R16

	in R20, TIMSK		; регистр отвечающий за таймер
	ori R20, 2			; установили бит 1 в 1 (разрешаем прерывания таймера 0 по переполнению)
	out TIMSK, R20		; отправили назад
	
	in R20, GIMSK		; читаем GIMSK, чтобы изменив нужное записать обратно
	ori R20, 64			; установили бит 6 (разрешаем прерывания по INT0)
	out GIMSK, R20		; отправили назад
	
	; выбираем тип активного сигнала на линии INT0 – фронт
	in R20, MCUCR		; читаем MCUCR
	ori R20, 3			; установили два мл. бита
	out MCUCR, R20		; отправили назад

	; Устанавливаем делитель таймера 0, запуская счет
	ldi R20, 5			; установили биты CS02, CS01, CS00 – коэф. деления 1024
	out TCCR0, R20

	bset 7				; SREG.7=1 – разрешить IRQ (аналог sei)
	
Loop:
	rjmp loop
	
ADC_ready:
	cbi PortD, 5
	nop
	
	cbi PortD, 0
	IN R21, PortB
	sbi PortD, 0
	
	cbi PortD, 1
	IN R22, PortB
	sbi PortD, 1
	
	sbi PortD, 5
reti

timer_0:
	sbi PortD, 4
	nop
	cbi PortD, 4
reti