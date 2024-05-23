program lab8;

uses windows,messages, {интерфейсы к системным DLL}
     sysUtils; {Служебные функции Дельфи для форматирования строк и т.д.}

     var
       msgHello, msgAnswer, msgData:UINT;
       hServer, edit:THandle;
       hFile,hMapping:THandle;
       pData:pointer;

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

  hwnd:=CreateWindowEx(
         0,
         szClassName, {имя класса окна}
         'Client Window',    {заголовок окна}
         ws_popupwindow or ws_sysmenu or ws_caption or ws_border or ws_visible,     {стиль окна}
         cw_useDefault,           {Left}
         cw_useDefault,           {Top}
         500,                     {Width}
         200,                     {Height}
         0,                       {хэндл родительского окна}
         0,                       {хэндл оконного меню}
         hInstance,               {хэндл экземпляра приложения}
         nil);                    {параметры создания окна}
  hMapping:=OpenFileMapping(FILE_MAP_WRITE,false, 'MyMapping');   //получение хэндла готового отображающего объекта по имени
  pData := MapViewOfFile(       //создание образа файла в адресном пространстве процесса
            hMapping,
            FILE_MAP_WRITE,
            0,0,0);

  ShowWindow(hwnd,sw_Show);  {отобразить окно}
  updateWindow(hwnd);   {послать wm_paint оконной процедуре, прорисовав
                         окно минуя очередь сообщений (необязательно)}


  while GetMessage(msg,0,0,0) do begin {получить очередное сообщение}
    TranslateMessage(msg);   {Windows транслирует сообщения от клавиатуры}
    DispatchMessage(msg);    {Windows вызовет оконную процедуру}
  end; {выход по wm_quit, на которое GetMessage вернет FALSE}
end;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;

  var
      length:Integer;
      buffer: array[0..255] of char;
begin
  result:=0;

  if Msg=wm_create then begin
    edit:=CreateWindowEx(WS_EX_CLIENTEDGE,      //создание edit
                   'edit',
                   '',
                   ws_visible or ws_child or ES_MULTILINE,
                    0, 0,
                   490, 170,
                   hwnd,
                   5,
                   hInstance,
                   nil);

    PostMessage(HWND_BROADCAST, msgHello, hWnd,0);     //широковещательная рассылка
    SetTimer(hwnd,0,1000,nil);
  end

  else if Msg=wm_timer then begin    //если произшел "тик" таймера
    KillTimer(hWnd, 0);
    MessageBox(0, 'Не удалось установить связь с сервером', 'Ошибка', MB_OK or MB_ICONERROR or MB_TASKMODAL);
    DestroyWindow(hwnd);
  end


  else if Msg=wm_command then begin
        if HiWord(wParam)=EN_CHANGE then begin //при изменении содержимоо edit
          length:=GetWindowtextLength(edit);   //получение длины
          GetWindowText(edit, pData,  256);    //получение содержимого
          PostMessage(hServer, msgData, length, 0);        //отправка
        end;
  end


  else if Msg=msgAnswer then begin //если пришел ответ от сервера
      KillTimer(hWnd, 0);       //выключить таймер
      hServer:=wParam;          //запомнить хэндл окна сервера
  end


  else if Msg=wm_destroy then begin
    UnmapViewOfFile(pData);
    CloseHandle(hMapping);
    PostQuitMessage(0);
  end


  else result:=DefWindowProc(hwnd,msg,wparam,lparam);
end;



begin
  WinMain;
end.

//Мой вопрос на защиту ЛР8:
//PostMessage и SendMessage при установке связи.