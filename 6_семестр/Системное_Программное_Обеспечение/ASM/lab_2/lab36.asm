.model small
.stack 100h 

; Сегмент данных
.data
port_address dw ? 							; Адрес КОМ-порта		
text_out db 'test13',0Dh,'$' 				; Строка на выход
text_in db 50 dup(?) 						; Строка на вход
error_flag db ?								; как бы флаг для проверки искажения

.code 

	; Начальная инициализация
	mov ax,@data
	mov ds,ax 
	xor ax,ax 
	mov es,ax 

	; Задаю адрес порта
	mov dx,es:[400h] 
	mov port_address,dx 

	mov dx,port_address						; Адрес в регистр
	add dx,3 								; Смещение на регистр LCR
	in al,dx 								; Считывание с регистра LCR в аккумулятор
	or al,10000000b 						; Включение DLAB = 1
	out dx,al 								; Запись из аккумулятора в регистр LCR

	mov dx,port_address 					; Выбор адреса регистра DLL (смещение = 0)
	mov al,192 								; Делитель D = 115200/V (V=600 bps)
	out dx,al 								; Вывод
	add dx,1 								; Адрес регистра DLM (делитель частоты)
	mov al,0 								
	out dx,al 								; Вывод 0 в регистр

	mov dx,port_address 					; Адрес в регистр
	add dx,3 								; Регистр LCR
	; 0,1 = 1, 1 - 8 data bits, стандартная
	; 2 = 1 - 2 stop bits, в конце передачи задержка в течение 2 бит
	; 5,4,3 = 0,1,1 - even parity (0, P = D0 xor D1 xor... - контроль по четности, there will be parity)
	; 6 = 0 - break signal disabled, сигнал обрыва
	; 7 = 0 - DLAB = 0
	mov al,00011111b 						; Выключение DLAB = 0, установка битов данных	
	out dx,al 								; Запись в LCR

	mov dx,port_address 					; Адрес в регистр
	add dx,2 								; Регистр идентификации прерывания (по смещению 2, только чтение)
	in al,dx 								; Чтение регистра
	and al,0FEh 							; Ноль в младший бит для отключения FIFO
	out dx,al 								; Запись из аккумулятора в FIFO control

	mov si,offset text_out 					; Перенос указателя на начало строки на выход

; Вывод
output: 

	mov dx,port_address 					; Адрес в регистр
	add dx,5 								; Смещение на регистр LSR
	in al,dx 								; Чтение из регистра в аккумулятор

	test al,00100000b						; Неразр лог "и", проверка 5 бита на готовность
	jz output								; Если 0, то возврат, готов к передаче следующего

	mov dx,port_address 					; Адрес в регистр
	mov al,[si] 							; Копирования символа по указателю в аккумулятор
	out dx,al 								; Вывод символа по адресу

	inc si 									; Смещение указателя на 1

	cmp al,'$' 								; Поиск конца строки
	jnz output 								; Если не найден, то повтор

	mov si,offset text_in 					; Перевод указателя на строку ввода
	
input: 
	mov dx,port_address 					; Адрес в регистр
	add dx,5 								; Смещение в регистр LSR 
	in al,dx 								; Чтение в аккумулятор
	test al,1h 								; Неразр лог "и", проверка 0 бита на готовность
	jz input 								; Если 0, то заново, принят очередной байт
	; Считали 1 раз, проверяем 2, потому что при чтении сбрасываются ошибки
	and al,00000100b 						; Логическое "и" с 3 для поиска ошибки скорости (сбился стоповый бит)
	mov error_flag,al						; Запись в флаг

	mov dx,port_address 					; Адрес в регистр
	in al,dx 								; Запись из порта по адресу в dx в аккумулятор
	mov [si],al 							; По метке записать символ

	cmp error_flag,0 						; Сравниваю флаг с 0
	je no_error								; Если флаг = 0, то переход в метку no_error
 	mov al,'#'								; Символ для замены искажения

no_error:
	mov dl,al 								; Копирование символа в регистр
	mov ah,06h 								; Функция вывода в консоль
	int 21h 								; Выполнение

	inc si 									; Смещение указателя на 1

	cmp byte ptr [si-1],0Dh 				; Сравнение байта по указателю с окончанием строки
	jnz input 								; Если не равны, то повтор

	; Выход
	mov ax,4C00h 
	int 21h 

end
