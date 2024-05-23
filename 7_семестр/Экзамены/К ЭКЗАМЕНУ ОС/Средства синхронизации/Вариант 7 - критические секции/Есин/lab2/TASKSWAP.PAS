{Demo program for h314task}

uses dos,rdelay, crt,graph,h314task;

{$S-}

var hThread1, hThread2, hThread3:integer;

procedure Thread0;
  var i:word;
      j:longint;
begin
  randomize;
  while true do begin
    EnterCritical(1);
    putpixel(random(getmaxx), random(getmaxy-50),White);
    putpixel(random(getmaxx), random(getmaxy-50),Black);
    LeaveCritical(1);
  end;
  LoopBack;
end;

procedure Thread2;
  var i:word;
      k:real;
      x:integer;
      ch:char;
begin
  x:=0;

  repeat
      ch:=readkey;
      if ch=#27 then break;
      enterCritical(1);
      outTextXY(x,getmaxy-16,char(ch));
      x:=(x+8) mod getmaxx;
      leaveCritical(1);
  until false;

  StopThread(hThread1);
  StopThread(hThread3);
  StopThread(hThread2);
  LoopBack;
end;

procedure Thread3;
  var t1,t2:longint;
      h,m,s,s100:word;
begin
  GetTime(h,m,s,s100);
  t1:=longint(h)*60*60*1000+m*60*1000+s*1000+s100*10;
  while true do begin
    GetTime(h,m,s,s100);
    t2:=longint(h)*60*60*1000+m*60*1000+s*1000+s100*10;
  end;

  LoopBack;
end;

{$S+}
var       gd,gm:integer;

begin
  gd:=detect;
  initgraph(gd,gm,'');

  clearThreads;
  hThread1:=RegisterThread(@Thread0,8000); {Registered as Thread #0}
  hThread2:=RegisterThread(@Thread2,8000); {Registered as Thread #1}
  hThread3:=RegisterThread(@Thread3,8000); {Registered as Thread #2}

  ExecuteRegisteredThreads(true);

  closegraph;
end.