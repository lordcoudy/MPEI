program Lab7;

{$APPTYPE CONSOLE}

uses
  windows;

var
n, i, j, k, l: Integer;
MIN, mini : real;
A: array [1..20] of Real;
B: array [1..20] of Real;
fin, fout: TextFile;
//Variant �2

begin
    SetConsoleCP(1251);
    SetConsoleOutputCP(1251);
    if ParamCount<2 then begin writeln('CritError: �� ������ ��������� ���������'); readln; exit end;
    AssignFile(fin, ParamStr(1));
    AssignFile(fout, ParamStr(2));
	  Reset(fin);
 	  Rewrite(fout);
    writeln(fout, 'Lab.7' :40);
    readln(fin, n);
    if (n<1) then writeln(fout,'������� n ������ 1')
    else if n>20 then writeln(fout,'������� n ������ 20')
    else
    begin
      for i := 1 to n do readln(fin, A[i]);
      writeln(fout, 'n = ', n:2);
      writeln(fout, '�������� ������: ');
      for i := 1 to n do writeln(fout,'A[',i,'] = ',A[i]:5:1);
      for i := 1 to n do
        B[i]:=A[i];

      for i:=1 to n-1 do
      begin
        MIN := B[i];
        k := i;
        for j:=i+1 to N do
        if abs(B[j])<abs(MIN) then
        begin
          MIN := (B[j]);
          k := j;
        end;
        B[k] := B[i];
        B[i] := min;
        writeln(fout, '������������� ������: ');
        for l := 1 to n do writeln(fout,'B[',l,'] = ',B[l]:5:1);
      end;

      writeln(fout, '������������ ������: ');
      for i := 1 to n do writeln(fout,'B[',i,'] = ',B[i]:5:1);
    end;
    CloseFile(fin);
    CloseFile(fout);
    writeln('Press ENTER...');
    readln;
end.
