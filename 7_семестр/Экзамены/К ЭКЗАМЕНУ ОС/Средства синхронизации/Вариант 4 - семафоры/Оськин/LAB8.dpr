{$A-,H-,I-}
program LAB8;

uses
  windows,
  messages;
var
   mas:array[1..10]of string[20]=('00000000000000000000','11111111111111111111',
  '22222222222222222222','33333333333333333333','44444444444444444444',
  '55555555555555555555','66666666666666666666','77777777777777777777',
  '88888888888888888888','99999999999999999999');
   hSema,hThreadB,hThreadC:THandle;
   ThreadsActive:Boolean;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall; forward;

function ThreadFunctionB(data:pointer):dword;stdcall;
var
  i:integer;
  buff_s:string[20];
begin
  while ThreadsActive do
   begin
    WaitForSingleObject(hSema,Infinite);
    buff_s:=mas[10];
    for i:=10 downto 2 do
      mas[i]:=mas[i-1];
    mas[1]:=buff_s;
    ReleaseSemaphore(hSema,1,nil);
   end;
end;

function ThreadFunctionC(data:pointer):dword;stdcall;
var
  i1,i2:integer;
  buff_s:string[20];
begin
  while ThreadsActive do
    begin

      i1:=0;
      i2:=0;
      while i1=i2 do
      begin
        i1:=random(9)+1;
        i2:=random(9)+1;
      end;
      WaitForSingleObject(hSema,Infinite);
      buff_s:=mas[i1];
      mas[i1]:=mas[i2];
      mas[i2]:=buff_s;
      ReleaseSemaphore(hSema,1,nil);
    end;
end;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
var
   hdc:THandle;
   ps:  TPaintStruct;
   Rect: TRect;
   ExitCodeB, ExitCodeC: cardinal;
   i: integer;
begin
 result:=0;
  case Msg of
    wm_create:
      SetTimer(hwnd,1,1000,nil);

    wm_timer:
      begin
        GetClientRect(hWnd, Rect);
        InvalidateRect(hWnd, @Rect, false);
      end;

    wm_paint:
      begin
        hdc:=BeginPaint(hwnd, ps);
        
        WaitForSingleObject(hSema,infinite);
        for i:=1 to 10 do
          TextOut(hdc,200,i*30,@mas[i,1],20);
        ReleaseSemaphore(hSema,1,nil);
        EndPaint(hWnd,ps);
      end;

    wm_close:
      begin

        ThreadsActive:=False;

        repeat
          GetExitCodeThread(hThreadB, ExitCodeB);
          GetExitCodeThread(hThreadC, ExitCodeC);
        until (ExitCodeB <> Still_active) and (ExitCodeC <> Still_active);

        KillTimer(hWnd,0);
        CloseHandle(hSema);
        CloseHandle(hThreadB);
        CloseHandle(hThreadC);
        DestroyWindow(hWnd);
      end;

    wm_destroy:
        PostQuitMessage(0);
    else
      result:=DefWindowProc(hwnd,msg,wparam,lparam);
  end;
end;

procedure WinMain;
const
   szClassName='ClassForLR8';
var
  wndClass:TWndClassEx;
  msg:TMsg;
  hWnd: THandle;
  idThreadB,idThreadC:dword;
begin
  wndClass.cbSize:=sizeof(wndClass);
  wndClass.style:=0;
  wndClass.lpfnWndProc:=@WndProc;
  wndClass.cbClsExtra:=0;
  wndClass.cbWndExtra:=0;
  wndClass.hInstance:=hInstance;
  wndClass.hIcon:=loadIcon(0, idi_Application);
  wndClass.hCursor:=loadCursor(0, idc_Arrow);
  wndClass.hbrBackground:=GetStockObject(white_Brush);
  wndClass.lpszMenuName:=nil;
  wndClass.lpszClassName:=szClassName;
  wndClass.hIconSm:=loadIcon(0, idi_Application);

  RegisterClassEx(wndClass);
  
  hwnd:=CreateWindowEx(
         0,
         szClassName, {имя класса окна}
         'ЛР №8',    {заголовок окна}
         WS_OVERLAPPED or WS_CAPTION or WS_SYSMENU or WS_MINIMIZEBOX,     {стиль окна}
         600,                     {Left}
         300,                     {Top}
         600,                     {Width}
         400,                     {Height}
         0,                       {хэндл родительского окна}
         0,                       {хэндл оконного меню}
         hInstance,               {хэндл экземпляра приложения}
         nil);                    {параметры создания окна}

  ShowWindow(hwnd,sw_Show);  {отобразить окно}

  hSema:=CreateSemaphore(
          nil, // атрибуты защиты
          1, // начальное значение
          1, // максимальное значение
          'MySemaphore' );// имя семафора
  ThreadsActive:=True;

  hThreadB:=CreateThread(nil, // флаги защиты, поддерживаются только в NT
                        0, // стандартный размер стека
                        @ThreadFunctionB, // функция потока
                        nil, // аргумент при старте ф-ции потока
                        0, // флаги создания, по умолчанию -- немедленный запуск
                        idThreadB);

  hThreadC:=CreateThread(nil, // флаги защиты, поддерживаются только в NT
                        0, // стандартный размер стека
                        @ThreadFunctionC, // функция потока
                        nil, // аргумент при старте ф-ции потока
                        0, // флаги создания, по умолчанию -- немедленный запуск
                        idThreadC);
                        
  while GetMessage(msg,0,0,0) do begin {получить очередное сообщение}
     TranslateMessage(msg);   {Windows транслирует сообщения от клавиатуры}
     DispatchMessage(msg);    {Windows вызовет оконную процедуру}
  end; {выход по wm_quit, на которое GetMessage вернет FALSE}
end;

begin
  randomize;
  WinMain;
end.
