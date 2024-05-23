program lab8Client;

uses windows, messages, sysUtils; {интерфейсы к системным DLL}

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;



var hwnd, hwndServer: THandle;
    myNumber: Integer;
    msg1, msg2, msg3, msg4, msg5: UINT;



procedure WinMain; {Основной цикл обработки сообщений}
  const szClassName='Client';
  var   wndClass:TWndClassEx;
        msg:TMsg;
begin
  //Регистрация сообщений
  msg1 := RegisterWindowMessage('Запрос');
  msg2 := RegisterWindowMessage('Ответ');
  msg3 := RegisterWindowMessage('Данные');
  msg4 := RegisterWindowMessage('Разрыв');
  msg5 := RegisterWindowMessage('Превышен лимит количества подключенных одновременно клиентов');
  //Регистрация первого класса
  wndClass.cbSize:=sizeof(wndClass);
  wndClass.style:=0;
  wndClass.lpfnWndProc:=@WndProc;
  wndClass.cbClsExtra:=0;
  wndClass.cbWndExtra:=DLGWINDOWEXTRA; // Чтобы можно было использовать DefDlgProc
  wndClass.hInstance:=hInstance;
  wndClass.hIcon:=loadIcon(0, idi_Application);
  wndClass.hCursor:=loadCursor(0, idc_Arrow);
  wndClass.hbrBackground:=GetStockObject(ltgray_Brush);
  wndClass.lpszMenuName:=nil;
  wndClass.lpszClassName:=szClassName;
  wndClass.hIconSm:=loadIcon(0, idi_Application);
  //Регистрация классов
  RegisterClassEx(wndClass);
  hwnd:=CreateWindowEx(0,
         szClassName, {имя класса окна}
         'Клиент',    {заголовок окна}
         ws_popupwindow or ws_sysmenu or ws_caption or ws_border or ws_visible,       {стиль окна}
         100,           {Left}
         100,           {Top}
         500,                     {Width}
         100,                     {Height}
         0,                       {хэндл родительского окна}
         0,                       {хэндл оконного меню}
         hInstance,               {хэндл экземпляра приложения}
         nil);                    {параметры создания окна}

                 {параметры создания окна}

  while GetMessage(msg,0,0,0) do begin {получить очередное сообщение}
    if not (IsDialogMessage(hwnd,msg))
           {Если Windows не распознает и не обрабатывает клавиатурные сообщения
            как команды переключения между оконными органами управления,
            тогда общение идет на стандартную обработку}
    then begin
      TranslateMessage(msg);   {Windows транслирует сообщения от клавиатуры}
      DispatchMessage(msg);    {Windows вызовет оконную процедуру}
    end;
  end; {выход по wm_quit, на которое GetMessage вернет FALSE}
end;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
  const number = 1;

  var rect:TRect;
      stringNum: string;
begin
  result:=0;
  case Msg of
    wm_create: {Органы управления создаются при создании главного окна}
      begin
        GetClientRect(hwnd,rect); //размеры клиентской области

        stringNum := 'Сервер не найден';
        CreateWindowEx(WS_EX_CLIENTEDGE, // Утопленная рамка
                   'edit',
                   PChar(stringNum),// пустой текст в поле ввода
                   ws_visible or ws_child or
                   WS_GROUP or ES_READONLY, //Группа закончена, отсюда начинается следующая
                   0,0,
                   500,20,
                   hwnd,
                   number,
                   hInstance,
                   nil);

      SendMessage(HWND_BROADCAST, msg1, hwnd, 0);

      end;
    wm_close:
    begin
      if (myNumber <> 0) then SendMessage(hwndServer, msg4, myNumber, 0);
      {DefDlgProc ничего не делает по умолчанию - это сообщение отдается
      в процедуру диалога, которой у нас нет}
      DestroyWindow(hwnd);
    end;

    wm_destroy:
      begin
        PostQuitMessage(0);
      end;
    else
      begin
        if (Msg = msg1) then begin
          Exit;
        end
        else if (Msg = msg2) then begin
          hwndServer := wparam;
          if (hwndServer = 0) then begin
            stringNum := 'Сервер не найден';
            SetWindowText(GetDlgItem(hWnd, number), PChar(stringNum))
          end;
        end
        else if (Msg = msg3) then begin
            myNumber := wParam;
            stringNum := 'Номер: ' + IntToStr(myNumber);
            SetWindowText(GetDlgItem(hWnd, number), PChar(stringNum))
        end
        else if (Msg = msg5) then begin
            myNumber := 0;
            stringNum := 'Превышен лимит количества подключенных одновременно клиентов';
            SetWindowText(GetDlgItem(hWnd, number), PChar(stringNum))
        end
        else result:=DefDlgProc(hwnd,msg,wparam,lparam);
      end;

  end;
end;

begin
  WinMain;
end.
