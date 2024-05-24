Template p (input x1, x2 : real; x3 : integer output y1 : real);
	var 
		N : integer;
		i : integer = 1;
		x1t : real;
		mem : real;
		end;
	Begin
		State S0:
			when (nem(x3)) using (x3) do
				N := x3;
				next(S1);
			when (nem(x1) and empty(x2) and empty(x3)) using (x1) do
				x1t := x1;
				next(S2);
		State S1:
			when (nem(x1) and nem(x2)) using (x1, x2) do
				if (x1 > x2) then
				begin
					use(y1);
					y1 := x2;
					mem := x1;
					i := i + 1;
					next(S4);
				end
				else
				begin
					use(y1);
					y1 := x1;
					mem := x2;
					i := i + 1;
					next(S3);
				end;
		State S2:
			when (nem(x2) and nem(x3)) using (x2, x3) do
				N := x3;
				if (x1t > x2) then
				begin
					use(y1);
					y1 := x2;
					mem := x1t;
					i := i + 1;
					next(S4);
				end
				else
				begin
					use(y1);
					y1 := x1t;
					mem := x2;
					i := i + 1;
					next(S3);
				end;
		State S3:
			when (nem(x1)) using (x1) do
				if (x1 > mem) then
				begin
					use(y1);
					y1 := mem;
					mem := x1;
					i := i + 1;
					if (i > N) then
						next(S6);
					else
						next(S4);
				end
				else
				begin
					use(y1);
					y1 := x1;
					i := i + 1;
					if (i > N) then
						next(S5);
					else
						next(S3);
				end;
		State S4:
			when (nem(x2)) using (x2) do
				if (mem > x2) then
				begin
					use(y1);
					y1 := x2;
					i := i + 1;
					if (i > N) then
						next(S6);
					else
						next(S4);
				end
				else
				begin
					use(y1);
					y1 := mem;
					mem := x2;
					i := i + 1;
					if (i > N) then
						next(S5);
					else
						next(S3);
				end;
		State S5:
			when (nem(x3)) using (x3) do
				N := x3;
				i := 1;
				next(S3);
			when (empty(x3)) do
				i := 1;
				next(S3);
		State S6:
			when (nem(x3)) using (x3) do
					N := x3;
					i := 1;
					next(S4);
				when (empty(x3)) do
					N := x3t;
					i := 1;
					next(S4);
	end;











