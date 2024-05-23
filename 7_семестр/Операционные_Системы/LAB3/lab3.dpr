program lab3;

uses windows,messages;                                // ��������� � ��������� DLL � ���������-���������

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

function WndProcToolbar(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

procedure WinMain;
  const szClassName='mainWindow';
        szClassNameChild='childWindow';  
  var   wndClass:TWndClassEx;
        msg:TMsg;
        hWnd, hWndChild1, hWndChild2: THandle;
begin

  fillchar(wndClass,sizeof(wndClass),0);              // ������� ��� ����
  wndClass.cbSize:=sizeof(wndClass);                  // ��������� ����� �� ������� �����������
  wndClass.style:=cs_hredraw or cs_vredraw;           // ����� ��������� (��������������� �� ���������������)
  wndClass.lpfnWndProc:=@WndProc;                     // ��������� ����
  wndClass.cbClsExtra:=0;
  wndClass.cbWndExtra:=0;
  wndClass.hInstance:=hInstance;
  wndClass.hIcon:=loadIcon(0, idi_Application);
  wndClass.hCursor:=loadCursor(0, idc_Arrow);
  wndClass.hbrBackground:=GetStockObject(white_Brush);
  wndClass.lpszMenuName:=nil;
  wndClass.lpszClassName:=szClassName;                // ��� �������� ������
  wndClass.hIconSm:=loadIcon(0, idi_Application);

  RegisterClassEx(wndClass);                          // ����������� �������� ������

  fillchar(wndClass,sizeof(wndClass),0);
  wndClass.cbSize:=sizeof(wndClass);
  wndClass.style:=cs_hredraw or cs_vredraw or cs_parentdc;
  wndClass.lpfnWndProc:=@WndProcToolbar;
  wndClass.cbClsExtra:=0;
  wndClass.cbWndExtra:=0;
  wndClass.hInstance:=hInstance;
  wndClass.hIcon:=loadIcon(0, idi_Application);
  wndClass.hCursor:=loadCursor(0, idc_Arrow);
  wndClass.hbrBackground:=GetStockObject(white_Brush);
  wndClass.lpszMenuName:=nil;
  wndClass.lpszClassName:=szClassNameChild;
  wndClass.hIconSm:=loadIcon(0, idi_Application);

  RegisterClassEx(wndClass);                           // ����������� �������� ������}

  // �������� ����
  hwnd:=CreateWindow(
         szClassName,                                 // ��� �������� ������
         '��������� ����',                            // ��������� ����
         ws_overlappedWindow,                         // ����� ���� (������������� ����)
         cw_useDefault,                               // ����
         cw_useDefault,                               // ����
         600,                                         // ������
         300,                                         // ������
         0,                                           // ����� ������������� ����
         0,                                           // ����� �������� ����
         hInstance,                                   // ����� ���������� ����������
         nil);                                        // ��������� �������� ����

  ShowWindow(hwnd,sw_Show);                           // ���������� ����

  // �������� ����
  hWndChild1:=CreateWindow(
        szClassNameChild,                             // ��� �������� ������
        'Toolbal 1',                                  // ��������� ����
        ws_child or ws_caption or ws_sysmenu,         // ����� ���� (����)
        15,           
        15,           
        200,          
        50,           
        hWnd,                      
        0,                       
        hInstance,               
        nil);                   

  ShowWindow(hWndChild1,sw_Show);  

  // �������� ����
  hWndChild2:=CreateWindow(
        szClassNameChild,
        'Toolbal 2',    
        ws_child or ws_caption or ws_sysmenu,     
        315,           
        15,           
        200,           
        50,           
        hWnd,                       
        0,                       
        hInstance,               
        nil);                    

  ShowWindow(hWndChild2,sw_Show);  

  // ��������� ���������
  while GetMessage(msg,0,0,0)=true do begin 
        TranslateMessage(msg);                         // ������� ���������
        DispatchMessage(msg);                          // ��������� ��������� � ���������
      end;
end;


// ��������� �������� ����
function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint; stdcall;
  var ps:TPaintStruct;
      hdc:THandle;
      rect:TRect;
begin
  result:=0;
  // ��������� ���������
  case Msg of
    wm_paint:
      begin
        hdc:=BeginPaint(hwnd,ps);
        GetClientRect(hwnd,rect);

        // ��������� � ���������� �������
        DrawText(hdc,'���������� �������',-1,rect,
                 DT_SINGLELINE or DT_VCENTER or DT_CENTER);

        endPaint(hwnd,ps);
      end;
    wm_destroy:
        // �����������
        PostQuitMessage(0);
    else
        // �� ���������
      result:=DefWindowProc(hwnd,msg,wparam,lparam);
  end;
end;


// ��������� �������
function WndProcToolbar(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint; stdcall;
  var ps:TPaintStruct;
      hdc:THandle;
      rect:TRect;
begin
  result:=0;
  case Msg of
    wm_paint:
      begin
        hdc:=BeginPaint(hwnd,ps);
        GetClientRect(hwnd,rect);

        DrawText(hdc,'����',-1,rect,
                 DT_SINGLELINE or DT_VCENTER or DT_CENTER);

        endPaint(hwnd,ps);
      end;
      wm_close:
        DestroyWindow(hWnd);
    else
      result:=DefWindowProc(hwnd,msg,wparam,lparam);
  end;
end;


begin
  WinMain;
end.
