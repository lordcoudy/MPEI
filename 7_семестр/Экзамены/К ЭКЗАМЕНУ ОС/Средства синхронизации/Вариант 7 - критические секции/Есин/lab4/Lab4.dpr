program Lab4;

uses windows, messages; {интерфейсы к системным DLL}

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

procedure WinMain; {основной цикл обработки сообщений}
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
         szClassName,             {имя класса окна}
         'Лабораторная работа 4, вариант 7',    {заголовок окна}
         ws_overlappedWindow,     {стиль окна}
         cw_useDefault,           {Left}
         cw_useDefault,           {Top}
         cw_useDefault,           {Width}
         cw_useDefault,           {Height}
         0,                       {хэндл родительского окна}
         0,                       {хэндл оконного меню}
         hInstance,               {хэндл экземпляра приложения}
         nil);                    {параметры создания окна}

  ShowWindow(hwnd, sw_Show);  {отобразить окно}
  updateWindow(hwnd);   {послать wm_paint оконной процедуре, прорисовав
                         окно минуя очередь сообщений (необязательно)}

  while GetMessage(msg, 0, 0, 0) do begin {получить очередное сообщение}
    TranslateMessage(msg);   {Windows транслирует сообщения от клавиатуры}
    DispatchMessage(msg);    {Windows вызовет оконную процедуру}
  end; {выход по wm_quit, на которое GetMessage вернет FALSE}
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
        hdc := BeginPaint(hwnd, ps); //удалить WM_PAINT из очереди и начать рисование
        GetClientRect(hwnd, rect);

        hPen := SelectObject(hdc, createPen(ps_Solid, 3, rgb(200,0,200)));

        SetStretchBltMode(hdc, COLORONCOLOR);

        // Запись изображения в память
        assignFile(f, 'background.bmp');
        reset(f);
        sze := filesize(f);
        getmem(imageP, sze);
        blockread(f, imageP^, sze);
        closeFile(f);

        integer(bmi) := integer(imageP) + sizeof(TBitmapFileheader);
        integer(data) := integer(imageP) + TBitmapFileheader(imageP^).bfOffBits;

        // Отрисовка изображения
        stretchDiBits(hdc,
                      rect.left, rect.top, rect.right, rect.bottom,
                      0, 0, bmi^.bmiheader.biWidth, bmi^.bmiheader.biHeight,
                      data,
                      bmi^, DIB_RGB_COLORS, srccopy);

        // Очистка памяти
        freemem(imageP);

        SelectObject(hdc, GetStockObject(NULL_BRUSH));

        // Переход к метрическим координатам
        SetMapMode(hdc, MM_LOMETRIC);
        SetViewportOrgEx(hdc, 0, rect.bottom, nil);

        // Координаты прямоугольника
        textRect.left := 100;
        textRect.right := 1100;
        textRect.top := 1100;
        textRect.bottom := 100;
        // Отрисовка прямоугольника
        rectangle(hdc, textRect.left, textRect.right, textRect.top, textRect.bottom);

        // Установка шрифта
        hf := SelectObject(hdc, CreateFont(49, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'courier'));
        SetBKMode(hdc, transparent);
        SetTextColor(hdc, RGB(0,0,0));

        // Отступы внутри прямоугольника
        textRect.left := textRect.left + 5;
        textRect.right := textRect.right - 5;
        textRect.top := textRect.top - 5;
        textRect.bottom := textRect.bottom + 5;

        // Запись текста из файла в память
        assignFile(f, 'lab4.dpr');
        reset(f);
        sze := filesize(f);
        getmem(textP, sze);
        blockread(f, textP^, sze);
        closeFile(f);

        // Отрисовка текста
        drawText(hdc, textP, sze, textRect, DT_WORD_ELLIPSIS);

        // Очистка памяти
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
