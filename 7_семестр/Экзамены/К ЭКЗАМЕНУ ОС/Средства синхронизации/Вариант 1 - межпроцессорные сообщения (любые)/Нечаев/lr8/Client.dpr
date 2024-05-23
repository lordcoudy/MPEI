program lab8;

uses windows,messages, {���������� � ��������� DLL}
     sysUtils; {��������� ������� ������ ��� �������������� ����� � �.�.}

     var
       msgHello, msgAnswer, msgData:UINT;
       hServer, edit:THandle;
       hFile,hMapping:THandle;
       pData:pointer;

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

  hwnd:=CreateWindowEx(
         0,
         szClassName, {��� ������ ����}
         'Client Window',    {��������� ����}
         ws_popupwindow or ws_sysmenu or ws_caption or ws_border or ws_visible,     {����� ����}
         cw_useDefault,           {Left}
         cw_useDefault,           {Top}
         500,                     {Width}
         200,                     {Height}
         0,                       {����� ������������� ����}
         0,                       {����� �������� ����}
         hInstance,               {����� ���������� ����������}
         nil);                    {��������� �������� ����}
  hMapping:=OpenFileMapping(FILE_MAP_WRITE,false, 'MyMapping');   //��������� ������ �������� ������������� ������� �� �����
  pData := MapViewOfFile(       //�������� ������ ����� � �������� ������������ ��������
            hMapping,
            FILE_MAP_WRITE,
            0,0,0);

  ShowWindow(hwnd,sw_Show);  {���������� ����}
  updateWindow(hwnd);   {������� wm_paint ������� ���������, ����������
                         ���� ����� ������� ��������� (�������������)}


  while GetMessage(msg,0,0,0) do begin {�������� ��������� ���������}
    TranslateMessage(msg);   {Windows ����������� ��������� �� ����������}
    DispatchMessage(msg);    {Windows ������� ������� ���������}
  end; {����� �� wm_quit, �� ������� GetMessage ������ FALSE}
end;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;

  var
      length:Integer;
      buffer: array[0..255] of char;
begin
  result:=0;

  if Msg=wm_create then begin
    edit:=CreateWindowEx(WS_EX_CLIENTEDGE,      //�������� edit
                   'edit',
                   '',
                   ws_visible or ws_child or ES_MULTILINE,
                    0, 0,
                   490, 170,
                   hwnd,
                   5,
                   hInstance,
                   nil);

    PostMessage(HWND_BROADCAST, msgHello, hWnd,0);     //����������������� ��������
    SetTimer(hwnd,0,1000,nil);
  end

  else if Msg=wm_timer then begin    //���� �������� "���" �������
    KillTimer(hWnd, 0);
    MessageBox(0, '�� ������� ���������� ����� � ��������', '������', MB_OK or MB_ICONERROR or MB_TASKMODAL);
    DestroyWindow(hwnd);
  end


  else if Msg=wm_command then begin
        if HiWord(wParam)=EN_CHANGE then begin //��� ��������� ���������� edit
          length:=GetWindowtextLength(edit);   //��������� �����
          GetWindowText(edit, pData,  256);    //��������� �����������
          PostMessage(hServer, msgData, length, 0);        //��������
        end;
  end


  else if Msg=msgAnswer then begin //���� ������ ����� �� �������
      KillTimer(hWnd, 0);       //��������� ������
      hServer:=wParam;          //��������� ����� ���� �������
  end


  else if Msg=wm_destroy then begin
    UnmapViewOfFile(pData);
    CloseHandle(hMapping);
    PostQuitMessage(0);
  end


  else result:=DefWindowProc(hwnd,msg,wparam,lparam);
end;



begin
  WinMain;
end.

//��� ������ �� ������ ��8:
//PostMessage � SendMessage ��� ��������� �����.