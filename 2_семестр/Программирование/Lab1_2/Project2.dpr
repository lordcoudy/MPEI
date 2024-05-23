program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  windows;

begin
  setConsoleCP(1251); // для ввода 
  setConsoleOutputCP(1251); // для вывода 

  writeln(ord('Ё'));
  readln;
end.
