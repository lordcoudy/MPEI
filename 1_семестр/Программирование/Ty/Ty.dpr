program Ty;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  windows,
  USolve;

var
  n : Byte;
  C, P : Mass;
  X : MassX;
  fin, fout: TextFile;

begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  if ParamCount<2 then begin writeln('CritError: �� ������ ��������� ���������'); readln; exit end;
  AssignFile(fin, ParamStr(1));
  AssignFile(fout, ParamStr(2));
  Reset(fin);
  Rewrite(fout);
  writeln(fout, '������� ������':40);
  readln(fin, n);
  if (n<1) then writeln(fout,'������� n ������ 1')
  else if (n>20) then writeln(fout, '������� n ������ 20')
  else
  begin
    writeln(fout, '������ C:');
    RW(n, C, fin, fout);
    writeln(fout, '������ P:');
    RW(n, P, fin, fout);
    if Max(n, C) < Min(n, P) then
    begin
//      n := 2 * n;
      writeln(fout, '������ X:');
      Put(n, C, P, X, fout);
    end
    else
    writeln(fout, '����. ��-� � �� ������ ���. ��-�� �');
  end;
  CloseFile(fin);
  CloseFile(fout);
  writeln('Press ENTER...');
  readln;
end.


