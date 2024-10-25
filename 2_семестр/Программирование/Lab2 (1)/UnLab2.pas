unit UnLab2;

interface
uses sysUtils;

Type

TSubject = (Physics = 1, Maths, English, Programming);
TMark = (Bad = 2, Okay, Good, Great);
TGroup = record
Name: string[10]; // ������ ����������� ������ ����� ��������� � ����
Subject : TSubject;
Mark : TMark;
Number : integer;
end;

//----------������ �����: �������� ��������������� ����� � �������
Procedure CreateTypedFile1();

//----------������ �����: �������� ��������������� ����� �� ����������
Procedure CreateTypedFile2();

//-------------- ������ �����: ����� � �������������� ����� ----
Procedure FindAndChange();

//-------------- �������� ��������������� ����� ----
Procedure ViewFile();

Implementation // -----------�������������� �����-----------------

//----------������ �����: �������� ��������������� ����� � �������

Procedure CreateTypedFile1();
var Group : TGroup;
fg : file of TGroup;
n, m, kol: integer;
i, l : byte;
ch: char;
FileName, Name:string[80];
begin
if ParamCount<1 then
begin
writeln('���� ���������� '#13#10'Press enter');
readln;exit
end;
FileName := ParamStr(1);
AssignFile(fg, FileName);
Try ReWrite(fg);
Except
writeln('Error: �� ������� ������� �������������� ���� ',FileName);
write('Press ENTER'); readln;exit
end;
kol:=0;
repeat
write('������ =?'); readln(Group.Name);
write('�������(1 - ������, 2 - ����������, 3 - ����������, 4- ����������������) =?'); readln(n); Group.Subject:=TSubject(n);
write('������(2 - ����, 3 - ��, 4 - ���, 5 - ���): '); readln(m); Group.Mark:=TMark(m);
write(fg, Group); // ������ ������ ������� � ����
inc(kol);
write('���? (y/n)');
readln(ch)
until UpCase(ch)='N';
writeln('������� ������, ������� ������ ���������');
readln(Name);
writeln('�������(1 - ������, 2 - ����������, 3 - ����������, 4- ����������������)');
readln(n);
writeln('� ������(2 - ����, 3 - ��, 4 - ���, 5 - ���) = ');
readln(m);
seek(fg, 0);
repeat
if (Group.Name = Name) and (ord(Group.Subject) = n) and (ord(group.Mark) = m) then
Group.Number := Group.Number + 1;
inc(i);
until (i>Filesize(fg));
CloseFile(fg);
writeln('������ �������������� ���� �� ',kol,' �������');
write('Press ENTER');
readln;
end;
//---------------------------------------------------------------------------------------
//----------������ �����: �������� ��������������� ����� �� ����������
Procedure CreateTypedFile2();
var
Group: TGroup;
ft: TextFile; // ��������� ����
fg: file of TGroup; // �������������� ���� - ���� �������
n, m, kol, c: integer;
i, l : byte;
ch: char;
FileName, FileNameF, Name:string[80];
begin
if ParamCount<2 then
begin
writeln('���� ���������� '#13#10'Press enter');
readln;exit
end;
FileNameF := Paramstr(1);
FileName:= Paramstr(2);
 AssignFile(ft, FileName);
Try Reset(ft);
Except
writeln('Error: �� ������� ������� ��������� ���� ', FileName);
write('Press ENTER'); readln;exit
end;
 AssignFile(fg, FileNameF);
Try ReWrite(fg);
Except
writeln('Error: �� ������� ������� �������������� ���� ',FileNameF);
write('Press ENTER'); readln;exit
end;
kol:=0;
repeat
readln(ft, Group.Name);
readln(ft, n); Group.Subject:=TSubject(n);
readln(ft, m); Group.Mark:=TMark(m);
Group.Number := 0;
write(fg, Group); // ������ ������ ������� � ����
inc(kol);
readln(ft, ch)
until UpCase(ch)='N';
readln(ft, Name);
readln(ft, n);
readln(ft, m);
seek(fg, 0);
i := 0;
c := 0;
repeat
read(fg, group);
if (Group.Name = Name) and (ord(Group.Subject) = n) and (ord(group.Mark) = m) then
begin
Inc(c);
end;
inc(i);
until (i>=Filesize(fg));
Seek(fg, Filesize(fg) - 1);
Read(fg, group);
group.Number := c;
Seek(fg, Filesize(fg) - 1);
Write(fg, group);
CloseFile(fg);
writeln('������ �������������� ���� �� ',kol,' �������');
CloseFile(ft);
write('Press ENTER');
readln;
end;
////--------------------------------------------------------------------------------------------------------------------------------
////-------------- ������ �����: ����� � �������������� ����� ----
Procedure FindAndChange();
var
Group, GroupTMP : TGroup;
fg : file of TGroup;
FileName, Name, Found, subj, mar : string[80];
tick : boolean;
ch : char;
min, i, sub, j, count, n, r : integer;

begin
if ParamCount<1 then
begin
writeln('���� ���������� '#13#10'Press enter');
readln;exit
end;
FileName := ParamStr(1);
AssignFile(fg, FileName);
Try ReSet(fg);
Except
writeln('Error: �� ������� ������� �������������� ���� ',FileName);
write('Press ENTER'); readln;exit
end;


writeln('������� �������(1 - ������, 2 - ����������, 3 - ����������, 4 - ����������������)');
readln(sub);

min := Filesize(fg);
i := 0;

While i < Filesize(fg) do
begin
Seek(fg, i);
Read(fg, Group);
Seek(fg, 0);
count := 0;
While not EOF(fg) do
begin
Read(fg, GroupTMP);
if (Group.Name = GroupTMP.Name) and (GroupTMP.Mark = Bad) and (ord(GroupTMP.Subject) = sub) then Inc(count);
end;
if count < min then begin min := count; Found := Group.Name; end;
Inc(i);
end;

writeln('������� ������ ', Found,' � ����������� ������ ����� �� ������� ', min);
 //���������


tick := false;
Seek(fg, 0);
While not EOF(fg) or not(tick) do
begin
Read(fg, Group);
if (Group.Name = Found) then begin
tick := true; break;
end;
end;
j:=FilePos(fg)-1;
seek(fg, j);
read(fg, Group);
 case Ord(Group.Subject) of
1: Subj := '������';
2: Subj := '����������';
3: Subj := '����������';
4: Subj := '����������������';
 end;

 case Ord(Group.Mark) of
2: Mar := '����.';
3: Mar := '����.';
4: Mar := '���.';
5: Mar := '���.';
 end;
writeln('������� ������ � ������ ', Group.Name,' ',
' ������� ', Subj,
' ������ ', Mar);


if j = Filesize(fg) then write ('������ ��� �� ��������� �����') else
begin
Seek(fg, Filesize(fg) - 1);
Read(fg, Group);
Seek(fg, j);
Read(fg, GroupTMP);
Seek(fg, FilePos(fg) - 1);
Write(fg, Group);
Seek(fg, Filesize(fg) - 1);
Write(fg, GroupTMP);
Writeln('Replaced (', j, ' and last)');
end;

CloseFile(fg);

write('Press ENTER');readln;
end;
//----------------------------------------------------------------------------------------------------------------------------------
//-------------- �������� ��������������� ����� ----
Procedure ViewFile();
var
Group: TGroup;
fg: file of TGroup;
n, m, kol, st: integer;
FileName, Sub, Mar, Gr:string[80];
begin
if ParamCount<1 then
begin
writeln('���� ���������� '#13#10'Press enter');
readln;exit
end;
FileName := ParamStr(1);
AssignFile(fg, FileName);
Try ReSet(fg);
Except
writeln('Error: �� ������� ������� �������������� ���� ',FileName);
write('Press ENTER'); readln;exit
end;
kol:=0;

while not eof(fg) do
begin
read(fg, Group);


 case Ord(Group.Subject) of
1: Sub := '������';
2: Sub := '����������';
3: Sub := '����������';
4: Sub := '����������������';
 end;

 case Ord(Group.Mark) of
2: Mar := '����.';
3: Mar := '����.';
4: Mar := '���.';
5: Mar := '���.';
 end;
writeln('������� ������ ', Group.Name,' ',
' ������� ', Sub,
' ������ ', Mar);
inc(kol);
end;
if kol=0 then
writeln('������ �� �������')
else
writeln('������� ',kol, ' �������', #13#10'�����, ��������� �� ������� ������� ', Group.Number);
CloseFile(fg);
write('Press ENTER');readln;
end;
end.
