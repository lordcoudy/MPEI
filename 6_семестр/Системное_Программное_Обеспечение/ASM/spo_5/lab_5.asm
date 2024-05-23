; А-08-19, Балашов
; Лаб 5
; Данные в конце текста программы.

.model tiny			; Выделить на всё один сегмент

.code
	org 100h		; Переход на 100h, потому что первые 256 байт занимает PSP

beg:
	jmp start

start:
	; Явная инициализация ds для возможности компиляции exe-файла
	push cs
	pop ds

	; Проводим операции по помещению смещения строк в регистр
	mov dx, offset s
	push dx
	mov dx, offset n

	; Вывод строки
	mov ah, 09h
	pop dx
	int 21h

	; Завершение работы
	mov ax, 4c00h
	int 21h

	; Данные
s 	db 'Hello, world!$'
n 	db 'Goodbye, everyone!$'
end beg