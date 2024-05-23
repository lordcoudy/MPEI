program lab8Server;

uses windows, messages, SysUtils; {интерфейсы к системным DLL}

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

const MAXCOUNTCLIENT = 10;

var hwnd: THandle;
    msg1, msg2, msg3, msg4, msg5: UINT;
    numbers: Integer;
    client_numbers: array [0..MAXCOUNTCLIENT - 1] of Boolean;

procedure WinMain; {Основной цикл обработки сообщений}
  const szClassName='Server';
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
         'Сервер',    {заголовок окна}
         ws_popupwindow or ws_sysmenu or ws_caption or ws_border or ws_visible,       {стиль окна}
         100,           {Left}
         100,           {Top}
         400,                     {Width}
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

function getClientNumber():Integer; stdcall;
var i: Integer;
begin
  i := 0;
  Result := i;
  For i := 0 to MAXCOUNTCLIENT - 1 do
  begin
    if (client_numbers[i] = False) then begin
      client_numbers[i] := True;
      Break;
    end;
  end;
  if (i >= MAXCOUNTCLIENT) then Result := 0
  else Result := i + 1;
end;

procedure deleteClient(clientId:Integer); stdcall;
begin
  numbers := numbers - 1;
  client_numbers[clientId - 1] := False;
end;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
  const count = 1;

  var
    rect:TRect;
    otherHwnd: THandle;
    stringNum: String;
    number: Integer;
begin
  result:=0;
  case Msg of
    wm_create: {Органы управления создаются при создании главного окна}
      begin
        GetClientRect(hwnd,rect); //размеры клиентской области

        stringNum := 'Количество подключенных клиентов: 0';

        CreateWindowEx(WS_EX_CLIENTEDGE, // Утопленная рамка
                   'edit',
                   PChar(stringNum),// пустой текст в поле ввода
                   ws_visible or ws_child or
                   WS_GROUP or ES_READONLY, //Группа закончена, отсюда начинается следующая
                   0,0,
                   400,20,
                   hwnd,
                   count,
                   hInstance,
                   nil);

      end;
    wm_close:
      {DefDlgProc ничего не делает по умолчанию - это сообщение отдается
       в процедуру диалога, которой у нас нет}
      DestroyWindow(hwnd);
    wm_destroy:
      begin
        PostQuitMessage(0);
      end;
    else
      begin
        if (Msg = msg1) then begin
          otherHwnd := wparam;

          PostMessage(otherHwnd, msg2, hWnd, 0);

          number := getClientNumber();

          if (number = 0) then PostMessage(otherHwnd, msg5, 0, 0)
          else begin
            numbers := numbers + 1;
            
            PostMessage(otherHwnd, msg3, number, 0);

            stringNum := 'Количество подключенных клиентов: ' + IntToStr(numbers);

            SetWindowText(GetDlgItem(hWnd, count), PChar(stringNum));
          end;
        end
        else if (Msg = msg4) then begin
           deleteClient(wParam);
           stringNum := 'Количество подключенных клиентов: ' + IntToStr(numbers);

          SetWindowText(GetDlgItem(hWnd, count), PChar(stringNum));
          Exit;
        end
        else result:=DefDlgProc(hwnd,msg,wparam,lparam);
      end;

  end;
end;



begin
  WinMain;
end.
