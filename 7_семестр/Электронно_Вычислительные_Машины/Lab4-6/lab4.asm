;	
 
.386
Regs	  Struc 		     ; Шаблон управляющей
_EDI	   dd	   0		     ; структуры для вызова
_ESI	   dd	   0		     ; прерывания или процедуры
_EBP	   dd	   0		     ; реального режима
	   dd	   0
_EBX	   dd	   0
_EDX	   dd	   0
_ECX	   dd	   0
_EAX	   dd	   0
_FLAGS	   dw	   0
; 
_ES	   dw	   0
_DS	   dw	   0
_FS	   dw	   0
_GS	   dw	   0
_IP	   dw	   0
_CS	   dw	   0
_SP	   dw	   0
_SS	   dw	   0
	  Ends
 
Dseg	  Segment  Para Use16 Public 'Data'    ; Сегмент данных
PMode_Offset   dw   ?		     ; Адрес процедуры перехода
PMode_Segment  dw   ?		     ; в защищенный режим
 
 
 
Mess	   db	 'Protected Mode with'
	   db	 ' DPMI.$'
 no_segment_message db '<<ERROR  11>>$'
Ar1	   Regs <>		     ; Управляющая структура
Video	   dw	   ?		     ; Селектор дескриптора
				     ; видеобуфера
MYSELECTOR dw      ?		;Селектор с битом присутствия =0
Dseg	  Ends
 
Sseg	  Segment Para Use16 Stack 'Stack'    ; Сегмент стека
dw	   100 dup (0)
Sseg	  Ends
 
Cseg	  Segment Use16 Para Public 'Code'    ; Кодовый сегмент
	  Assume    cs:Cseg,ds:Dseg,es:Sseg
Begin	  Proc	  Far
	   push    ds
	   xor	   ax,ax
	   push    ax
	   mov	   ax,dseg
	   mov	   ds,ax	       ; DS - сегмент данных
	   mov	   ax, 1687h	       ; Получаем адрес проце-
	   int	   2Fh		       ; дуры переключения в
				       ; защищенный режим
	   test    ax, ax	       ; Если DPMI не установ-
	   jnz	   Error	       ; лен, то выход
;
 
	   mov	   [PMode_Segment],es  ; Сохраняем полученный
	   mov	   [PMode_Offset],di   ; адрес процедуры
 
	   test    si, si	       ; Нужна память серверу ?
	   jz	   Switch	       ; Нет - переходим на пе-
				       ; реключение режима
	   mov	   bx, si	       ; Да - запрашиваем блок
	   xor	   ax,ax	       ; памяти DOS
	   mov	   ah, 48h
	   int	   21h
	   jc	   Error	    ; Выход, если нет памяти
	   mov	   es, ax	    ; Адрес полученного блока
Switch:    xor	   ax, ax	    ; AX=0 (16битная программа)
	   call    dword ptr [PMode_Offset] ; Переключиться в
					    ; защищенный режим
	   jc	   Error	    ; Выход, если ошибка
; Работа в защищенном режиме
	   mov	   ax,0000h	     ; Создать один дескриптор
	   mov	   cx,1 	     ; в LDT этой задачи
	   int	   31h
	   mov	   Video,ax	     ; Сохранить его селектор
	   mov	   cx,000bh	     ; Установить базовый адрес
	   mov	   dx,8000h	     ; сегмента видеопамяти в
	   mov	   bx,Video	     ; созданном дескрипторе
	   mov	   ax,0007h
	   int	   31h
	   jc	   Error	     ; Выход, если ошибка
	   xor	   cx,cx	     ; Установить предел
	   mov	   dx,1000h	     ; сегмента видеопамяти
	   mov	   bx,Video	     ; в созданном дескрипторе
	   mov	   ax,0008h
	   int	   31h
	   jc	   Error	     ; Выход, если ошибка
	   mov	   ax,0009h	     ; Установить права доступа
	   mov	   bx,Video	     ; сегмента
	   mov	   cx,0000000011110010b
	   int	   31h
;
 
	   jc	   Error	     ; Выход, если ошибка
	   mov	   es,Video	     ; Селектор сегмента
	   mov	   cx,2000	     ; Количество повторений
	   mov	   ax,0f20h	     ; Символ с атрибутом
	   xor	   di,di	     ; Начальное смещение
	   rep	   stosw	     ; Заполнить область памяти
	   push    ds
	   pop	   es		     ; ES := DS
 
 
;Здесь далее устанавливается обработчик особой ситуации 11 (сегмент не присутствует)
	   mov ax,0203h;
	   mov bl,11;
	   mov cx,cs;
	   mov dx,offset int_11;
	   int 31h;	   
	   jc Error;
 
 
 
;Теперь создаём в LDT дескриптор 
	   mov ax,0000h;
	   mov cx,1;
	   int 31h;
	   jc Error;
 
		mov MYSELECTOR,ax;
 
 
	   mov	   cx,000bh	     ; Установить базовый адрес
	   mov	   dx,8000h	     ; сегмента видеопамяти в
	   mov	   bx,MYSELECTOR     ; созданном дескрипторе
	   mov	   ax,0007h
	   int	   31h
 
	   jc	   Error	     ; Выход, если ошибка
	   xor	   cx,cx	     ; Установить предел
	   mov	   dx,1000h	     ; сегмента видеопамяти
 
	   mov	   ax,0008h
	   mov bx,MYSELECTOR;
	   int	   31h
	   jc	   Error	     ; Выход, если ошибка
 
 
 
;Записываем байт прав доступа
 
	   mov 	ax,0009h;
	   mov cx,0000000001110010b;
			;Бит обращения=0
			;TYPE=001 сегмент данных (разрешено чтение и запись)
			;Тип сегмента =1 (прикладной)
			;Уровень привилегированности =11
			;бит присутствия=0 (отсутствует)
	   mov bx,MYSELECTOR
	   int	31h
	   jc Error;	
 
 
;Теперь при загрузке в сегментный регистр созданного селектора должна произойти особая ситуация 11
	   mov ax,MYSELECTOR;
	   mov es,ax;
	   
	   push ds;
	   pop es;
; Установка координат курсора
	   mov	   word ptr Ar1._EAX,0200h    ; AH := 02h
	   mov	   word ptr Ar1._EBX,0000h    ; BX := 0000h
	   mov	   word ptr Ar1._EDX,050Ah    ; DX := 050Ah
	   xor	   cx,cx		; Количество параметров
	   mov	   bx,0010h		; Номер прерывания
	   lea	   di,Ar1		; Адрес структуры
	   mov	   ax,0300h		; Функция DPMI
	   int	   31h			; Вызов прерывания
					; реального режима
	   jc	   Error		; Выход, если ошибка
; Вывод строки посимвольно на экран
	   lea	   si,Mess		; Адрес строки
Next_Char: lodsb			; Считать символ
	   cmp	   al,'$'               ; Символ конца строки ?
	   jz	   Ex			; Да - конец вывода
	   mov	   ah,0eh		; Номер функции INT 10h
	   mov	   word ptr Ar1._EAX,ax
	   lea	   di,Ar1		; Адрес структуры
	   mov	   bx,0010h		; Номер прерывания
	   xor	   cx,cx		; Количество параметров
	   mov	   ax,0300h		; Функция DPMI
	   int	   31h			; Вызов прерывания ре-
					; ального режима
	   jmp	   short  Next_Char	; Перейти к следующему
					; символу
 
Ex:	   mov	   ax, 4C00h		; Выход с кодом ошибки 0
	   int	   21h
Error:	   mov	   ax, 4C01h		; Выход с кодом ошибки 1
 
 
	   int	   21h
Begin	   Endp
 
 
 
 
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Обработчик особой ситуации 11 (сегмент не присутствует)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int_11     proc near
	   mov	   es,Video	     ; Селектор сегмента
	   mov	   cx,2000	     ; Количество повторений
	   mov	   ax,0F20h	     ; Символ с атрибутом
	   
	   xor	   di,di	     ; Начальное смещение
	   rep	   stosw	     ; Заполнить область памяти
 
	   push    ds
	   pop	   es		     ; ES := DS
 
; Установка координат курсора
	   mov	   word ptr Ar1._EAX,0200h    ; AH := 02h
	   mov	   word ptr Ar1._EBX,0000h    ; BX := 0000h
	   mov	   word ptr Ar1._EDX,050Ah    ; DX := 050Ah
	   xor	   cx,cx		; Количество параметров
	   mov	   bx,0010h		; Номер прерывания
	   lea	   di,Ar1		; Адрес структуры
	   mov	   ax,0300h		; Функция DPMI
	   int	   31h			; Вызов прерывания
					; реального режима
	   jc	   Error		; Выход, если ошибка
; Вывод строки посимвольно на экран
	   lea	   si,no_segment_message		; Адрес строки
int_11_Next_Char: lodsb			; Считать символ
	   cmp	   al,'$'               ; Символ конца строки ?
	   jz	   Ex			; Да - конец вывода
	   mov	   ah,0eh		; Номер функции INT 10h
	   mov	   word ptr Ar1._EAX,ax
	   lea	   di,Ar1		; Адрес структуры
	   mov	   bx,0010h		; Номер прерывания
	   xor	   cx,cx		; Количество параметров
	   mov	   ax,0300h		; Функция DPMI
	   int	   31h			; Вызов прерывания ре-
					; ального режима
	   jmp	   short  int_11_Next_Char	; Перейти к следующему
				; символу
 
   mov	   ax, 4C01h		; Выход с кодом ошибки 1
	   int	   21h 
int_11     endp 
 
Cseg	   Ends
End	   Begin