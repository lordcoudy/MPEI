// A-07-18, Есин Алексей, Вариант 7
// Два стандартных окна. Программа завершается при закрытии любого окна.
// При минимизации одного окна другое должно максимизироваться.

program lab3;

uses windows, messages;

var hWindow1, hWindow2: THandle;

// процедура максимизации окна
procedure MaximizeWnd (hWnd: THandle);
var anotherWindow: THandle;
begin
    if (hWnd = hWindow1) then
        anotherWindow := hWindow2
    else if (hWnd = hWindow2) then
        anotherWindow := hWindow1;
    ShowWindow(anotherWindow, SW_MAXIMIZE);
end;


function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
var ps: TPaintStruct; hdc: THandle; rect: TRect;
begin
    result := 0;
    case Msg of
        wm_paint:
        begin
            hdc := BeginPaint(hwnd, ps);
            GetClientRect(hwnd, rect);
            endPaint(hwnd, ps);
        end;

        WM_SIZE:
        begin
            if (wParam = SIZE_MINIMIZED) then
                MaximizeWnd(hWnd);
        end;

        wm_destroy:
            PostQuitMessage(0);
        
        else
            result := DefWindowProc(hwnd, msg, wparam, lparam);
    end;
end;


procedure WinMain;  {Содержит основной цикл обработки сообщений,
                    для совместимости с документацией по С выделено в отдельную процедуру}
    const szClassName = 'lab3';
    var wndClass: TWndClassEx; msg: TMsg;
begin
    // Заполнение описания оконного класса
    wndClass.cbSize := sizeof(wndClass);
    wndClass.style := cs_hredraw or cs_vredraw;
    wndClass.lpfnWndProc := @WndProc;
    wndClass.cbClsExtra := 0;
    wndClass.cbWndExtra := 0;
    wndClass.hInstance := hInstance;
    wndClass.hIcon := loadIcon(0, idi_Application);
    wndClass.hCursor := loadCursor(0, idc_Arrow);
    wndClass.hbrBackground := GetStockObject(white_Brush);
    wndClass.lpszMenuName := nil;
    wndClass.lpszClassName := szClassName;
    wndClass.hIconSm := loadIcon(0, idi_Application);

    RegisterClassEx(wndClass);              {регистрация оконного класса}

    hWindow1:=CreateWindow(szClassName,     {имя класса окна}
            'Window 1',                     {заголовок окна}
            ws_overlappedWindow,            {стиль окна}
            cw_useDefault,                  {Left}
            cw_useDefault,                  {Top}
            300,                            {Width}
            300,                            {Height}
            0,                              {хэндл родительского окна}
            0,                              {хэндл оконного меню}
            hInstance,                      {хэндл экземпляра приложения}
            nil);                           {параметры создания окна}

    hwindow2:=CreateWindow(szClassName,     {имя класса окна}
            'Window 2',                     {заголовок окна}
            ws_overlappedWindow,            {стиль окна}
            cw_useDefault,                  {Left}
            cw_useDefault,                  {Top}
            300,                            {Width}
            300,                            {Height}
            0,                              {хэндл родительского окна}
            0,                              {хэндл оконного меню}
            hInstance,                      {хэндл экземпляра приложения}
            nil);                           {параметры создания окна}

    ShowWindow(hWindow1,sw_Show);           {отобразить окно}
    ShowWindow(hwindow2,sw_Show);           {отобразить окно}

    while GetMessage(msg,0,0,0) do begin    {получить очередное сообщение}
        TranslateMessage(msg);              {Windows транслирует сообщения от клавиатуры}
        DispatchMessage(msg);               {Windows вызовет оконную процедуру}
    end;                                    {выход по wm_quit, на которое GetMessage вернет FALSE}
end;


begin
    WinMain;
end.
