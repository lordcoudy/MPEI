program Lab4;

{$APPTYPE CONSOLE}
uses windows;

var
n, i, M1, M2 : Integer;
C1, C2 : Integer;
Q : array [1..20] of Integer;
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
    C1 := 0;
    C2 := 0;
    M1 := 0;
    M2 := 0;
    writeln(fout, 'Lab.4' :40);
    readln(fin, n);
    if (n<1) then writeln(fout,'������� n ������ 1')
    else if n>20 then writeln(fout,'������� n ������ 20')
    else
    begin

      for i := 1 to n do
        readln(fin, Q[i]);

      writeln(fout,'n = ', n:2);
      for i := 1 to n do
        begin
          writeln(fout, 'Q[ ',i,' ] = ', Q[i]:4);
        end;

      for i := 1 to n do
      begin
        if Q[i] > 0 then
                begin
                  C2 := C2 + Q[i];
                  M2 := M2 + 1;
                end
                else if Q[i] < 0 then
                begin
                  C1 := C1 + Q[i];
                  M1 := M1 + 1;
                end;
      end;
      if (M1 = 0) and (M2 = 0) then
              writeln(fout,'M1 = ',M1:2,' M2 = ',M2:2,' ��� ��� M1 � M2 ����� 0, �� ���������� ����� C1 � C2')
              else if M2 = 0 then
              writeln(fout,'M1 = ',M1:2,' ��� ��� �1 ����� 0, �� ���������� ����� �1 ','M2 = ',M2:2,', C2 = ',C2:5)
              else if M1 = 0 then
              writeln(fout,'M1 = ',M1:2,', C1 = ',C1:5,' M2 = ',M2:2,' ��� ��� �2 ����� 0, �� ���������� ����� �2 ')
              else
              writeln(fout,'M1 = ',M1:2,', C1 = ',C1:5,' M2 = ',M2:2,', C2 = ',C2:5);
    end;
    CloseFile(fin);
    CloseFile(fout);
    writeln('Press ENTER...');
    readln;
end.

