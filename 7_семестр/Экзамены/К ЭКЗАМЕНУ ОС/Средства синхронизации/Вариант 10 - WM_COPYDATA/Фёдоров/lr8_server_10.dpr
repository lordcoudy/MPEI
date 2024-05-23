program lr8_server;

uses
  windows,
  messages,
  Sysutils;

var
   request,response,close:longint;
   con:longint;
   clientWnd ,mywnd: THandle;
   rect:TRect;

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

procedure WinMain;

  const szClassName='L8server';
  var   wndClass:TWndClassEx;
        msg:TMsg;

begin
  request := RegisterWindowMessage(PChar('request'));
  response := RegisterWindowMessage(PChar('response'));
  close := RegisterWindowMessage(PChar('close'));

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

  RegisterClassEx(wndClass); {регистрация оконного класса}

  Con:=0;
  mywnd:=CreateWindow(szClassName,
         'Server',
         WS_OVERLAPPEDWINDOW,
         cw_useDefault,
         cw_useDefault,
         500,
         500,
         0,
         0,
         hInstance,
         nil);
  ShowWindow(mywnd,SW_SHOW);



  while GetMessage(msg,0,0,0) do begin
    TranslateMessage(msg);
    DispatchMessage(msg);
  end;
end;

function WndProc(hWnd: THandle; Msg,wParam ,lParam: integer): integer;

var ps:TPaintStruct;
   hdc:THandle;
   s:string;
   sbuf: ShortString;
   data: TCopyDataStruct;

begin
   result:=0;
   case Msg of
      WM_PAINT:
         begin
            hdc:=BeginPaint(hwnd,ps);
            GetClientRect(hwnd,rect);
            s:=IntToStr(con)+' клиентов подключено в данный момент';
            TextOut(hdc,0,0,PChar(s),strlen(PChar(s) ));
            endPaint(hwnd,ps);
         end;
      WM_DESTROY:
         PostQuitMessage(0);
      else
      if Msg = request then
         begin
         clientWnd:=lparam;
         sbuf:='Client ' + IntToStr(con);
         data.dwData := mywnd;
         data.cbData := Length(sbuf);
         data.lpData := @sbuf[1];
         SendMessage(clientWnd,WM_COPYDATA,mywnd,integer(@data));
         con:=con+1;
         InvalidateRect(mywnd,@rect,true);
         UpdateWindow(mywnd);
         end
      else
      if Msg = close then
         begin
         con:=con-1;
         InvalidateRect(mywnd,@rect,true);
         UpdateWindow(mywnd);
         end
      else
         result:=DefWindowProc(hwnd,msg,wparam,lparam);
   end;

end;

begin
   WinMain;
end.
