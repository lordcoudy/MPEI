program lab6;

uses windows, messages; {���������� � ��������� DLL}

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

var CreationCounter:integer=0; // ������� ��������� ������� ����

procedure WinMain; {�������� ���� ��������� ���������}
  const szClassName='Controls demo';
  var   wndClass:TWndClassEx;
        msg:TMsg;
        hwnd1,hwnd2:THandle;
begin
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

  RegisterClassEx(wndClass);

  hwnd1:=CreateWindowEx(0,
         szClassName, {��� ������ ����}
         '��������� ����',    {��������� ����}
         ws_popupwindow or ws_sysmenu or ws_caption or ws_border or ws_visible,       {����� ����}
         10,           {Left}
         10,           {Top}
         500,                     {Width}
         300,                     {Height}
         0,                       {����� ������������� ����}
         0,                       {����� �������� ����}
         hInstance,               {����� ���������� ����������}
         nil);                    {��������� �������� ����}

  hwnd2:=CreateWindowEx(0,
         szClassName, {��� ������ ����}
         '��������� ����',    {��������� ����}
         ws_popupwindow or ws_sysmenu or ws_caption or ws_border or ws_visible,       {����� ����}
         500,           {Left}
         350,           {Top}
         500,                     {Width}
         300,                     {Height}
         0,                       {����� ������������� ����}
         0,                       {����� �������� ����}
         hInstance,               {����� ���������� ����������}
         nil);                    {��������� �������� ����}


  while GetMessage(msg,0,0,0) do begin {�������� ��������� ���������}
    if not (IsDialogMessage(hwnd1,msg) or IsDialogMessage(hwnd2,msg))
           {���� Windows �� ���������� � �� ������������ ������������ ���������
            ��� ������� ������������ ����� �������� �������� ����������,
            ����� ��������� ���� �� ����������� ���������}
    then begin
      TranslateMessage(msg);   {Windows ����������� ��������� �� ����������}
      DispatchMessage(msg);    {Windows ������� ������� ���������}
    end;
  end; {����� �� wm_quit, �� ������� GetMessage ������ FALSE}
end;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
  const
      btnGet=1;         btnSet=2;
      btnClear=3;       btnExecute=4;
      list=5;           edit=6;

  var i,j:integer;
      rect:TRect;
      buffer: array[0..255] of char;
begin
  result:=0;
  case Msg of
    wm_create: {������ ���������� ��������� ��� �������� �������� ����}
      begin
        inc(CreationCounter);
        GetClientRect(hwnd,rect); //������� ���������� �������

        CreateWindow('button',
                   '��������:',
                   ws_visible or ws_child or bs_groupbox or
                   ws_group, // ������ ������ ������ ������� ����������
                   0,0,
                   150,100,
                   hwnd,
                   0,
                   hInstance,
                   nil);

        CreateWindow('button',
                   '���������',
                   ws_visible or ws_child or bs_autoradiobutton OR WS_TABSTOP,
                   10,20,
                   100,20,
                   hWnd,
                   1, //btnGet
                   hInstance,
                   nil);

        CreateWindow('button',
                   '��������',
                   ws_visible or ws_child or bs_autoradiobutton,
                   10,40,
                   100,20,
                   hWnd,
                   2, //btnSet
                   hInstance,
                   nil);

        CreateWindow('button',
                   '��������',
                   ws_visible or ws_child or bs_autoradiobutton,
                   10,60,
                   100,20,
                   hWnd,
                   3, //btnClear
                   hInstance,
                   nil);

        CreateWindowEx(WS_EX_CLIENTEDGE, // ���������� �����
                   'edit',
                   '',// ������ ����� � ���� �����
                   ws_visible or ws_child or ws_border or ws_tabstop or
                   WS_GROUP or es_multiline, //������ ���������, ������ ���������� ���������
                   200,30,
                   100,40,
                   hwnd,
                   6,
                   hInstance,
                   nil);

        CreateWindow('button',
                   '���������',
                   ws_visible or ws_child or bs_defpushbutton or ws_tabstop,
                   200,70,
                   100,25,
                   hwnd,
                   4, //btnExecute
                   hInstance,
                   nil);

        CreateWindowEx(WS_EX_CLIENTEDGE, // ���������� �����
                   'listbox',
                   '',
                   ws_visible or ws_child or ws_border or ws_tabstop or ws_vscroll,
                   5,100,
                   rect.right-10,rect.bottom-100,
                   hwnd,
                   5, //list
                   hInstance,
                   nil);

      end;

    wm_command: // ��������� ������ �� ���� ������� ����������
      case hiword(wParam) of
        BN_Clicked:
          if loword(wParam)=btnExecute then begin

            if SendMessage(GetDlgItem(hwnd,btnSet), BM_GETCHECK,0,0)<>0 then begin
              SendMessage(GetDlgItem(hwnd,edit),wm_gettext,sizeof(buffer),integer(@buffer));
              SendMessage(GetDlgItem(hwnd,list),LB_ADDSTRING,0,integer(@buffer))
            end

            else if SendMessage(GetDlgItem(hwnd,btnGet), BM_GETCHECK,0,0)<>0 then begin
              i:=SendDlgItemMessage(hwnd,list,LB_GETCURSEL,0,0);
              if i>=0 then
                SendDlgItemMessage(hwnd,list,LB_GETTEXT,i,integer(@buffer))
                {�.�. ���������� ���� �� ����� ������, �� ����� ������ ������}
              else
                buffer[0]:=#0; // ������ �� ������� => ������ �����
              SendDlgItemMessage(hwnd,edit,wm_settext,sizeof(buffer),integer(@buffer));
            end

            else if SendMessage(GetDlgItem(hwnd,btnClear), BM_GETCHECK,0,0)<>0 then begin
              SendDlgItemMessage(hwnd,list,LB_RESETCONTENT,0,0);
            end;
          end;
      end; //case hiword(wparam) in for WM_COMMAND message

    wm_close:
      {DefDlgProc ������ �� ������ �� ��������� - ��� ��������� ��������
       � ��������� �������, ������� � ��� ���}
      DestroyWindow(hwnd);
    wm_destroy:
      begin // ������ ���������� ������������ �������������
        dec(CreationCounter);
        if CreationCounter=0 then PostQuitMessage(0);
      end;
    else
      result:=DefDlgProc(hwnd,msg,wparam,lparam);
  end;
end;



begin
  WinMain;
end.
