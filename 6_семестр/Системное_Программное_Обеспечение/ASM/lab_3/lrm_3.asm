; А-08-19, Балашов
; Вариант 4
; Прерывание 78h
; Таймер 200h
; Клавиатура 180h 

.model small
.stack 100h

; Сегмент данных
.data
	sym	db	?
	In_A0	equ	20h		  		; Порт обращения к контроллеру прерываний (А0=0)
	In_A1	equ	21h				; Порт обращения к контроллеру прерываний (А0=1)
	; D7-D5 = 000 (80/85 only), D4 = 1 ключ формата, D3 = 0 (LTIM Edge triggered mode фронт), D2 = 0 (ADI interval of 8), D1 = 0 (SNGL cascade mode), D0 = 1 (IC4 ICW4 needed)
	ICW1	equ	00010001b		; первая команда инициализации контроллера
	; D7 - T7 of interrupt vector address (iva), D6-D3 - T6-T3 of iva, D2-D0 - 80/85 only | D0:78h - D7:07Dh
	ICW2_S	equ	78h 	  		; вторая команда инициализации контроллера (вектор смещения в таблице прерываний)
	ICW2_E	equ	8h 		  		; вектор смещения по умолчанию
	; 1 - has a slave, 0 does not has a slave
	ICW3	equ	00000100b		; третья команда инициализации контроллера (ко 2-му входу подключен ведомый)
	; D7-D5 = 0, D4 = 0 (!SFNM - not special fully nested mode), D3 = 0 (!BUF - non buffered mode), D2 = x (depends on D3), D1 = 0 (AEOI, 0 - normal EOI (END OF INTERRUPT)), D0 = 1 (1 - 8086 mode)
	ICW4	equ	00000001b 		; последняя команда инициализации
	
	;Смещения обработчиков
	timer_offset equ 200h  		; Для таймера
	keyboard_offset equ 180h  	; Для клавиатуры

; Сегмент кода
.code 
;Начальная инициализация
start:
	mov	ax, @data				
	mov	ds, ax

	cli							; clear interruptions flag

;Инициализация I8259A
	mov	al, ICW1
	out	In_A0, al				; Загрузка первого управляющего слова
	mov	al, ICW2_S	
	out	In_A1, al				; Загрузка второго управляющего слова
	mov	al, ICW3	
	out	In_A1, al				; Загрузка третьего управляющего слова
	mov	al, ICW4	
	out	In_A1, al				; Загрузка последнего управляющего слова

;Запись в память векторов прерываний для двух обработчиков
	push es						; Бэкап es (доп сегмент)
	xor	ax, ax					; Обнуление аккумулятора
	mov	es, ax					; Обнуление es

; Запись смещений обработчиков прерываний (Все обработчики находятся в строго фиксированном месте, отсюда умножение на 4)
	; Таймер	
	mov	es:[4*ICW2_S], timer_offset	
	mov	es:[4*ICW2_S+2], cs   	; Заносим сегментную часть адреса 
	
	; Клавиатура
	mov	es:[4*ICW2_S+4], keyboard_offset	
	mov	es:[4*ICW2_S+6], cs   	; Заносим сегментную часть адреса 

	pop	es						; восстановить es

; Маскирование прерывания от таймера
	in	al, In_A1				; Принимаем с порта управляющее слово
	or	al, 00000001b			; Устанавливаем в любом случае режим 8086
	out	In_A1, al				; Загружаем управляющее слово

	sti							; set interruptions flag

;Основная программа
lea si, sym              		; Зaгpyзкa aдpeca для зaпиcи в память компьютера cкэнкoдa
	hlt                  		; Выxoд из cocтoяния ocтaнoвa пocлe нaжaтия на клавиатуру
	hlt                  		
	mov cx, 0cch 				; Счeтчик чиcлa пpepывaний
	mov di, 300h  				; 
	in  al, In_A1				; Считывание
    and al, 11111100b   		; Сброс маски для прерывания от таймера
    out In_A1, al 				; Загрузка

; Цикл пока не поступит сигнал с таймера или клавиатуры
m1: 
	hlt          
    loop m1

	cli

;Восстановление режима работы контроллера
	mov	al, ICW1
	out	In_A0, al				; Загрузка первого управляющего слова
	mov	al, ICW2_E	
	out	In_A1, al				; Загрузка второго управляющего слова
	mov	al, ICW3	
	out	In_A1, al				; Загрузка третьего управляющего слова
	mov	al, ICW4	
	out	In_A1, al				; Загрузка последнего управляющего слова

	sti

;Завершение программы
	mov	ax, 4C00h
	int	21h


;Обработчик прерываний для таймера
org timer_offset 
	push ax						; Бэкап
	push es
	
	dec si 						; Смещаемся назад
	mov	ax, 0B800h				; Начало видеопамяти
	mov	es, ax					; Заносим в сегментный регистр
	mov	al, [si]				; Заносим в al код символа 
	mov	ah, 2Ch					; Загрузка фона и цвета (2 - зеленый, 0ch - розовый)

	mov	es:[di], ax				; Загрузка символа в видеопамять
	sub di, 2 					; Смещаемся на 2 бита в памяти
	inc si 						; Смещаемся на бит
	xor ax, ax
	mov al, ' '
	mov	es:[di], ax				
	sub di, 2 				

	mov	al, 20h					; Загружаем адрес порта 
	out	In_A0, al				; Очистка регистра обслуживаемых прерываний 
	
	pop es 						; Восстановление
	pop	ax
iret

;Обработчик для клавиатуры
org keyboard_offset
	push ax						; Бэкап

	in al, 60h					; Ввод scan кода;
	test al, 10000000b			; Анализ нажатия или отжатия;
	jnz	m2						; Переход, если клавиша отжата
	mov	[si], al				; Сохранение scan кода в памяти
	inc si 						; Смещаемся

m2:			
	in	al, 61h					; Читаем из PB
	or	al, 10000000b			
	out	61h, al					; Установка разряда PB7 в "1" - сброс триггера
	and	al, 7Fh					; 01111111
	out	61h, al					; Сброс разряда PB7 в "0"
	mov	al, 20h					; Загружаем адрес порта 
	out	In_A0, al				; Очистка регистра обслуживаемых прерываний 
					
	pop	ax
iret

end start		
