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

procedure WinMain; {�������� ���� ��������� ���������}
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
         szClassName, {��� ������ ����}
         '������',    {��������� ����}
         ws_overlappedWindow,     {����� ����}
         cw_useDefault,           {Left}
         cw_useDefault,           {Top}
         300,                     {Width}
         200,                     {Height}
         0,                       {����� ������������� ����}
         0,                       {����� �������� ����}
         hInstance,               {����� ���������� ����������}
         nil);                    {��������� �������� ����}

  serverHandle:=hwnd;
  ShowWindow(hwnd,sw_Show);  {���������� ����}
  updateWindow(hwnd);   {������� wm_paint ������� ���������, ����������
                         ���� ����� ������� ��������� (�������������)}

  while GetMessage(msg,0,0,0) do begin {�������� ��������� ���������}
    TranslateMessage(msg);   {Windows ����������� ��������� �� ����������}
    DispatchMessage(msg);    {Windows ������� ������� ���������}
  end; {����� �� wm_quit, �� ������� GetMessage ������ FALSE}
end;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
  {$WriteableConst ON}

  {$WriteableConst OFF}

  var ps:TPaintStruct;
      hdc:THandle;
      rect:TRect;
      s:shortstring; //������ ��� � �����-�������
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
        hdc:=BeginPaint(hwnd, ps); //������� WM_PAINT �� ������� � ������ ���������
        GetClientRect(hwnd, rect);
        s:='���������� ��������: '+ IntToStr(clientCount);
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
          s:='������ �'+IntToStr(clientCount);
          data.dwData:=0; //������������ 32-��������� ��������, �� ������������
          data.cbData:=length(s); //������ �����, ����������� lpData
          data.lpData:=@s[1]; //��������� �� ������������ ���� ������
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
