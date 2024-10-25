program lab8server;

uses windows,messages, Math, SysUtils; {���������� � ��������� DLL}

var
  msgBroadcast: THandle;
  msgAccept: THandle;
  msgLeave: THandle;
  n:integer; //���������� �����������
  t:integer; //��� �������

  hFile: THandle;
  hMapping: THandle;
  pData: pointer;
  hEvent: THandle;


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

  hEvent := CreateEvent(nil, false, true, 'MyEvent');

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
      i:integer;

      outStr: ShortString;
      hOpponentsMas: array [0..255] of THandle;

      th:DWORD;

begin
  result:=0;
  case Msg of
    wm_create:
      begin

        n := 0;
        t := 1;

        for i := 0 to 255 do hOpponentsMas[i] := 0;

        hFile := CreateFile(
          'myfile.map', // ��� �����
          GENERIC_READ or GENERIC_WRITE, // ������ �� ������-������
          0, // ������������ ������
          0, // �������� ������, �� �������������� Windows 95, ������ NT
          CREATE_ALWAYS, // ��������� ������
          FILE_ATTRIBUTE_NORMAL,
          0);

        hMapping := CreateFileMapping(
          hFile, // ����� ��������� �����
          0, // �������� ������, �� �������������� Windows 95, ������ NT
          PAGE_READWRITE,
          0, 4096, // 4096 ����, ���� 0 - ������ ����� ������� �����
          'MyMapping'); // ���-������������� �������

        pData := MapViewOfFile(
          hMapping, // ����� ������������� �������
          FILE_MAP_ALL_ACCESS, // ������ �� ������-������
          0,0,0); // ������ �� ����� ����������� (����� ������ �����)
          
      end;


    wm_paint:
      begin


        hdc:=BeginPaint(hwnd,ps); //������� WM_PAINT �� ������� � ������ ���������
        GetClientRect(hwnd,rect);

        //����� ������ ��� ������ ������
        fillchar(lf,sizeof(lf),0);
        lf.lfQuality := 5;
        with lf do begin
          lfHeight:=35;
          lfFaceName:='Arial Cyr';
        end;
        hf:=SelectObject(hdc,createFontIndirect(lf));

        DrawText(hdc, PChar('����� �����������: ' + IntToStr(n)), -1, rect, DT_SINGLELINE or DT_CENTER or DT_VCENTER);

        //������� �����, ������� ������������ ��� ������ ������
        DeleteObject(SelectObject(hdc,hf));

        endPaint(hwnd,ps);
      end;

    wm_keydown:
      if (wParam = VK_ESCAPE) then
      begin
        th := GetCurrentThreadId();
         if (MessageBox(hwnd, '�� ������ ������� ����?', '������ �� �������� ����', MB_YESNO or MB_ICONWARNING) = IDYES) then
         begin
          DestroyWindow(hwnd);
         end;
      end;

    wm_destroy:
      begin
        UnmapViewOfFile(pData);
        CloseHandle(hMapping);
        CloseHandle(hFile);
        PostQuitMessage(0);
      end;

    else
        if Msg = msgBroadcast then
        begin
          outStr := '������������ ';
          outStr := outStr + IntToStr(t);
          t := t + 1;
          Move(outStr, pData^, 256);

          SendMessage(wParam, msgAccept, hWnd, 0); //���������� ���� �����
          n := n + 1; //���������� ���������� ����������� �� 1
          InvalidateRect(hWnd, nil, True);
        end
        else if Msg = msgLeave then
        begin
          //��������� ���������� ����������� �� 1
          n := n - 1;
          InvalidateRect(hWnd, nil, True);
        end
        else
          result:=DefWindowProc(hwnd,msg,wparam,lparam);
  end;
end;



begin
  WinMain;
end.
