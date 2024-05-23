//{$A-,H-,I-}
program Lab8_server;

uses
  windows,
  messages,
  sysUtils;
  //sound;

//{$R thrd.res}

var request, ok, close:longint;
    clientCount:integer;
    serverHandle:THandle; 

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

procedure WinMain; {Основной цикл обработки сообщений}
  const szClassName='Server';
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
         'Сервер',    {заголовок окна}
         ws_overlappedWindow,     {стиль окна}
         cw_useDefault,           {Left}
         cw_useDefault,           {Top}
         300,                     {Width}
         200,                     {Height}
         0,                       {хэндл родительского окна}
         0,                       {хэндл оконного меню}
         hInstance,               {хэндл экземпляра приложения}
         nil);                    {параметры создания окна}

  serverHandle:=hwnd;
  ShowWindow(hwnd,sw_Show);  {отобразить окно}
  updateWindow(hwnd);   {послать wm_paint оконной процедуре, прорисовав
                         окно минуя очередь сообщений (необязательно)}

  while GetMessage(msg,0,0,0) do begin {получить очередное сообщение}
    TranslateMessage(msg);   {Windows транслирует сообщения от клавиатуры}
    DispatchMessage(msg);    {Windows вызовет оконную процедуру}
  end; {выход по wm_quit, на которое GetMessage вернет FALSE}
end;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
  {$WriteableConst ON}

  {$WriteableConst OFF}

  var ps:TPaintStruct;
      hdc:THandle;
      rect:TRect;
      s:shortstring; //Строка как в Турбо-Паскале
      newClientWindow:THandle;
      data: TCopyDataStruct;
begin
  result:=0;
  case Msg of
    wm_create:
      begin
        clientCount:=0;
      end;

    wm_paint:
      begin
        hdc:=BeginPaint(hwnd, ps); //Удалить WM_PAINT из очереди и начать рисование
        GetClientRect(hwnd, rect);
        s:='Подключено клиентов: '+ IntToStr(clientCount);
        TextOut(hdc, 10, 10, @s[1], length(s));
        s:='Request: '+ IntToStr(request);
        TextOut(hdc, 10, 30, @s[1], length(s));
        s:='Server Handle: '+ IntToStr(serverHandle);
        TextOut(hdc, 10, 50, @s[1], length(s));
        endPaint(hwnd,ps);
      end;

    wm_destroy:
      begin
        PostQuitMessage(0);
      end;
    else
    begin
      if Msg=request then
        begin
          newClientWindow:=wparam;
          clientCount:=clientCount+1; 
          s:='Клиент №'+IntToStr(clientCount);
          data.dwData:=0; //произвольное 32-разрядное значение, не используется
          data.cbData:=length(s); //размер блока, адресуемого lpData
          data.lpData:=@s[1]; //указатель на передаваемый блок данных
          SendMessage(newClientWindow, WM_COPYDATA, serverHandle, integer(@data));
        end
      else
      if Msg=ok then
        begin
        InvalidateRect(serverHandle, nil, true);
        UpdateWindow(serverHandle);
        end
      else
      if Msg=close then
        begin
        clientCount:=clientCount-1;
        InvalidateRect(serverHandle, nil, true);
        UpdateWindow(serverHandle);
        end
      else
      result:=DefWindowProc(hwnd,msg,wparam,lparam);
    end;
  end;
end;

begin
  WinMain;
end.
