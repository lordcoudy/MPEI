{А-07-18 Есин Алексей, Вариант 7. Потоки: A, C, F}

uses dos, rdelay, crt, graph, h314task;

{$S-}

var hThread0, hThread1, hThread2: integer;

procedure Thread0;
begin
	while true do begin
		if ((KeyPressed) and (readkey = #27)) then break;
		SwitchThreads;
	end;
	StopThread(hThread1);
	StopThread(hThread2);
	StopThread(hThread0);
	LoopBack;
end;

procedure Thread1;
begin
	randomize;
	while true do begin
		EnterCritical(2);
		EnterCritical(1);
		
		SetColor(Random(GetMaxColor) + 1);
		Line(random(320), random(480), random(320), random(480));
		
		LeaveCritical(2);
		LeaveCritical(1);
	end;
	LoopBack;
end;

procedure Thread2;
var color: word;
begin
	randomize;
	while true do begin
		EnterCritical(1);
		EnterCritical(2);
		
		color := Random(GetMaxColor) + 1;
		SetColor(color);
		SetFillStyle(SolidFill, color);
		FillEllipse(random(320) + 320, random(480), random(50), random(50));
		
		LeaveCritical(2);
		LeaveCritical(1);
	end;
	LoopBack;
end;


{$S+}
var gd, gm: integer;

begin
	gd := detect;
	initgraph(gd ,gm, '');

	hThread0 := RegisterThread(@Thread0, 8000);
	hThread1 := RegisterThread(@Thread1, 8000);
	hThread2 := RegisterThread(@Thread2, 8000);

	ExecuteRegisteredThreads(true);
  
    clearThreads;

	closegraph;
end.