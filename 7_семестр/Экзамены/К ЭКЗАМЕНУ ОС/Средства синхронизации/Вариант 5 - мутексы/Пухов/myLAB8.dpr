{$A-,H-,I-}
program myLAB8;

uses windows,messages;
var
   mas:array[1..10]of string[20]=('00000000000000000000','11111111111111111111',
  '22222222222222222222','33333333333333333333','44444444444444444444',
  '55555555555555555555','66666666666666666666','77777777777777777777',
  '88888888888888888888','99999999999999999999');
   i:byte;
   hMutex,hThreadB,hThreadC:THandle;
   flagCloseThread:Boolean;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall; forward;

Function FunctionThreadB(data:pointer):dword;stdcall;
var
  i:byte;
  s:string[20];
begin
 while flagCloseThread do
   begin
    WaitForSingleObject(hMutex,Infinite);
    s:=mas[1];
    for i:=1 to 9 do
      mas[i]:=mas[i+1];

    mas[10]:=s;
    ReleaseMutex(hMutex);
   end;
end;

Function FunctionThreadC(data:pointer):dword;stdcall;
var
  a1,a2:byte;
  s:string[20];
begin
  while flagCloseThread do
    begin
      WaitForSingleObject(hMutex,Infinite);
      a1:=0;
      a2:=0;
      while a1=a2 do
      begin
        a1:=random(9)+1;
        a2:=random(9)+1;
      end;
      s:=mas[a1];
      mas[a1]:=mas[a2];
      mas[a2]:=s;
      ReleaseMutex(hMutex);
    end;
end;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
var
   hdc:THandle;
   ps:  TPaintStruct;
   Rect: TRect;
   ExitStatusB, ExitStatusC: cardinal;
   
begin
 result:=0;
  case Msg of
    wm_create:
      SetTimer(hwnd,1,1000,nil);

    wm_timer:
      begin
        GetClientRect(hWnd, Rect);
        InvalidateRect(hWnd, @Rect, false);
      end;
      
    wm_paint:
      begin
        hdc:=BeginPaint(hwnd, ps);
        WaitForSingleObject(hMutex,infinite);
        for i:=1 to 10 do
          TextOut(hdc,10,i*15,@mas[i,1],20);
        EndPaint(hWnd,ps);
        ReleaseMutex(hMutex);
      end;

    wm_close:
      begin
        flagCloseThread:=False;
        repeat
          GetExitCodeThread(hThreadB, ExitStatusB);
          GetExitCodeThread(hThreadC, ExitStatusC);
        until (ExitStatusB <> Still_active) and (ExitStatusC <> Still_active);
        KillTimer(hWnd,0);
        CloseHandle(hMutex);
        CloseHandle(hThreadB);
        CloseHandle(hThreadC);
        DestroyWindow(hWnd);
      end;

    wm_destroy:
        PostQuitMessage(0);
    else
      result:=DefWindowProc(hwnd,msg,wparam,lparam);
  end;
end;

procedure WinMain;
const
   szClassName='Shablon';
var
  wndClass:TWndClassEx;
  msg:TMsg;
  hWnd: THandle;
  idThreadB,idThreadC:dword;
begin
  wndClass.cbSize:=sizeof(wndClass);
  wndClass.style:=0;
  wndClass.lpfnWndProc:=@WndProc;
  wndClass.cbClsExtra:=0;
  wndClass.cbWndExtra:=0;
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
         szClassName, {��� ������ ����}
         '������������ ������ �8',    {��������� ����}
         WS_OVERLAPPED or WS_CAPTION or WS_SYSMENU or WS_MINIMIZEBOX,     {����� ����}
         600,               {Left}
         300,                {Top}
         200,                     {Width}
         200,                     {Height}
         0,                       {����� ������������� ����}
         0,                       {����� �������� ����}
         hInstance,               {����� ���������� ����������}
         nil);                    {��������� �������� ����}

  ShowWindow(hwnd,sw_Show);  {���������� ����}
  
  hMutex:=CreateMutex(nil,false,'MyMutex');

  flagCloseThread:=True;

  hThreadB:=CreateThread(nil, // ����� ������, �������������� ������ � NT
                        0, // ����������� ������ �����
                        @FunctionThreadB, // ������� ������
                        nil, // �������� ��� ������ �-��� ������
                        0, // ����� ��������, �� ��������� -- ����������� ������
                        idThreadB);

  hThreadC:=CreateThread(nil, // ����� ������, �������������� ������ � NT
                        0, // ����������� ������ �����
                        @FunctionThreadC, // ������� ������
                        nil, // �������� ��� ������ �-��� ������
                        0, // ����� ��������, �� ��������� -- ����������� ������
                        idThreadC);
                        
  while GetMessage(msg,0,0,0) do begin {�������� ��������� ���������}
     TranslateMessage(msg);   {Windows ����������� ��������� �� ����������}
     DispatchMessage(msg);    {Windows ������� ������� ���������}
  end; {����� �� wm_quit, �� ������� GetMessage ������ FALSE}
end;

begin
  randomize;
  WinMain;
end.
