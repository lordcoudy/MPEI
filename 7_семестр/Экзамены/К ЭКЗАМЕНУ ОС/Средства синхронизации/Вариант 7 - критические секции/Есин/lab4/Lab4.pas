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
  wndClass.hInstance:=hPrevInst;
  wndClass.hInstance:=hInstance;
  wndClass.hIcon:=loadIcon(0, idi_Application);
  wndClass.hCursor:=loadCursor(0, idc_Arrow);
  wndClass.hbrBackground:=GetStockObject(black_Brush);
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
      color:integer;
      p:pointer;
      bmi:^TBitmapInfo;
      data:pointer;
      f:file;
      sze:integer;
      lf:TLogFont;
      hf:THandle;
begin
  result:=0;
  case Msg of
    wm_paint:
      begin
        hdc:=BeginPaint(hwnd,ps); //������� WM_PAINT �� ������� � ������ ���������
        GetClientRect(hwnd,rect);

        hPen:=SelectObject(hdc,createPen(ps_Solid,3,rgb(0,200,0)));
        SetRop2(hdc,r2_xorpen);

        assignFile(f,'wallppr.bmp'); reset(f,1);
        sze:=filesize(f);
        getmem(p,sze);
        blockread(f,p^,sze);
        closeFile(f);

        integer(bmi):=integer(p)+sizeof(TBitmapFileheader);
        integer(data):=integer(p)+TBitmapFileheader(p^).bfOffBits;

        stretchDiBits(hdc,
                      rect.left,rect.top,rect.right,rect.bottom,
                      0,0,bmi^.bmiheader.biWidth, bmi^.bmiheader.biHeight,
                      data,
                      bmi^,DIB_RGB_COLORS,srccopy);

        SelectObject(hdc,GetStockObject(black_Brush));
        rectangle(hdc,10,10,130,130);


        fillchar(lf,sizeof(lf),0);
        with lf do begin
          lfHeight:=16; 
          lfFaceName:='Courier New Cyr';
        end;
        hf:=SelectObject(hdc,createFontIndirect(lf));
        textOut(hdc,30,30,'����������',10);
        DeleteObject(SelectObject(hdc,hf));

        SetRop2(hdc,r2_copypen);
        DeleteObject(SelectObject(hdc,hPen));

        freemem(p);

        SetMapMode(hdc, MM_ISOTROPIC);
        SetWindowExtEx(hdc, 512, 512, nil);
        SetViewportExtEx(hdc, rect.right, -rect.bottom, nil); {����� -> Y �����}
        SetViewportOrgEx(hdc, rect.right div 2, rect.bottom div 2, nil);

        moveToEx(hdc,-128,-128,nil);  lineTo(hdc,128,128);
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
