// Текстовое описание шаблона, который описывает кольцевое обслуживание входов

Template Primer1 (input x1, x2, x3, x4 : real; output y1 : real);
	var : MUL := real;
	Begin
		State S0:
			when nem(x4) using (x4) do
			Begin			// f00
				MUL := x4;
				next S1;
			end;
		State S1:
			when nem(x4) using (x4) do
			Begin			// f10
				MUL := x4;
				next S1;
			end;
			when nem(x1) and empty(x4) using (x1) do
			Begin
				use (x1);
				y1 := x1 * MUL;
				next S2;
			end;
			when nem(x2) and empty(x1, x4) using (x2) do
			Begin
				use (x2);
				y1 := x2 * MUL;
				next S3;
			end;
			when nem(x3) and empty(x1, x2, x4) using (x3) do
			Begin
				use (x3);
				y1 := x3 * MUL;
				next S1;
			end;

		State S2:
			when nem(x4) using (x4) do
			Begin
				MUL := x4;
				next S2;
			end;
			when nem(x1) and empty(x4) using (x1) do
			Begin
				use (x1);
				y1 := x1 * MUL;
				next S2;
			end;
			when nem(x2) and empty(x1, x4) using (x2) do
			Begin
				use (x2);
				y1 := x2 * MUL;
				next S3;
			end;
			when nem(x3) and empty(x1, x2, x4) using (x3) do
			Begin
				use (x3);
				y1 := x3 * MUL;
				next S1;
			end;

		State S3:
			when nem(x4) using (x4) do
			Begin
				MUL := x4;
				next S3;
			end;
			when nem(x1) and empty(x4) using (x1) do
			Begin
				use (x1);
				y1 := x1 * MUL;
				next S2;
			end;
			when nem(x2) and empty(x1, x4) using (x2) do
			Begin
				use (x2);
				y1 := x2 * MUL;
				next S3;
			end;
			when nem(x3) and empty(x1, x2, x4) using (x3) do
			Begin
				use (x3);
				y1 := x3 * MUL;
				next S1;
			end;