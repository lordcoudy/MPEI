program lab8Server;

uses windows, messages, SysUtils; {���������� � ��������� DLL}

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

const MAXCOUNTCLIENT = 10;

var hwnd: THandle;
    msg1, msg2, msg3, msg4, msg5: UINT;
    numbers: Integer;
    client_numbers: array [0..MAXCOUNTCLIENT - 1] of Boolean;

procedure WinMain; {�������� ���� ��������� ���������}
  const szClassName='Server';
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
         400,                     {Width}
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

function getClientNumber():Integer; stdcall;
var i: Integer;
begin
  i := 0;
  Result := i;
  For i := 0 to MAXCOUNTCLIENT - 1 do
  begin
    if (client_numbers[i] = False) then begin
      client_numbers[i] := True;
      Break;
    end;
  end;
  if (i >= MAXCOUNTCLIENT) then Result := 0
  else Result := i + 1;
end;

procedure deleteClient(clientId:Integer); stdcall;
begin
  numbers := numbers - 1;
  client_numbers[clientId - 1] := False;
end;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
  const count = 1;

  var
    rect:TRect;
    otherHwnd: THandle;
    stringNum: String;
    number: Integer;
begin
  result:=0;
  case Msg of
    wm_create: {������ ���������� ��������� ��� �������� �������� ����}
      begin
        GetClientRect(hwnd,rect); //������� ���������� �������

        stringNum := '���������� ������������ ��������: 0';

        CreateWindowEx(WS_EX_CLIENTEDGE, // ���������� �����
                   'edit',
                   PChar(stringNum),// ������ ����� � ���� �����
                   ws_visible or ws_child or
                   WS_GROUP or ES_READONLY, //������ ���������, ������ ���������� ���������
                   0,0,
                   400,20,
                   hwnd,
                   count,
                   hInstance,
                   nil);

      end;
    wm_close:
      {DefDlgProc ������ �� ������ �� ��������� - ��� ��������� ��������
       � ��������� �������, ������� � ��� ���}
      DestroyWindow(hwnd);
    wm_destroy:
      begin
        PostQuitMessage(0);
      end;
    else
      begin
        if (Msg = msg1) then begin
          otherHwnd := wparam;

          PostMessage(otherHwnd, msg2, hWnd, 0);

          number := getClientNumber();

          if (number = 0) then PostMessage(otherHwnd, msg5, 0, 0)
          else begin
            numbers := numbers + 1;
            
            PostMessage(otherHwnd, msg3, number, 0);

            stringNum := '���������� ������������ ��������: ' + IntToStr(numbers);

            SetWindowText(GetDlgItem(hWnd, count), PChar(stringNum));
          end;
        end
        else if (Msg = msg4) then begin
           deleteClient(wParam);
           stringNum := '���������� ������������ ��������: ' + IntToStr(numbers);

          SetWindowText(GetDlgItem(hWnd, count), PChar(stringNum));
          Exit;
        end
        else result:=DefDlgProc(hwnd,msg,wparam,lparam);
      end;

  end;
end;



begin
  WinMain;
end.
