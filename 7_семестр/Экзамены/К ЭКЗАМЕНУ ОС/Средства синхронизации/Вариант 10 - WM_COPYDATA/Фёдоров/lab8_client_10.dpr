program lab8_client;

uses
  windows,
  messages,
  Sysutils;

  //Ћ– 8
  //¬ар 10
  //"Ќадзиратель" :
  //при запуске клиент отправл€ет широковещательное сообщение request
  //сервер отображает кол-во подключенных клиентов
  //клиент отображает строку, которую передает ему сервер с использованием WM_COPYDATA сообщени€
  //при закрытии окна клиент уведомл€ет об этом сервер

var
   request,response,close:longint;
   serverWnd,mywnd: THandle;
   rect:TRect;

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: integer; lParam: integer): integer;
                 stdcall; forward;

procedure WinMain;

  const szClassName='lr8';
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

  RegisterClassEx(wndClass); {регистраци€ оконного класса}

  mywnd:=CreateWindow(szClassName,
         'Client',
         WS_OVERLAPPEDWINDOW,
         cw_useDefault,
         cw_useDefault,
         400,
         400,
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

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: integer; lParam: integer): integer;
                 stdcall;
var ps:TPaintStruct;
   hdc:THandle;
   s:string;
   s2: ShortString;
   data: ^TCopyDataStruct;
begin
   result:=0;
   case Msg of
      WM_CREATE:
      begin
         PostMessage(HWND_BROADCAST,request,0,hWnd);
      end;
      WM_PAINT:
         begin
            hdc:=BeginPaint(hwnd,ps);
            GetClientRect(hwnd,rect);
            endPaint(hwnd,ps);
         end;
      WM_CLOSE:
         begin
            PostMessage(serverWnd,close,0,0);
            PostQuitMessage(0);
         end;
      WM_COPYDATA:
         begin
               data := pointer(lParam);
               serverWnd:= data^.dwData;
               s2[0]:=AnsiChar(char(data^.cbData));
               move(data^.lpdata^,s2[1],data^.cbData);
               SetWindowTextA(hwnd,s2);
               InvalidateRect(mywnd,@rect,true);
               UpdateWindow(mywnd);
         end
      else
      if Msg = response then
         begin

         end
      else
         result:=DefWindowProc(hwnd,msg,wparam,lparam);
   end;

end;

begin
   WinMain;
end.
