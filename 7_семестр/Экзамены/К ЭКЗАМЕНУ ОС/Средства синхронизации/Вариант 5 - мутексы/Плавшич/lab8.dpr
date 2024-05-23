{$A-,H-,I-}
program lab8;
{$APPTYPE CONSOLE}  // Shows console

uses
  windows,
  messages,
  sysutils;

const valueCount = 10;

var
  valueArray: array[0..valueCount - 1] of string[20] =
  ('00000000000000000000',
   '11111111111111111111',
   '22222222222222222222',
   '33333333333333333333',
   '44444444444444444444',
   '55555555555555555555',
   '66666666666666666666',
   '77777777777777777777',
   '88888888888888888888',
   '99999999999999999999');
  hThreadB, hThreadC: THandle;
  hMutex: THandle;
  mainThreadID: DWORD;
  killThreads, swapped, randomed: boolean;

function WinMainCallback(hWnd: THandle; msg: integer; wParam: longint; lParam: longint): longint; stdcall; forward;
function ThreadBCallback(data: pointer): DWORD; stdcall; forward;
function ThreadCCallback(data: pointer): DWORD; stdcall; forward;

procedure WinMain;
const szClassName = 'lab8';
var
  msg: TMsg;
  wndClass: TWndClassEx;
  hWnd: THandle;
  idThreadB, idThreadC: DWORD;
begin
  WriteLn('Program ConsoleTest is running'); 
  mainThreadID := GetCurrentThreadId();

  wndClass.cbSize := sizeof(wndClass);
  wndClass.style := CS_HREDRAW or CS_VREDRAW;
  wndClass.lpfnWndProc := @WinMainCallback;
  wndClass.cbClsExtra := 0;
  wndClass.cbWndExtra := 0;
  wndClass.hInstance := hInstance;
  wndClass.hIcon := LoadIcon(0, IDI_APPLICATION);
  wndClass.hCursor := LoadCursor(0, IDC_ARROW);
  wndClass.hbrBackground := GetStockObject(WHITE_BRUSH);
  wndClass.lpszMenuName := nil;
  wndClass.lpszClassName := szClassName;
  wndClass.hIconSm := LoadIcon(0, IDI_APPLICATION);
  RegisterClassEx(wndClass);
  hWnd := CreateWindowEx(
      0,
      szClassName,
      'Лаб 8',
      WS_OVERLAPPEDWINDOW,
      CW_USEDEFAULT, CW_USEDEFAULT,
      500, 300,
      0, 0,
      hInstance,
      nil);

  ShowWindow(hWnd, SW_SHOW);
  UpdateWindow(hwnd);   {послать wm_paint оконной процедуре, прорисовав окно минуя очередь сообщений (необязательно)}

  swapped := false;
  randomed := false;

  hMutex := CreateMutex(
    nil,   // default security attributes
    false, // initialy not owned
    nil);  // unnamed mutex

  if (hMutex = 0) then
    halt(1);

  hThreadB := CreateThread(
    nil,              // default security attributes
    0,                // default stack size
    @ThreadBCallback, // thread function
    nil,              // no thread function argumets
    0,                // default creation flag
    idThreadB);       // receive thread identifier

  if (hThreadB = 0) then
    halt(1);

  hThreadC := CreateThread(
    nil,
    0,
    @ThreadCCallback,
    nil,
    0,
    idThreadC);

  if (hThreadC = 0) then
    halt(1);

  killThreads := false;
  while GetMessage(msg, 0, 0, 0) do begin
    TranslateMessage(msg);
    DispatchMessage(msg);
  end;
end;

function WinMainCallback(hWnd: THandle; msg: integer; wParam: longint; lParam: longint): longint; stdcall;
var
  hDC: THandle;
  i: byte;
  waitResult: DWORD;
begin

  result := 0;

  case msg of
    WM_CREATE:
      SetTimer(hWnd, 1, 1000, nil);

    WM_TIMER:
      begin
        waitResult := WaitForSingleObject(hMutex, INFINITE); // Wait for mutex to get freed - infinitely
        case waitResult of
          WAIT_OBJECT_0:
            begin
              try
                hDC := GetDC(hWnd);
                for i := 0 to valueCount - 1 do
                  TextOut(hDC, 170, (i + 1) * 20, @(valueArray[i, 1]), 20);
                TextOut(hDC, 350, 20, PAnsiChar('Main Thread: ' + IntToStr(mainThreadID)), 20);
                ReleaseDC(hWnd, hDC);
              finally
                swapped := false;
                randomed := false;
                ReleaseMutex(hMutex);

              end;
            end;

          WAIT_ABANDONED:
            PostMessage(hWnd, WM_CLOSE, 0, 0); // Something went wrong, terminate program.
        end;
      end;

    WM_CLOSE:
      begin
        killThreads := true;
        WaitForSingleObject(hThreadB, INFINITE);
        CloseHandle(hThreadB);
        WaitForSingleObject(hThreadC, INFINITE);
        CloseHandle(hThreadC);
        CloseHandle(hMutex);
        KillTimer(hWnd, 0);
        DestroyWindow(hWnd);
      end;

    WM_DESTROY:
      PostQuitMessage(0);

    else
      result := DefWindowProc(hWnd, msg, wParam, lParam);
  end;
end;

function ThreadBCallback(data: pointer): DWORD; stdcall;
var
  waitResult: DWORD;
  tempValue: string[20];
  i: byte;
begin
  while not killThreads do
  begin
    if not swapped then
    begin
      //waitResult := WAIT_OBJECT_0;
      waitResult := WaitForSingleObject(hMutex, INFINITE); // Wait for mutex to get freed - infinitely and capture it
      case waitResult of
        WAIT_OBJECT_0:
          begin
            try
              tempValue := valueArray[0];
                for i := 0 to valueCount - 1 do
                  valueArray[i] := valueArray[i + 1];
                valueArray[valueCount - 1] := tempValue;
            finally
              //swapped := true;
              ReleaseMutex(hMutex);
            end;
          end;

        WAIT_ABANDONED:
          ExitThread(0);
      end;
    end;
  end;
  ExitThread(0);
end;

function ThreadCCallback(data: pointer): DWORD; stdcall;
var
  waitResult: DWORD;
  randomPos1, randomPos2: byte;
  tempValue: string[20];
begin
  while not killThreads do
  begin
    if not randomed then
    begin
      waitResult := WaitForSingleObject(hMutex, INFINITE); // Wait for mutex to get freed - infinitely
      case waitResult of
        WAIT_OBJECT_0:
          begin
            try
              randomPos1 := random(valueCount - 1);
              randomPos2 := random(valueCount - 1);
              tempValue := valueArray[randomPos1];
              valueArray[randomPos1] := valueArray[randomPos2];
              valueArray[randomPos2] := tempValue;
            finally
              //randomed := true;
              ReleaseMutex(hMutex);
            end;
          end;
          
        WAIT_ABANDONED:
          ExitThread(0);
      end;     
    end;     
  end;
  ExitThread(0);
end;


begin
  WinMain
end.

