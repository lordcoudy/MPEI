program Lab11;

{$APPTYPE CONSOLE}

uses
  windows;

Type Matr = array [1..10, 1..10] of real;
Type Mass = array [1..20] of byte;

Procedure Solve( nS: byte; var SB: Matr; var SC: Mass; var finS: Textfile; var foutS: TextFile; var SumS : real);
var Si, Sj : byte;
    Sk : bool;
    Sl : byte;
begin
      Sj := 1;
      Sk := false;
      SumS := 0;
      repeat
        Sl := 0;
        for Si := 1 to nS do
        begin
          SumS := SumS + SB[Si, Sj];
          if SB[Si, Sj] <> 0 then Sl := Sl + 1;
        end;
        if Sl = 0 then
        SC[Sj] := 0
        else
        SC[Sj] := 1;
        inc(Sj);
      until Sj = nS + 1;
end;

Procedure ReadR (nK: byte; var K: Matr; var finK : Textfile);
var iK, jK : byte;
begin
  for iK := 1 to nK do
      begin
        for jK := 1 to nK do
        begin
          read(finK, K[iK, jK]);
        end;
        readln(finK);
      end;
end;

Procedure WriteR(nR: byte; var M: Matr; var CR: Mass; var foutR, finR : Textfile; var sumR: real);
var iR, jR: byte;
begin
  writeln(foutR, '�������� �������: ');
    for iR:=1 to nR do
      begin
        for jR:=1 to nR do write(foutR, M[iR,jR]:5:1,'   ');
        writeln(foutR);
      end;
    writeln(foutR, '���������� ������:');
      for iR := 1 to nR do
        writeln(foutR,'C[',iR,'] = ', CR[iR]);
      writeln(foutR, '����� ���� ��������� ������� sum = ', sumR:5:1);
end;

Procedure FindMin(Sum01 : real; Sum02: real; Sum03 : real; var MinK : byte);
begin
  if (abs(Sum01)<abs(Sum02)) and (abs(Sum01)<abs(Sum03)) then MinK := 1
  else if (abs(Sum01)>abs(Sum02)) and (abs(Sum02)<abs(Sum03)) then MinK := 2
  else if (abs(Sum01)>abs(Sum02)) and (abs(Sum02)>abs(Sum03)) then MinK := 3
  else if (abs(Sum01)<abs(Sum02)) and (abs(Sum01)>abs(Sum03)) then MinK := 3
  else if (abs(Sum01)=abs(Sum02)) and (abs(Sum01)<abs(Sum03)) then MinK := 4
  else if (abs(Sum01)=abs(Sum02)) and (abs(Sum01)>abs(Sum03)) then MinK := 3
  else if (abs(Sum01)>abs(Sum02)) and (abs(Sum02)=abs(Sum03)) then MinK := 5
  else if (abs(Sum01)<abs(Sum02)) and (abs(Sum01)=abs(Sum03)) then MinK := 6
  else MinK := 0;
end;

var
  n1, n2, n3, i, j, Min: byte;
  Sum1, Sum2, Sum3 : real;
  A, B, C : Matr;
  C1, C2, C3 : Mass;
  fin, fout: TextFile;
begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  if ParamCount<2 then begin writeln('CritError: �� ������ ��������� ���������'); readln; exit end;
  AssignFile(fin, ParamStr(1));
  AssignFile(fout, ParamStr(2));
  Reset(fin);
  Rewrite(fout);
  writeln(fout, 'Lab.11':40);
  readln(fin, n1, n2, n3);
  if (n1<2) or (n2<2) or (n3<2) then writeln(fout,'������� n ������ 2')
  else if (n1>20) or (n2>20) or (n3>20) then writeln(fout, '������� n ������ 20')
  else
  begin
    ReadR(n1, A, fin);
    ReadR(n2, B, fin);
    ReadR(n3, C, fin);

    writeln(fout, 'n = ', n1:2);
    Solve(n1, A, C1, fin, fout, sum1);
    WriteR(n1, A, C1, fout, fin, sum1);

    writeln(fout, 'n = ', n2:2);
    Solve(n2, B, C2, fin, fout, sum2);
    WriteR(n2, B, C2, fout, fin, sum2);

    writeln(fout, 'n = ', n3:2);
    Solve(n3, C, C3, fin, fout, sum3);
    WriteR(n3, C, C3, fout, fin, sum3);

    FindMin(Sum1, Sum2, Sum3, Min);

    case Min of
    0: writeln(fout, '����� �� ���� �������� �����');
    1: writeln(fout, '���������� �� ���������� �������� ����� ���� ��������� ��������� � ������� �');
    2: writeln(fout, '���������� �� ���������� �������� ����� ���� ��������� ��������� � ������� B');
    3: writeln(fout, '���������� �� ���������� �������� ����� ���� ��������� ��������� � ������� C');
    4: writeln(fout, '���������� �� ���������� �������� ����� ���� ��������� ��������� � �������� � � �');
    5: writeln(fout, '���������� �� ���������� �������� ����� ���� ��������� ��������� � �������� � � C');
    6: writeln(fout, '���������� �� ���������� �������� ����� ���� ��������� ��������� � �������� � � C');
    end;
  end;
  CloseFile(fin);
  CloseFile(fout);
  writeln('Press ENTER...');
  readln;
end.
