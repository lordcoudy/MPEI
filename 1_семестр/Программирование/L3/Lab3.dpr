program Lab3;

{$APPTYPE CONSOLE}
uses windows;

var
n, i, M1, M2 : Integer;
C1, C2 : Integer;
Fl : Boolean;
Q : array [1..20] of Integer;
//Variant �2

begin
    SetConsoleCP(1251);
    SetConsoleOutputCP(1251);
    C1 := 0;
    C2 := 0;
    M1 := 0;
    M2 := 0;
    writeln('������� n');
    readln(n);
    Fl := True;
    if (n<1) then writeln('������� n ������ 1')
    else if n>20 then writeln('������� n ������ 20')
    else
    begin
      writeln('������� ������');
      i:=1;
      repeat
          write('Q[ ',i,' ] = ');
          readln(Q[i]);
          i := i + 1;
      until i = n + 1;

      writeln('n = ',n);
      for i := 1 to n do
        begin
          writeln('Q[ ',i,' ] = ',Q[i]:4);
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
              writeln('M1 = ',M1:2,' M2 = ',M2:2,' ��� ��� M1 � M2 ����� 0, �� ���������� ����� C1 � C2')
              else if M2 = 0 then
              writeln('M1 = ',M1:2,' ��� ��� �1 ����� 0, �� ���������� ����� �1 ','M2 = ',M2:2,', C2 = ',C2:5)
              else if M1 = 0 then
              writeln('M1 = ',M1:2,', C1 = ',C1:5,' M2 = ',M2:2,' ��� ��� �2 ����� 0, �� ���������� ����� �2 ')
              else
              writeln('M1 = ',M1:2,', C1 = ',C1:5,' M2 = ',M2:2,', C2 = ',C2:5);
    end;
    writeln('Press ENTER...');
    readln;
end.
