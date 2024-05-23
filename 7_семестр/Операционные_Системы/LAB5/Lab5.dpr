program Lab5;

uses windows,
  messages,
  sysUtils; {Служебные функции Дельфи для форматирования строк и т.д.}

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

procedure WinMain; {Основной цикл обработки сообщений}
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
         szClassName, {имя класса окна}
         'Keyboard view',    {заголовок окна}
         ws_overlappedWindow,     {стиль окна}
         cw_useDefault,           {Left}
         cw_useDefault,           {Top}
         1020,                     {Width}
         460,                     {Height}
         0,                       {хэндл родительского окна}
         0,                       {хэндл оконного меню}
         hInstance,               {хэндл экземпляра приложения}
         nil);                    {параметры создания окна}

  ShowWindow(hwnd,sw_Show);  {отобразить окно}
  updateWindow(hwnd);   {послать wm_paint оконной процедуре, прорисовав
                         окно минуя очередь сообщений (необязательно)}

  while GetMessage(msg,0,0,0) do begin {получить очередное сообщение}
    TranslateMessage(msg);   {Windows транслирует сообщения от клавиатуры}
    DispatchMessage(msg);    {Windows вызовет оконную процедуру}
  end; {выход по wm_quit, на которое GetMessage вернет FALSE}
end;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
  const
   {$J+} //директива для возможности изменения типизированных констант
        str1:array [1..12]of char=('1','2','3','4','5','6','7','8','9','0','-','='); //массив цифр клавиатуры
        str2:array [1..12]of char=('q','w','e','r','t','y','u','i','o','p','[',']'); //массив вернего ряда символов
        str3:array [1..10]of char=('a','s','d','f','g','h','j','k','l',';');    //массив среднего ряда символов
        str4:array [1..10]of char=('z','x','c','v','b','n','m',',','.','/');   //массив нижнего ряда символов
        key1:byte=0;  //индекс для массивов клавиатуры - номер конкретной клавиши в ряду
        n:byte=0;
        st:byte=0; //константа для конкретной строки
        space:boolean=false;
     {$J-}
  var ps:TPaintStruct;
      hdc:THandle;
      rect,but:TRect;
      s:shortstring; //Строка как в Турбо-Паскале
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
        hdc:=BeginPaint(hwnd,ps); //Удалить WM_PAINT из очереди и начать рисование
        GetClientRect(hwnd,rect);
        assignFile(f,'Klava.bmp');  //выводим изображение клавиатуры в окно
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
       
        but.Left:=102+rect.left+Round((rect.Right-bmi^.bmiheader.biWidth)/2)+59*(key1-1)+n;     //задаём координаты прямоугольника для каждой клавиши
        but.Top:=130+rect.top+Round((rect.Bottom-bmi^.bmiheader.biHeight)/2)+59*(st-1);           //34 - расстояние в пикселях от начала изображения клавиатуры до конца клавиши ` - начала нужной клавиши
        but.Right:=152+rect.left+Round((rect.Right-bmi^.bmiheader.biWidth)/2)+59*(key1-1)+n;  //8 - расстояние в пискелях от начала изображения клавиатуры до верхней границы клавиши
        but.Bottom:=180+rect.top+Round((rect.Bottom-bmi^.bmiheader.biHeight)/2)+59*(st-1);     //20 - сторона клавиши с учётом пропусков, 15 - чистая сторона
       
       if st=1 then s:='"'+str1[key1]+'"'+' key pressed'       //выводим s, если строка 1 на клавиатуре
        else if st=2 then s:='"'+str2[key1]+'"'+' key pressed'  //выводим s, если строка 2 на клавиатуре
         else if st=3 then s:='"'+str3[key1]+'"'+' key pressed'  //выводим s, если строка 3 на клавиатуре
          else if st=4 then s:='"'+str4[key1]+'"'+' key pressed'  //выводим s, если строка 4 на клавиатуре
         else s:='';
       if(key1>0)then InvertRect(hdc,but); // инвеpтиpуем цвет пpямоугольника конкретной клавиши
       if(space=true)then    //если флаг пробела установлен
        begin
        but.Left:=rect.left+Round((rect.Right-bmi^.bmiheader.biWidth)/2)+277;    //задаём координаты прямоугольника для пробела
        but.Top:=365+rect.top+Round((rect.Bottom-bmi^.bmiheader.biHeight)/2);    //277 - длина рамки клавы+Ctrl+Win+Alt
        but.Right:=rect.left+Round((rect.Right-bmi^.bmiheader.biWidth)/2)+277+350; //350 - длина пробела
        but.Bottom:=365+rect.top+Round((rect.Bottom-bmi^.bmiheader.biHeight)/2)+52; //365 - высота 4-х рядов клавиш+рамка, 52 - высота пробела
        InvertRect(hdc,but); // инвеpтиpуем цвет пpямоугольника пробела
        s:='"Space" key pressed' //выводим строку о нажатии пробела
        end;
      // TextOut(hdc,rect.left+Round((rect.Right-bmi^.bmiheader.biWidth)/2)+5,
      //         rect.top+Round((rect.Bottom-bmi^.bmiheader.biHeight)/2)+5+bmi^.bmiheader.biHeight,@s[1],length(s)); //устанавливаем прямоугольник для вывода текста о нажатии клавиши
      TextOut(hdc, 350, 50, @s[1], length(s));
      freemem(p);
      endPaint(hwnd,ps);
      end;

   WM_CHAR:   //обработка символьных сообщений
      begin
       for i:=1 to 12 do       //пробегаемся по массивам
       if wParam=integer(str1[i]) then  //если в wparam лежит виртуальный код клавиши из массива str1
        begin
         key1:=i;  //keyl тепе`
         st:=1;
         n:=0;     //смещение относительно клавиши с ` по горизонтали нулевое
         invalidaterect(hwnd,nil,true);   //перерисовать клиентскую область окна и её фон
        end
       else
        if wParam=integer(str2[i]) then
         begin
          key1:=i;
          st:=2;
          n:=30;   //смещение относительно клавиши с ` по горизонтали на длину Tab-`
          invalidaterect(hwnd,nil,true);
         end;
       if key1=0 then
       for i:=1 to 10 do
       if wParam=integer(str3[i]) then
        begin
         key1:=i;
         st:=3;
         n:=44;  //смещение относительно клавиши с ` по горизонтали на длину Caps-`
        invalidaterect(hwnd,nil,true);
        end
       else
        if wParam=integer(str4[i]) then
         begin
          key1:=i;
          st:=4;
          n:=74;  //смещение относительно клавиши с ` по горизонтали на длину Shift-`
          invalidaterect(hwnd,nil,true);
         end
        else if wParam=integer(' ')then     //если же пробел
        begin
         space:=true;      //устанавливаем флаг
         invalidaterect(hwnd,nil,true);
        end;
      end;

   WM_KEYUP:  //обработка аппаратного сообщения об отпускании клавиши
    begin     //обнуляем keyl, st и сбрасываем флаг пробела
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

