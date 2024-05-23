program Lab5;

{$APPTYPE CONSOLE}

uses
  Windows;

var
  n,M,S,i,k:Integer;
  A:array[1..20] of Integer;
  fin, fout: TextFile;
  //Variant #2
begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  if ParamCount<2 then begin writeln('CritError: Не заданы параметры программы'); readln; exit end;
  AssignFile(fin, ParamStr(1));
  AssignFile(fout, ParamStr(2));
  Reset(fin);
  Rewrite(fout);
  writeln(fout, 'Lab.5':40);
  readln(fin, n);
  if (n<2) then writeln(fout,'Введено n меньше 2')
  else if (n>20) then writeln(fout, 'Введено n больше 20')
  else
  begin
    for i := 1 to n do readln(fin, A[i]);
    writeln(fout, 'n = ', n:2);
    for i := 1 to n do writeln(fout, 'A[i] = ', A[i]);
    i:=2;
    S:=(A[2]-A[1]);
    M:=abs(S);
    k:=2;
    for i := 2 to n do
      begin
      S:=A[i]-A[i-1];
      if abs(S)>M then
      begin
        M:=abs(S);
        k:=i;
      end;
    end;
    M:=A[k] - A[k-1];
    writeln(fout, 'Максимальная разность равна ', M:4)
  end;
  CloseFile(fin);
  CloseFile(fout);
  writeln('Press ENTER...');
  readln;
end.

