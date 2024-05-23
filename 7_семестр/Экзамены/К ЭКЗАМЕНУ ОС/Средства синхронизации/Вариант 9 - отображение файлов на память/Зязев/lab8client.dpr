program lab8server;

uses windows,messages, Math, SysUtils; {���������� � ��������� DLL}

var
  msgBroadcast: THandle;
  msgAccept: THandle;
  msgLeave: THandle;

  clientName:ShortString;
  hOpponent: THandle;

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

procedure WinMain; {�������� ���� ��������� ���������}
  const szClassName='Shablon';
  var   wndClass:TWndClassEx;
        hWnd: THandle;
        msg:TMsg;
begin
  msgBroadcast := RegisterWindowMessage('��, ��� ���� ������?');
  msgAccept := RegisterWindowMessage('��');
  msgLeave := RegisterWindowMessage('������ � �����');

  hOpponent := 0;

  wndClass.cbSize:=sizeof(wndClass);
  wndClass.style:=cs_hredraw or cs_vredraw;
  wndClass.lpfnWndProc:=@WndProc;
  wndClass.cbClsExtra:=0;
  wndClass.cbWndExtra:=0;
  //wndClass.hInstance:=hPrevInst;
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
         500,           {Width}
         400,           {Height}
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
  var ps:TPaintStruct;
      hdc:THandle;
      rect:TRect;

      lf:TLogFont;
      hf:THandle;

      hMapping: THandle;
      pData: pointer;
      
begin
  result:=0;
  case Msg of
    wm_create:
        begin
          clientName := '�� ���������';
          //�������� ������������������ ��������� - �������� ������� �������
          SendMessage(HWND_BROADCAST, msgBroadcast, hWnd, 0);
        end;

    wm_paint:
      begin


        hdc:=BeginPaint(hwnd,ps); //������� WM_PAINT �� ������� � ������ ���������
        GetClientRect(hwnd,rect);
        rect.Top := rect.Top - 100;

        //����� ������ ��� ������ ������
        fillchar(lf,sizeof(lf),0);
        with lf do begin
          lfHeight:=35;
          lfFaceName:='Arial Cyr';
        end;
        hf:=SelectObject(hdc,createFontIndirect(lf));

        DrawText(hdc, PChar('��� �������: ' + clientName), -1, rect, DT_SINGLELINE or DT_CENTER or DT_VCENTER);

        //������� �����, ������� ������������ ��� ������ ������
        DeleteObject(SelectObject(hdc,hf));

        endPaint(hwnd,ps);
      end;

    wm_keydown:
      if (wParam = VK_ESCAPE) then
      begin
         if (MessageBox(hwnd, '�� ������ ������� ����?', '������ �� �������� ����', MB_YESNO or MB_ICONWARNING) = IDYES) then
         begin
          DestroyWindow(hwnd);
         end;
      end;
	
    wm_destroy:
    begin
      if (hOpponent <> 0) then PostMessage(hOpponent, msgLeave, 0, 0);
      PostQuitMessage(0);
    end;
    
    else
      if Msg = msgAccept then
      begin
        hOpponent := wParam;
        //clientName := '���������';

        //�������� ����� �������
        hMapping := OpenFileMapping(FILE_MAP_ALL_ACCESS,false,'MyMapping');
        pData := MapViewOfFile(
          hMapping, // ����� ������������� �������
          FILE_MAP_ALL_ACCESS, // ������ �� ������-������
          0,0,0); // ������ �� ����� ����������� (����� ������ �����)

        Move(pData^, clientName, 256);

        UnmapViewOfFile(pData);
        CloseHandle(hMapping);
      end

      else
        result:=DefWindowProc(hwnd,msg,wparam,lparam);
  end;
end;



begin
  WinMain;
end.
