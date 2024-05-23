program lab7;

uses windows, messages; {���������� � ��������� DLL}

{$R res7.res} // ������������ ���� ��������

procedure static(a,b:integer); stdcall; external 'lib7.dll' name 'static';
  //����������� �������� �������

var dyn:procedure(a,b:integer) stdcall; //���������� ��� ������������ ��������
    hLib7:hModule;


function dlgProc(hdlg: THandle; Msg: integer; wParam: longint; lParam: longint): LRESULT; stdcall;
  const
      btnGet=1;         btnSet=2;
      btnClear=3;       btnExecute=4;
      list=5;           edit=6;

  var i,j:integer;
      buffer: array[0..255] of char;
begin
  result:=1;
  case Msg of
    wm_command: // ��������� ������ �� ���� ������� ����������
      case hiword(wParam) of
        BN_Clicked:
          if loword(wParam)=btnExecute then begin

            if SendMessage(GetDlgItem(hdlg,btnSet), BM_GETCHECK,0,0)<>0 then begin
              SendMessage(GetDlgItem(hdlg,edit),wm_gettext,sizeof(buffer),integer(@buffer));
              SendMessage(GetDlgItem(hdlg,list),LB_ADDSTRING,0,integer(@buffer))
            end

            else if SendMessage(GetDlgItem(hdlg,btnGet), BM_GETCHECK,0,0)<>0 then begin
              i:=SendDlgItemMessage(hdlg,list,LB_GETCURSEL,0,0);
              if i>=0 then
                SendDlgItemMessage(hdlg,list,LB_GETTEXT,i,integer(@buffer))
                {�.�. ���������� ���� �� ����� ������, �� ����� ������ ������}
              else
                buffer[0]:=#0; // ������ �� ������� => ������ �����
              SendDlgItemMessage(hdlg,edit,wm_settext,sizeof(buffer),integer(@buffer));
            end

            else if SendMessage(GetDlgItem(hdlg,btnClear), BM_GETCHECK,0,0)<>0 then begin
              SendDlgItemMessage(hdlg,list,LB_RESETCONTENT,0,0);
            end;
          end;
      end; //case hiword(wparam) in for WM_COMMAND message

    wm_close:
      begin
        EndDialog(hdlg,idCancel);
      end;
    else
      result:=0;
      // ������� DefDlgProc!
  end;
end;


function wndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
begin
  result:=0;
  case Msg of
    wm_create:
      begin
        // � ������ -- �������� �������. �� ����� ���� ��� DLL ��� ���������,
        // ������� ��� ��� �� �����������, ������������� ���� ������� ������ �� ���
        hLib7:=loadLibrary('lib7.dll');
        // ��������� ���������� ������������ ���� �� ������ 100 � DLL
        @dyn:=GetProcAddress(hLib7,pointer(100));
      end;
    wm_command: // ��������� ������ �� ���� ������� ����������
      if hiword(wparam)=0 then begin //� ���������� ���� ������� ��� �����������
        case loword(wparam) of
          101: static(101,1);
          102: dyn(102,1);
          103: // ������ �� ������� ������� ������ -- hLib7 !
            DialogBox(hLib7,'lib7dlg',hwnd,@dlgproc);
          104: sendmessage(hwnd,wm_close,0,0);
        end;
      end;
    wm_close:
      begin // ������ ���������� ������������ �������������
        FreeLibrary(hLib7);
        PostQuitMessage(0);
      end;
    else
      result:=DefWindowProc(hwnd,msg,wparam,lparam);
  end;
end;

procedure WinMain; {�������� ���� ��������� ���������}
  const szClassName='Controls demo';
  var   wndClass:TWndClassEx;
        msg:TMsg;
        hwnd1,hwnd2:THandle;
        sbuf:array[byte] of char;
begin
  loadString(hInstance,1,@sbuf,256);

  wndClass.cbSize:=sizeof(wndClass);
  wndClass.style:=0;
  wndClass.lpfnWndProc:=@WndProc;
  wndClass.cbClsExtra:=0;
  wndClass.cbWndExtra:=0;
  wndClass.hInstance:=hInstance;
  wndClass.hIcon:=loadIcon(hInstance, 'lab7');
  wndClass.hCursor:=loadCursor(hInstance, 'TRIANGLE');
  wndClass.hbrBackground:=GetStockObject(white_Brush);
  wndClass.lpszMenuName:='lab7menu';
  wndClass.lpszClassName:=szClassName;
  wndClass.hIconSm:=wndClass.hIcon;

  RegisterClassEx(wndClass);

  hwnd1:=CreateWindowEx(0,
         szClassName, {��� ������ ����}
         @sbuf,    {��������� ����}
         ws_overlappedwindow,       {����� ����}
         10,           {Left}
         10,           {Top}
         500,                     {Width}
         300,                     {Height}
         0,                       {����� ������������� ����}
         0,                       {����� �������� ����}
         hInstance,               {����� ���������� ����������}
         nil);                    {��������� �������� ����}

  ShowWindow(hwnd1,sw_showmaximized);

  while GetMessage(msg,0,0,0) do begin {�������� ��������� ���������}
      TranslateMessage(msg);   {Windows ����������� ��������� �� ����������}
      DispatchMessage(msg);    {Windows ������� ������� ���������}
  end; {����� �� wm_quit, �� ������� GetMessage ������ FALSE}
end;

begin
  WinMain;
end.
