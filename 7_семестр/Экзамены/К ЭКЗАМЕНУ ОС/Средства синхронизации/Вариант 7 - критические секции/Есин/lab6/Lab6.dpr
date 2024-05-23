program Lab6;

uses windows, sysutils,  messages;


function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

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

procedure WinMain; {�������� ���� ��������� ���������}
  const szClassName = 'Lab6';
  var   wndClass: TWndClassEx;
        msg: TMsg;
        hwnd: THandle;
begin
  wndClass.cbSize := sizeof(wndClass);
  wndClass.style := 0;
  wndClass.lpfnWndProc := @WndProc;
  wndClass.cbClsExtra := 0;
  wndClass.cbWndExtra := DLGWINDOWEXTRA; // ����� ����� ���� ������������ DefDlgProc
  wndClass.hInstance := hInstance;
  wndClass.hIcon := loadIcon(0, idi_Application);
  wndClass.hCursor := loadCursor(0, idc_Arrow);
  wndClass.hbrBackground := GetStockObject(ltgray_Brush);
  wndClass.lpszMenuName := nil;
  wndClass.lpszClassName := szClassName;
  wndClass.hIconSm := loadIcon(0, idi_Application);

  RegisterClassEx(wndClass);

  hwnd := CreateWindowEx(0,
         szClassName, {��� ������ ����}
         '������������ ������ 6', {��������� ����}
         ws_popupwindow or ws_sysmenu or ws_caption or ws_border or ws_visible, {����� ����}
         10,           {Left}
         10,           {Top}
         500,          {Width}
         520,          {Height}
         0,            {����� ������������� ����}
         0,            {����� �������� ����}
         hInstance,    {����� ���������� ����������}
         nil);         {��������� �������� ����}


  while GetMessage(msg, 0, 0, 0) do begin {�������� ��������� ���������}
    if not (IsDialogMessage(hwnd, msg))
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
  var rect, textRect1, textRect2: TRect;
      inputBuffer: array[0..2000] of char;
      outputBuffer: array[0..8000] of char;
      ps: TPaintStruct;
      hdc: THandle;
begin
  result := 0;
  case Msg of

    wm_paint:
    begin
      GetClientRect(hwnd, rect);
      hdc := BeginPaint(hWnd, ps);
      SetBKMode(hdc, transparent);
        
      textRect1.Left := 10;
      textRect1.Right := rect.right-10; 
      textRect1.Top := 10;   
      textRect1.Bottom := 30;
        
      textRect2.Left := 10;
      textRect2.Right := rect.right-10; 
      textRect2.Top := 250;   
      textRect2.Bottom := 270;
                                                                              
      DrawText(hdc, '������� �����:', 14, textRect1, DT_LEFT);
      DrawText(hdc, '������������������� �����:', 26, textRect2, DT_LEFT);
      endPaint(hWnd, ps);
    end;
  
    wm_create: {������ ���������� ��������� ��� �������� �������� ����}
    begin
      GetClientRect(hwnd, rect); //������� ���������� �������
        
      CreateWindowEx(WS_EX_CLIENTEDGE,
                 'edit',
                 '',
                 ws_visible or ws_child or ws_border or ws_tabstop or es_multiline or ws_vscroll,
                 10,
                 40,
                 rect.right-20,
                 200,
                 hwnd,
                 1,
                 hInstance,
                 nil);

      SendDlgItemMessage(hwnd, 1, EM_SETLIMITTEXT, 2000, 0);

      CreateWindowEx(WS_EX_CLIENTEDGE,
                 'edit',
                 '',
                 ws_visible or ws_child or ws_border or ws_tabstop or es_multiline or ws_vscroll or es_readonly,
                 10,
                 280,
                 rect.right-20,
                 200,
                 hwnd,
                 2,
                 hInstance,
                 nil);
    end;

    wm_command: // ��������� ������ �� ���� ������� ����������
    begin
      if (hiword(wParam) = EN_CHANGE) then begin
        SendDlgItemMessage(hwnd, 1, wm_gettext, sizeOf(inputBuffer), integer(@inputBuffer));
        Transliterate(@inputBuffer, @outputBuffer);
        SendDlgItemMessage(hwnd, 2, wm_settext, sizeOf(outputBuffer), integer(@outputBuffer));
      end;
    end;

    wm_close: // DefDlgProc ������ �� ������ �� ��������� - ��� ��������� �������� � ��������� �������, ������� � ��� ���
      DestroyWindow(hwnd);
    wm_destroy: // ������ ���������� ������������ �������������
      PostQuitMessage(0);
    else
      result := DefDlgProc(hwnd, msg, wparam, lparam);
  end;
end;


begin
  WinMain;
end.

