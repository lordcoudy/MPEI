{$A-,H-,I-}
program LabThred;

uses windows,messages;
var
edithandle: THandle;
buffer: array[0..2000] of char;
filehandle : THandle;
RefreshMsgId:integer;
FileMap: THandle;
pData: Pointer;
{$R thrd.res}


function DlgProc(hDlg: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  result:=1;
  case msg of
    wm_close: EndDialog(hdlg,idCancel);
    wm_command:
      case hiword(wparam) of
        BN_CLICKED:
          case loword(wparam) of
              idok:
                   begin
                     SendDlgItemMessage(hDlg, 101,wm_gettext,sizeof(buffer),integer(@buffer));
                     pData := MapViewOfFile(FileMap, FILE_MAP_ALL_ACCESS,0,0,0);
                     Move(buffer, pData^, sizeof(buffer));
                     UnmapViewOfFile(pData);
                     SendMessage(HWND_BROADCAST, RefreshMsgId, hDlg,0);
                   end;
            end;

      end;
    else
      begin
        if (msg = RefreshMsgId) then
          begin
          pData := MapViewOfFile(FileMap, FILE_MAP_ALL_ACCESS,0,0,0);
          Move(pData^, buffer, sizeof(buffer));
          UnmapViewOfFile(pData);
          SendDlgItemMessage(hDlg, 101,wm_settext,sizeof(buffer),integer(@buffer));
          end
        else
        result:=0;
      end;
  end;
end;

procedure a;
begin
     RefreshMsgId:= RegisterWindowMessage('refresh');
     FileMap := OpenFileMapping(FILE_MAP_WRITE, false, 'myfile.map');
  if (FileMap = 0) then
    begin
      filehandle := CreateFile('myfile.map', GENERIC_READ or GENERIC_WRITE,0,nil,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,0);
      FileMap := CreateFileMapping( filehandle,nil,PAGE_READWRITE,0, 4096,'myfile.map');
      DialogBox(hInstance,'DIALOG1',0,@DlgProc);
      CloseHandle(FileMap);
      CloseHandle(filehandle);
    end
  else
    begin
      DialogBox(hInstance,'DIALOG1',0,@DlgProc);
      CloseHandle(FileMap);
    end;
end;

begin
  a;
end.
