; Расчётное задание
; Балашов Савва, А-08-19
; Преобразование файла из формата PCX в формат BMP (256-цветов на точку).

; сегмент стека
stk segment stack
db 100h dup ('?')
stk ends

; сегмент данных
data segment para public 'data'
 
PCXName db 255,255 dup (?)                                                      ; буфер для строки, хранящей имя файла pcx
BMPName db 255,255 dup (?)                                                      ; буфер для строки, хранящей имя файла bmp

; строки меню, которые будут выводиться на экран
MenuNewMsg db 0ah,0dh, '*****Press R to choose a new file*****',0ah,0dh,'$'                            
MenuExitMsg db 0ah,0dh, '*****Press E to exit*****',0ah,0dh,'$' 

; строки сообщений, которые будут выводиться на экран
Prompt1 db 'PCX File: $'
Prompt2 db 0ah,0dh,'BMP File: $'
OFE db 0ah,0dh,'Open File Error ',0ah,0dh,'$'      
NotPCX db 0ah,0dh,'File Is Not PCX-Image',0ah,0dh,'$'
Not256 db 0ah,0dh,'File Is Not 256-colors PCX',0ah,0dh,'$'
RE db 0ah,0dh,'Read error',0ah,0dh,'$'  
СNСFMsg db 0ah,0dh,'Could Not Create File',0ah,0dh,'$'
DoneMsg db 0ah, 0dh, 'File converted successfully', 0ah, 0dh, '$'

; заголовок PCX
Manufacturer db ?                                                               ; Постоянный флаг 10 = ZSoft .PCX
Version db ?                                                                    ; Информация о версии (должна быть 5)
Encoding db ?                                                                   ; 1 = PCX кодирование длинными сериями
BitsPerPixel db ?                                                               ; кол-во бит на пиксель
WindowXmin dw ?                                                                 ; верхняя левая граница изображения
WindowYmin dw ? 
WindowXmax dw ?                                                                 ; правая нижняя граница изображения
WindowYmax dw ?
Hres dw ?                                                                       ; горизонтальное разрешение
Vres dw ?                                                                       ; вертикальное разрешение
Colormap db 48 dup (?)                                                          ; информация о палитре
Reserved db ?                                                                   ; зарезервировано
NPlanes db ?                                                                    ; кол-во цветовых слоев
BytesPerLine dw ?                                                               ; кол-во байт на 1 цветовой слой ( ширина + байты для выравнивания)
PaletteInfo dw ?                                                                ; как интерпретировать палитру
Filler db 58 dup(?)                                                             ; нули
PCXHeaderSize equ $-Manufacturer                                                ; размер заголовка

; заголовок BMP
bfType db 'BM'                                                                  ; информация о типе файла
bfSize dd ?                                                                     ; размер самого файла в байтах
bfReserved1 dw 0                                                                ; нули
bfReserved2 dw 0                                                                ; нули
bfOffBits dd ?                                                                  ; смещение относительно начала файла на битовый массив растра
BMPHeaderSize equ $-bfType                                                      ; размер заголовка
 
; заголовок BMPInfo 
biSize dd BMPInfoHeaderSize                                                     ; размер структуры BITMAPINFOHEADER
biWidth dd ?                                                                    ; ширина изображения
biHeight dd ?                                                                   ; высота изображения
biPlanes dw 1                                                                   ; количество плоскостей
biBitCount dw 8                                                                 ; кол-во бит на пиксель
biCompression dd 0                                                              ; тип сжатия
biSizeImage dd ?                                                                ; размер изображения в байтах
biXPelsPerMeter dd ?                                                            ; горизонтальное разрешение
biYPelsPerMeter dd ?                                                            ; вертикльное разрешение
biClrUsed dd 256                                                                ; текущее число цветов графического движка
biClrImportant dd ?                                                             ; кол-во важных цветов
BMPInfoHeaderSize equ $-biSize                                                  ; размер структуры BITMAPINFOHEADER   
 
; палитра BMP
BMPPallete db 1024 dup(0)                                                       ; буфер для палитры BMP
BMPPalleteSize equ 1024                                                         ; фиксированный размер палитры
ColorsCount dw 0                                                                ; переменная для хранения кол-ва цветов в документе
 
AdditiveBytes db 0                                                              ; кол-во байт для выравнивания в PCX
 
PCXDescr dw ?                                                                   ; дескриптор файла PCX
BMPDescr dw ?                                                                   ; дескриптор файла BMP
 
ArraySize dw ?                                                                  ; переменная для хранения кол-ва байт в запакованном растре PCX
CurByte dw 0                                                                    ; переменная, хранит номер следующего байта в растре bmp
 
; переменные для хранения текущих значений составляющих R, G и B
CurR db ?
CurG db ?
CurB db ?
PackedArray db 60000 dup (?)                                                    ; буфер, в который считается запакованный растр PCX
data ends
 
; сегмент для хранения распакованного растра PCX
MemoryBuf segment para public 'data'
    db 0FFFFh dup (?)
MemoryBuf ends
; сегмент для хранения растра BMP
Bitmap segment para public 'data'
    db 0FFFFh dup (0)
Bitmap ends
 
; сегмент кода
code segment para public 'code'

; основная программа
main proc
    assume cs:code,ds:data,ss:stk,es:MemoryBuf
    mov ax,data
    mov ds,ax
    mov ax,MemoryBuf
    mov es,ax
    
    jmp Start   ; переходим на начало программы
 
; сообщения об ошибках
FileNotFound:   ; если файл не найден
    mov ah,9
    mov dx, offset OFE
    int 21h
    jmp MainMenu
 
ReadErr:    ; если ошибка чтения из файла
    mov ah,9
    lea dx,RE
    int 21h
    jmp MainMenu
 
Start:
    call ClearScreen    ; очистка экрана
    
    ; ввод строки имени исходного PCX-файла
    push offset PCXName
    push offset Prompt1
    call GetFileName    ; введем строку и приведем ее к требуемому виду
    
    ; ввод строки имени выходного BMP-файла
    push offset BMPName
    push offset Prompt2
    call GetFileName    ; введем строку и приведем ее к требуемому виду
    
    ; Откроем файл
    lea dx,PCXName
    mov ah,3dh          ; ф-ия для открытия файла
    xor al,al           ; режим - чтение
    add dx,2            ; перейдем на начало строки
    int 21h             ; открыть файл
    jc FileNotFound     ; если ошибка, то сообщим об этом
    
    mov PCXDescr,ax     ; сохраним дескриптор открытого файла
    mov bx,ax
    
    ; Читаем заголовок
    mov ah,3fh          ; ф-ия для чтения из файла
    lea dx,Manufacturer     ; адрес на начала буфера
    mov cx,PCXHeaderSize    ; размер заголовка
    int 21h  
    jc ReadErr
    
    ; проверка соответствия файла формату PCX
    CheckPCX:
    
        ; проверка записи о формате 
        mov ah,Manufacturer
        cmp ah,10
        je PCXVersionCheck      ; если все верно, то дальше проверяем
        push word ptr PCXDescr  ; если нет, то закрываем файл, печатаем сообщение об ошибке и выходим в меню
        call Close
        mov ah,9
        lea dx,NotPCX
        int 21h
        jmp MainMenu
    
    ; проверка соответствия версии формата
    PCXVersionCheck:
        mov ah,Version
        cmp ah,5
        je PCXBitPixelCheck     ;если все верно, то дальше проверяем
        push word ptr PCXDescr  ; если нет, то закрываем файл, печатаем сообщение об ошибке и выходим в меню
        call Close
        mov ah,9
        lea dx,NotPCX
        int 21h
        jmp MainMenu
    
    ; проверка кол-ва бит на пиксель (должно быть 8 для 256 цветов)
    PCXBitPixelCheck:
        mov ah,BitsPerPixel
        cmp ah,8
        je CheckNplanes         ;если все верно, то проверяем NPlanes
        push word ptr PCXDescr  ; если нет, то закрываем файл, печатаем сообщение об ошибке и выходим в меню
        call Close
        mov ah,9
        lea dx,Not256
        int 21h
        jmp MainMenu
    ; проверка кол-ва цветовых линий
    ; должны быть 3 - R, G и B
    CheckNPlanes:
        mov ah,NPlanes
        cmp ah,3
        je CompleteCheck        ;если все верно, то формат проверен
        push word ptr PCXDescr  ; если нет, то закрываем файл, печатаем сообщение об ошибке и выходим в меню
        call Close
        mov ah,9
        lea dx,Not256
        int 21h
        jmp MainMenu

    CompleteCheck:
        ; формирование размеров изображения, которые будут указаны в BMP
        mov ax,WindowXmax
        sub ax,WindowXmin
        inc ax                  ; в ax - ширина изображения
        mov word ptr biWidth,ax ; сохраним в biWidth
        mov ax, WindowYmax
        sub ax,WindowYmin
        inc ax                  ; в ax - высота изображения
        mov word ptr biHeight,ax    ; сохраним в biHeight
        
        ; сформируем biSizeImage = biHeight * biWidth
        mov dx,word ptr biWidth
        mul dx
        mov word ptr biSizeImage,ax
        mov word ptr biSizeImage+2,dx
        
        ; запишем в структуру BMP (в памяти) информацию о разрешении изображения
        mov ax,Hres
        mov word ptr biXPelsPerMeter,ax
        mov ax,Vres
        mov word ptr biYPelsPerMeter,ax
        
        ; сформируем BfOffBits - смещение на начало растра
        mov ax, BMPHeaderSize       ; размер заголовка
        add ax,BMPInfoHeaderSize    ; + размер информационной структуры
        add ax,1024                 ; + размер палитры
        mov word ptr BfOffBits,ax   ; сохраним
        
        ; вычислим кол-во дополнящих байт для строки BMP
        mov ax,word ptr biWidth ; в ax - ширина изображения
        ; умножим ее на 3 и разделим на 4 (см. пояснительную записку)
        mov bl,4 
        mov cl,3
        mul cl
        div bl
        mov AdditiveBytes,ah        ; сохраним остаток
        
        ; Создадим / откроем выходной BMP-файл
        lea dx,BMPName
        mov ah,3ch                  ; ф-ия для создания файла
        mov cx,0                    ; режим записи
        add dx,2                    ; перейдем на начало строки
        int 21h                     ; открыли файл
        jnc SkipNotCreateMessage    ; если нет ошибок, то обрабатываем файл
        push word ptr PCXDescr      ; если ошибка открытия то закрываем файл, печатаем сообщение об ошибке и выходим в меню
        call Close
        mov ah, 9
        lea dx,СNСFMsg
        int 21h
        jmp MainMenu
    
    SkipNotCreateMessage:
    
        mov BMPDescr,ax         ; сохраним дескриптор файла в переменную
        mov bx,ax
        ; запишем заголовок BMP
        lea dx,bfType
        mov ah,40h              ; ф-ия DOS для записи в файл
        mov cx,BMPHeaderSize
        int 21h
        
        ; запишем также информационную структуру
        mov cx,BMPInfoHeaderSize
        lea dx,biSize
        mov ah,40h
        mov bx,BMPDescr
        int 21h
        
        ; считаем запакованный растр из PCX файла в буфер PackedArray
        mov ah,3fh
        mov bx,PCXDescr
        lea dx,PackedArray
        mov cx,60000
        int 21h
        mov cx,ax           ; количество считанных байт кладем в сx (для организации цикла)
        mov ArraySize,cx    ; и записываем в переменную
    
    ;---------------- дешифрование растра PCX ----------------
    
    lea si,PackedArray  ; si указывает на считанный растр
    xor di,di           ; di=0 - нулевое смещение в сегменте MemoryBuf
    UnPack:
        mov al,[si]         ; загружаем в al байт растра
        cmp al,10111111b    ; является ли данный байт эталонным ? (не счетчиком)
        jb Ethalon           ; если да, то на Ethalon
        ; если это счетчик, то вычленяем количество повторений с помощью сдвигов
        shl al,2 
        shr al,2
        inc si              ; переходим к следующему байту

        dec cx              ; cx сразу уменьшим
        mov ah,[si]         ; в ah загрузим этот байт растра
        ; цикл повторения байта ah раз
        CycleWrite:
            mov es:[di],ah      ; запишем его в сегмент, выделенный для расшифровки
            inc di              ; увеличим индекс
            
            dec al              ; уменьшим счетчик повторений
            jnz CycleWrite      ; если еще не нужное количество раз повторили байт, то пишем еще 

            inc si              ; выставляем указатель на след. байт
            jmp Next            ; переход к следующей итерации
        ; Для эталонного байта
        Ethalon:
        mov es:[di],al      ; пишем его в буферный сегмент
        inc di              ;  увеличим индекс

        inc si              ; переходим к следующему байту
            
    Next:
            
    loop Unpack
 
    ;---------------- обработка расшифрованного растра ----------------
    
    ; вычислим кол-во байт, дополненных к строке развертки до выравнивания.
    mov cx,word ptr biWidth         ; в cx - ширина изображения
    mov ax,word ptr BytesPerLine    ; в ax - кол-во байт на линию
        sub ax,cx                   ; найдем разницу
    mov di,ax                       ; в di кол-во лишних байт
    mov cx,word ptr biHeight        ; в cx - высота
    xor si,si                       ; si=0
    ; будем в цикле перебирать все строки
    ForHeight:
        push cx                         ; сохраним счетчик строк, чтоб не испортить
        mov cx,word ptr biWidth         ; в cx - снова ширина
        mov ax,cx                       ; запишем ее в ax
        add ax,di                       ; добавим число байт для выравнивания
        xor bx,bx                       ; bx=0
        
        ; в цикле будем перебирать все пиксели по ширине. раздельно по разверткам R, G и B.
        ForWidth:
        
            ; строки развертки хранятся в порядке R,G,B
            mov dl,es:[si+bx]               ; в dl пишем значение R текущего пикселя
            mov CurR,dl                     ; сохраняем
            add si,ax                       ; переходим к линии G 
            mov dl,es:[si+bx]               ; в dl пишем значение R текущего пикселя
            mov CurG,dl                     ; сохраняем
            add si,ax                       ; переходим к линии B 
            mov dl,es:[si+bx]               ; в dl пишем значение R текущего пикселя
            mov CurB,dl                     ; сохраняем
            sub si,ax
            sub si,ax                       ; верунли si на начало линии R
            inc bx                          ; увеличили счетчик обработанных пикселей
            call SetPallete                 ; вызываем процедуру обработки пикселя
        loop ForWidth
        
        ; переход к следующей строке
        add si,ax
        add si,ax
        add si,bx
        add si,di
        mov al,AdditiveBytes            ; в al - кол-во дополнояющих строку байт
        xor ah,ah                       ; ah=0
        ; увеличиваем счетчик байтов в BMP-растре
        mov cx,CurByte
        add cx,ax
        mov CurByte,cx
        pop cx                          ; восстанавливаем счетчик строк
    loop ForHeight
    
    ; проверка адекватности кол-ва цветов
    mov ax,ColorsCount
    cmp ax,256                      ; если цветов меньше чем 256,
    jng SkipColorError              ; то работаем дальше, иначе отрабатываем ошибку
    ; закроем файлы, выведем сообщение и выйдем в меню
    push word ptr PCXDescr  
    call Close
    push word ptr BMPDescr  
    call Close
    mov ah,9
    lea dx,Not256
    int 21h
    jmp MainMenu
    
    SkipColorError:
        ; запишем в BMP палитру
        mov cx,BMPPalleteSize
        lea dx,BMPPallete
        mov ah,40h
        mov bx,BMPDescr
        int 21h
    ; строки изображения в сегменте Bitmap хранятся в обычном порядке, а в BMP - в перевернутом, поэтому необходимо
    ; записать строки изображения в обратном порядке
    
    mov cx,word ptr biHeight            ; в cx - высота (кол-во строк фактически)
    mov bx,BMPDescr                     ; рабоатем с BMP-файлом
    WriteStrings:
        push cx                             ; сохраним cx
        mov cx,word ptr biWidth             ; теперь в cx - ширина изображения
        add cl,AdditiveBytes                ; в cl - кол-во байт для выравнивания
        mov ax,CurByte                      ; в ax - индекс текущего байта в сегменте
        sub ax,cx                           ; вычитаем из него размер строки. теперь указывает индекс на начало строки
        mov CurByte,ax                      ; сохраним
        mov dx,CurByte                      ; запишем в dx для записи в файл
        mov ax,Bitmap                       ; в ax - адрес сегмента Bitmap
        mov ds,ax                           ; теперь сегмент данных по умолчанию - Bitmap, поскольку dx - это смещение относительно ds
        mov ah,40h
        int 21h                             ; записали строку
        ; восстанавливаем сегментный регистр ds
        mov ax,data
        mov ds,ax
        pop cx                              ; восстанавливаем cx
    loop WriteStrings
    
    ; для BMP файла, укажем размер bfSize в заголовке
    ; вычислим его на основе уже сформированного файла
    mov ah,42h          ; ф-ия для перемещения укзателя по файлу
    mov al,2            ; относительно конца файла
    xor cx,cx
    xor dx,dx
    int 21h
    ; теперь в dx:ax -длина файла
    mov word ptr bfSize,ax
    mov word ptr bfSize+2,dx
    ; теперь перейдем в начало файла
    mov ah,42h          ; ф-ия для перемещения укзателя по файлу
    mov al,0            ; относительно начала файла
    xor cx,cx
    xor dx,dx
    int 21h
    ; и заново запишем заголовок
    lea dx,bfType
    mov ah,40h          ; ф-ия DOS для записи в файл
    mov cx,BMPHeaderSize
    int 21h
    ; закрываем входной и выходной файлы
    
    push BMPDescr
    call Close
    
    push PCXDescr
    call Close

    ; выводим сообщение об успехе
    mov ah,9
    lea dx, DoneMsg
    int 21h

    ; меню программы
    MainMenu:
        call DisplayMenu 

        ; ждём нажатие на клавиатуру 
        mov ah, 00h
        int 16h

        ; сравниваем с нужными клавишами
        cmp al, 'R'
        je ReturnStart
        cmp al, 'r'
        je ReturnStart
        cmp al, 'E'
        je ExitProg
        cmp al, 'e'
        je ExitProg
        call ClearScreen
        jmp MainMenu

    ReturnStart:
        jmp Start
    
    
    
    ExitProg:
        mov ax,4C00h ; выходим
        int 21h
    
main endp
    
; в стеке - адрес ссобщения, буфер строки
; выход: в bx дескриптор файла
GetFileName proc
    pop di      ; в di - адрес возврата
    pop dx      ; в dx - адрес сообщения
    ; вывод строки для ввода имени файла
    mov ah,9
    int 21h     ; выводим строку
    pop dx      ; в dx - адрес (смещение) на буфер для ввода строки
    ; ввод имени
    mov ah,0ah  ; 0ah - ф-ия для буферизированного ввода строки с клавиатуры
    int 21h
    ; формирование строки имени файла
    mov bx,dx   ; в [bx] лежит размер буфера  для ввода
    inc bx      ; в [bx] - количество байт в строке
    mov al,[bx] ; в al - кол-во записанных байт
    add bl,al   ; теперь bx указвает на последний записанный байт в строке
    inc bl      ; bx указывает на след. после последнего байт
    mov [bx],0  ; и помещаем туда ноль (необходимо для DOS)
    push di     ; кладем в стек адрес возрврата
    ret
GetFileName endp
    
; Функция для закрытия файла
; ВХОД: на вершине стека - дескриптор файла
Close proc 
 
    mov ah,3eh  ; 3eh - ф-ия для закрытия файла
    pop cx      ; в cx - адрес возврата
    pop bx      ; берем из стека дескриптор файла
    int 21h 
    push cx     ; снова в на вершине стека адрес возврата
ret
Close endp

; Ф-ия для поиска цвета в палитре
; Вход: -
; выход: в dx индекс цвета или 0ffffh если цвета CurR,CurG,CurB в палитре нет
FindColorIndex proc
    push cx ; сохраним cx и si в стеке
    push si
    lea bx,BMPPallete ; bx указывает на палитру
    mov cx,ColorsCount ; в cx - кол-во цветов в палитре
    xor si,si ; si=0
    xor di,di ; di=0
    mov dx,0ffffh ; по умолчанию - цвет в палитре не найден, если не докажется обратное
; будем в цикле перебирать все цвета палитры
    Find:
        mov al,[bx+si] ; в al - занчение состоавляющей B текущего цвета
        cmp al,CurB ; сравниваем с искомым
        jne NextColor ; если цвета не идентичны то переходим к проверке следующего цвета
        mov al,[bx+si+1]; в al - занчение состоавляющей G текущего цвета
        cmp al,CurG ; сравниваем с искомым
        jne NextColor ; если цвета не идентичны то переходим к проверке следующего цвета
        mov al,[bx+si+2]; в al - занчение состоавляющей R текущего цвета
        cmp al,CurR ; сравниваем с искомым
        jne NextColor ; если цвета не идентичны то переходим к проверке следующего цвета
        mov dx,di ; если все проверки прошли успешно, то искомый цвет найдем и в dx помещаем его индекс
        
    NextColor:
        inc di ; переходим к следующему цвету
        add si,4 ; в si - смещение на начала следующей записи RGBQ
    loop Find
    pop si ; восстановим регистры
    pop cx
ret
FindColorIndex endp
 
; ф-ия для обработки пикселя. 
SetPallete proc
    ; сохраним регистры, которые не стоит портить
    push ax
    push bx
    push si
    push di
    push dx
 
    lea si,BMPPallete   ; si указывает на палитру
    mov bx,ColorsCount  ; в bx - кол-во цветов
    test bx,bx          ; если bx=0
    jz NullColors       ; то цветов нет и это будет первый
    call FindColorIndex ; если не первый, то ищем не было ли данного цвета CurR, CurB, CurG в палитре
    cmp dx,0ffffh       ; если уже был,
    jne SkipAddColor    ; то не добавляем
    AddColor:
        ; добавление цвета в палитру
        mov ax,ColorsCount  ; в ax - кол-во цветов в палите
        mov bl,4
        mul bl              ; умножаем на 4, чтобы получить смещение относительно начала палитры (каждый цвет 4мя байтами кодируется)
        mov bx,ax           ; в bx будет лежать это смещение
    NullColors:         ; если первый цвет, то все что было выше нам не нужно
        ; в BMP данные хранятся в порядке BGRQ, где Q - 00 всегда. в таком порядке их и записываем:
        mov al,CurB         ; в al составляюущая B
        mov [si+bx],al
        mov al,CurG         ;в al составляюущая G
        mov [si+bx+1],al
        mov al,CurR         ; в al составляюущая Q
        mov [si+bx+2],al
        mov [si+bx+3],0
        mov dx,ColorsCount  ; в dx  индекс данного цвета в палитре
        inc ColorsCount     ; увеличиваем кол-во цветов
 
    ; запишем теперь пиксел (а именно порядковый номер цвета в палитре) в растр
    SkipAddColor:
        push es             ; сохранием зн-ие сегментного регистра es
        mov ax,Bitmap       ; в ax - адрес сегмента Bitmap
        mov es,ax           ; теперь es на него указывает
        mov si,CurByte      ; si указывает на текущий байт растра
        mov es:[si],dl      ; записываем зн-ие индекса палитры
        inc CurByte         ; и увеличиваем указатель
 
    ; восстановим es и необходимые регистры из стека
    pop es
    pop dx
    pop di
    pop si
    pop bx
    pop ax
ret
SetPallete endp 

; ф-ия вывода строк меню
DisplayMenu proc
; смещение и вывод
  lea dx, MenuNewMsg
  mov  ah,9
  int  21h
  lea dx, MenuExitMsg
  mov  ah,9
  int  21h
  ret
DisplayMenu endp

; ф-ия очистки экрана
ClearScreen proc
  mov  ah,0
  mov  al,3
  int  10H
  ret
ClearScreen endp

code ends

end main