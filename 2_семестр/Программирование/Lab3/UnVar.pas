unit UnVar;

interface

uses UnList;  // �������� ���� � ��� ���������
var NachaloSpiska, KonecSpiska: PElem; // ������ � ����� ������

implementation
  // �����

initialization
  NachaloSpiska:=nil;  // ������������� ����������
  KonecSpiska:=nil;
finalization
  FreeList(NachaloSpiska, KonecSpiska);  // ������������ ������
end.

