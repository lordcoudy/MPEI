{А-07-18 Есин Алексей, Вариант 7. Потоки: A, C, F}

uses dos, rdelay, crt, graph, h314task;

{$S-}
var hThreadA, hThreadC, hThreadF: integer;

procedure ThreadA;
begin
	while true do begin
		if ((KeyPressed) and (readkey = #27)) then break;
		SwitchThreads;
	end;

	StopThread(hThreadC);
	StopThread(hThreadF);
	StopThread(hThreadA);
	LoopBack;
end;


procedure ThreadC;
begin
	randomize;
	while true do begin
		SetColor(Random(GetMaxColor) + 1);
		Line(random(320), random(480), random(320), random(480));
		SwitchThreads;
	end;
	LoopBack;
end;


procedure ThreadF;
var color: word;
begin
	randomize;
	while true do begin
		color := Random(GetMaxColor) + 1;
		SetColor(color);
		SetFillStyle(SolidFill, color);
		FillEllipse(random(320) + 320, random(480), random(50), random(50));
		SwitchThreads;
	end;
	LoopBack;
end;

{$S+}
var gd, gm: integer;

begin
	gd := detect;
	initgraph(gd, gm, '');

	hThreadA := RegisterThread(@ThreadA, 8000);
	hThreadC := RegisterThread(@ThreadC, 8000);
	hThreadF := RegisterThread(@ThreadF, 8000);

	ExecuteRegisteredThreads(false);

	clearThreads;
	
	closegraph;
end.