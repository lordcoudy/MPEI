program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  windows;

begin
  setConsoleCP(1251); // ��� ����� 
  setConsoleOutputCP(1251); // ��� ������ 

  writeln(ord('�'));
  readln;
end.
