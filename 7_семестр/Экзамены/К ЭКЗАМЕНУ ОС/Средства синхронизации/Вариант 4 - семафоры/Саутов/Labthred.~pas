{$A-,H-,I-}
program LabThred;

uses windows,messages,sound;

{$R thrd.res}

const DELAY_MS=10500;
      melody:array [0..10] of word=
      (440,523,880,698,587,494,330,415,523,440,880);

procedure SimpleDelay;
  var t,dt:integer;
begin
  t:=getTickCount;
  repeat
    {что-нибудь делать}
    dt:=GetTickCount-t;
    if dt mod 1000 < 50 then
      OnSound(440{melody[dt div 1000]});
  until DT>DELAY_MS;
  NoSound;
end;

procedure DelayWithMessages;
  var t,dt:integer;
      msg:TMsg;
begin
  t:=getTickCount;
  repeat
    {что-нибудь делать}
    dt:=GetTickCount-t;
    if dt mod 1000 < 100 then
      OnSound(melody[dt div 1000]);

    if PeekMessage(msg,0,0,0,pm_Remove) then begin
      TranslateMessage(msg);
      DispatchMessage(MSG);
      t:=GetTickCount-dt; // для продолжения после обработки сообщения
    end;
  until DT>DELAY_MS;
  NoSound;
end;

procedure ThreadFunction(var dwParam:dword); stdcall;
begin
  SimpleDelay;
  // просто выход из функции потока приводит к завершению потока
  // также поток завершается при завершении процесса
end;

procedure ThreadedDelay;
  var hThread:THandle;
      idThread:integer;
begin
  hThread:=CreateThread(nil, // флаги защиты, поддерживаются только в NT
                        0, // стандартный размер стека
                        @ThreadFunction, // функция потока
                        nil, // аргумент при старте ф-ции потока
                        0, // флаги создания, по умолчанию -- немедленный запуск
                        idThread);
end;

function DlgProc(hDlg: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  case msg of
    wm_close: EndDialog(hdlg,idCancel);
    wm_command:
      case hiword(wparam) of
        BN_CLICKED:
          case loword(wparam) of
            idok: endDialog(hdlg,idOk);
            idcancel: EndDialog(hdlg,idCancel);
            101: SimpleDelay;
            102: DelayWithMessages;
            103: ThreadedDelay;
          end;
      end;
  end;
end;

begin
  DialogBox(hInstance,'DIALOG1',0,@DlgProc);
  noSound; // Для выключения звука при множестве потоков
end.
