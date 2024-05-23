uses windows,messages, {интерфейсы к системным DLL}
     sysUtils; {Служебные функции Дельфи для форматирования строк и т.д.}

var
   msgHello,msgAnswer, msgData:UINT;
   hClient:tHandle;
   hFile,hMapping, edit:THandle;
   pData:pointer;
   length:integer;
   buffer: array[0..255] of char; //Строка как в Турбо-Паскале

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

procedure WinMain; {Основной цикл обработки сообщений}
  const szClassName='Shablon';
  var   wndClass:TWndClassEx;
        hWnd: THandle;
        msg:TMsg;

begin
  msgHello:=RegisterWindowMessage('Lab_8_client_hello');
  msgAnswer:=RegisterWindowMessage('Lab_8_server_answer');
  msgData:=RegisterWindowMessage('Lab_8_data_transfer');

  wndClass.cbSize:=sizeof(wndClass);
  wndClass.style:=cs_hredraw or cs_vredraw;
  wndClass.lpfnWndProc:=@WndProc;
  wndClass.cbClsExtra:=0;
  wndClass.cbWndExtra:=0;
  wndClass.hInstance:=hPrevInst;
  wndClass.hInstance:=hInstance;
  wndClass.hIcon:=loadIcon(0, idi_Application);
  wndClass.hCursor:=loadCursor(0, idc_Arrow);
  wndClass.hbrBackground:=GetStockObject(white_Brush);
  wndClass.lpszMenuName:=nil;
  wndClass.lpszClassName:=szClassName;
  wndClass.hIconSm:=loadIcon(0, idi_Application);

  RegisterClassEx(wndClass);


   hFile := CreateFile(   //создание файла
        'myfile.map', // имя файла
        GENERIC_READ or GENERIC_WRITE, // доступ на чтение-запись
        0, // эксклюзивный доступ
        0, // атрибуты защиты, не поддерживается Windows 95, только NT
        CREATE_ALWAYS, // создавать заново
        FILE_ATTRIBUTE_NORMAL, 0);


  hMapping := CreateFileMapping(   //создание оттображающего объекта
        hFile, // хэндл открытого файла
        0, // атрибуты защиты, не поддерживается Windows 95, только NT
        PAGE_READWRITE,
        0, 4096, // 4096 байт, если 0 - размер равен размеру файла
        'MyMapping' // имя-идентификатор объекта
        );


  pData := MapViewOfFile(    //создание образа объекта
        hMapping, // хэндл отображающего объекта
        FILE_MAP_ALL_ACCESS, // доступ на чтение-запись
        0,0,0 // доступ ко всему отображению (можно задать часть)
        );


  hwnd:=CreateWindowEx(
         0,
         szClassName, {имя класса окна}
         'Server Window',    {заголовок окна}
         ws_popupwindow or ws_sysmenu or ws_caption or ws_border or ws_visible,     {стиль окна}
         cw_useDefault,           {Left}
         cw_useDefault,           {Top}
         500,                     {Width}
         200,                     {Height}
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

begin
  result:=0;
    if Msg=wm_create then begin
      length:=0;
    end

    else if Msg=msgHello then begin
       hClient:=wParam;
       PostMessage(hClient, msgAnswer, hWnd, 0);
    end

    else if Msg=wm_paint then begin

        hdc:=BeginPaint(hwnd,ps);
        GetClientRect(hwnd,rect);
        rect.Right:= rect.Right-13;
        DrawText(hdc, buffer, length, rect,  DT_WORDBREAK);
        endPaint(hwnd,ps);

    end


    else if   Msg=msgData then begin
      Move(pData^, buffer, wParam);
      length:=wParam;
      InvalidateRect(hWnd, nil, True);
    end

    else if  Msg=wm_destroy then begin
      UnmapViewOfFile(pData);
      CloseHandle(hMapping);
      CloseHandle(hFile);
      PostQuitMessage(0);
    end


    else result:=DefWindowProc(hwnd,msg,wparam,lparam);
end;



begin
  WinMain;
end.
