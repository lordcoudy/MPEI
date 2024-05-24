// Разработать ААС, преобразующю последовательность вещественных чисел {A0, A1,..., An, ...} 
// в последовательность E(A) {E(A0), E(A1), ..., E(An), ...}.
// e(a) = {
// 	E1(a), если a < 0, 
// 	E2(a), если a >= 0
// 	}

// Шаблон компонента P1:
Template sigma1 (output y1, y2 : real; y3 : boolean);
	source
		sr : real;
	var 
		a : real;
	Begin
		State S0:
			read(sr, a);
			if a < 0 then
			begin
				use(y1, y3);
				y1 = a;
				y3 = false;
			end;
			else
			begin
				use(y2, y3);
				y2 = a;
				y3 = true;
			end;
			next S0;
	end;

// Шаблон компонента P4:
Template sigma4 (input x1, x2 : real; x3 : boolean);
	receiver
		rc : real;
	var 
		a : real;
	Begin
		State S0:
			when nem(x3) using (x3) do
				if not x3 then next S1;
				else next S2;
		State S1:
			when nem(x1) using (x1) do
			begin
				write (rc, x1);
				next S0;
			end;
		State S2:
			when nem(x2) using (x2) do
			begin
				write (rc, x2);
				next S0;
			end;
