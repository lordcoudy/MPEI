uses dos, rdelay, crt, graph, h314task;

{$S-}
{$F+}
var hndl1, hndl2, hndl3 :integer;

procedure Exit;
    var K:char;
begin
    repeat
        K:=readkey;
        if K=#27 then break;
    until false;

    StopThread(hndl3);
    StopThread(hndl2);
    StopThread(hndl1);
    LoopBack;
end;

procedure Lines;
const rs: longint = 0;
begin
   Randomize;
    rs:=RandSeed;
   while true do begin
      EnterCritical(1);
     RandSeed:=rs;
      EnterCritical(2);
    { Randomize;
}      setcolor(Random(10)+1);
      Line(Random(400), Random(400), Random(400), Random(400));
      rs:=RandSeed;
      LeaveCritical(1);
      LeaveCritical(2);
   end;
   LoopBack;
end;

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
      LeaveCritical(1);

      EnterCritical(1);
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

{MAIN PROGRAMM}
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
