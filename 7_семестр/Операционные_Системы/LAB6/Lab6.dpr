program Lab6;

uses windows, messages;                                             // Интерфейсы к системным DLL

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

// Основной цикл обработки сообщений
procedure WinMain;                                                  
  const szClassName='Controls demo';
  var   wndClass:TWndClassEx;
        msg:TMsg;
        hwnd:THandle;
begin
  wndClass.cbSize:=sizeof(wndClass);
  wndClass.style:=0;
  wndClass.lpfnWndProc:=@WndProc;
  wndClass.cbClsExtra:=0;
  wndClass.cbWndExtra:=DLGWINDOWEXTRA;
  wndClass.hInstance:=hInstance;
  wndClass.hIcon:=loadIcon(0, idi_Application);
  wndClass.hCursor:=loadCursor(0, idc_Arrow);
  wndClass.hbrBackground:=GetStockObject(ltgray_Brush);
  wndClass.lpszMenuName:=nil;
  wndClass.lpszClassName:=szClassName;
  wndClass.hIconSm:=loadIcon(0, idi_Application);

  RegisterClassEx(wndClass);

  hwnd:=CreateWindowEx(
    ws_ex_controlparent,
    szClassName, {имя класса окна}
    'DDLC10',    {заголовок окна}
    ws_popupwindow or ws_sysmenu or ws_caption or ws_border or ws_visible,       {стиль окна}
    10,           {Left}
    10,           {Top}
    500,                     {Width}
    300,                     {Height}
    0,                       {хэндл родительского окна}
    0,                       {хэндл оконного меню}
    hInstance,               {хэндл экземпляра приложения}
    nil
  );                    {параметры создания окна}


  while GetMessage(msg,0,0,0) do begin
    if not IsDialogMessage(GetActiveWindow,msg)
           {Если Windows не распознает и не обрабатывает клавиатурные сообщения
            как команды переключения между оконными органами управления,
            тогда сообщение идет на стандартную обработку}
    then begin
      TranslateMessage(msg);
      DispatchMessage(msg);    
    end;
  end;
end;
        {$H+}
function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
  const
      IDEdit=1;                                                     //идентификатор контрола edit - редактор текста
      IDListbox=2;                                                  //идентификатор контрола listbox - список строк с полосой прокрутки
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
       //массив Z-строк для listbox-a

  var i:integer;
      rect:TRect;
      listelements: array[0..listLength] of PChar;                  //массив указателей на строки
      buffer: array[0..255] of char;                                //размер буфера
begin
  result:=0;
  case Msg of
    wm_create: {Органы управления создаются при создании главного окна}
      begin

        GetClientRect(hwnd,rect);                                   //размеры клиентской области

        CreateWindowEx(
          WS_EX_CLIENTEDGE,                                         //утопленная рамка
          'edit',                                                   //класс контрола в поле заголовка
          '',                                                       //нет текста
          ws_visible or ws_child or WS_TABSTOP or
          ES_CENTER or WS_GROUP,                                    //флаги для разрешения Tab-a, установки курсора по умолчанию в центре и начала новой группы
          100,30,                                                   //координаты верхнего левого угла прям-ка
          250,40,                                                   //ширина и высота
          hwnd,
          IDEdit,                                                   //идентификатор edit-a
          hInstance,
          nil
        );

        CreateWindowEx(
          WS_EX_CLIENTEDGE,
          'listbox',
          '',
          ws_visible or 
          ws_child or 
          WS_BORDER or 
          WS_TABSTOP or 
          WS_VSCROLL or                                             //ws_vscroll - добавление вертикальной полосы прокрутки
          LBS_NOTIFY or                                             //LBS_NOTIFY - для того, чтобы listbox посылал окну сообщения WM_COMMAND
          LBS_SORT,
          5,100,
          rect.Right-10,rect.Bottom-100,
          hWnd,
          IDListbox,                                                //идентификатор listbox-a
          hInstance,
          nil
        );

        for i:=0 to listLength do begin
          listelements[i]:=@liststrings[i][1];                      //теперь любой элемент массива указателей указывает на 1-ый символ соответствующей строки
          SendMessage(
            GetDlgItem(hWnd,IDListbox), 
            LB_ADDSTRING, 
            0, 
            Integer(listelements[i])
          );                                                        //заполняем listbox строками при помощи addstring
          //GetDlgItem - возвращает хэндл edit-a
        end;

      end;

    wm_command:                                                     // Обработка команд от всех органов управления
      case hiword(wParam) of                                        // Если в старшем слове wparam содержится:
            LBN_SELCHANGE:                                          // Пользователь что-то изменил в listbox-e - изменилась выделенная строка
              if (loword(wparam)=IDListBox) then begin              // Если в младшем слове содержится ID listbox-a
                i:=SendDlgItemMessage(
                  hWnd, 
                  IDListbox, 
                  LB_GETCURSEL,
                  0,
                  0
                );                                                  // Послать ему сообщение получить номер выбранной строки
                if i>=0 then                                        // Если была выбрана какая-то строка
                  SendDlgItemMessage(
                    hWnd,
                    IDListbox, 
                    LB_GETTEXT,
                    i,
                    Integer(@buffer)
                  )                                                 // Посылаем сообщение о запоминании текста из этой строки в буфер

                else
                  buffer[0]:=#0;                                    // Иначе в буфере пусто
                  SendDlgItemMessage(
                    hWnd, 
                    IDEdit, 
                    WM_SETTEXT, 
                    SizeOf(buffer),
                    Integer(@buffer)
                  );                                                // Посылаем edit-у сообщение, чтобы в нём появился текст выбранной строки
              end;

            EN_CHANGE:                                              // В edit-e набрали букву, и она уже отобразилась
              if (loword(wParam)=IDEdit) then begin                 // Если в младшем слове содержится ID edit-a
                SendDlgItemMessage(
                  hWnd,
                  IDEdit, 
                  WM_GETTEXT,
                  SizeOf(buffer),
                  Integer(@buffer)
                );                                                  // Получить текст выбранной строки в edit-e
                if (SendMessage(
                  GetDlgItem(hWnd, IDListbox), 
                  LB_SELECTSTRING, 
                  -1, 
                  Integer(@buffer))=LB_ERR
                ) then                                              // Если в listbox-е при наборе буквы не нашли строку с такими символами
                    SendMessage(
                      GetDlgItem(hWnd, IDListbox), 
                      LB_SETCURSEL, 
                      -1, 
                      -1
                    );                                              // Не производить выделение строк
              end;

      end;               

    wm_close: DestroyWindow(hwnd);
    wm_destroy:
     PostQuitMessage(0);

    else
      result:=DefDlgProc(hwnd,msg,wparam,lparam);
  end;
end;



begin
  WinMain;
end.

