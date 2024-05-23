{$A-,H-,I-}
program lab8;

uses
  windows,
  messages,
  sysutils;
  {$R thrd.res}
var
  strBufer:string;
  hEvent:THandle;
  flag:bool;

  mas:array[0..9] of string[20]=('00000000000000000000',
                                 '11111111111111111111',
                                 '22222222222222222222',
                                 '33333333333333333333',
                                 '44444444444444444444',
                                 '55555555555555555555',
                                 '66666666666666666666',
                                 '77777777777777777777',
                                 '88888888888888888888',
                                 '99999999999999999999');
function ThreadB(data: pointer): dword; stdcall;
  var  i:byte;
  str0:string[20];
begin
  while flag do begin
    str0:='';
     // while True do begin
      WaitForSingleObject(hEvent,infinite);
      str0:=mas[0];
      for i:=1 to 10 do
      mas[i-1]:=mas[i];
      mas[9]:=str0;
      SetEvent(hEvent);
    //end;
  end;
end;

function ThreadC(data: pointer): dword; stdcall;
  var a1,a2:byte;
      str:string[20];
begin
  while flag do begin
    str:='';
    //  while True do begin
      WaitForSingleObject(hEvent,infinite);
      a1:=random(10);
      a2:=random(10);
      str:=mas[a1];
      mas[a1]:=mas[a2];
      mas[a2]:=str;
      SetEvent(hEvent);
    //end;
  end;
end;

function DlgProc(hDlg: HWND;Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
  var i:byte;
      strPointer:Pointer;
      hThreadB,hThreadC:THandle;
      idThreadB,idThreadC:dword;
      statusB,statusC:DWORD;

begin
  case msg of
    wm_initdialog:
      begin
        randomize;
        flag:=true;
        hEvent:=CreateEvent(nil, // атрибуты защиты
                      false, // автосброс после наступления при ожидании
                      true, // начальное значение
                      'MyEvent'); // имя события
        SetTimer(hDlg,0,1000,nil);
      end;

    wm_timer:
      begin
        WaitForSingleObject(hEvent,infinite);
        strBufer:='';
        for i:=0 to 9 do
        strBufer:=strBufer+mas[i]+#13#10;
        strPointer:=@strBufer[1];
        SetEvent(hEvent);
        SendMessage(GetDlgItem(hDlg,3),wm_settext,0,integer(strPointer));
      end;

    wm_command:
      begin
        case hiword(wparam) of
          BN_ClICKED:
            case loword(wparam) of
              1:
                begin
                  hThreadB:=CreateThread(nil, // флаги защиты, поддерживаются только в NT
                        0, // стандартный размер стека
                        @ThreadB, // функция потока
                        nil, // аргумент при старте ф-ции потока
                        0, // флаги создания, по умолчанию -- немедленный запуск
                        idThreadB);

                  hThreadC:=CreateThread(nil, // флаги защиты, поддерживаются только в NT
                        0, // стандартный размер стека
                        @ThreadC, // функция потока
                        nil, // аргумент при старте ф-ции потока
                        0, // флаги создания, по умолчанию -- немедленный запуск
                        idThreadC);
                end;
              2:
                SendMessage(hdlg,wm_close,0,0);

            end;
        end;
      end;

    wm_close:
      begin
        flag:=false;
        WaitForSingleObject(hThreadB,infinite);
        CloseHandle(hThreadB);
        WaitForSingleObject(hThreadC,infinite);
        CloseHandle(hThreadC);
        CloseHandle(hEvent);
       //ExitProcess(0);
        killTimer(hdlg,0);
        EndDialog(hdlg,2);
      end;

    else
      result:=0;
  end;
end;

begin
  DialogBox(hInstance,'DIALOG1',0,@DlgProc);
end.
