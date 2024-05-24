Template p (input x1, x2 : real; x3 : integer output y1, y2 : real);
	var 
		N : integer = 10;
		i : integer = 1;
		x1t : real;
		x3t : real;
		outStruct : Record
			val : real;
			id : integer;
		end;
	Begin
		State S0:
			when (nem(x1) and empty(x2) and empty(x3)) using (x1) do
			// N начальное есть, приоритетный пуст, на неприоритетный пришло значение
				outStruct.val := x1;
				outStruct.id := i;
				if (x1 > 0) then
				begin
					use(y1);
					y1 := outStruct;
				end
				else if (x1 < 0)
				begin
					use(y2);
					y2 := outStruct;
				end;
				i := i + 1;
				x3t := N;
				// Остаемся на приоритетном
				next(S2);
			when (nem(x1) and nem(x3)) using (x1, x3) do
			// N начальное есть, но пришли значения
				x1t := x1; // значение на неприоритетном
				x3t := x3; // временное N
				next(S1);

		State S1:
			when (nem(x2)) using (x2) do
				// Пришло значение на приоритетный вход
				// Вывести приоритетный, сменить приоритет
				outStruct.val := x2;
				outStruct.id := i;
				if (x2 > 0) then
				begin
					use(y1);
					y1 := outStruct;
				end
				else if (x2 < 0)
				begin
					use(y2);
					y2 := outStruct;
				end;
				i := i + 1;
				if (x1t > 0) then
				begin
					use(y1);
					y1 := outStruct;
				end
				else if (x1t < 0)
				begin
					use(y2);
					y2 := outStruct;
				end;
				i := i + 1;
				next(S2);
			when (empty(x2)) do
				// Приоритетный пуст
				// Вывести неприоритетный, оставить приоритет
				outStruct.val := x1t;
				outStruct.id := i;
				if (x1t > 0) then
				begin
					use(y1);
					y1 := outStruct;
				end
				else if (x1t < 0)
				begin
					use(y2);
					y2 := outStruct;
				end;
				i := i + 1;
				next(S2);

		State S2:
			when (nem(x2)) using (x2) do
				// Пришло значение на приоритетный
				outStruct.val := x2;
				outStruct.id := i;
				if (x2 > 0) then
				begin
					use(y1);
					y1 := outStruct;
				end
				else if (x2 < 0)
				begin
					use(y2);
					y2 := outStruct;
				end;
				i := i + 1;
				if (i > N) then
					next(S5);
				else
					next(S3);
			when (nem (x1) and empty(x2)) using (x1) do
				// Пришло значение на неприоритетный
				outStruct.val := x1;
				outStruct.id := i;
				if (x1 > 0) then
				begin
					use(y1);
					y1 := outStruct;
				end
				else if (x1 < 0)
				begin
					use(y2);
					y2 := outStruct;
				end;
				i := i + 1;
				if (i > N) then
					next(S4);
				else
					next(S2);

		State S3:
			when (nem(x1)) using (x1) do
				// Пришло значение на приоритетный
				outStruct.val := x1;
				outStruct.id := i;
				if (x1 > 0) then
				begin
					use(y1);
					y1 := outStruct;
				end
				else if (x1 < 0)
				begin
					use(y2);
					y2 := outStruct;
				end;
				i := i + 1;
				if (i > N) then
					next(S4);
				else
					next(S2);
			when (nem (x2) and empty(x1)) using (x2) do
				// Пришло значение на неприоритетный
				outStruct.val := x2;
				outStruct.id := i;
				if (x2 > 0) then
				begin
					use(y1);
					y1 := outStruct;
				end
				else if (x2 < 0)
				begin
					use(y2);
					y2 := outStruct;
				end;
				i := i + 1;
				if (i > N) then
					next(S5);
				else
					next(S3);
			
		State S4:
			when (nem(x3)) using (x3) do
				N := x3;
				i := 1;
				next(S2);
			when (empty(x3)) do
				N := x3t;
				i := 1;
				next(S2);

		State S5:
			when (nem(x3)) using (x3) do
				N := x3;
				i := 1;
				next(S3);
			when (empty(x3)) do
				N := x3t;
				i := 1;
				next(S3);
	end;