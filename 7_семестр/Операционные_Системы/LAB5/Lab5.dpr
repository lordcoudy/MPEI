program Lab5;

uses windows,
  messages,
  sysUtils; {��������� ������� ������ ��� �������������� ����� � �.�.}

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

procedure WinMain; {�������� ���� ��������� ���������}
  const szClassName='Shablon';
  var   wndClass:TWndClassEx;
        hWnd: THandle;
        msg:TMsg;
begin
  wndClass.cbSize:=sizeof(wndClass);
  wndClass.style:=cs_hredraw or cs_vredraw;
  wndClass.lpfnWndProc:=@WndProc;
  wndClass.cbClsExtra:=0;
  wndClass.cbWndExtra:=0;
  wndClass.hInstance:=hPrevInst;
  wndClass.hInstance:=hInstance;
  wndClass.hIcon:=loadIcon(0, idi_Application);
  wndClass.hCursor:=loadCursor(0, idc_Arrow);
  wndClass.hbrBackground:=GetStockObject(white_Brush);
  wndClass.lpszMenuName:=nil;
  wndClass.lpszClassName:=szClassName;
  wndClass.hIconSm:=loadIcon(0, idi_Application);

  RegisterClassEx(wndClass);

  hwnd:=CreateWindowEx(0,
         szClassName, {��� ������ ����}
         'Keyboard view',    {��������� ����}
         ws_overlappedWindow,     {����� ����}
         cw_useDefault,           {Left}
         cw_useDefault,           {Top}
         1020,                     {Width}
         460,                     {Height}
         0,                       {����� ������������� ����}
         0,                       {����� �������� ����}
         hInstance,               {����� ���������� ����������}
         nil);                    {��������� �������� ����}

  ShowWindow(hwnd,sw_Show);  {���������� ����}
  updateWindow(hwnd);   {������� wm_paint ������� ���������, ����������
                         ���� ����� ������� ��������� (�������������)}

  while GetMessage(msg,0,0,0) do begin {�������� ��������� ���������}
    TranslateMessage(msg);   {Windows ����������� ��������� �� ����������}
    DispatchMessage(msg);    {Windows ������� ������� ���������}
  end; {����� �� wm_quit, �� ������� GetMessage ������ FALSE}
end;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
  const
   {$J+} //��������� ��� ����������� ��������� �������������� ��������
        str1:array [1..12]of char=('1','2','3','4','5','6','7','8','9','0','-','='); //������ ���� ����������
        str2:array [1..12]of char=('q','w','e','r','t','y','u','i','o','p','[',']'); //������ ������� ���� ��������
        str3:array [1..10]of char=('a','s','d','f','g','h','j','k','l',';');    //������ �������� ���� ��������
        str4:array [1..10]of char=('z','x','c','v','b','n','m',',','.','/');   //������ ������� ���� ��������
        key1:byte=0;  //������ ��� �������� ���������� - ����� ���������� ������� � ����
        n:byte=0;
        st:byte=0; //��������� ��� ���������� ������
        space:boolean=false;
     {$J-}
  var ps:TPaintStruct;
      hdc:THandle;
      rect,but:TRect;
      s:shortstring; //������ ��� � �����-�������
      p:pointer;
      bmi:^TBitmapInfo;
      data:pointer;
      f:file;
      sze:integer;
      i:byte;
      c:char;

begin
  result:=0;
  case Msg of

    WM_PAINT:
      begin
        hdc:=BeginPaint(hwnd,ps); //������� WM_PAINT �� ������� � ������ ���������
        GetClientRect(hwnd,rect);
        assignFile(f,'Klava.bmp');  //������� ����������� ���������� � ����
        reset(f,1);
        sze:=filesize(f);
        getmem(p,sze);
        blockread(f,p^,sze);
        closeFile(f);
        integer(bmi):=integer(p)+sizeof(TBitmapFileheader);
        integer(data):=integer(p)+TBitmapFileheader(p^).bfOffBits;
        stretchDiBits(hdc,
                      rect.left+Round((rect.Right-bmi^.bmiheader.biWidth)/2),rect.top+Round((rect.Bottom-bmi^.bmiheader.biHeight)/2),
                      bmi^.bmiheader.biWidth,bmi^.bmiheader.biHeight,
                      0,0,bmi^.bmiheader.biWidth, bmi^.bmiheader.biHeight,
                      data,
                      bmi^,DIB_RGB_COLORS,srccopy);
       
        but.Left:=102+rect.left+Round((rect.Right-bmi^.bmiheader.biWidth)/2)+59*(key1-1)+n;     //����� ���������� �������������� ��� ������ �������
        but.Top:=130+rect.top+Round((rect.Bottom-bmi^.bmiheader.biHeight)/2)+59*(st-1);           //34 - ���������� � �������� �� ������ ����������� ���������� �� ����� ������� ` - ������ ������ �������
        but.Right:=152+rect.left+Round((rect.Right-bmi^.bmiheader.biWidth)/2)+59*(key1-1)+n;  //8 - ���������� � �������� �� ������ ����������� ���������� �� ������� ������� �������
        but.Bottom:=180+rect.top+Round((rect.Bottom-bmi^.bmiheader.biHeight)/2)+59*(st-1);     //20 - ������� ������� � ������ ���������, 15 - ������ �������
       
       if st=1 then s:='"'+str1[key1]+'"'+' key pressed'       //������� s, ���� ������ 1 �� ����������
        else if st=2 then s:='"'+str2[key1]+'"'+' key pressed'  //������� s, ���� ������ 2 �� ����������
         else if st=3 then s:='"'+str3[key1]+'"'+' key pressed'  //������� s, ���� ������ 3 �� ����������
          else if st=4 then s:='"'+str4[key1]+'"'+' key pressed'  //������� s, ���� ������ 4 �� ����������
         else s:='';
       if(key1>0)then InvertRect(hdc,but); // ����p��p��� ���� �p������������ ���������� �������
       if(space=true)then    //���� ���� ������� ����������
        begin
        but.Left:=rect.left+Round((rect.Right-bmi^.bmiheader.biWidth)/2)+277;    //����� ���������� �������������� ��� �������
        but.Top:=365+rect.top+Round((rect.Bottom-bmi^.bmiheader.biHeight)/2);    //277 - ����� ����� �����+Ctrl+Win+Alt
        but.Right:=rect.left+Round((rect.Right-bmi^.bmiheader.biWidth)/2)+277+350; //350 - ����� �������
        but.Bottom:=365+rect.top+Round((rect.Bottom-bmi^.bmiheader.biHeight)/2)+52; //365 - ������ 4-� ����� ������+�����, 52 - ������ �������
        InvertRect(hdc,but); // ����p��p��� ���� �p������������ �������
        s:='"Space" key pressed' //������� ������ � ������� �������
        end;
      // TextOut(hdc,rect.left+Round((rect.Right-bmi^.bmiheader.biWidth)/2)+5,
      //         rect.top+Round((rect.Bottom-bmi^.bmiheader.biHeight)/2)+5+bmi^.bmiheader.biHeight,@s[1],length(s)); //������������� ������������� ��� ������ ������ � ������� �������
      TextOut(hdc, 350, 50, @s[1], length(s));
      freemem(p);
      endPaint(hwnd,ps);
      end;

   WM_CHAR:   //��������� ���������� ���������
      begin
       for i:=1 to 12 do       //����������� �� ��������
       if wParam=integer(str1[i]) then  //���� � wparam ����� ����������� ��� ������� �� ������� str1
        begin
         key1:=i;  //keyl ����`
         st:=1;
         n:=0;     //�������� ������������ ������� � ` �� ����������� �������
         invalidaterect(hwnd,nil,true);   //������������ ���������� ������� ���� � � ���
        end
       else
        if wParam=integer(str2[i]) then
         begin
          key1:=i;
          st:=2;
          n:=30;   //�������� ������������ ������� � ` �� ����������� �� ����� Tab-`
          invalidaterect(hwnd,nil,true);
         end;
       if key1=0 then
       for i:=1 to 10 do
       if wParam=integer(str3[i]) then
        begin
         key1:=i;
         st:=3;
         n:=44;  //�������� ������������ ������� � ` �� ����������� �� ����� Caps-`
        invalidaterect(hwnd,nil,true);
        end
       else
        if wParam=integer(str4[i]) then
         begin
          key1:=i;
          st:=4;
          n:=74;  //�������� ������������ ������� � ` �� ����������� �� ����� Shift-`
          invalidaterect(hwnd,nil,true);
         end
        else if wParam=integer(' ')then     //���� �� ������
        begin
         space:=true;      //������������� ����
         invalidaterect(hwnd,nil,true);
        end;
      end;

   WM_KEYUP:  //��������� ����������� ��������� �� ���������� �������
    begin     //�������� keyl, st � ���������� ���� �������
     key1:=0;
     st:=0;
     space:=false;
     invalidaterect(hwnd,nil,true);
    end;

    WM_DESTROY:
        PostQuitMessage(0);

    else
      result:=DefWindowProc(hwnd,msg,wparam,lparam);
  end;
end;

begin
  WinMain;
end.

