program Lab4;

uses windows, messages; {���������� � ��������� DLL}

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

procedure WinMain; {�������� ���� ��������� ���������}
  const szClassName = 'lab4';
  var   wndClass: TWndClassEx;
        hWnd: THandle;
        msg: TMsg;
begin
  wndClass.cbSize := sizeof(wndClass);
  wndClass.style := cs_hredraw or cs_vredraw;
  wndClass.lpfnWndProc := @WndProc;
  wndClass.cbClsExtra := 0;
  wndClass.cbWndExtra := 0;
  wndClass.hInstance := hInstance;
  wndClass.hIcon := loadIcon(0, idi_Application);
  wndClass.hCursor := loadCursor(0, idc_Arrow);
  wndClass.hbrBackground := GetStockObject(black_Brush);
  wndClass.lpszMenuName := nil;
  wndClass.lpszClassName := szClassName;
  wndClass.hIconSm:=loadIcon(0, idi_Application);

  RegisterClassEx(wndClass);

  hwnd := CreateWindowEx(
         0,
         szClassName,             {��� ������ ����}
         '������������ ������ 4, ������� 7',    {��������� ����}
         ws_overlappedWindow,     {����� ����}
         cw_useDefault,           {Left}
         cw_useDefault,           {Top}
         cw_useDefault,           {Width}
         cw_useDefault,           {Height}
         0,                       {����� ������������� ����}
         0,                       {����� �������� ����}
         hInstance,               {����� ���������� ����������}
         nil);                    {��������� �������� ����}

  ShowWindow(hwnd, sw_Show);  {���������� ����}
  updateWindow(hwnd);   {������� wm_paint ������� ���������, ����������
                         ���� ����� ������� ��������� (�������������)}

  while GetMessage(msg, 0, 0, 0) do begin {�������� ��������� ���������}
    TranslateMessage(msg);   {Windows ����������� ��������� �� ����������}
    DispatchMessage(msg);    {Windows ������� ������� ���������}
  end; {����� �� wm_quit, �� ������� GetMessage ������ FALSE}
end;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
  var ps: TPaintStruct;
      hdc: THandle;
      hpen: THandle;
      rect, textRect: TRect;
      color: integer;
      imageP, textP: pointer;
      bmi: ^TBitmapInfo;
      data: pointer;
      f: file of byte;
      sze: integer;
      lf: TLogFont;
      hf: THandle;
begin
  result := 0;
  case Msg of
    wm_paint:
      begin
        hdc := BeginPaint(hwnd, ps); //������� WM_PAINT �� ������� � ������ ���������
        GetClientRect(hwnd, rect);

        hPen := SelectObject(hdc, createPen(ps_Solid, 3, rgb(200,0,200)));

        SetStretchBltMode(hdc, COLORONCOLOR);

        // ������ ����������� � ������
        assignFile(f, 'background.bmp');
        reset(f);
        sze := filesize(f);
        getmem(imageP, sze);
        blockread(f, imageP^, sze);
        closeFile(f);

        integer(bmi) := integer(imageP) + sizeof(TBitmapFileheader);
        integer(data) := integer(imageP) + TBitmapFileheader(imageP^).bfOffBits;

        // ��������� �����������
        stretchDiBits(hdc,
                      rect.left, rect.top, rect.right, rect.bottom,
                      0, 0, bmi^.bmiheader.biWidth, bmi^.bmiheader.biHeight,
                      data,
                      bmi^, DIB_RGB_COLORS, srccopy);

        // ������� ������
        freemem(imageP);

        SelectObject(hdc, GetStockObject(NULL_BRUSH));

        // ������� � ����������� �����������
        SetMapMode(hdc, MM_LOMETRIC);
        SetViewportOrgEx(hdc, 0, rect.bottom, nil);

        // ���������� ��������������
        textRect.left := 100;
        textRect.right := 1100;
        textRect.top := 1100;
        textRect.bottom := 100;
        // ��������� ��������������
        rectangle(hdc, textRect.left, textRect.right, textRect.top, textRect.bottom);

        // ��������� ������
        hf := SelectObject(hdc, CreateFont(49, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'courier'));
        SetBKMode(hdc, transparent);
        SetTextColor(hdc, RGB(0,0,0));

        // ������� ������ ��������������
        textRect.left := textRect.left + 5;
        textRect.right := textRect.right - 5;
        textRect.top := textRect.top - 5;
        textRect.bottom := textRect.bottom + 5;

        // ������ ������ �� ����� � ������
        assignFile(f, 'lab4.dpr');
        reset(f);
        sze := filesize(f);
        getmem(textP, sze);
        blockread(f, textP^, sze);
        closeFile(f);

        // ��������� ������
        drawText(hdc, textP, sze, textRect, DT_WORD_ELLIPSIS);

        // ������� ������
        freemem(textP);

        DeleteObject(SelectObject(hdc, hf));
        DeleteObject(SelectObject(hdc, hPen));
        endPaint(hwnd, ps);
      end;
    wm_destroy:
      PostQuitMessage(0);
    else
      result := DefWindowProc(hwnd,msg,wparam,lparam);
  end;
end;



begin
  WinMain;
end.
