program lab8server;

uses windows,messages, Math, SysUtils; {интерфейсы к системным DLL}

var
  msgBroadcast: THandle;
  msgAccept: THandle;
  msgLeave: THandle;

  clientName:ShortString;
  hOpponent: THandle;

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

procedure WinMain; {Основной цикл обработки сообщений}
  const szClassName='Shablon';
  var   wndClass:TWndClassEx;
        hWnd: THandle;
        msg:TMsg;
begin
  msgBroadcast := RegisterWindowMessage('Ау, тут есть сервер?');
  msgAccept := RegisterWindowMessage('Да');
  msgLeave := RegisterWindowMessage('Сервер я пошел');

  hOpponent := 0;

  wndClass.cbSize:=sizeof(wndClass);
  wndClass.style:=cs_hredraw or cs_vredraw;
  wndClass.lpfnWndProc:=@WndProc;
  wndClass.cbClsExtra:=0;
  wndClass.cbWndExtra:=0;
  //wndClass.hInstance:=hPrevInst;
  wndClass.hInstance:=hInstance;
  wndClass.hIcon:=loadIcon(0, idi_Application);
  wndClass.hCursor:=loadCursor(0, idc_Arrow);
  wndClass.hbrBackground:=GetStockObject(white_Brush);
  wndClass.lpszMenuName:=nil;
  wndClass.lpszClassName:=szClassName;
  wndClass.hIconSm:=loadIcon(0, idi_Application);

  RegisterClassEx(wndClass);

  hwnd:=CreateWindowEx(
         0,
         szClassName, {имя класса окна}
         'Клиент',    {заголовок окна}
         ws_overlappedWindow,     {стиль окна}
         cw_useDefault,           {Left}
         cw_useDefault,           {Top}
         500,           {Width}
         400,           {Height}
         0,                       {хэндл родительского окна}
         0,                       {хэндл оконного меню}
         hInstance,               {хэндл экземпляра приложения}
         nil);                    {параметры создания окна}

  ShowWindow(hwnd,sw_Show);  {отобразить окно}
  updateWindow(hwnd);   {послать wm_paint оконной процедуре, прорисовав
                         окно минуя очередь сообщений (необязательно)}

  while GetMessage(msg,0,0,0) do begin {получить очередное сообщение}
    TranslateMessage(msg);   {Windows транслирует сообщения от клавиатуры}
    DispatchMessage(msg);    {Windows вызовет оконную процедуру}
  end; {выход по wm_quit, на которое GetMessage вернет FALSE}
end;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
  var ps:TPaintStruct;
      hdc:THandle;
      rect:TRect;

      lf:TLogFont;
      hf:THandle;

      hMapping: THandle;
      pData: pointer;
      
begin
  result:=0;
  case Msg of
    wm_create:
        begin
          clientName := 'Не подключен';
          //Отправка широковещательного сообщения - проверка наличия сервера
          SendMessage(HWND_BROADCAST, msgBroadcast, hWnd, 0);
        end;

    wm_paint:
      begin


        hdc:=BeginPaint(hwnd,ps); //Удалить WM_PAINT из очереди и начать рисование
        GetClientRect(hwnd,rect);
        rect.Top := rect.Top - 100;

        //Выбор шрифта для вывода текста
        fillchar(lf,sizeof(lf),0);
        with lf do begin
          lfHeight:=35;
          lfFaceName:='Arial Cyr';
        end;
        hf:=SelectObject(hdc,createFontIndirect(lf));

        DrawText(hdc, PChar('Имя клиента: ' + clientName), -1, rect, DT_SINGLELINE or DT_CENTER or DT_VCENTER);

        //Убираем шрифт, который использовали для вывода текста
        DeleteObject(SelectObject(hdc,hf));

        endPaint(hwnd,ps);
      end;

    wm_keydown:
      if (wParam = VK_ESCAPE) then
      begin
         if (MessageBox(hwnd, 'Вы хотите закрыть окно?', 'Запрос на закрытие окна', MB_YESNO or MB_ICONWARNING) = IDYES) then
         begin
          DestroyWindow(hwnd);
         end;
      end;
	
    wm_destroy:
    begin
      if (hOpponent <> 0) then PostMessage(hOpponent, msgLeave, 0, 0);
      PostQuitMessage(0);
    end;
    
    else
      if Msg = msgAccept then
      begin
        hOpponent := wParam;
        //clientName := 'Подключен';

        //Загрузки имени клиента
        hMapping := OpenFileMapping(FILE_MAP_ALL_ACCESS,false,'MyMapping');
        pData := MapViewOfFile(
          hMapping, // хэндл отображающего объекта
          FILE_MAP_ALL_ACCESS, // доступ на чтение-запись
          0,0,0); // доступ ко всему отображению (можно задать часть)

        Move(pData^, clientName, 256);

        UnmapViewOfFile(pData);
        CloseHandle(hMapping);
      end

      else
        result:=DefWindowProc(hwnd,msg,wparam,lparam);
  end;
end;



begin
  WinMain;
end.
