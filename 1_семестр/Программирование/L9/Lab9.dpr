program Lab9;

{$APPTYPE CONSOLE}


uses
  windows;

var
  n, m, i, j, k: byte;
  F1, F2 : bool;
  Err : byte;
  B : array [1..10, 1..10] of real;
  fin, fout: TextFile;

begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  if ParamCount<2 then begin writeln('CritError: �� ������ ��������� ���������'); readln; exit end;
    Err := 0;
    AssignFile(fin, ParamStr(1));
    AssignFile(fout, ParamStr(2));
    try
      Reset(fin);
      try
        try
          Rewrite(fout);
          try
            try
              readln(fin, n, m);
              if (n<1) then writeln(fout,'������� n ������ 1')
              else if n>10 then writeln(fout,'������� n ������ 10')
              else if m>10 then writeln(fout,'������� m ������ 10')
              else if (m<1) then writeln(fout,'������� m ������ 1')
              else
              begin
//              ����
                for i := 1 to n do
                begin
                  for j := 1 to m do
                  read(fin, B[i, j]);
                  readln(fin);
                end;

//              �����
                writeln(fout, 'Lab.9' :40);
                writeln(fout, 'n = ', n:2);
                writeln(fout, 'm = ', m:2);
                writeln(fout, '�������� �������: ');
                for i:=1 to n do
                begin
                  for j:=1 to m do
                  write(fout, B[i,j]:5:1,'   ');
                  writeln(fout);
                end;

//              ������
                i := n;
                k := 0;
                F1 := false;
                while (i >= 1) and (F1 = false) do
                begin
                  F2 := true;
                  j := 1;
                  while (F2=True) and (j <= m-1) do
                  begin
                    if B[i, j] > B[i, j + 1] then
                      j := j + 1
                    else
                      F2 := false;
                  end;
                  if F2 = true then
                  begin
                    k := i;
                    F1 := true;
                  end;
                  dec(i);
                end;
//              �����
                if k = 0 then
                  writeln(fout, '��� ����� ������!')
                else
                  writeln(fout, '����� ���������� ������ = ', k:2);
              end;
            except
              Err:=3;
            end;
          finally CloseFile(fout);
          end;
        Except
          Err:=2;
        End;
      finally
        CloseFile(fin);
      end;
    Except
       Err := 1;
    End;

    case Err of
    0: writeln('Success');
    1: Writeln('������ �������� ����� fin.txt ', paramstr(1));
    2: Writeln('������ ��������/�������� ����� fout.txt', paramstr(2));
    3: Writeln('������ ��� ���������� ��� ������ � ����');
    end;
    writeln('Press Enter');
    readln
end.
