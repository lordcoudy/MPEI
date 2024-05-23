program lab5;

uses windows,messages, {���������� � ��������� DLL}
     sysUtils; {��������� ������� ������ ��� �������������� ����� � �.�.}

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

procedure WinMain; {�������� ���� ��������� ���������}
  const szClassName='Shablon';
  var   wndClass:TWndClassEx;
        hWnd: THandle;
        msg:TMsg;
begin
  wndClass.cbSize:=sizeof(wndClass);
  wndClass.style:=cs_hredraw or cs_vredraw;
  wndClass.lpfnWndProc:=@WndProc;
  wndClass.cbClsExtra:=0;
  wndClass.cbWndExtra:=0;
  wndClass.hInstance:=hPrevInst;
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
         '�������� ������� ���������, �������� ����� �������',    {��������� ����}
         ws_overlappedWindow,     {����� ����}
         cw_useDefault,           {Left}
         cw_useDefault,           {Top}
         500,                     {Width}
         200,                     {Height}
         0,                       {����� ������������� ����}
         0,                       {����� �������� ����}
         hInstance,               {����� ���������� ����������}
         nil);                    {��������� �������� ����}

  ShowWindow(hwnd,sw_Show);  {���������� ����}
  updateWindow(hwnd);   {������� wm_paint ������� ���������, ����������
                         ���� ����� ������� ��������� (�������������)}

  while GetMessage(msg,0,0,0) do begin {�������� ��������� ���������}
    TranslateMessage(msg);   {Windows ����������� ��������� �� ����������}
    DispatchMessage(msg);    {Windows ������� ������� ���������}
  end; {����� �� wm_quit, �� ������� GetMessage ������ FALSE}
end;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
  const xOffset:integer=0; //���������� ��� ����������� ����������
        yOffset:integer=0;
        timeStamp:integer=-1;

  var ps:TPaintStruct;
      hdc:THandle;
      rect:TRect;
      s:shortstring; //������ ��� � �����-�������
      moveFlag:boolean;
begin
  result:=0;
  case Msg of
    wm_create:
      begin
        SetTimer(hwnd,0,1000,nil); // ������ ~1 �, �������� WM_TIMER
      end;

    wm_paint:
      begin
        hdc:=BeginPaint(hwnd,ps); //������� WM_PAINT �� ������� � ������ ���������
        GetClientRect(hwnd,rect);

        s:='����� ����� ������ ����� ������� ���������:';
        TextOut(hdc,xOffset+5,yOffset+5,@s[1],length(s));

        if TimeStamp>0 then begin
          s:=intToStr(GetTickCount-TimeStamp);
          TextOut(hdc,xOffset+5,yOffset+20,@s[1],length(s));
        end;

        endPaint(hwnd,ps);
      end;

    WM_KEYDOWN:
      begin
        moveFlag:=true;
        case wParam of
          vk_up: dec(yOffset); // �������� ������� ���������
          vk_down: inc(yOffset);
          vk_left: dec(xOffset);
          vk_right: inc(xOffset);
          vk_escape: begin xOffset:=0; yOffset:=0; end; // ������� �� ���������
        else
          moveFlag:=false; // ����� ������� �� ���������
        end;
        if moveFlag then begin // ���� ������� ���������
          invalidaterect(hwnd,nil,true);
          updateWindow(hwnd); //������������ ���� ������ ��, �� ��������� ����������� �������
        end;
      end;

    wm_lbuttondown:
      begin
        TimeStamp:=GetTickCount;
        invalidateRect(hwnd,nil,true);
      end;

    wm_timer:
      if timeStamp>0 then begin // ���� ����� �� ����, �� �� ����� ��������������
        invalidateRect(hwnd,nil,true);
      end;

    wm_destroy:
      begin
        killTimer(hwnd,0);
        PostQuitMessage(0);
      end;

    else
      result:=DefWindowProc(hwnd,msg,wparam,lparam);
  end;
end;



begin
  WinMain;
end.
