{$A-,H-,I-}
program LabThred;

uses windows,messages,sound, SysUtils;

{$R res8.res}

var strarr:array[1..10] of shortstring;
    strbuf: shortstring;
    hSema: THandle;
    hThreadB,hThreadC:THandle;
    idThreadB,idThreadC:dword;
    flaga:boolean;


procedure ThreadFunctionB(var dwParam:dword); stdcall;
var i:integer;
begin
  while flaga do
    begin
      WaitForSingleObject(hSema,INFINITE);
      strbuf:=strarr[1];
      for i:=1 to 9 do
        strarr[i]:=strarr[i+1];
      strarr[10]:=strbuf;
      ReleaseSemaphore(hSema,1,nil);
    end;
  ExitThread(0);
end;

procedure ThreadFunctionC(var dwParam:dword); stdcall;
var a,b:byte;
begin
  while flaga do
    begin
      WaitForSingleObject(hSema, INFINITE);
      a:=random(10)+1;
      repeat
        b:=random(10)+1;
        until a<>b;
      strbuf:=strarr[a];
      strarr[a]:=strarr[b];
      strarr[b]:=strbuf;
      ReleaseSemaphore(hSema,1,nil);
    end;
  ExitThread(0);
end;

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

procedure WinMain; {Основной цикл обработки сообщений}
  const szClassName='Controls demo';
  var   wndClass:TWndClassEx;
        msg:TMsg;
        hwnd1:THandle;
begin
  hThreadB:=0;
  hThreadC:=0;
  flaga:=true;
  randomize;
  wndClass.cbSize:=sizeof(wndClass);
  wndClass.style:=0;
  wndClass.lpfnWndProc:=@WndProc;
  wndClass.cbClsExtra:=0;
  wndClass.cbWndExtra:=DLGWINDOWEXTRA;
  wndClass.hInstance:=hInstance;
  wndClass.hIcon:=loadIcon(0, idi_Application);
  wndClass.hCursor:=loadCursor(0, idc_Arrow);
  wndClass.hbrBackground:=GetStockObject(White_Brush);
  wndClass.lpszMenuName:=nil;
  wndClass.lpszClassName:=szClassName;
  wndClass.hIconSm:=loadIcon(0, idi_Application);

  RegisterClassEx(wndClass);

  hwnd1:=CreateWindowEx(0,
         szClassName, {имя класса окна}
         'лаб 8',    {заголовок окна}
         ws_popupwindow or ws_sysmenu or ws_caption or ws_border or ws_visible,       {????? ????}
         10,           {Left}
         10,           {Top}
         500,                     {Width}
         300,                     {Height}
         0,                       {хэндл родительского окна}
         0,                       {хэндл оконного меню}
         hInstance,               {хэндл экземпляра приложения}
         nil);                    {параметры создания окна}

  while GetMessage(msg,0,0,0) do begin {получить очередное сообщение}
    if not IsDialogMessage(hwnd1,msg)
    {Если Windows не распознает и не обрабатывает клавиатурные сообщения
            как команды переключения между оконными органами управления,
            тогда чообщение идет на стандартную обработку}
     then begin
      TranslateMessage(msg);   {Windows транслирует сообщения от клавиатуры}
      DispatchMessage(msg);    {Windows вызовет оконную процедуру}
    end;
  end; {выход по wm_quit, на которое GetMessage вернет FALSE}
end;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
  const list=2;
        start=3;
        pause=4;
        exit=5;

  var i:integer;
      rect:TRect;
      statusb,statusc:DWORD;

begin
  result:=0;
  case Msg of
    wm_create: {Органы управления создаются при создании главного окна}
      begin
        GetClientRect(hwnd,rect); //размеры клиентской области
        CreateWindowEx(WS_EX_CLIENTEDGE,
                   'listbox',
                   '', //пустой текст в поле ввода
                   ws_visible or ws_child or ws_border or ws_tabstop or ws_vscroll or LBS_Notify,
                   10,50,
                   rect.right-20,rect.bottom-60,
                   hwnd,
                   list, //list
                   hInstance,
                   nil);

        CreateWindowEx(WS_EX_CLIENTEDGE, // Утопленная рамка
                   'button',
                   'Запуск',
                   ws_visible or ws_child or ws_border,
                   50, 20,
                   80, 25,
                   hwnd,
                   start,
                   hInstance,
                   nil);

        CreateWindowEx(WS_EX_CLIENTEDGE, // Утопленная рамка
                   'button',
                   'Выход',
                   ws_visible or ws_child or ws_border,
                   350, 20,
                   80, 25,
                   hwnd,
                   exit,
                   hInstance,
                   nil);
         for i:=1 to 10 do
          begin
            LoadString(hInstance,i,@strarr[i],255);
            SendMessage(GetDlgItem(hwnd,list),LB_ADDSTRING,0,integer(@strarr[i]));
          end;

         hSema:=CreateSemaphore(
            nil, // атрибуты защиты
            1, // начальное значение
            1, // максимальное значение
            'MySemaphore' // имя семафора
            );
      end;
  wm_command:
    case hiword(wParam) of
      BN_CLICKED:
        begin
          case loword(wParam) of
            start:
              begin
                if(hThreadB=0) and (hThreadC=0) then
                  begin
                    SetTimer(hwnd,0,1000,nil);
                    hThreadB:=CreateThread(nil, // ????? ??????, ?????????????? ?????? ? NT
                            0, // ??????????? ?????? ?????
                            @ThreadFunctionB, // ??????? ??????
                            nil, // ???????? ??? ?????? ?-??? ??????
                            0, // ????? ????????, ?? ????????? -- ??????????? ??????
                            idThreadB);
                    hThreadC:=CreateThread(nil, // ????? ??????, ?????????????? ?????? ? NT
                            0, // ??????????? ?????? ?????
                            @ThreadFunctionC, // ??????? ??????
                            nil, // ???????? ??? ?????? ?-??? ??????
                            0, // ????? ????????, ?? ????????? -- ??????????? ??????
                            idThreadC);
                  end;
              end;
            exit:
              begin
                flaga:=false;
                repeat
                  GetExitCodeThread(hThreadB,statusb);
                  GetExitCodeThread(hThreadC,statusc);
                until (statusb<>STILL_ACTIVE) and (statusc<>STILL_ACTIVE);
                CloseHandle(hThreadB);
                CloseHandle(hThreadC);
                killTimer(hwnd,0);
                CloseHandle(hSema);
		            DestroyWindow(hWnd);
              end;
          end;
        end;
    end;
  wm_timer:
      begin
        WaitForSingleObject(hSema,INFINITE);
        SendMessage(GetDlgItem(hwnd,list),LB_RESETCONTENT,0,0);
        for i:=1 to 10 do
          SendMessage(GetDlgItem(hwnd,list),LB_ADDSTRING,0,integer(@strarr[i]));
        ReleaseSemaphore(hSema,1,nil);
      end;
	wm_close:
	  begin
      flaga:=false;
      repeat
        GetExitCodeThread(hThreadB,statusb);
        GetExitCodeThread(hThreadC,statusc);
      until (statusb<>STILL_ACTIVE) and (statusc<>STILL_ACTIVE);
      CloseHandle(hThreadB);
      CloseHandle(hThreadC);
      killTimer(hwnd,0);
      CloseHandle(hSema);
		  DestroyWindow(hWnd);
	  end;
  wm_destroy:
    begin // ?????? ?????????? ???????????? ?????????????
      PostQuitMessage(0);
    end;
  else
    result:=DefDlgProc(hwnd,msg,wparam,lparam);
  end;
end;



begin
  WinMain;
end.

