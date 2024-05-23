; Var 4
; Балашов, А-08-19
; Задан массив однобайтовых целых чисел без знака. Рассчитать среднее значение элементов массива.

.model small
.stack 100h

; Сегмент данных

.data
	
	mass db 255, 255, 255, 254	; Задаю массив однобайтовых чисел
	massLength db $-mass 		; Задаю длину массива

	; Заготавливаю строки сообщений
	str0 db 'Massive: $'
	str1 db 'Length of massive: $'
	str2 db 'Average value of elements: $'
	str3 db 'Remainder of division: $'

	; Определения

	showValue EQU call print_byte
	byteWord EQU call print_word
	exec EQU int 21h
	stout EQU 09h
	q EQU 4C00h

; Сегмент кода

.code
	; Переменные суммы, среднего и остатка
	sum dw 0
	average db 0
	remainder db 0


;Процедура преобразования байта в строку в десятичном виде

print_byte:
    push ax						; Бэкап регистра
    xor ah,ah   				; Обнуление старшего байта
    byteWord   					; Вызов процедуры вывода слова
    pop ax						; Восстановление регистра
    ret 						; Конец процедуры

print_word:
    push ax						; Бэкап регистров
    push cx
    push dx
    push bx
    xor cx,cx					; Обнуление CX
    mov bx,10 					; Копирование в регистр 10 (на что делиться число для представления в сс)
 
; Цикл расчета остатков

rem:            
    xor dx,dx					; Обнуление старшего байта
    div bx						; Деление AX = (DX:AX)/BX, остаток в DX
    add dl,'0'					; Преобразование остатка в код символа
    push dx						; Бэкап в стек
    inc cx						; Увеличение счетчика символов
    test ax,ax					; Проверка AX на 0 (AX & AX = )
    jnz rem 					; Переход к началу цикла, если частное не 0.

mov ah, 02h						; Системная функция прерывания 21h для вывода на экран

; Цикл извлечения символов из стека

getter:							
    pop dx						; Восстановление регистра из стека
    mov [di],dl					; Сохранение символа в буфере
    inc di 						; Инкремент адреса буфера
    exec						; Прерывание 21h
    loop getter					; Цикл
 
    pop bx						; Восстановление регистров
    pop dx
    pop cx
    pop ax
    ret 						; Конец процедуры

; Основная программа

start:
	
	mov ax, @data				; Загрузка данных в регистр
	mov ds, ax					; Регистр настроен на начало сегмента данных
	xor ax, ax					; Очистка регистра AX

	mov si, offset mass 		; Настройка регистра на начало массива
	mov cl, massLength			; Загрузка в младший байт длины массива
	xor ch, ch

	; Цикл суммы

	sumLoop:
		mov bl, [si]			; Загрузка в младший байт регистра значения массива
		add ax, bx				; Копирование байта в регистр
		inc si 					; Сдвиг по массиву

	Loop sumLoop				; Запуск цикла (будет работать согласно значению в CX)

	mov sum, ax					; Сохранение суммы в переменной
	div massLength				; AX = AX / massLength (результат в al, сдвиг в ah)
	mov average, al 			; Сохранение результатов в переменные
	mov remainder, ah

	xor ax, ax					; Очистка регистра
	mov si, offset mass 		; Настройка регистра на начало массива
	mov cl, massLength			; Загрузка в младший байт длины массива

	mov ah, stout				; PRINT STRING функция 21 прерывания
	mov dx, offset str0			; Строка на печать
	exec						; Выполнение

	xor ax, ax					; Очистка регистров
	xor dx, dx					

	mov dl, 32					; Код пробела в регистр
	mov ah, 02h 				; Системная функция прерывания 21h для вывода на экран
	exec						; Выполнение

	; Цикл вывода массива

	resultLoop:
		mov ax, [si]			; Загрузка в регистр значения массива
		showValue				; Выполнение процедуры вывода
		inc si 					; Сдвиг по массиву

	xor ax, ax					; Очистка регистров
	xor dx, dx				

	mov dl, 32					; Код пробела в регистр
	mov ah, 02h 				; Системная функция прерывания 21h для вывода на экран
	exec						; Выполнение

	Loop resultLoop				; Запуск цикла

	xor ax, ax					; Очистка регистров
	xor dx, dx			

	mov dl, 10 					; Код переноса строки в регистр
	mov ah, 02h 				; Системная функция прерывания 21h для вывода на экран
	exec						; Выполнение

	xor ax, ax					; Очистка регистра

	mov ah, stout				; PRINT STRING функция 21 прерывания
	mov dx, offset str1			; Строка на печать
	exec						; Выполнение

	mov al, massLength			; Загрузка длины в младший байт
	showValue					; Выполнение процедуры вывода

	mov dl, 10 					; Код переноса строки в регистр
	mov ah, 02h 				; Системная функция прерывания 21h для вывода на экран
	exec						; Выполнение

	xor ax, ax					; Очистка регистра

	mov ah, stout				; PRINT STRING функция 21 прерывания
	mov dx, offset str2 		; Строка на печать
	exec						; Выполнение

	mov al, average				; Загрузка результата деления в младший байт
	showValue					; Выполнение процедуры вывода

	mov dl, 10 					; Код переноса строки в регистр
	mov ah, 02h 				; Системная функция прерывания 21h для вывода на экран
	exec						; Выполнение

	xor ax, ax					; Очистка регистра

	mov ah, stout				; PRINT STRING функция 21 прерывания
	mov dx, offset str3			; Строка на печать
	exec						; Выполнение

	mov al, remainder			; Загрузка остатка от деления в младший байт
	showValue					; Выполнение процедуры вывода

	mov ax, q 					; Код функции прекращения
	exec						; Выполнение функции
end start