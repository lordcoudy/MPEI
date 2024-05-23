program lab3;

uses windows,messages;                                // Интерфейс к системным DLL и константы-сообщения

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

function WndProcToolbar(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

procedure WinMain;
  const szClassName='mainWindow';
        szClassNameChild='childWindow';  
  var   wndClass:TWndClassEx;
        msg:TMsg;
        hWnd, hWndChild1, hWndChild2: THandle;
begin

  fillchar(wndClass,sizeof(wndClass),0);              // занулил всю инфу
  wndClass.cbSize:=sizeof(wndClass);                  // Размерчик берем по размеру зануленного
  wndClass.style:=cs_hredraw or cs_vredraw;           // Стиль отрисовки (перерисовывался от масштабирования)
  wndClass.lpfnWndProc:=@WndProc;                     // Процедура окна
  wndClass.cbClsExtra:=0;
  wndClass.cbWndExtra:=0;
  wndClass.hInstance:=hInstance;
  wndClass.hIcon:=loadIcon(0, idi_Application);
  wndClass.hCursor:=loadCursor(0, idc_Arrow);
  wndClass.hbrBackground:=GetStockObject(white_Brush);
  wndClass.lpszMenuName:=nil;
  wndClass.lpszClassName:=szClassName;                // Имя оконного класса
  wndClass.hIconSm:=loadIcon(0, idi_Application);

  RegisterClassEx(wndClass);                          // Регистрация оконного класса

  fillchar(wndClass,sizeof(wndClass),0);
  wndClass.cbSize:=sizeof(wndClass);
  wndClass.style:=cs_hredraw or cs_vredraw or cs_parentdc;
  wndClass.lpfnWndProc:=@WndProcToolbar;
  wndClass.cbClsExtra:=0;
  wndClass.cbWndExtra:=0;
  wndClass.hInstance:=hInstance;
  wndClass.hIcon:=loadIcon(0, idi_Application);
  wndClass.hCursor:=loadCursor(0, idc_Arrow);
  wndClass.hbrBackground:=GetStockObject(white_Brush);
  wndClass.lpszMenuName:=nil;
  wndClass.lpszClassName:=szClassNameChild;
  wndClass.hIconSm:=loadIcon(0, idi_Application);

  RegisterClassEx(wndClass);                           // Регистрация оконного класса}

  // Создание окна
  hwnd:=CreateWindow(
         szClassName,                                 // Имя оконного класса
         'Заголовок окна',                            // Заголовок окна
         ws_overlappedWindow,                         // Стиль окна (перекрывающее окно)
         cw_useDefault,                               // Лево
         cw_useDefault,                               // Верх
         600,                                         // Ширина
         300,                                         // Высота
         0,                                           // Хэндл родительского окна
         0,                                           // Хэндл оконного меню
         hInstance,                                   // Хэндл экземпляра приложения
         nil);                                        // Параметры создания окна

  ShowWindow(hwnd,sw_Show);                           // Отрисовать окно

  // Создание окна
  hWndChild1:=CreateWindow(
        szClassNameChild,                             // Имя оконного класса
        'Toolbal 1',                                  // Заголовок окна
        ws_child or ws_caption or ws_sysmenu,         // Стиль окна (дитя)
        15,           
        15,           
        200,          
        50,           
        hWnd,                      
        0,                       
        hInstance,               
        nil);                   

  ShowWindow(hWndChild1,sw_Show);  

  // Создание окна
  hWndChild2:=CreateWindow(
        szClassNameChild,
        'Toolbal 2',    
        ws_child or ws_caption or ws_sysmenu,     
        315,           
        15,           
        200,           
        50,           
        hWnd,                       
        0,                       
        hInstance,               
        nil);                    

  ShowWindow(hWndChild2,sw_Show);  

  // Получение сообщения
  while GetMessage(msg,0,0,0)=true do begin 
        TranslateMessage(msg);                         // Перевод сообщения
        DispatchMessage(msg);                          // Обработка сообщения в процедуре
      end;
end;


// Процедура главного окна
function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint; stdcall;
  var ps:TPaintStruct;
      hdc:THandle;
      rect:TRect;
begin
  result:=0;
  // Обработка сообщений
  case Msg of
    wm_paint:
      begin
        hdc:=BeginPaint(hwnd,ps);
        GetClientRect(hwnd,rect);

        // Рисование в клиентской области
        DrawText(hdc,'Клиентская область',-1,rect,
                 DT_SINGLELINE or DT_VCENTER or DT_CENTER);

        endPaint(hwnd,ps);
      end;
    wm_destroy:
        // Уничтожение
        PostQuitMessage(0);
    else
        // По умолчанию
      result:=DefWindowProc(hwnd,msg,wparam,lparam);
  end;
end;


// Процедура ребенка
function WndProcToolbar(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint; stdcall;
  var ps:TPaintStruct;
      hdc:THandle;
      rect:TRect;
begin
  result:=0;
  case Msg of
    wm_paint:
      begin
        hdc:=BeginPaint(hwnd,ps);
        GetClientRect(hwnd,rect);

        DrawText(hdc,'Меню',-1,rect,
                 DT_SINGLELINE or DT_VCENTER or DT_CENTER);

        endPaint(hwnd,ps);
      end;
      wm_close:
        DestroyWindow(hWnd);
    else
      result:=DefWindowProc(hwnd,msg,wparam,lparam);
  end;
end;


begin
  WinMain;
end.
