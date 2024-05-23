unit UnVar;

interface

uses UnList;  // описание типа и все процедуры
var NachaloSpiska, KonecSpiska: PElem; // начало и конец списка

implementation
  // пусто

initialization
  NachaloSpiska:=nil;  // инициализация переменных
  KonecSpiska:=nil;
finalization
  FreeList(NachaloSpiska, KonecSpiska);  // освобождение памяти
end.

