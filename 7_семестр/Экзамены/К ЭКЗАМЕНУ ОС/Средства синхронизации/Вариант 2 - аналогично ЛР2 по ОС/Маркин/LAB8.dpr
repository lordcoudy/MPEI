program LAB8;

uses
  windows,
  messages,
  SysUtils;

{интерфейсы к системным DLL}


var
    main_hwnd           :THandle;
    lines_thread_id     :Cardinal;
    circles_thread_id   :Cardinal;
    clear_window_f      :bool=true;
    lines_thread_h      :THandle;
    circles_thread_h      :THandle;

function  lines_thread_proc(data_ptr: pointer): dword; stdcall;
var
  ps            :TPaintStruct;
  hdc           :THandle;
  hwnd          :THandle;
  rect          :TRect;
  old_pen,pen   :HPen;
  sema          :NativeUInt;
  event         :NativeUInt;
  flag_draw        :bool;
  msg           :tagMSG;
  hdlg          :THandle;

begin
  result := 0;
  flag_draw := false;
  hwnd := main_hwnd;
  hdlg := GetDlgItem(hwnd,101);
  sema := OpenSemaphore(SEMAPHORE_ALL_ACCESS,true,'GDI_HDC_Semaphore');
  event := OpenEvent(EVENT_ALL_ACCESS,true,'lines_message_rdy');

  while True do
    begin
      SetEvent(event);
      if PeekMessage(msg,0,WM_USER,WM_USER,PM_REMOVE) then
        begin
          if (msg.wParam=0) and (msg.lParam=1) then
            if flag_draw then
              begin
                flag_draw := false;
                SetWindowText(hdlg,'ЗАПУСК ЛИНИЙ');
              end
            else
              begin
                flag_draw := true;
                SetWindowText(hdlg,'ОСТАНОВКА ЛИНИЙ');
              end;
          if (msg.wParam=0) and (msg.lParam=2) then
                ExitThread(0);
        end;
      ResetEvent(event);

      if flag_draw then
        begin
          GetClientRect(hwnd,rect);
            begin
              hdc := GetDC(hwnd);
              pen := CreatePen(PS_SOLID, 2 + Random(3),rgb(Random(256), Random(256), Random(256)));
              old_pen := SelectObject(hdc, pen);
              MoveToEx(hdc,Random(rect.right div 2),47 + Random(rect.bottom - 47),nil);
              LineTo(hdc,Random(rect.right div 2),47 + Random(rect.bottom - 47));
              SelectObject(hdc,old_pen);
              DeleteObject(pen);
              ReleaseDC(hwnd,hdc);
            end;
          InvalidateRect(hwnd,rect,false);
          Sleep (1);
        end;
    end;

end;


function  circles_thread_proc(data_ptr: pointer): dword; stdcall;
var
  ps              :TPaintStruct;
  hdc             :THandle;
  hwnd            :THandle;
  rect            :TRect;
  old_pen,pen     :HPen;
  old_brush,brush :Hbrush;
  sema            :NativeUInt;
  event           :NativeUInt;
  flag_draw          :bool;
  msg             :tagMSG;
  hdlg            :THandle;

begin
  result := 0;
  flag_draw := false;
  hwnd := main_hwnd;
  hdlg := GetDlgItem(hwnd,102);
  sema := OpenSemaphore(SEMAPHORE_ALL_ACCESS,true,'GDI_HDC_Semaphore');
  event := OpenEvent(EVENT_ALL_ACCESS,true,'circles_message_rdy');

  while True do
    begin
      SetEvent(event);
      if PeekMessage(msg,0,WM_USER,WM_USER,PM_REMOVE) then
        begin
          if (msg.wParam=0) and (msg.lParam=1) then
            if flag_draw then
              begin
                flag_draw := false;
                SetWindowText(hdlg,'ЗАПУСК ОКРУЖНОСТЕЙ');
              end
            else
              begin
                flag_draw := true;
                SetWindowText(hdlg,'ОСТАНОВКА ОКРУЖНОСТЕЙ');
              end;
          if (msg.wParam=0) and (msg.lParam=2) then
              ExitThread(0);
        end;
      ResetEvent(event);

      if flag_draw then
        begin
          GetClientRect(hwnd,rect);
            begin
              hdc := GetDC(hwnd);

              pen := CreatePen(PS_SOLID, Random(3), rgb(Random(256), Random(256), Random(256)));
              brush := CreateSolidBrush(rgb(Random(256), Random(256), Random(256)));
              old_pen := SelectObject(hdc, pen);
              old_brush := SelectObject(hdc, brush);
              Ellipse(hdc,rect.right div 2 + Random(rect.right div 2),47 + Random(rect.bottom - 47),rect.right div 2 + Random(rect.right div 2),47 + Random(rect.bottom - 47));
              SelectObject(hdc,old_pen);
              SelectObject(hdc,old_brush);
              DeleteObject(pen);
              DeleteObject(brush);
              ReleaseDC(hwnd,hdc);
            end;
          InvalidateRect(hwnd,rect,false);
          Sleep (1);
        end;
    end;

end;

function wndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
var
  ps          :TPaintStruct;
  rect        :Trect;
  hdc         :THandle;
  sema        :NativeUInt;
  event       :NativeUInt;
  brush       :HBrush;
  Exit_lines, Exit_circles: Cardinal;
begin
  result:=0;
  case Msg of
    wm_paint:
      begin
        sema := OpenSemaphore(SEMAPHORE_ALL_ACCESS,true,'GDI_HDC_Semaphore');
        GetClientRect(hwnd,rect);
        WaitForSingleObject(sema, INFINITE);
          begin
            hdc := BeginPaint(hwnd, ps);
            if clear_window_f then
              begin
                clear_window_f := false;
                brush := CreateSolidBrush(rgb(255,255,255));
                FillRect(hdc, rect, brush);
                DeleteObject(brush);
              end;
            EndPaint(hwnd, ps);
          end;
        ReleaseSemaphore(sema,1,nil);
      end;

    wm_create:
      begin
        GetClientRect(hwnd, rect);
        CreateWindow(
                   'button',
                   'ЗАПУСК ЛИНИЙ',
                   ws_visible or ws_child or ws_border or ws_tabstop or BS_DEFPUSHBUTTON,
                   25, 15,
                   250, 30,
                   hwnd,
                   101,
                   hInstance,
                   nil);

        CreateWindow(
                   'button',
                   'ЗАПУСК ОКРУЖНОСТЕЙ',
                   ws_visible or ws_child or ws_border or ws_tabstop or BS_DEFPUSHBUTTON,
                   300, 15,
                   250, 30,
                   hwnd,
                   102,
                   hInstance,
                   nil);

      end;
    wm_command:
      case hiword(wparam) of
        bn_clicked:
          case loword(wparam) of
            101:
              begin
                event := OpenEvent(EVENT_ALL_ACCESS,true,'lines_message_rdy');
                WaitForSingleObject(event, INFINITE);
                PostThreadMessage(lines_thread_id, WM_USER, 0, 1);
                CloseHandle(event);
              end;
            102:
              begin
                event := OpenEvent(EVENT_ALL_ACCESS,true,'circles_message_rdy');
                WaitForSingleObject(event, INFINITE);
                PostThreadMessage(circles_thread_id, WM_USER, 0, 1);
                CloseHandle(event);
              end;
          end;
      end;
    wm_close:
      begin
        PostThreadMessage(lines_thread_id, WM_USER, 0, 2);
        PostThreadMessage(circles_thread_id, WM_USER, 0, 2);

        repeat
             GetExitCodeThread (lines_thread_id, Exit_lines);
             GetExitCodeThread (lines_thread_id, Exit_circles);
        until (Exit_lines<>STILL_ACTIVE) AND (Exit_circles<>STILL_ACTIVE);

        CloseHandle(lines_thread_h);
        CloseHandle(circles_thread_h);
        PostQuitMessage(0);
      end;
    else
      result:=DefWindowProc(hwnd,msg,wparam,lparam);
  end;
end;

procedure WinMain; {Основной цикл обработки сообщений}
  const szClassName='Controls demo';
  var   wndClass:TWndClassEx;
        msg:TMsg;
        hwnd:THandle;
begin

  wndClass.cbSize:=sizeof(wndClass);
  wndClass.style:=0;
  wndClass.lpfnWndProc:=@WndProc;
  wndClass.cbClsExtra:=0;
  wndClass.cbWndExtra:=0;
  wndClass.hInstance:=hInstance;
  wndClass.hIcon:=loadIcon(0, idi_Application);
  wndClass.hCursor:=loadCursor(0, idc_Arrow);
  wndClass.hbrBackground:=0;
  wndClass.lpszMenuName:=nil;
  wndClass.lpszClassName:=szClassName;
  wndClass.hIconSm:=wndClass.hIcon;

  RegisterClassEx(wndClass);

  hwnd:=CreateWindowEx(0,
         szClassName, {имя класса окна}
         'ЛР8 Маркин А.Н. А-08-18',    {заголовок окна}
         WS_OVERLAPPED or WS_CAPTION or WS_SYSMENU or WS_MINIMIZEBOX or WS_MAXIMIZEBOX,       {стиль окна}
         500,           {Left}
         100,           {Top}
         575,                     {Width}
         500,                     {Height}
         0,                       {хэндл родительского окна}
         0,                       {хэндл оконного меню}
         hInstance,               {хэндл экземпляра приложения}
         nil);                    {параметры создания окна}

  main_hwnd := hwnd;

  CreateSemaphore(
    nil,
    1,
    1,
    'GDI_HDC_semaphore'
  );
  CreateEvent(
    nil,
    false,
    false,
    'lines_message_rdy'
  );
  CreateEvent(
    nil,
    false,
    false,
    'circles_message_rdy'
  );

  lines_thread_h := CreateThread(nil,8000,@lines_thread_proc,nil,0,lines_thread_id);
  circles_thread_h := CreateThread(nil,8000,@circles_thread_proc,nil,0,circles_thread_id);

  ShowWindow(hwnd,sw_show);
  while GetMessage(msg,0,0,0) do begin {получить очередное сообщение}
    if not IsDialogMessage(hwnd,msg) then
      begin
        TranslateMessage(msg);   {Windows транслирует сообщения от клавиатуры}
        DispatchMessage(msg);    {Windows вызовет оконную процедуру}
      end;
  end; {выход по wm_quit, на которое GetMessage вернет FALSE}
end;

begin
  WinMain;
end.
