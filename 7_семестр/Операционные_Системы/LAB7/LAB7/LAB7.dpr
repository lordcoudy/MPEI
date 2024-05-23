// A-08-19 Balashov, var 4

Program lab7;
Uses Windows, Messages, Dialogs, SysUtils;


{$R  'res7.res'}

// Static loading of function
Procedure static(a, b : Integer); stdcall; external 'LIB7.dll' name 'static';

// Dynamic loading of function
Var Proc4 : Procedure(a, b : PChar) cdecl; 

hLib7 : hModule;

Function Lab6Dialog(hdlg: THandle; Msg: integer; wParam: longint; lParam: longint): LRESULT; stdcall;
const
      IDEdit=6;                                                     // ID of Edit control - EditText
      IDListbox=7;                                                  // ID of listbox control - ListBox
      listLength=13;
      liststrings: array[0..listLength] of AnsiString = (
        'Cyberpunk Edgerunners'#0, 
        'Top-Gun: Maverick'#0, 
        'Scarface'#0, 
        'Big eyes'#0, 
        'Neon White'#0, 
        'Rum diary'#0, 
        'Chrome'#0,
        'Love, Death & Robots'#0,
        'Skyrim'#0,
        'Arkane'#0,
        'Treasure Island'#0,
        'Taxi Driver'#0,
        'Bullet Train'#0,
        'DOOM'#0
      );
      idCancel = 4;
       // Z-strings for listbox

  var i:integer;
      listelements: array[0..listLength] of PChar;                  // array of string pointers
      buffer: array[0..255] of char;                                // BUF size
begin
  result:=0;
  case Msg of
    wm_initdialog: {Органы управления создаются при создании главного окна}
      begin
        for i:=0 to listLength do begin
          listelements[i]:=@liststrings[i][1];                      // Pointers now point at first symbol of each string
          SendMessage(
            GetDlgItem(hdlg,IDListbox), 
            LB_ADDSTRING, 
            0, 
            Integer(listelements[i])
          );                                                        // Put strings to listbox with ADDSTRING
          //GetDlgItem - returns Edit handle
        end;

      end;

    wm_command:                                                    
      case hiword(wParam) of                                        // If in High word of WPARAM:
            LBN_SELCHANGE:                                          // User changed smth in listbox
              if (loword(wparam)=IDListBox) then begin              // if Low word contains listbox id
                i:=SendDlgItemMessage(
                  hdlg, 
                  IDListbox, 
                  LB_GETCURSEL,
                  0,
                  0
                );                                                  // Send message with chosen string
                if i>=0 then                                        // If certain string was chosen
                  SendDlgItemMessage(
                    hdlg,
                    IDListbox, 
                    LB_GETTEXT,
                    i,
                    Integer(@buffer)
                  )                                                 // Send a message that string was recognised and was put into buffer

                else
                  buffer[0]:=#0;                                    // Or buffer is empty
                  SendDlgItemMessage(
                    hdlg, 
                    IDEdit, 
                    WM_SETTEXT, 
                    SizeOf(buffer),
                    Integer(@buffer)
                  );                                                // Send chosen string to Edit
              end;

            EN_CHANGE:                                              // Letter is printed to edit and already is visible
              if (loword(wParam)=IDEdit) then begin                 // if Low word contains edit id
                SendDlgItemMessage(
                  hdlg,
                  IDEdit, 
                  WM_GETTEXT,
                  SizeOf(buffer),
                  Integer(@buffer)
                );                                                  // Get text of chosen string
                if (SendMessage(
                  GetDlgItem(hdlg, IDListbox), 
                  LB_SELECTSTRING, 
                  -1, 
                  Integer(@buffer))=LB_ERR
                ) then                                              // If such string was not found in listbox
                    SendMessage(
                      GetDlgItem(hdlg, IDListbox), 
                      LB_SETCURSEL, 
                      -1, 
                      -1
                    );                                              // Do not highlight any strings
              end;

            BN_CLICKED:
              if (loword(wParam)=idCancel) then 
              EndDialog(hdlg,idCancel);
      end;        



    wm_close:
      begin
        EndDialog(hdlg,idCancel);
      end;
    else
      result:=0;
  end;
end;

Function Lab4Dialog(hdlg: THandle; Msg: integer; wParam: longint; lParam: longint): LRESULT; stdcall;
  var ps:TPaintStruct;
      hdc:THandle;
      hpen:THandle;
      rect:TRect;
      fontInfo : TLogFont;
      hfnt : HFont;
      hBitmap :THandle;
      hbrsh:HBRUSH;
  const
    idCancel = 4;
begin
  result:=0;
  case Msg of
    wm_paint:
      begin
        hdc:=BeginPaint(hdlg,ps);
        GetClientRect(hdlg,rect);

        hPen:=SelectObject(hdc,createPen(ps_Solid,3,rgb(0,200,0)));
        SetRop2(hdc,r2_copypen);

        hBitmap := LoadBitmap(hInstance, 'SHUT');
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

        endPaint(hdlg,ps);
      end;
    wm_close:
      begin
        EndDialog(hdlg,idCancel);
      end;
    else
      result:=0;
      // no DefDlgProc
  end;
end;



function wndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
  var ps:TPaintStruct;
      hdc:THandle;
      hpen:THandle;
      rect:TRect;
      hBitmap :THandle;
      hbrsh:HBRUSH;
      word1, word2 : PChar;
begin
  result:=0;
  word1:='Hello';
  word2:='world!';
  case Msg of
    wm_create:
      begin
        // "Load" DLL, actually it's already loaded so just +1 to counter
        hLib7 := LoadLibrary('LIB7.dll');
        // Set the dynamic procedure on a certain one in dll (procd4)
        @Proc4 := GetProcAddress(hLib7, 'proc4');
      end;
    wm_command:
      if hiword(wparam)=0 then begin // Looks like it's a dialog
        case loword(wparam) of
          101: DialogBox(hLib7, 'Lab6Dialog', hwnd, @Lab6Dialog); // Lab6 - Search in list
          102: DialogBox(hLib7, 'Lab4Dialog', hwnd, @Lab4Dialog); // Lab4 - Picture
          103: Proc4(word1, word2); //Параметры
          104: SendMessage(hwnd, wm_close, 0, 0);
        end;
      end;
    wm_paint:
      begin
        hdc := BeginPaint(hWnd,ps); // Delete wm_paint from waitlist and start drawing
        GetClientRect(hWnd,rect);

        hPen:=SelectObject(hdc,createPen(ps_Solid,3,rgb(0,200,0)));

        //DRAW      
        hBitmap := LoadBitmap(hInstance, 'BACKGROUND');
        hbrsh := SelectObject(hdc, CreatePatternBrush(hBitmap));  
        Rectangle(hdc, rect.left, rect.top, rect.right, rect.bottom); 
 
        DeleteObject(SelectObject(hdc, hbrsh)); 
        DeleteObject(hBitmap); 
        //END DRAW

        SetMapMode(hdc, MM_LOMETRIC);
        SetWindowExtEx(hdc, 128, 128, nil);

        SelectObject(hdc, GetStockObject(BLACK_BRUSH));
        DeleteObject(SelectObject(hdc, hPen));

        endPaint(hWnd,ps);
      end;
    wm_close:
      Begin // Everything else is destroyed automatically
        FreeLibrary(hLib7);
        PostQuitMessage(0);
      end;
    else
      result:=DefWindowProc(hwnd,msg,wparam,lparam);
  end;
end;

procedure WinMain; {Основной цикл обработки сообщений}
  const szClassName='Balashov';
  var   wndClass:TWndClassEx;
        msg:TMsg;
        hwnd1:THandle;
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
         szClassName, {имя класса окна}
         @sbuf,    {заголовок окна}
         ws_overlappedwindow,       {стиль окна}
         10,           {Left}
         10,           {Top}
         500,                     {Width}
         300,                     {Height}
         0,                       {хэндл родительского окна}
         0,                       {хэндл оконного меню}
         hInstance,               {хэндл экземпляра приложения}
         nil);                    {параметры создания окна}

  ShowWindow(hwnd1,sw_showmaximized);

  while GetMessage(msg,0,0,0) do begin {получить очередное сообщение}
      TranslateMessage(msg);   {Windows транслирует сообщения от клавиатуры}
      DispatchMessage(msg);    {Windows вызовет оконную процедуру}
  end; {выход по wm_quit, на которое GetMessage вернет FALSE}
end;


begin
  WinMain;
end.
