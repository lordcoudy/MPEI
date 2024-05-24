{------------------------- 1 -------------------------}

function GCD (a, b : integer) : integer;
begin
	if b = 0 then
		GCD := a
	else
		GCD := GCD(b, a mod b);
end;

{------------------------- 2 -------------------------}

function fibonachi (n : integer) : integer;
begin
	if n = 0 then
		fibonachi := 0
	else
		if n = 1 then
			fibonachi := 1
		else
			fibonachi := fibonachi(n - 1) + fibonachi(n - 2);
end;

{------------------------- 3 -------------------------}

function factorial (n : integer) : integer;
begin
	if n = 0 then
		factorial := 1
	else
		factorial := n * factorial(n - 1);
end;

function binom (n, k : integer) : integer;
begin
	binom := factorial(n) div (factorial(k) * factorial(n - k));
end;

{------------------------- 4 -------------------------}

function pow (x, n : integer) : integer;
begin
	if n = 0 then
		pow := 1
	else
		pow := x * pow(x, n - 1);
end;

function fraction (a, i : integer) : integer;
begin
	fraction := 1 div (pow(a + i, 2));
end;

function seriesSum (a, n : integer) : real;
begin
	seriesSum := 0;
	for i := 1 to n do
		seriesSum := seriesSum + fraction(a, i);
end;