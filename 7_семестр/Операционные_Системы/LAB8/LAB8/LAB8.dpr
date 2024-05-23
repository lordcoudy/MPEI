// A-08-19 Balashov, var 4

program LAB8;

uses
WIndows,messages;

{$R thrd.res}

// Array of strings
var 
  StringsArray : array[1..10] of string =
  (
    'comeinthenameofpeace',
    'ecomeinthenameofpeac',
    'cecomeinthenameofpea',
    'acecomeinthenameofpe',
    'eacecomeinthenameofp',
    'peacecomeinthenameof',
    'fpeacecomeinthenameo',
    'ofpeacecomeinthename',
    'eofpeacecomeinthenam',
    'meofpeacecomeinthena'
   );

  sStr : String;                                                     // Temporal string for replacing
  hSemaphore : integer;                                              // Handle of semaphore

// Semaphore values
const 
  MaxSemaphoreValue = 1;
  StartSemaphoreValue = 1;

// Writing array to listbox
procedure Output(h:hWnd);
var 
  i, hWait : integer;
  ST : pointer;
begin
  WaitForSingleObject(hSemaphore, INFINITE);
  sStr := '';
  for i := 1 to 10 do
    sStr := sStr + StringsArray[i] + #13#10;
  ST := @sStr[1];
  ReleaseSemaphore(hSemaphore, 1, nil);
  SendMessage(
    GetDlgItem(h,3),
    wm_settext,
    0,
    integer(ST)
  );
end;

// Rotate array procedure
procedure proc1; stdcall;
var 
  s : string;
  i : integer;
  hWait : THandle;
begin
  repeat
    begin
      WaitForSingleObject(hSemaphore, INFINITE);
      s := StringsArray[1];
      for i := 1 to 9 do
        StringsArray[i] := StringsArray[i+1];
      StringsArray[10] := s;
      ReleaseSemaphore(hSemaphore, 1, nil);
    end;
  until false;
end;

// Switch random strings
procedure proc2; stdcall;
var 
  s : string;
  i, j, hWait : integer;
begin
  repeat
    begin
      WaitForSingleObject(hSemaphore, INFINITE);
      i:=random(10) + 1;
      j:=random(10) + 1;
      s := StringsArray[i];
      StringsArray[i]:= StringsArray[j];
      StringsArray[j]:= s;
      ReleaseSemaphore(hSemaphore, 1, nil);
    end;
  until false;
end;

// Main programm/dialog
function DlgProc(hDlg: HWND;Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var 
  hThread1, hThread2:THandle;
  idthread1, idthread2:DWORD;
begin
  Randomize;
  hSemaphore := CreateSemaphore(
    nil, // protection attributes
    StartSemaphoreValue, // starting value
    MaxSemaphoreValue, // maximum value
    'LikeMutexSemaphore' // Semaphore name
  );

  SetTimer(hDlg,0,1000,nil);
  case msg of
    wm_close:
      begin
        CloseHandle(hthread1);
        CloseHandle(hthread2);
        CloseHandle(hSemaphore);
        killTimer(hdlg,0);
        EndDialog(hdlg,2);
      end;
    wm_timer:
      begin
        Output(hdlg);
      end;
    wm_command:
      begin
        case hiword(wparam) of
          BN_ClICKED:
            case loword(wparam) of
              1:
                begin
                  hThread1:=CreateThread(nil,0,@proc1,nil,0,idthread1);
                  hThread2:=CreateThread(nil,0,@proc2,nil,0,idthread2);
                end;
              2: EndDialog(hdlg,2);
            end;
        end;
      end
      else
        result:=0;
  end;
end;

begin
  DialogBox(hInstance,'MAINDIALOG',0,@DlgProc);
end.
