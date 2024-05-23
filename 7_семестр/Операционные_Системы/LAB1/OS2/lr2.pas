uses dos, rdelay, crt, graph, h314task;

{$S-}
{$F+}
var hndl1, hndl2, hndl3 :integer;

{Процедура завершения}
procedure Exit;
var 
d : boolean;
current, hour, minute, second, sec100 : word;
begin
    GetTime(hour,minute,second,sec100);
    current := (second + 20) mod 60;
    d:=true;
    while d do begin
    GetTime(hour,minute,second,sec100);
        if (second = current) then d:= false;
    end;


    StopThread(hndl3);
    StopThread(hndl2);
    StopThread(hndl1);
    LoopBack;
end;

{Процедура для рисования линий}
procedure Lines;
const rs: longint = 0;
x : Integer = 0;
y : Integer = 0;
x1 : Integer = 0;
y1 : Integer = 0;
begin
   Randomize;
    rs:=RandSeed;
   while true do begin
      EnterCritical(1);
      RandSeed:=rs;
      EnterCritical(2);

      setcolor(Random(10)+1);
      x1 := Random(400);
      y1 := Random(400);
      Line(x, y, x1, y1);
      x := x1;
      y := y1;
      rs:=RandSeed;
      LeaveCritical(1);
      LeaveCritical(2);
   end;
   LoopBack;
end;

{Процедура для рисования точек}
procedure Dots;
var
    n: Integer;
begin
    while true do begin
      EnterCritical(1);
      RandSeed:=123;
      EnterCritical(2);
      for n:=1 to 1000 do begin
         putpixel(Random(400)+400, Random(400), 2);
      end;
      RandSeed:=123;
      for n:=1 to 1000 do begin
         putpixel(Random(400)+400, Random(400), 0);
      end;
      LeaveCritical(1);
      LeaveCritical(2);
   end;
   LoopBack;
end;

{$S+}
{$F-}

{Основная программа}
var
    Gd,Gm:integer;
begin
  Gd:=detect;
  initgraph(Gd, Gm, '');

  clearThreads;
  hndl1:=RegisterThread(@Exit,8000);
  hndl2:=RegisterThread(@Lines,8000);
  hndl3:=RegisterThread(@Dots,8000);
  ExecuteRegisteredThreads(true);

  closegraph;
end.
