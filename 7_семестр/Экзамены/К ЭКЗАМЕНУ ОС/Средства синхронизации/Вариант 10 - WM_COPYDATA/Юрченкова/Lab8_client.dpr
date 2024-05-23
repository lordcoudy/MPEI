//{$A-,H-,I-}
program Lab8_client;

uses
  windows,
  messages,
  sysUtils;
  //sound;

//{$R thrd.res}

var request, ok, close:longint;
    hClientWindow:THandle;
    serverHandle:THandle;

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

procedure WinMain; {Основной цикл обработки сообщений}
  const szClassName='Client';
  var   wndClass:TWndClassEx;
        hWnd: THandle;
        msg:TMsg;
begin
  request:=RegisterWindowMessage('LR8_request');
  ok:=RegisterWindowMessage('LR8_ok');
  close:=RegisterWindowMessage('LR8_close');

  wndClass.cbSize:=sizeof(wndClass);
  wndClass.style:=cs_hredraw or cs_vredraw;
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
         'Клиент',    {заголовок окна}
         ws_overlappedWindow,     {стиль окна}
         500,           {Left}
         500,           {Top}
         300,                     {Width}
         200,                     {Height}
         0,                       {хэндл родительского окна}
         0,                       {хэндл оконного меню}
         hInstance,               {хэндл экземпляра приложения}
         nil);                    {параметры создания окна}

  hClientWindow:=hwnd;
  ShowWindow(hwnd,sw_Show);  {отобразить окно}
  updateWindow(hwnd);   {послать wm_paint оконной процедуре, прорисовав
                         окно минуя очередь сообщений (необязательно)}

  while GetMessage(msg,0,0,0) do begin {получить очередное сообщение}
    TranslateMessage(msg);   {Windows транслирует сообщения от клавиатуры}
    DispatchMessage(msg);    {Windows вызовет оконную процедуру}
  end; {выход по wm_quit, на которое GetMessage вернет FALSE}
end;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;

  var ps:TPaintStruct;
      hdc:THandle;
      rect:TRect;
      s:shortstring; //Строка как в Турбо-Паскале
      t:shortstring;
      data: ^TCopyDataStruct;

begin
  result:=0;
  case Msg of
    wm_create:
      begin
        PostMessage(HWND_BROADCAST, request, hWnd, 0);
      end;

    wm_paint:
      begin
        hdc:=BeginPaint(hwnd, ps); //Удалить WM_PAINT из очереди и начать рисование
        GetClientRect(hwnd, rect);
        s:='Request: '+ IntToStr(request);
        TextOut(hdc, 10, 10, @s[1], length(s));
        s:='Server Handle: '+ IntToStr(serverHandle);
        TextOut(hdc, 10, 30, @s[1], length(s));
        endPaint(hwnd,ps);
      end;

    WM_COPYDATA:
      begin
        data:=pointer(lparam);
        serverHandle:=wparam;
        t[0]:=ansichar(char(data^.cbData));
        Move(data^.lpData^, t[1], data^.cbData);
        SetWindowTextA(hClientWindow, pansichar(AnsiString(t)));
        SendMessage(serverHandle, ok, 0, 0);
      end;

    wm_destroy:
      begin
        PostMessage(serverHandle, close, 0, 0);
        PostQuitMessage(0);
      end

    else
      result:=DefWindowProc(hwnd,msg,wparam,lparam);
  end;
end;

begin
  WinMain;
end.
