program Lab5;

uses windows, messages, sysUtils;

var
  digitButtons: array [0..14] of THandle;
  textboxBuffer, operand1Char, operand2Char, operatorChar: string;
  operand1, operand2: integer;
  resultPrinted: boolean;
  xPosGlob, yPosGlob: integer;
  fillGlob: boolean;

{—лужебные функции ƒельфи дл€ форматировани€ строк и т.д.}

function WndProc(hWnd: THandle; Msg: integer;
                 wParam: longint; lParam: longint): longint;
                 stdcall; forward;

procedure Reset();
begin
  operand1Char := '';
  operand2Char := '';
  operatorChar := '';
  textboxBuffer := '';
  resultPrinted := false;
end;

procedure InputChar(key : integer);
begin
  if (resultPrinted = true) then Reset();

  if ((key >= 0) and (key <= 9)) then begin
    if ((operatorChar = '') and (Length(operand1Char) < 8)) then begin
      operand1Char := operand1Char + IntToStr(key);
      textboxBuffer := operand1Char;
    end

    else if ((operatorChar <> '') and (Length(operand2Char) < 8)) then begin
      operand2Char := operand2Char + IntToStr(key);
      textboxBuffer := operand2Char;
    end;
  end

  else begin
    case key of
      10:
        begin
          if ((operatorChar = '') and (Length(operand1Char) > 0) and (resultPrinted = false)) then begin
            operatorChar := '+';
            textboxbuffer := operatorChar;
          end;
        end;

      11:
        begin
          if ((operatorChar = '') and (Length(operand1Char) > 0) and (resultPrinted = false)) then begin
            operatorChar := '-';
            textboxbuffer := operatorChar;
          end;
        end;

      12:
        begin
          if (Length(operand2Char) > 0) then begin
            operand1 := StrToInt(operand1Char);
            operand2 := StrToInt(operand2Char);
            if (operatorChar = '+') then
              textboxBuffer := IntToStr(operand1 + operand2)
            else if (operatorChar = '-') then
              textboxBuffer := IntToStr(operand1 - operand2);

            resultPrinted := true;
          end;
        end;

      13:
        Reset();

      14:
        begin
          if (resultPrinted = false) then begin
            if ((operatorChar = '') and (Length(operand1Char) > 0)) then begin
              Delete(operand1Char, Length(operand1Char), 1);
              textboxBuffer := operand1Char;
            end

            else if ((operatorChar <> '') and (Length(operand2Char) = 0)) then begin
              operatorChar := '';
              textboxBuffer := operand1Char;
            end

            else if ((operatorChar <> '') and (Length(operand2Char) > 0)) then begin
              Delete(operand2Char, Length(operand2Char), 1);
              if (Length(operand2Char) > 0) then
                textboxBuffer := operand2Char
              else
                textboxBuffer := operatorChar;
            end;
          end;
        end;

    end;
  end;


end;

procedure WinMain; {ќсновной цикл обработки сообщений}
  const szClassName = 'lab5';
  var   wndClass: TWndClassEx;
        hWnd: THandle;
        msg: TMsg;
begin
  wndClass.cbSize := sizeof(wndClass);
  wndClass.style := cs_hredraw or cs_vredraw;
  wndClass.lpfnWndProc := @WndProc;
  wndClass.cbClsExtra := 0;
  wndClass.cbWndExtra := 0;
  wndClass.hInstance := hInstance;
  wndClass.hIcon := loadIcon(0, idi_Application);
  wndClass.hCursor := loadCursor(0, idc_Arrow);
  wndClass.hbrBackground := GetStockObject(white_Brush);
  wndClass.lpszMenuName := nil;
  wndClass.lpszClassName := szClassName;
  wndClass.hIconSm := loadIcon(0, idi_Application);

  RegisterClassEx(wndClass);

  hWnd := CreateWindowEx(
         0,
         szClassName,             {им€ класса окна}
         'Lab5',                  {заголовок окна}
         WS_OVERLAPPED or WS_CAPTION or WS_SYSMENU or WS_MINIMIZEBOX,     {стиль окна}
         cw_useDefault,           {Left}
         cw_useDefault,           {Top}
         250,                     {Width}
         300,                     {Height}
         0,                       {хэндл родительского окна}
         0,                       {хэндл оконного меню}
         hInstance,               {хэндл экземпл€ра приложени€}
         nil);                    {параметры создани€ окна}

  ShowWindow(hwnd,sw_Show); {отобразить окно}
  updateWindow(hwnd);       {послать wm_paint оконной процедуре, прорисовав окно мину€ очередь сообщений (необ€зательно)}

  while GetMessage(msg,0,0,0) do begin {получить очередное сообщение}
    TranslateMessage(msg);   {Windows транслирует сообщени€ от клавиатуры}
    DispatchMessage(msg);    {Windows вызовет оконную процедуру}
  end; {выход по wm_quit, на которое GetMessage вернет FALSE}
end;

function WndProc(hWnd: THandle; Msg: integer; wParam: longint; lParam: longint): longint; stdcall;
  var ps: TPaintStruct;
      hdc, hf, hBrush: THandle;
      rect, textRect, buttonRect: TRect;
      i, index: integer;
      xPos, yPos: integer;
      fill: boolean;
begin
  result := 0;
  case Msg of
    WM_PAINT:
      begin
        hdc := BeginPaint(hwnd, ps); //”далить WM_PAINT из очереди и начать рисование
        GetClientRect(hwnd, rect);

        if (fillGlob = true) then begin
          hBrush := CreateSolidBrush(RGB(255,0,67));
          hBrush := SelectObject(hdc, hBrush);

          Rectangle(hdc, xPosGlob, yPosGlob, xPosGlob+40, yPosGlob+40);

          fillGlob := false;
          DeleteObject(SelectObject(hdc, hBrush));
        end;

        textRect.top := 20;
        textRect.left := 35;
        textRect.right := 165;
        textRect.bottom := 45;

        hf := CreateFont(-20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'courier');
        hf := SelectObject(hdc, hf);


        Rectangle(hdc, 30, 10, 170, 50);
        SetBKMode(hdc, transparent);
        drawText(hdc, textboxbuffer, Length(textboxbuffer), textRect, DT_RIGHT);

        buttonRect.left := 80;
        buttonRect.top := 220;
        buttonRect.right := 120;
        buttonRect.bottom := 250;
        Rectangle(hdc, 80, 210, 120, 250);
        drawText(hdc, '0', 1, buttonRect, DT_CENTER);

        buttonRect.left := 30;
        buttonRect.top := 70;
        buttonRect.right := 70;
        buttonRect.bottom := 100;
        Rectangle(hdc, 30, 60, 70, 100);
        drawText(hdc, '1', 1, buttonRect, DT_CENTER);

        buttonRect.left := 80;
        buttonRect.top := 70;
        buttonRect.right := 120;
        buttonRect.bottom := 100;
        Rectangle(hdc, 80, 60, 120, 100);
        drawText(hdc, '2', 1, buttonRect, DT_CENTER);

        buttonRect.left := 130;
        buttonRect.top := 70;
        buttonRect.right := 170;
        buttonRect.bottom := 100;
        Rectangle(hdc, 130, 60, 170, 100);
        drawText(hdc, '3', 1, buttonRect, DT_CENTER);

        buttonRect.left := 30;
        buttonRect.top := 120;
        buttonRect.right := 70;
        buttonRect.bottom := 150;
        Rectangle(hdc, 30,  110,  70, 150);
        drawText(hdc, '4', 1, buttonRect, DT_CENTER);

        buttonRect.left := 80;
        buttonRect.top := 120;
        buttonRect.right := 120;
        buttonRect.bottom := 150;
        Rectangle(hdc, 80,  110, 120, 150);
        drawText(hdc, '5', 1, buttonRect, DT_CENTER);

        buttonRect.left := 130;
        buttonRect.top := 120;
        buttonRect.right := 170;
        buttonRect.bottom := 150;
        Rectangle(hdc, 130, 110, 170, 150);
        drawText(hdc, '6', 1, buttonRect, DT_CENTER);

        buttonRect.left := 30;
        buttonRect.top := 170;
        buttonRect.right := 70;
        buttonRect.bottom := 200;
        Rectangle(hdc, 30,  160,  70, 200);
        drawText(hdc, '7', 1, buttonRect, DT_CENTER);

        buttonRect.left := 80;
        buttonRect.top := 170;
        buttonRect.right := 120;
        buttonRect.bottom := 200;
        Rectangle(hdc, 80,  160, 120, 200);
        drawText(hdc, '8', 1, buttonRect, DT_CENTER);

        buttonRect.left := 130;
        buttonRect.top := 170;
        buttonRect.right := 170;
        buttonRect.bottom := 200;
        Rectangle(hdc, 130, 160, 170, 200);
        drawText(hdc, '9', 1, buttonRect, DT_CENTER);

        buttonRect.left := 180;
        buttonRect.top := 120;
        buttonRect.right := 220;
        buttonRect.bottom := 150;
        Rectangle(hdc, 180, 110, 220, 150);
        drawText(hdc, '+', 1, buttonRect, DT_CENTER);

        buttonRect.left := 180;
        buttonRect.top := 170;
        buttonRect.right := 220;
        buttonRect.bottom := 200;
        Rectangle(hdc, 180, 160, 220, 200);
        drawText(hdc, '-', 1, buttonRect, DT_CENTER);

        buttonRect.left := 180;
        buttonRect.top := 220;
        buttonRect.right := 220;
        buttonRect.bottom := 250;
        Rectangle(hdc, 180, 210, 220, 250);
        drawText(hdc, '=', 1, buttonRect, DT_CENTER);

        buttonRect.left := 180;
        buttonRect.top := 20;
        buttonRect.right := 220;
        buttonRect.bottom := 50;
        Rectangle(hdc, 180,  10, 220,  50);
        drawText(hdc, 'C', 1, buttonRect, DT_CENTER);

        buttonRect.left := 180;
        buttonRect.top := 70;
        buttonRect.right := 220;
        buttonRect.bottom := 100;
        Rectangle(hdc, 180,  60, 220, 100);
        drawText(hdc, '<-', 2, buttonRect, DT_CENTER);

        DeleteObject(SelectObject(hdc, hf));

        endPaint(hwnd, ps);
      end;

    WM_CHAR:
      begin
        if ((wParam >= 48) and (wParam <= 57)) then begin
          InputChar(wParam - 48);
          InvalidateRect(hwnd, nil, true);
        end

        else begin
          case wParam of
            43:
              begin
                InputChar(10);
                InvalidateRect(hwnd, nil, true);
              end;

            45:
              begin
                InputChar(11);
                InvalidateRect(hwnd, nil, true);
              end;

            61:
              begin
                InputChar(12);
                InvalidateRect(hwnd, nil, true);
              end;

            VK_ESCAPE:
              begin
                InputChar(13);
                InvalidateRect(hwnd, nil, true);
              end;

            VK_BACK:
              begin
                InputChar(14);
                InvalidateRect(hwnd, nil, true);
              end;
          end;
        end;

        if (fillGlob = true) then SendMessage(hWnd, WM_PAINT, 0, 0);

      end;

      WM_LBUTTONDOWN:
        begin
         xPos := LOWORD(lParam);
         ypos := HIWORD(lParam);
         fillGlob := true;

          if (xpos >= 30) and (xpos <= 70) then  begin
            if (ypos >= 60) and (ypos <= 100) then begin
              xPosGlob := 30;
              yPosGlob := 60;
              sendmessage(hwnd, WM_CHAR, 49, 0);
            end;
            if (ypos >= 110) and (ypos <= 150) then begin
              xPosGlob := 30;
              yPosGlob := 110;
              sendmessage(hwnd, WM_CHAR, 52, 0);
            end;
            if (ypos >= 160) and (ypos <= 200) then begin
              xPosGlob := 30;
              yPosGlob := 160;
              sendmessage(hwnd, WM_CHAR, 55, 0);
            end;
          end

          else if (xpos >= 80) and (xpos <= 120) then begin
            if (ypos >= 60) and (ypos <= 100) then begin
              xPosGlob := 80;
              yPosGlob := 60;
              sendmessage(hwnd, WM_CHAR, 50, 0);
            end;
            if (ypos >= 110) and (ypos <= 150) then begin
              xPosGlob := 80;
              yPosGlob := 110;
              sendmessage(hwnd, WM_CHAR, 53, 0);
            end;
            if (ypos >= 160) and (ypos <= 200) then begin
              xPosGlob := 80;
              yPosGlob := 160;
              sendmessage(hwnd, WM_CHAR, 56, 0);
            end;
            if (ypos >= 210) and (ypos <= 250) then begin
              xPosGlob := 80;
              yPosGlob := 210;
              sendmessage(hwnd, WM_CHAR, 48, 0);
            end;
          end

          else if (xpos >= 130) and (xpos <= 170) then begin
            if (ypos >= 60) and (ypos <= 100) then begin
              xPosGlob := 130;
              yPosGlob := 60;
              sendmessage(hwnd, WM_CHAR, 51, 0);
            end;
            if (ypos >= 110) and (ypos <= 150) then begin
              xPosGlob := 130;
              yPosGlob := 110;
              sendmessage(hwnd, WM_CHAR, 54, 0);
            end;
            if (ypos >= 160) and (ypos <= 200) then begin
              xPosGlob := 130;
              yPosGlob := 160;
              sendmessage(hwnd, WM_CHAR, 57, 0);
            end;
          end

          else if (xpos >= 180) and (xpos <= 240) then begin
            if (ypos >= 10) and (ypos <= 50) then begin
              xPosGlob := 180;
              yPosGlob := 10;
              sendmessage(hwnd, WM_CHAR, 27, 0);
            end;
            if (ypos >= 60) and (ypos <= 100) then begin
              xPosGlob := 180;
              yPosGlob := 60;
              sendmessage(hwnd, WM_CHAR, 8, 0);
            end;
            if (ypos >= 110) and (ypos <= 150) then begin
              xPosGlob := 180;
              yPosGlob := 110;
              sendmessage(hwnd, WM_CHAR, 43, 0);
            end;
            if (ypos >= 160) and (ypos <= 200) then begin
              xPosGlob := 180;
              yPosGlob := 160;
              sendmessage(hwnd, WM_CHAR, 45, 0);
            end;
            if (ypos >= 210) and (ypos <= 250) then begin
              xPosGlob := 180;
              yPosGlob := 210;
              sendmessage(hwnd, WM_CHAR, 61, 0);
            end;
          end;

          fill := false;
        end;

    WM_DESTROY:
        PostQuitMessage(0);

    else
      result := DefWindowProc(hwnd, msg, wParam, lParam);
  end;
end;


begin
  WinMain;
end.

