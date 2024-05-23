program lab4;

{
Задание
Программа должна создавать окно, в котором фон заполнен рисунком из файла .BMP,
а в прямоугольной рамке заданной конфигурации выведен текст.
Файл .BMP может быть создан с помощью стандартного редактора Paint или с помощью image Editor из комплекта по-
ставки Delphi. Текст не должен "выезжать" за и на границу рамки.

Вариант:
№ | Заполнение рисунком | Рамка           | Текст
1 | растянут            | 10х10 см.       | Строки программы, 12pt, Aria
}

uses windows,messages;

 {Объявление типа оконной процедуры}
Type WndProcType = function (hWnd: THandle; Msg: LongWord;
                  wParam: longint; lParam: longint):longint; stdcall;

{-------ОКОННАЯ ПРОЦЕДУРА-------}

function WndProc(hWnd: THandle; Msg: LongWord; wParam: longint; lParam: longint): longint; stdcall;
  var ps:TPaintStruct;
      hdc:THandle;
      hpen:THandle;
      rect:TRect;
      color:integer;
      p:pointer;
      t:pointer;
      bmi:^TBitmapInfo;
      data:pointer;
      f:file;
      ftext:file;
      sze:integer;
      lf:TLogFont;
      hf:THandle;
begin
  result:=0;
  case Msg of
    wm_paint:
      begin
        hdc:=BeginPaint(hwnd,ps);              //Начало отрисовки
        GetClientRect(hwnd,rect);              //Получение клиентской области окна

        assignFile(f,'wallppr.bmp');   //Назначение хендлу файла названия изображения
        reset(f,1);                    //Открытие файла для чтения
        sze:=filesize(f);              //Получение размера изображения
        getmem(p,sze);                 //Выделение памяти для его считывания
        blockread(f,p^,sze);           //Считывание блоками
        closeFile(f);                  //Закрытие файла

        integer(bmi):=integer(p)+sizeof(TBitmapFileheader);              //Адрес для помещения заголовка bmp
        integer(data):=integer(p)+TBitmapFileheader(p^).bfOffBits;       //Адрес для помещения данных bmp

        {Отрисовка считанного изображения из памяти}
        stretchDiBits(hdc,
                      rect.left,rect.top,rect.right,rect.bottom,
                      0,0,bmi^.bmiheader.biWidth, bmi^.bmiheader.biHeight,
                      data,
                      bmi^,DIB_RGB_COLORS,srccopy);

        {Рисование рамки и текста}

        //Определение шрифта
        with lf do begin
          lfHeight:= - 12*GetDeviceCaps(hDC, LOGPIXELSY) div 72;     //Перевод высоты  шрифта для соответствия 12кеглю
          lfWidth:=0;                                                //Ширина = 0 для корректного отображения
          lfFaceName:='Arial';                                       //Установленный шрифт
        end;

        fillchar(lf,sizeof(lf),0);                     //Заполнение непрерывное значение байт пустыми символами

        {Прямоугольник}
        //Установка метрической системы координат
        SetMapMode(hdc, MM_LOMETRIC);
        SetWindowExtEx(hdc, 1000, 1000, nil);
        SetViewportOrgEx(hdc, 50, rect.bottom-50, nil);

        rect.left:=0;
        rect.right:=1000;
        rect.top:=1000;
        rect.bottom:=0;

        //Перо
        hPen:=SelectObject(hdc,createPen(ps_Solid,3,rgb(0,0,200))); //Создание и выбор пера
        SetRop2(hdc,R2_COPYPEN);                                         //установка режима пера
        //Кисть
        SelectObject(hdc,GetStockObject(null_Brush));     //Фон заливки прямоугольника

        rectangle(hdc, rect.left, rect.top, rect.right, rect.bottom);                  //Отрисовать прямоугольник

        SetRop2(hdc,r2_copypen);                           //Установка режима рисования по умолчанию
        DeleteObject(SelectObject(hdc,hPen));              //Удаление созданного пера

        hf:=SelectObject(hdc,createFontIndirect(lf)); //хендл шрифта
        SetBKMode(hdc,transparent);                   //Прозрачная заливка

        rect.left:=rect.left+5;
        rect.right:=rect.right-5;
        rect.top:=rect.top+5;
        rect.bottom:=rect.bottom+5;

        assignFile(ftext,'text.txt');   //Назначение хендлу файла названия изображения
        reset(ftext,1);                    //Открытие файла для чтения
        sze:=filesize(ftext);              //Получение размера изображения
        getmem(t,sze);                 //Выделение памяти для его считывания
        blockread(ftext,t^,sze);           //Считывание блоками
        closeFile(ftext);                  //Закрытие файла

        DrawText(hdc, t, sze, rect, DT_WORD_ELLIPSIS);
        DeleteObject(SelectObject(hdc,hf));                                          //освобождение хендла шрифта

        freemem(p);          //Освободить память
        endPaint(hwnd,ps);   //Закончить рисование
      end;
    wm_destroy:
      PostQuitMessage(0);
    else
      result:=DefWindowProc(hwnd,msg,wparam,lparam);
  end;
end;


{-----ГЛАВНАЯ ПРОЦЕДУРА-------}

  const szClassName='Text and rectangle';
  var   wndClass:TWndClassEx;
        hWnd: THandle;
        msg:TMsg;
        wndprocvar : WndProcType;

begin
  wndprocvar:=@WndProc ;
  {Установка параметров оконного класса}
  wndClass.cbSize:=sizeof(wndClass);
  wndClass.style:=cs_hredraw or cs_vredraw;
  wndClass.lpfnWndProc:= wndprocvar;
  wndClass.cbClsExtra:=0;
  wndClass.cbWndExtra:=0;
  wndClass.hInstance:=hPrevInst;
  wndClass.hInstance:=hInstance;
  wndClass.lpszClassName:=szClassName;
  wndClass.lpszMenuName:=nil;
  wndClass.hIconSm:=loadIcon(0, idi_Application);
  wndClass.hIcon:=loadIcon(0, idi_Application);
  wndClass.hCursor:=loadCursor(0, idc_Arrow);
  wndClass.hbrBackground:=GetStockObject(black_Brush);

  RegisterClassEx(wndClass); {Регистрация нового оконного класса}

  {Порождение оконного класа}
  hwnd:=CreateWindow(
         szClassName,  {имя оконного класса}
         'Text and rectangle',    {заголовок окна}
         ws_overlappedWindow,     {стиль}
         20,                      {Left}
         20,                      {Top}
         700,                     {Width}
         700,                     {Height}
         0,                       {хендл родительского окна}
         0,                       {хендл оконного меню}
         hInstance,               {хендл экземпляра приложения}
         nil);                    {параметры создания окна}

  ShowWindow(hwnd,sw_Show);  {Отобразить окно}
  updateWindow(hwnd);   {посылает окну сообщение wm_paint, пропуская очередь}

  {цикл обработки сообщений}
  while GetMessage(msg,0,0,0) do begin {получить очередное сообщение}
    TranslateMessage(msg);   {Windows транслирует сообщения от клавиатуры}
    DispatchMessage(msg);    {Windows вызовет оконную процедуру}
  end; {выход по wm_quit, на которое GetMessage вернет FALSE}

end.


