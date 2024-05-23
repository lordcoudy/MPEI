{Алябьев В.О. А-07-18 Вариант 1}
{Задача 1 : Стандартное масштабируемое окно, в котором по центру нарисованы
          Декартовы оси координат с метками 0 и названием осей X и Y,
          размеры осей должны изменяться при изменении размеров окна.}

program lab3;
uses windows, messages,sysutils;


{Объявление типа оконной процедуры}
Type WndProc = function (hwnd: THandle; msg: LongWord;
                  wparam: longint; lparam: longint):longint; stdcall;

{-----Оконная процедура-----}

function wndProc1 (hwnd: THandle; msg: LongWord;
                  wparam: longint; lparam: longint):longint; stdcall;
var ps:TPaintStruct;
      hdc:THandle;
      rect:TRect;
      a: longint;
      i: longint;
      r: LongWord;
const scaleX = 50;
      scaleY = 50;
begin
     case msg of
     WM_PAINT:
        begin
           hdc:=BeginPaint(hwnd,ps);
           GetClientRect(hwnd,rect);
           {Рисование клиенской области}

           //Горизонтальная ось
           MoveToEx(hdc, 0, rect.height div 2, @ps);
           LineTo(hdc, rect.width, rect.height div 2);

           //Стрелка на оси
           MoveToEx(hdc, rect.width, rect.height div 2, @ps);
           LineTo(hdc, rect.width - 20, rect.height div 2 - 20);
           MoveToEx(hdc, rect.width, rect.height div 2, @ps);
           LineTo(hdc, rect.width - 20, rect.height div 2 + 20);

           //Деления +x
           a:=rect.width div 2 + scaleX;
           i:=1;
           while a < rect.width - 20 do
                 begin
                   MoveToEx(hdc, a, rect.height div 2 + 10, @ps);
                   LineTo(hdc, a, rect.height div 2 - 10);
                   TextOut(hdc, a-5, rect.height div 2 - 30,PChar(IntToStr(i)),2);
                   a:= a + scaleX;
                   i:=i+1;
                 end;

           //Деления -x
           a:=rect.width div 2 - scaleX;
           i:=-1;
           while a > 0 do
                 begin
                   MoveToEx(hdc, a, rect.height div 2 + 10, @ps);
                   LineTo(hdc, a, rect.height div 2 - 10);
                   TextOut(hdc, a-5, rect.height div 2 - 30,PChar(IntToStr(i)),3);
                   a:= a - scaleX;
                   i:=i-1;
                 end;

           //Вертикальная ось
           MoveToEx(hdc, rect.width div 2, 0, @ps);
           LineTo(hdc, rect.width div 2, rect.height);

           //Стрелка на оси
           MoveToEx(hdc, rect.width div 2, 0, @ps);
           LineTo(hdc, rect.width div 2 - 20, +20);
           MoveToEx(hdc, rect.width div 2, 0, @ps);
           LineTo(hdc, rect.width div 2 + 20, +20);

           //Деления +y
           a:=rect.height div 2 - scaleY;
           i:=1;
           while a > 20 do
                 begin
                   MoveToEx(hdc, rect.width div 2 + 10, a, @ps);
                   LineTo(hdc, rect.width div 2 - 10, a);
                   TextOut(hdc, rect.width div 2 + 15, a,PChar(IntToStr(i)),2);
                   a:= a - scaleY;
                   i:=i+1;
                 end;

           //Деления -y
           a:=rect.height div 2 + scaleY;
           i:=-1;
           while a < rect.height do
                 begin
                   MoveToEx(hdc, rect.width div 2 + 10, a, @ps);
                   LineTo(hdc, rect.width div 2 - 10, a);
                   TextOut(hdc, rect.width div 2 + 15, a,PChar(IntToStr(i)),3);
                   a:= a + scaleY;
                   i:=i-1;
                 end;

           //Центр координат
           TextOut(hdc, rect.width div 2 + 5, rect.height div 2 -20,'(0,0)',5);

           //Название оси X
           TextOut(hdc,rect.width - 20, rect.height div 2 - 35,'X',1);
           //Название оси Y
           TextOut(hdc, rect.width div 2 + 30, + 20,'Y',1);

           endPaint(hwnd,ps);
        end;
     WM_DESTROY: PostQuitMessage(0);

     WM_CHAR:
        begin
        if Chr(wparam) = #27 then
           begin
               SendMessage(hwnd, WM_CLOSE, wparam, lparam);
           end;
        end;

     else
         result:=DefWindowProc(hwnd, msg, wparam, lparam);
     end;
end;

{-----Главная процедура-----}

const myClassName = 'lab3';
var myWndClass: TWndClassEx;
    hWnd: THandle;
    msg: TMsg;
    wndprocvar : WndProc;
begin
     {Установка параметров оконного класса}
     wndprocvar:= @wndProc1;
     myWndClass.cbSize:=sizeof(myWndClass);
     myWndClass.style:=cs_hredraw or cs_vredraw;
     myWndClass.lpfnWndProc:=wndprocvar;
     myWndClass.cbClsExtra:=0;
     myWndClass.cbWndExtra:=0;
     myWndClass.hInstance:=hInstance;
     myWndClass.lpszClassName:=myClassName;
     myWndClass.lpszMenuName:=nil;
     myWndClass.hIconSm:=loadIcon(0, idi_Application);
     myWndClass.hIcon:=loadIcon(0, idi_Application);
     myWndClass.hCursor:=loadCursor(0, idc_Arrow);
     myWndClass.hbrBackground:=GetStockObject(white_Brush);

     RegisterClassEx(myWndClass); {Регистрация оконного класса}

     {Порождение оконного класса}
     hwnd := CreateWindow(myClassName, {имя класса окна}
             'Cartesian coordinate system',         {заголовок окна}
             ws_overlappedWindow,      {стиль окна}
             cw_useDefault,            {Left}
             cw_useDefault,            {Top}
             cw_useDefault,            {Width}
             cw_useDefault,            {Height}
             0,                        {хэндл родительского окна}
             0,                        {хэндл оконного меню}
             hInstance,                {хэндл экземпляра приложения}
             nil);                     {параметры создания окна}

     ShowWindow(hwnd,sw_Show);  {Отобразить окно на экране}

     {Цикл обработки сообщений}
     while GetMessage(msg,0,0,0) do begin {получить очередное сообщение}
           TranslateMessage(msg);   {Windows транслирует сообщения от клавиатуры}
           DispatchMessage(msg);    {Windows вызовет оконную процедуру}
     end; {выход по wm_quit, на которое GetMessage вернет FALSE}
end.
