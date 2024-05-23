program lab7;

uses windows, messages, SysUtils;

var hBMP1: HBitmap;
    buff: array[0..255] of char;
    memdc1: Thandle;

{$R menu.res}

function CallDLL(a, b: pchar): char; CDecl; external 'lib7.dll' name 'proc7';

procedure Transliterate(inBuffer, outBuffer: Pointer);
var
  inPtr, outPtr: PChar;
  inChar: char;
  outChar: string;
  i: integer;
begin
  inPtr := inBuffer;
  outPtr := outBuffer;
  inChar := inPtr^;

  while (inChar <> '') do begin
    case inChar of
      '�': outChar := 'A';
      '�': outChar := 'a';
      '�': outChar := 'B';
      '�': outChar := 'b';
      '�': outChar := 'V';
      '�': outChar := 'v';
      '�': outChar := 'G';
      '�': outChar := 'g';
      '�': outChar := 'D';
      '�': outChar := 'd';
      '�': outChar := 'E';
      '�': outChar := 'e';
      '�': outChar := 'YO';
      '�': outChar := 'yo';
      '�': outChar := 'ZH';
      '�': outChar := 'zh';
      '�': outChar := 'Z';
      '�': outChar := 'z';
      '�': outChar := 'I';
      '�': outChar := 'i';
      '�': outChar := 'J';
      '�': outChar := 'j';
      '�': outChar := 'K';
      '�': outChar := 'k';
      '�': outChar := 'L';
      '�': outChar := 'l';
      '�': outChar := 'M';
      '�': outChar := 'm';
      '�': outChar := 'N';
      '�': outChar := 'n';
      '�': outChar := 'O';
      '�': outChar := 'o';
      '�': outChar := 'P';
      '�': outChar := 'p';
      '�': outChar := 'R';
      '�': outChar := 'r';
      '�': outChar := 'S';
      '�': outChar := 's';
      '�': outChar := 'T';
      '�': outChar := 't';
      '�': outChar := 'U';
      '�': outChar := 'u';
      '�': outChar := 'F';
      '�': outChar := 'f';
      '�': outChar := 'H';
      '�': outChar := 'h';
      '�': outChar := 'C';
      '�': outChar := 'c';
      '�': outChar := 'CH';
      '�': outChar := 'ch';
      '�': outChar := 'SH';
      '�': outChar := 'sh';
      '�': outChar := '';
      '�': outChar := 'shch';
      '�': outChar := char(34);
      '�': outChar := char(34);
      '�': outChar := 'Y';
      '�': outChar := 'y';
      '�': outChar := char(39);
      '�': outChar := char(39);
      '�': outChar := 'E';
      '�': outChar := 'e';
      '�': outChar := 'YU';
      '�': outChar := 'yu';
      '�': outChar := 'YA';
      '�': outChar := 'ya';
      else outChar := inChar;
    end;


    for i := 1 to length(outChar) do begin
      outPtr^ := outChar[i];
      inc(outPtr);
    end;

    inc(inPtr);
    inChar := inPtr^;
  end;
  outPtr^ := char(0);
end;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall; forward;
function DlgProc6(hDlg: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall; forward;
function WndProc4(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall; forward;
procedure OpenLab4(hwnd: THandle); forward;

procedure WinMain; {�������� ���� ��������� ���������}
  const szClassName = 'Lab7';
        lr4ClassName = 'Lab4_7';

  var wndClass, wndClass2: TWndClassEx;
      hWnd, hAcc: THandle;
      msg: TMsg;

begin
  wndClass.cbSize := sizeof(wndClass);
  wndClass.style := cs_hredraw or cs_vredraw;
  wndClass.lpfnWndProc := @WndProc;
  wndClass.cbClsExtra := 0;
  wndClass.cbWndExtra := 0;
  wndClass.hInstance := hInstance;
  wndClass.hIconSm := loadIcon(hInstance, 'Icon1');
  wndClass.hIcon := loadIcon(hInstance, 'Icon1');
  wndClass.hCursor := loadCursor(hInstance, 'Cursor1');
  wndClass.hbrBackground := CreateSolidBrush(GetSysColor(COLOR_BTNFACE));
  wndClass.lpszMenuName := 'Lab7Menu';
  wndClass.lpszClassName := szClassName;
  RegisterClassEx(wndClass);

  wndClass2.cbSize := sizeof(wndClass);
  wndClass2.style := cs_hredraw or cs_vredraw;
  wndClass2.lpfnWndProc := @WndProc4;
  wndClass2.cbClsExtra := 0;
  wndClass2.cbWndExtra := 0;
  wndClass2.hInstance := hInstance;
  wndClass2.hIcon := loadIcon(0, idi_Application);
  wndClass2.hCursor := loadCursor(0, idc_Arrow);
  wndClass2.hbrBackground := GetStockObject(NULL_BRUSH);
  wndClass2.lpszMenuName := nil;
  wndClass2.lpszClassName := lr4ClassName;
  wndClass2.hIconSm := wndClass2.hIcon;
  RegisterClassEx(wndClass2);

  loadString(hInstance, 7, @buff, 255);
  hAcc := LoadAccelerators(hInstance, 'ACC');

  hwnd := CreateWindowEx(
         0,
         szClassName,             {��� ������ ����}
         buff,                    {��������� ����}
         WS_OVERLAPPEDWINDOW,     {����� ����}
         cw_useDefault,           {Left}
         cw_useDefault,           {Top}
         400,                     {Width}
         300,                     {Height}
         0,                       {����� ������������� ����}
         0,                       {����� �������� ����}
         hInstance,               {����� ���������� ����������}
         nil);                    {��������� �������� ����}

  ShowWindow(hwnd,sw_Show);  {���������� ����}

  while GetMessage(msg,0,0,0) do begin {�������� ��������� ���������}
    if TranslateAccelerator(hwnd, hacc, msg) = 0 then begin
      if not IsDialogMessage(GetActiveWindow, msg) then begin
         TranslateMessage(msg);   {Windows ����������� ��������� �� ����������}
         DispatchMessage(msg);    {Windows ������� ������� ���������}
      end;
    end; {����� �� wm_quit, �� ������� GetMessage ������ FALSE}
  end;
end;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
begin
  result := 0;

  case Msg of
    WM_COMMAND:
    begin
      if HiWord(wparam) = 0 then begin //� ���������� ���� ������� ��� �����������
        case loWord(wParam) of
        100:  //EXIT
            SendMessage(hwnd, wm_close, 0, 0);
        204:  //Lab4
            OpenLab4(hwnd);
        206:  //Lab6
            DialogBox(hInstance, 'Lab6', hwnd, @DlgProc6);
        207:  //DLL
            CallDLL('First string'#0, 'Second string'#0);
        end;
      end;

      if ((HiWord(wparam) = 1) and (lparam = 0)) then begin
        case loword(wparam) of
          204: PostMessage(hwnd, wm_command, 204, 0);
          206: PostMessage(hwnd, wm_command, 206, 0);
          100: PostMessage(hwnd, wm_command, 100, 0);
        end;
      end;
    end;

    WM_CLOSE:
      PostQuitMessage(0);

    else
      result := DefWindowProc(hwnd, msg, wParam, lParam);
  end;
end;

function DlgProc6(hDlg: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
var
   ret: integer;
   inputBuffer: array[0..2000] of char;
   outputBuffer: array[0..8000] of char;

begin
    ret := 1;
    case Msg of
      WM_INITDIALOG:
          SendMessage(GetDlgItem(hdlg,203), BM_CLICK,0,0);

      WM_CLOSE:
          EndDialog(hDlg,0);

      WM_COMMAND:
        if (lParam=GetDlgItem(hdlg,102)) AND (hiWord(wparam)=EN_CHANGE) then begin
          GetWindowText(GetDlgItem(hdlg, 102), @inputBuffer, 2000);
          Transliterate(@inputBuffer, @outputBuffer);
          SetWindowText(GetDlgItem(hdlg, 104), @outputBuffer);
        end;

      else
        ret := 0;
    end;
    DlgProc6 := ret;
end;

function WndProc4(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
  var ps: TPaintStruct;
      hdc: THandle;
      hFont, hPen: THandle;
      rect, textRect: TRect;
      txt: string[255];
      data: windows.TBITMAP;
      b: boolean;
begin
  result := 0;
  case Msg of

    WM_CREATE:
    begin
      hBMP1 := loadBitmap(hInstance, 'backgroundBMP');
      hdc := getDC(hwnd);
      memDC1 := CreateCompatibleDC(hdc);
      releaseDC(hwnd, hdc);
      SelectObject(memDC1, hBMP1);
    end;

    WM_PAINT:
    begin
      hdc:=BeginPaint(hwnd, ps); //������� WM_PAINT �� ������� � ������ ���������
      GetClientRect(hwnd, rect);

      SetStretchBltMode(hdc, COLORONCOLOR);

      GetObject(hBMP1, sizeof(windows.TBITMAP), @data);
      StretchBlt(hdc, 0, 0, rect.right, rect.bottom, memDC1, 0, 0, data.bmWidth, data.bmHeight, SRCCOPY);

      // ������� � ����������� �����������
      SetMapMode(hdc, MM_LOMETRIC);
      SetViewportOrgEx(hdc, 0, rect.bottom, nil);

      // ���������� ��������������
      textRect.left := 100;
      textRect.right := 1100;
      textRect.top := 1100;
      textRect.bottom := 100;
      // ��������� ��������������
      SelectObject(hdc, GetStockObject(NULL_BRUSH));
      hPen := SelectObject(hdc, createPen(ps_Solid, 3, rgb(200,0,200)));
      rectangle(hdc, textRect.left, textRect.right, textRect.top, textRect.bottom);

      // ��������� ������
      hFont := SelectObject(hdc, CreateFont(-49, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'courier'));
      SetBKMode(hdc, transparent);
      SetTextColor(hdc, RGB(0,0,0));

      // ������� ������ ��������������
      textRect.left := textRect.left + 5;
      textRect.right := textRect.right - 5;
      textRect.top := textRect.top - 5;
      textRect.bottom := textRect.bottom + 5;

      // ��������� ������
      DrawText(hdc, @txt[1],  loadString(hInstance, 777, @txt[1], 255), textRect, DT_WORD_ELLIPSIS);

      DeleteObject(SelectObject(hdc, hFont));
      DeleteObject(SelectObject(hdc, hPen));

      endPaint(hwnd,ps);
    end;

    WM_CLOSE:
    begin
      b := DeleteObject(hBMP1);
      DeleteDC(memDC1);
      DestroyWindow(hwnd);
    end;

    else
      result := DefWindowProc(hwnd, msg, wparam, lparam);
  end;
end;

procedure OpenLab4(hwnd: THandle);
const lr4ClassName = 'Lab4_7';
var hwnd2: THandle;
begin
  loadString(hInstance, 4, @buff, 255);
  hwnd2 := CreateWindowEx(
         0,
         lr4ClassName,             {��� ������ ����}
         buff,                    {��������� ����}
         WS_OVERLAPPEDWINDOW,     {����� ����}
         CW_USEDEFAULT,           {Left}
         CW_USEDEFAULT,           {Top}
         1000,                    {Width}
         1000,                    {Height}
         hwnd,                    {����� ������������� ����}
         0,                       {����� �������� ����}
         hInstance,               {����� ���������� ����������}
         nil);                    {��������� �������� ����}

  ShowWindow(hwnd2, SW_SHOW);      {���������� ����}
  updateWindow(hwnd2);   {������� wm_paint ������� ���������, ���������� ���� ����� ������� ��������� (�������������)}
end;

begin
  WinMain;
end.


