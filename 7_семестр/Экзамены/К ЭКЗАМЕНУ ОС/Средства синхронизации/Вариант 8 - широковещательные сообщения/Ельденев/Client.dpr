program lab8Client;

uses windows, messages, sysUtils; {���������� � ��������� DLL}

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;



var hwnd, hwndServer: THandle;
    myNumber: Integer;
    msg1, msg2, msg3, msg4, msg5: UINT;



procedure WinMain; {�������� ���� ��������� ���������}
  const szClassName='Client';
  var   wndClass:TWndClassEx;
        msg:TMsg;
begin
  //����������� ���������
  msg1 := RegisterWindowMessage('������');
  msg2 := RegisterWindowMessage('�����');
  msg3 := RegisterWindowMessage('������');
  msg4 := RegisterWindowMessage('������');
  msg5 := RegisterWindowMessage('�������� ����� ���������� ������������ ������������ ��������');
  //����������� ������� ������
  wndClass.cbSize:=sizeof(wndClass);
  wndClass.style:=0;
  wndClass.lpfnWndProc:=@WndProc;
  wndClass.cbClsExtra:=0;
  wndClass.cbWndExtra:=DLGWINDOWEXTRA; // ����� ����� ���� ������������ DefDlgProc
  wndClass.hInstance:=hInstance;
  wndClass.hIcon:=loadIcon(0, idi_Application);
  wndClass.hCursor:=loadCursor(0, idc_Arrow);
  wndClass.hbrBackground:=GetStockObject(ltgray_Brush);
  wndClass.lpszMenuName:=nil;
  wndClass.lpszClassName:=szClassName;
  wndClass.hIconSm:=loadIcon(0, idi_Application);
  //����������� �������
  RegisterClassEx(wndClass);
  hwnd:=CreateWindowEx(0,
         szClassName, {��� ������ ����}
         '������',    {��������� ����}
         ws_popupwindow or ws_sysmenu or ws_caption or ws_border or ws_visible,       {����� ����}
         100,           {Left}
         100,           {Top}
         500,                     {Width}
         100,                     {Height}
         0,                       {����� ������������� ����}
         0,                       {����� �������� ����}
         hInstance,               {����� ���������� ����������}
         nil);                    {��������� �������� ����}

                 {��������� �������� ����}

  while GetMessage(msg,0,0,0) do begin {�������� ��������� ���������}
    if not (IsDialogMessage(hwnd,msg))
           {���� Windows �� ���������� � �� ������������ ������������ ���������
            ��� ������� ������������ ����� �������� �������� ����������,
            ����� ������� ���� �� ����������� ���������}
    then begin
      TranslateMessage(msg);   {Windows ����������� ��������� �� ����������}
      DispatchMessage(msg);    {Windows ������� ������� ���������}
    end;
  end; {����� �� wm_quit, �� ������� GetMessage ������ FALSE}
end;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
  const number = 1;

  var rect:TRect;
      stringNum: string;
begin
  result:=0;
  case Msg of
    wm_create: {������ ���������� ��������� ��� �������� �������� ����}
      begin
        GetClientRect(hwnd,rect); //������� ���������� �������

        stringNum := '������ �� ������';
        CreateWindowEx(WS_EX_CLIENTEDGE, // ���������� �����
                   'edit',
                   PChar(stringNum),// ������ ����� � ���� �����
                   ws_visible or ws_child or
                   WS_GROUP or ES_READONLY, //������ ���������, ������ ���������� ���������
                   0,0,
                   500,20,
                   hwnd,
                   number,
                   hInstance,
                   nil);

      SendMessage(HWND_BROADCAST, msg1, hwnd, 0);

      end;
    wm_close:
    begin
      if (myNumber <> 0) then SendMessage(hwndServer, msg4, myNumber, 0);
      {DefDlgProc ������ �� ������ �� ��������� - ��� ��������� ��������
      � ��������� �������, ������� � ��� ���}
      DestroyWindow(hwnd);
    end;

    wm_destroy:
      begin
        PostQuitMessage(0);
      end;
    else
      begin
        if (Msg = msg1) then begin
          Exit;
        end
        else if (Msg = msg2) then begin
          hwndServer := wparam;
          if (hwndServer = 0) then begin
            stringNum := '������ �� ������';
            SetWindowText(GetDlgItem(hWnd, number), PChar(stringNum))
          end;
        end
        else if (Msg = msg3) then begin
            myNumber := wParam;
            stringNum := '�����: ' + IntToStr(myNumber);
            SetWindowText(GetDlgItem(hWnd, number), PChar(stringNum))
        end
        else if (Msg = msg5) then begin
            myNumber := 0;
            stringNum := '�������� ����� ���������� ������������ ������������ ��������';
            SetWindowText(GetDlgItem(hWnd, number), PChar(stringNum))
        end
        else result:=DefDlgProc(hwnd,msg,wparam,lparam);
      end;

  end;
end;

begin
  WinMain;
end.
