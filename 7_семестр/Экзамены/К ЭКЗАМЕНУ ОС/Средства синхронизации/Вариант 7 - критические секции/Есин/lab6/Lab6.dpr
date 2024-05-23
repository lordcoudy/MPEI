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
      'А': outChar := 'A';
      'а': outChar := 'a';
      'Б': outChar := 'B';
      'б': outChar := 'b';
      'В': outChar := 'V';
      'в': outChar := 'v';
      'Г': outChar := 'G'; 
      'г': outChar := 'g';
      'Д': outChar := 'D'; 
      'д': outChar := 'd';
      'Е': outChar := 'E'; 
      'е': outChar := 'e';
      'Ё': outChar := 'YO'; 
      'ё': outChar := 'yo';
      'Ж': outChar := 'ZH'; 
      'ж': outChar := 'zh';
      'З': outChar := 'Z'; 
      'з': outChar := 'z';
      'И': outChar := 'I'; 
      'и': outChar := 'i';
      'Й': outChar := 'J'; 
      'й': outChar := 'j';
      'К': outChar := 'K'; 
      'к': outChar := 'k';
      'Л': outChar := 'L'; 
      'л': outChar := 'l';
      'М': outChar := 'M'; 
      'м': outChar := 'm';
      'Н': outChar := 'N'; 
      'н': outChar := 'n';
      'О': outChar := 'O';  
      'о': outChar := 'o';
      'П': outChar := 'P'; 
      'п': outChar := 'p';
      'Р': outChar := 'R'; 
      'р': outChar := 'r';
      'С': outChar := 'S';  
      'с': outChar := 's';
      'Т': outChar := 'T'; 
      'т': outChar := 't';
      'У': outChar := 'U';  
      'у': outChar := 'u';
      'Ф': outChar := 'F'; 
      'ф': outChar := 'f';
      'Х': outChar := 'H'; 
      'х': outChar := 'h';
      'Ц': outChar := 'C';  
      'ц': outChar := 'c';
      'Ч': outChar := 'CH';   
      'ч': outChar := 'ch';
      'Ш': outChar := 'SH'; 
      'ш': outChar := 'sh';
      'Щ': outChar := '';
      'щ': outChar := 'shch';
      'Ъ': outChar := char(34); 
      'ъ': outChar := char(34);
      'Ы': outChar := 'Y';  
      'ы': outChar := 'y';
      'Ь': outChar := char(39); 
      'ь': outChar := char(39);
      'Э': outChar := 'E';  
      'э': outChar := 'e';
      'Ю': outChar := 'YU';  
      'ю': outChar := 'yu';
      'Я': outChar := 'YA'; 
      'я': outChar := 'ya';
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

procedure WinMain; {Основной цикл обработки сообщений}
  const szClassName = 'Lab6';
  var   wndClass: TWndClassEx;
        msg: TMsg;
        hwnd: THandle;
begin
  wndClass.cbSize := sizeof(wndClass);
  wndClass.style := 0;
  wndClass.lpfnWndProc := @WndProc;
  wndClass.cbClsExtra := 0;
  wndClass.cbWndExtra := DLGWINDOWEXTRA; // Чтобы можно было использовать DefDlgProc
  wndClass.hInstance := hInstance;
  wndClass.hIcon := loadIcon(0, idi_Application);
  wndClass.hCursor := loadCursor(0, idc_Arrow);
  wndClass.hbrBackground := GetStockObject(ltgray_Brush);
  wndClass.lpszMenuName := nil;
  wndClass.lpszClassName := szClassName;
  wndClass.hIconSm := loadIcon(0, idi_Application);

  RegisterClassEx(wndClass);

  hwnd := CreateWindowEx(0,
         szClassName, {имя класса окна}
         'Лабораторная работа 6', {заголовок окна}
         ws_popupwindow or ws_sysmenu or ws_caption or ws_border or ws_visible, {стиль окна}
         10,           {Left}
         10,           {Top}
         500,          {Width}
         520,          {Height}
         0,            {хэндл родительского окна}
         0,            {хэндл оконного меню}
         hInstance,    {хэндл экземпляра приложения}
         nil);         {параметры создания окна}


  while GetMessage(msg, 0, 0, 0) do begin {получить очередное сообщение}
    if not (IsDialogMessage(hwnd, msg))
           {Если Windows не распознает и не обрабатывает клавиатурные сообщения
            как команды переключения между оконными органами управления,
            тогда сообщение идет на стандартную обработку}
    then begin
      TranslateMessage(msg);   {Windows транслирует сообщения от клавиатуры}
      DispatchMessage(msg);    {Windows вызовет оконную процедуру}
    end;
  end; {выход по wm_quit, на которое GetMessage вернет FALSE}
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
                                                                              
      DrawText(hdc, 'Введите текст:', 14, textRect1, DT_LEFT);
      DrawText(hdc, 'Транслитерированный текст:', 26, textRect2, DT_LEFT);
      endPaint(hWnd, ps);
    end;
  
    wm_create: {Органы управления создаются при создании главного окна}
    begin
      GetClientRect(hwnd, rect); //размеры клиентской области
        
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

    wm_command: // Обработка команд от всех органов управления
    begin
      if (hiword(wParam) = EN_CHANGE) then begin
        SendDlgItemMessage(hwnd, 1, wm_gettext, sizeOf(inputBuffer), integer(@inputBuffer));
        Transliterate(@inputBuffer, @outputBuffer);
        SendDlgItemMessage(hwnd, 2, wm_settext, sizeOf(outputBuffer), integer(@outputBuffer));
      end;
    end;

    wm_close: // DefDlgProc ничего не делает по умолчанию - это сообщение отдается в процедуру диалога, которой у нас нет
      DestroyWindow(hwnd);
    wm_destroy: // Органы управления уничтожаются автоматически
      PostQuitMessage(0);
    else
      result := DefDlgProc(hwnd, msg, wparam, lparam);
  end;
end;


begin
  WinMain;
end.

