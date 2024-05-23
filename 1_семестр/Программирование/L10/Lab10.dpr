program Lab10;

{$APPTYPE CONSOLE}

uses
  windows;

Type Mass = array [1..20] of Integer;

Procedure RW( n: byte; var A: Mass; var fin: Textfile; var fout: TextFile; var B : Integer);
var i : byte;
begin
  for i := 1 to n do
    readln(fin, A[i]);
    readln(fin, B);
  writeln(fout, 'n = ', n:2);
  writeln(fout, 'B = ', B);
  for i := 1 to n do
    writeln(fout, 'A[',i,'] = ', A[i]);
end;

Procedure More1 ( n : byte; var A : Mass; var k : byte; var B : Integer);
var i : byte;
    F : bool;
begin
  i := 1;
  F := False;
  while (i <= n) and (F = false) do
  begin
  if A[i]>B then
      begin
        k := i;
        F := True;
      end;
   inc(i);
  end;
end;

Procedure More2 ( n : byte; var A : Mass; var k2 : byte);
var i : byte;
    F : bool;
begin
  F := False;
  i := n;
  k2 := n;
  while (i >= 1) and (F = false) do
  begin
  if A[i]>A[1] then
      begin
        k2 := i;
        F := True;
      end;
   dec(i);
  end;
end;

Procedure FindMin ( n : byte; var A : Mass; var k : byte; var k2 : byte; var Min : Integer);
var i : byte;
begin
  Min := A[k];
  for i := k to k2 do
  begin
  if A[i]<Min then
      begin
        Min:=A[i];
      end;
  end;
end;

var
  n, i, k, k2 : Byte;
  B, Min :Integer;
  A : Mass;
  fin, fout: TextFile;
begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  if ParamCount<2 then begin writeln('CritError: Не заданы параметры программы'); readln; exit end;
  AssignFile(fin, ParamStr(1));
  AssignFile(fout, ParamStr(2));
  Reset(fin);
  Rewrite(fout);
  writeln(fout, 'Lab.10':40);
  readln(fin, n);
  if (n<2) then writeln(fout,'Введено n меньше 2')
  else if (n>20) then writeln(fout, 'Введено n больше 20')
  else
  begin
    RW(n, A, fin, fout, B);
    More1(n, A, k, B);
    More2(n, A, k2);
    if k <> 0 then
    begin
    FindMin(n, A, k, k2, Min);
    writeln(fout,'Минимальный элемент, удовлетворяющий условию: ', Min);
    end
    else
    writeln(fout,'Нет элемента, большего В');
  end;
  CloseFile(fin);
  CloseFile(fout);
  writeln('Press ENTER...');
  readln;
end.
