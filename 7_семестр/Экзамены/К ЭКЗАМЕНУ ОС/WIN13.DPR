program Win13;
//Receive and display data from COM port

uses windows, messages;

const MM_COMMDATA=WM_USER+1024;
      MaxBuf=1024;
      PortionCount=32;

var hCommThread: THandle;
    hCommFile:THandle;
    hStopCommEvent:THandle;
    hWnd:THandle;
    hCommWnd: THandle;
    CS:TRtlCriticalSection;

    Buffer,buff:array [0..maxBuf-1] of byte;
    First, Last: integer; //indexes in buffer

function ReadBuffer(var buf; MaxCount:integer):integer;
  //returns read bytes count
  var n2:integer;
begin
  EnterCriticalSection(CS);
  if Last=First then
    result:=0
  else if Last>First then begin
    result:=Last-First;
    if result>MaxCount then result:=MaxCount;
    Move(Buffer[First],buf,result);
    inc(First,result);
  end
  else begin //if Last<First
    result:=MaxBuf-First;
    if result>MaxCount then result:=MaxCount;
    Move(Buffer[First],buf,result);
    inc(First,result);
    if First>=MaxBuf then begin
      First:=0;
      if result+Last>MaxCount then n2:=MaxCount-result else n2:=Last;
      Move(Buffer[0],pointer(integer(@buf)+result)^,n2);
      inc(First,n2);
    end;
  end;
  LeaveCriticalSection(CS);
end;

procedure WriteBuffer(var buf; count:integer);
  var i:integer;
      PB:^byte;
begin
  EnterCriticalSection(CS);
  pb:=@buf;
  for i:=0 to count-1 do begin
    Buffer[Last]:=pb^;
    inc(pb); // increment pointer by addressed datasize=1
    inc(Last);
    if Last>=MaxBuf then Last:=0;
  end;
  PostMessage(hCommWnd,MM_COMMDATA,0,0);
  LeaveCriticalSection(CS);
end;

function SetupReadEvent( OverlappedRead: POverlapped;
                                     InputBuffer: LPSTR;
                                     BufSize: DWORD;
                                     var BytesCount: DWORD): Boolean;
 label StartSetupReadEvent;
 var dwLastError: DWORD;
begin
StartSetupReadEvent:

  Result := False;

  if WaitForSingleObject(hStopCommEvent,0) <> wait_timeout
    then Exit;

  if ReadFile( hCommFile, InputBuffer^, BufSize, BytesCount, OverlappedRead )
  then begin
    if (BytesCount<> 0) then begin
      WriteBuffer(InputBuffer^,Bytescount);
    end
    else exit;

    goto StartSetupReadEvent;
  end;

  dwLastError := GetLastError;
  if dwLastError = ERROR_IO_PENDING then
    Result := True;
end;

function HandleReadEvent( OverlappedRead: POverlapped;
                                      InputBuffer: LPSTR;
                                      BufSize: DWORD;
                                      var BytesCount: DWORD ): Boolean;
begin
  Result := False;
  if GetOverlappedResult( hCommFile, OverlappedRead^, BytesCount, False )
  then begin
    result := (BytesCount<> 0);
    if result then
      WriteBuffer(InputBuffer^,Bytescount);
  end;
end;

function CommThread(p:pointer):integer; stdcall;
  label EndReadThread;
  const com='COM2';
  var
   CommTimeouts: TCommTimeouts;
   DCB: Tdcb;
   CommProp: TCommProp;
   fdwEvtMask: DWORD;
   OverlappedRead: TOverlapped; // Для Overlapped ReadFile
   HandlesToWaitFor: array[0..2] of THandle;
   ws:integer;
   BytesCount:dword;

begin
  hCommFile := CreateFile(  com,          {Имя порта}
                            GENERIC_READ,{читать}
                            0, {not shared}
                            nil, {no security}
                            OPEN_EXISTING,       {Для COM потра только это значение}
                            FILE_FLAG_OVERLAPPED,{Асинхронное чтение}
                            0  ); {файл-образец для атрибутов}
  if hCommFile = INVALID_HANDLE_VALUE then begin
    MessageBox(0,'Error opening '+com,'Error', mb_iconstop or mb_ok);
    Exit;
  end;

   // Запрос и установка конфигурации COM порта
   GetCommState( hCommFile, dcb );          //Заполняем сьруктуру DCB
   dcb.parity:=0;
   dcb.byteSize:=8;
   dcb.StopBits:=0; //0,1,2 == 1, 1.5, 2
   dcb.BaudRate := 16384;
   dcb.flags:=dcb.flags and not $3030 or (1 shl 4) or (0 shl 12);
   SetCommState( hCommFile, dcb );

   FillChar( overlappedRead, Sizeof(overlappedRead), 0 );
   OverlappedRead.hEvent := CreateEvent( nil, True, false {false ?}, nil);

   HandlesToWaitFor[0] := hStopCommEvent;
   HandlesToWaitFor[1] := OverlappedRead.hEvent;

   SetupReadEvent( @OverlappedRead,@Buff,PortionCount,BytesCount );

  while true do begin
    ws := WaitForMultipleObjects(2, @HandlesToWaitFor, False, 1000);
    case ws of
     WAIT_OBJECT_0:
      goto EndReadThread;
     WAIT_OBJECT_0 + 1:
       begin
        HandleReadEvent( @OverlappedRead,@Buff,PortionCount,BytesCount);
        SetupReadEvent( @OverlappedRead,@Buff,PortionCount,BytesCount);
       end;
    end; {case dwHandleSignaled}
  end; {while True}
EndReadThread:
end;

procedure PerformDrawing(var buf; count:integer);
  const MaxPosition=512;
        CurPosition:integer=0;
  var PB:^byte;
      i:integer;
      hdc:THandle;
begin
  PB:=@buf;
  hdc:=GetDC(HWnd);
  for i:=0 to count-1 do begin
    if pb^ and 1 = 0 then begin
      if (CurPosition=0) then begin
        InvalidateRect(hWnd,nil,true); // Clear window
        UpdateWindow(hwnd);
        MoveToEx(hdc,CurPosition,300-PB^,nil);
      end;
      LineTo(hdc,CurPosition,300-PB^);
      if Curposition>=MaxPosition then
        CurPosition:=0
      else
        inc(CurPosition);
    end;
    inc(PB);
  end;
  ReleaseDC(hWnd, hDC);
end;

function CommWndProc(hwnd,msg,wparam,lparam:integer):integer; stdcall;
  var id:dword;
      sze:integer;
      buf:array[0..MaxBuf] of byte;
begin
  result:=0;
  case msg of
    wm_create:
      begin
        hStopCommEvent:=CreateEvent(nil,true,false,nil); // manual, initially reset
        hCommThread:=CreateThread(nil,8000,@CommThread,nil,0,id);
      end;
    wm_destroy:
      SetEvent(hStopCommEvent);
    mm_commdata:
      begin
        sze:=ReadBuffer(buf,sizeof(buf));
        PerformDrawing(buf,sze);
      end;
    else
      result:=DefWindowProc(hwnd,msg,wparam,lparam);
  end;//case
end;

function MainWndProc(hwnd,msg,wparam,lparam:integer):integer; stdcall;
  const szClassName='CommReceiver';
  var   wndClass:TWndClassEx;
begin
  result:=0;
  case msg of
    wm_create:
      begin
        fillchar(wndClass,sizeof(wndclass),0);
        wndClass.cbSize:=sizeof(wndClass);
        wndClass.lpszClassName:=szClassName;
        wndClass.lpfnWndProc:=@CommWndProc;
        wndClass.hInstance:=hInstance;
        RegisterClassEx(wndClass);

        hCommWnd:=CreateWindow(szClassName, {имя класса окна}
         '',    {заголовок окна}
         ws_overlappedWindow,     {стиль окна}
         0,0,0,0,
         0,                       {хэндл родительского окна}
         0,                       {хэндл оконного меню}
         hInstance,               {хэндл экземпляра приложения}
         nil);
      end;
    wm_close:
      begin
        DestroyWindow(hCommWnd);
        PostQuitMessage(0);
      end;
    else
      result:=DefWindowProc(hwnd,msg,wparam,lparam);
  end;//case
end;

procedure WinMain;
  const szClassName='lab13';
  var   wndClass:TWndClassEx;
        msg:TMsg;
begin
  // Заполнение описания оконного класса
  wndClass.cbSize:=sizeof(wndClass);
  wndClass.style:=cs_hredraw or cs_vredraw or cs_owndc;
  wndClass.lpfnWndProc:=@MainWndProc;
  wndClass.cbClsExtra:=0;
  wndClass.cbWndExtra:=0;
  wndClass.hInstance:=hInstance;
  wndClass.hIcon:=loadIcon(0, idi_Application);
  wndClass.hCursor:=loadCursor(0, idc_Arrow);
  wndClass.hbrBackground:=GetStockObject(white_Brush);
  wndClass.lpszMenuName:=nil;
  wndClass.lpszClassName:=szClassName;
  wndClass.hIconSm:=loadIcon(0, idi_Application);

  RegisterClassEx(wndClass); {регистрация оконного класса}

  hwnd:=CreateWindow(szClassName, {имя класса окна}
         'Заголовок окна',    {заголовок окна}
         ws_overlappedWindow,     {стиль окна}
         cw_useDefault,           {Left}
         cw_useDefault,           {Top}
         cw_useDefault,           {Width}
         cw_useDefault,           {Height}
         0,                       {хэндл родительского окна}
         0,                       {хэндл оконного меню}
         hInstance,               {хэндл экземпляра приложения}
         nil);                    {параметры создания окна}

  ShowWindow(hwnd,sw_Show);  {отобразить окно}

  InitializeCriticalSection(CS);

  while GetMessage(msg,0,0,0)=true do begin
    TranslateMessage(msg);
    DispatchMessage(msg);
  end;

  WaitForSingleObject(hCommThread,2000);
  DeleteCriticalSection(CS);
end;

begin
  WinMain;
end.