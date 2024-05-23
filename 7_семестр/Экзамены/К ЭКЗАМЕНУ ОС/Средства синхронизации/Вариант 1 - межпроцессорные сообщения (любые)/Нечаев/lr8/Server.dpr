uses windows,messages, {���������� � ��������� DLL}
     sysUtils; {��������� ������� ������ ��� �������������� ����� � �.�.}

var
   msgHello,msgAnswer, msgData:UINT;
   hClient:tHandle;
   hFile,hMapping, edit:THandle;
   pData:pointer;
   length:integer;
   buffer: array[0..255] of char; //������ ��� � �����-�������

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

procedure WinMain; {�������� ���� ��������� ���������}
  const szClassName='Shablon';
  var   wndClass:TWndClassEx;
        hWnd: THandle;
        msg:TMsg;

begin
  msgHello:=RegisterWindowMessage('Lab_8_client_hello');
  msgAnswer:=RegisterWindowMessage('Lab_8_server_answer');
  msgData:=RegisterWindowMessage('Lab_8_data_transfer');

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


   hFile := CreateFile(   //�������� �����
        'myfile.map', // ��� �����
        GENERIC_READ or GENERIC_WRITE, // ������ �� ������-������
        0, // ������������ ������
        0, // �������� ������, �� �������������� Windows 95, ������ NT
        CREATE_ALWAYS, // ��������� ������
        FILE_ATTRIBUTE_NORMAL, 0);


  hMapping := CreateFileMapping(   //�������� �������������� �������
        hFile, // ����� ��������� �����
        0, // �������� ������, �� �������������� Windows 95, ������ NT
        PAGE_READWRITE,
        0, 4096, // 4096 ����, ���� 0 - ������ ����� ������� �����
        'MyMapping' // ���-������������� �������
        );


  pData := MapViewOfFile(    //�������� ������ �������
        hMapping, // ����� ������������� �������
        FILE_MAP_ALL_ACCESS, // ������ �� ������-������
        0,0,0 // ������ �� ����� ����������� (����� ������ �����)
        );


  hwnd:=CreateWindowEx(
         0,
         szClassName, {��� ������ ����}
         'Server Window',    {��������� ����}
         ws_popupwindow or ws_sysmenu or ws_caption or ws_border or ws_visible,     {����� ����}
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

  var ps:TPaintStruct;
      hdc:THandle;
      rect:TRect;

begin
  result:=0;
    if Msg=wm_create then begin
      length:=0;
    end

    else if Msg=msgHello then begin
       hClient:=wParam;
       PostMessage(hClient, msgAnswer, hWnd, 0);
    end

    else if Msg=wm_paint then begin

        hdc:=BeginPaint(hwnd,ps);
        GetClientRect(hwnd,rect);
        rect.Right:= rect.Right-13;
        DrawText(hdc, buffer, length, rect,  DT_WORDBREAK);
        endPaint(hwnd,ps);

    end


    else if   Msg=msgData then begin
      Move(pData^, buffer, wParam);
      length:=wParam;
      InvalidateRect(hWnd, nil, True);
    end

    else if  Msg=wm_destroy then begin
      UnmapViewOfFile(pData);
      CloseHandle(hMapping);
      CloseHandle(hFile);
      PostQuitMessage(0);
    end


    else result:=DefWindowProc(hwnd,msg,wparam,lparam);
end;



begin
  WinMain;
end.
