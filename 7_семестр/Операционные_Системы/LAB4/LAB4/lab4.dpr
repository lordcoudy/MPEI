program lab4;

uses windows,messages; {���������� � ��������� DLL}

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
  wndClass.hInstance:=hInstance;
  wndClass.hIcon:=loadIcon(0, idi_Application);
  wndClass.hCursor:=loadCursor(0, idc_Arrow);
  wndClass.hbrBackground:=GetStockObject(BLACK_BRUSH);
  wndClass.lpszMenuName:=nil;
  wndClass.lpszClassName:=szClassName;
  wndClass.hIconSm:=loadIcon(0, idi_Application);

  RegisterClassEx(wndClass);

  hwnd:=CreateWindowEx(
         0,
         szClassName, {��� ������ ����}
         '��������� ����',    {��������� ����}
         ws_overlappedWindow,     {����� ����}
         cw_useDefault,           {Left}
         cw_useDefault,           {Top}
         cw_useDefault,           {Width}
         cw_useDefault,           {Height}
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
      hpen:THandle;
      rect:TRect;
      p:pointer;
      bmi:^TBitmapInfo;
      data:pointer;
      f:file;
      sze:integer;
      fontInfo : TLogFont;
      hfnt : HFont;
      hBitmap :THandle;
      hbrsh:HBRUSH;

begin
  result:=0;
  case Msg of
    wm_paint:
      begin
        hdc:=BeginPaint(hwnd,ps); //������� WM_PAINT �� ������� � ������ ���������
        GetClientRect(hwnd,rect);

        hPen:=SelectObject(hdc,createPen(ps_Solid,3,rgb(0,200,0)));
        SetRop2(hdc,r2_copypen);


        hBitmap := LoadImage(hdc, 'shut.bmp', IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE);
        //hBitmap := LoadBitmap(hInstance, 'shut.bmp');
        hbrsh := SelectObject(hdc, CreatePatternBrush(hBitmap));  
        Rectangle(hdc, rect.left, rect.top, rect.right, rect.bottom);

        DeleteObject(SelectObject(hdc, hbrsh)); 
        DeleteObject(hBitmap);

        SetMapMode(hdc, MM_LOMETRIC);
        SetWindowExtEx(hdc, 512, 512, nil);

        SelectObject(hdc, GetStockObject(NULL_BRUSH));
        rectangle(hdc, 0, 0, 1000, -1000);
        DeleteObject(SelectObject(hdc, hPen));

        fontInfo.lfHeight := -14 * GetDeviceCaps(hDC, LOGPIXELSY) div 72;
        fontInfo.lfWidth := 0;
        fontInfo.lfEscapement := 450;
        fontInfo.lfOrientation := 0;
        fontInfo.lfWeight := 400;
        fontInfo.lfItalic := 0;
        fontInfo.lfUnderline := 0;
        fontInfo.lfStrikeOut := 0;
        fontInfo.lfFaceName := 'Courier'#0;


        

        hfnt := SelectObject(hdc, CreateFontIndirect(fontInfo));
        textOut(hdc, 250, -250, 'Shut your mouth', 15);
        DeleteObject(SelectObject(hdc, hfnt));


        
        SetRop2(hdc, r2_copypen);
        freemem(p);
        endPaint(hwnd,ps);
      end;
    wm_destroy:
      PostQuitMessage(0);
    else
      result:=DefWindowProc(hwnd,msg,wparam,lparam);
  end;
end;



begin
  WinMain;
end.

