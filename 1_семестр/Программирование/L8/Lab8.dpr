program Lab8;

{$APPTYPE CONSOLE}

uses
  windows;

  //Variant �2

var
  n, i, j: byte;
  Sum : real;
  k : bool;
  B : array [1..20, 1..20] of real;
  C : array [1..20] of byte;
  fin, fout: TextFile;
begin
   SetConsoleCP(1251);
    SetConsoleOutputCP(1251);
    if ParamCount<2 then begin writeln('CritError: �� ������ ��������� ���������'); readln; exit end;
    AssignFile(fin, ParamStr(1));
    AssignFile(fout, ParamStr(2));
	  Reset(fin);
 	  Rewrite(fout);
    writeln(fout, 'Lab.8' :40);
    readln(fin, n);
    if (n<1) then writeln(fout,'������� n ������ 1')
    else if n>20 then writeln(fout,'������� n ������ 20')
    else
    begin
      for i := 1 to n do
      begin
        for j := 1 to n do
        begin
          read(fin, B[i, j]);
        end;
        readln(fin);
      end;
      writeln(fout, 'n = ', n:2);
      writeln(fout, '�������� �������: ');
      for i:=1 to n do
      begin
        for j:=1 to n do write(fout, B[i,j]:5:1,'   ');
        writeln(fout);
      end;
      j := 1;
      k := false;
      sum := 0;
      repeat
        for i := 1 to n do
        begin
          sum := sum + B[i, j];
          if B[i, j] <> 0 then k := true;
        end;
        if k then
        C[j] := 1
        else
        C[j] := 0;

        inc(j);
      until j = n + 1;
      writeln(fout, '���������� ������:');
      for i := 1 to n do
        writeln(fout,'C[',i,'] = ', C[i]);
      writeln(fout, '����� ���� ��������� ������� sum = ', sum:5:1);
    end;
    CloseFile(fin);
    CloseFile(fout);
    writeln('Press ENTER...');
    readln;
end.
