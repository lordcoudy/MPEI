Program Lab1;
{$AppType CONSOLE}

uses
  Windows,
  UnLAB1 in 'UnLAB1.pas';

Var 
	S, S1, S2: ANSIString;
	Nom: Byte;
Begin

 // ������ ������� ��������  ��� ����������� ����� � ������
  setConsoleCP(1251); // ��� ����� 
  setConsoleOutputCP(1251); // ��� ������ 

  Writeln('������� ������ (������� ����� �� Lucida Console)');
  readln(S); // ���� 

 S1:=Copy(S, 1, Length(S)); S2:=Copy(S, 1, Length(S)); // �������� ����� ���.������ 

  // ��� ����� ������� �������� (�� ������� �������� ������)
  Writeln(#13#10, '������ �� ����������'#13#10, S1);
  Nom:= Chck1(s1); // ��������
  Case Nom of
    1: writeln('������ ������');
    2: writeln('������������ �������');
    else
     begin // ����������
       Srt1(s1);
       Writeln('��������������� ������ 1'#13#10,'"', S1, '"');  // ����� ������ S1
     end; {else}
  End; {case}
  
  // �� ����� �������� ��������
  Writeln(#13#10'������ �� ����������'#13#10, S2);
  Nom:= Chck2(s2); // ��������
  Case Nom of
    1: writeln('������ ������');
    2: writeln('������������ �������');
    else
     begin // ����������
       Srt2(s2);
       Writeln('��������������� ������ 2'#13#10,'"', S2, '"');  // ����� ������ S2
     end; {else}
  End; {case}

  writeln(#13#10'Press ENTER to exit');
  readln
End.

