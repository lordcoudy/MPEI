{$A-,H-,I-}
program Lab8;

uses windows, messages, SysUtils;

var
  mas: array[0..9] of string[20] =
  ('00000000000000000000',
   '11111111111111111111',
   '22222222222222222222',
   '33333333333333333333',
   '44444444444444444444',
   '55555555555555555555',
   '66666666666666666666',
   '77777777777777777777',
   '88888888888888888888',
   '99999999999999999999');
  hThreadB, hThreadC: THandle;
  activeThreads: Boolean;
  section: TRTLCriticalSection;

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

function ThreadB(data: pointer): dword; stdcall;
var temp: string[20];
    i: byte;
begin
  while activeThreads do begin
    EnterCriticalSection(section);
    temp := mas[0];
    for i := 1 to 10 do
      mas[i-1] := mas[i];
    mas[9] := temp;
    LeaveCriticalSection(section);
  end;
  ExitThread(0);
end;

function ThreadC(data: pointer): dword; stdcall;
var r1, r2: byte;
    temp: string[20];
begin          
  randomize;
  while activeThreads do begin
    EnterCriticalSection(section);
    r1 := random(9);
    r2 := random(9);
    temp := mas[r1];
    mas[r1] := mas[r2];
    mas[r2] := temp;
    LeaveCriticalSection(section);
  end;
  ExitThread(0);
end;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
var hdc: THandle;
    i: byte;
    codeB, codeC: dword;
begin
  result := 0;

  case Msg of
    wm_create: 
      SetTimer(hwnd, 1, 1000, nil);

    wm_timer:
      begin
        EnterCriticalSection(section);
        hdc := GetDC(hwnd);
        for i := 0 to 9 do
          TextOut(hdc, 170, (i+1)*20, @mas[i,1], 20);
        ReleaseDC(hwnd, hdc);
        LeaveCriticalSection(section);
      end;

    wm_close:
      begin
        activeThreads := false;
        WaitForSingleObject(hThreadB, INFINITE); 
        CloseHandle(hThreadB);
        WaitForSingleObject(hThreadC, INFINITE);
        CloseHandle(hThreadC);
        DeleteCriticalSection(section);
        KillTimer(hwnd, 0);
        DestroyWindow(hwnd);
      end;

    wm_destroy:
        PostQuitMessage(0);
    else
      result := DefWindowProc(hwnd, msg, wparam, lparam);
  end;

end;



procedure WinMain;
const szClassName = 'Lab8';
var msg: TMsg;
    wndClass: TWndClassEx;
    hWnd: THandle;
    idThreadB, idThreadC: dword;
begin
  wndClass.cbSize := sizeof(wndClass);
  wndClass.style := cs_hredraw or cs_vredraw;
  wndClass.lpfnWndProc := @WndProc;
  wndClass.cbClsExtra := 0;
  wndClass.cbWndExtra := 0;
  wndClass.hInstance := hInstance;
  wndClass.hIcon := loadIcon(0, idi_Application);
  wndClass.hCursor := loadCursor(0, idc_Arrow);
  wndClass.hbrBackground := GetStockObject(white_Brush);
  wndClass.lpszMenuName := nil;
  wndClass.lpszClassName := szClassName;
  wndClass.hIconSm := loadIcon(0, idi_Application);

  RegisterClassEx(wndClass);
  hwnd := CreateWindowEx(
         0,
         szClassName, {им€ класса окна}
         'Ћабораторна€ работа 8', {заголовок окна}
         ws_overlappedWindow,     {стиль окна}
         cw_usedefault,           {Left}
         cw_usedefault,           {Top}
         500,                     {Width}
         300,                     {Height}
         0,                       {хэндл родительского окна}
         0,                       {хэндл оконного меню}
         hInstance,               {хэндл экземпл€ра приложени€}
         nil);                    {параметры создани€ окна}

  ShowWindow(hwnd, sw_Show);  {отобразить окно}
  UpdateWindow(hwnd);   {послать wm_paint оконной процедуре, прорисовав окно мину€ очередь сообщений (необ€зательно)}

  InitializeCriticalSection(section);

  hThreadB := CreateThread(nil,        // флаги защиты, поддерживаютс€ только в NT
                        0,             // стандартный размер стека
                        @ThreadB,      // функци€ потока
                        nil,           // аргумент при старте ф-ции потока
                        0,             // флаги создани€, по умолчанию - немедленный запуск
                        idThreadB);

  hThreadC := CreateThread(nil,        // флаги защиты, поддерживаютс€ только в NT
                        0,             // стандартный размер стека
                        @ThreadC,      // функци€ потока
                        nil,           // аргумент при старте ф-ции потока
                        0,             // флаги создани€, по умолчанию - немедленный запуск
                        idThreadC);

  activeThreads := true;
  while GetMessage(msg,0,0,0) do begin {получить очередное сообщение}
    TranslateMessage(msg);             {Windows транслирует сообщени€ от клавиатуры}
    DispatchMessage(msg);              {Windows вызовет оконную процедуру}
  end;                                 {выход по wm_quit, на которое GetMessage вернет FALSE}
end;

begin
  WinMain
end.

