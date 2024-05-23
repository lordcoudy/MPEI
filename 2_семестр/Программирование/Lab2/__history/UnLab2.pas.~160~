unit UnLab2;

interface
uses sysUtils;

Type

TSubject = (Physics = 1, Maths, English, Programming);
TMark = (Bad = 2, Okay, Good, Great);
TGroup = record
Name: string[10]; // Только статические строки можно сохранить в файл
Subject : TSubject;
Mark : TMark;
Number : integer;
end;

//----------первая часть: создание типизированного файла в диалоге
Procedure CreateTypedFile1();

//----------вторая часть: создание типизированного файла из текстового
Procedure CreateTypedFile2();

//-------------- третья часть: поиск в типизированном файле ----
Procedure FindAndChange();

//-------------- просмотр типизированного файла ----
Procedure ViewFile();

Implementation // -----------реализационная часть-----------------

//----------первая часть: создание типизированного файла в диалоге

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
writeln('Мало параметров '#13#10'Press enter');
readln;exit
end;
FileName := ParamStr(1);
AssignFile(fg, FileName);
Try ReWrite(fg);
Except
writeln('Error: не удалось создать типизированный файл ',FileName);
write('Press ENTER'); readln;exit
end;
kol:=0;
repeat
write('Группа =?'); readln(Group.Name);
write('Предмет(1 - Физика, 2 - Математика, 3 - Английский, 4- Программирование) =?'); readln(n); Group.Subject:=TSubject(n);
write('Оценка(2 - неуд, 3 - уд, 4 - хор, 5 - отл): '); readln(m); Group.Mark:=TMark(m);
write(fg, Group); // запись записи целиком в файл
inc(kol);
write('Ещё? (y/n)');
readln(ch)
until UpCase(ch)='N';
writeln('Введите группу, которую хотите проверить');
readln(Name);
writeln('предмет(1 - Физика, 2 - Математика, 3 - Английский, 4- Программирование)');
readln(n);
writeln('и оценку(2 - неуд, 3 - уд, 4 - хор, 5 - отл) = ');
readln(m);
seek(fg, 0);
repeat
if (Group.Name = Name) and (ord(Group.Subject) = n) and (ord(group.Mark) = m) then
Group.Number := Group.Number + 1;
inc(i);
until (i>Filesize(fg));
CloseFile(fg);
writeln('Создан типизированный файл из ',kol,' записей');
write('Press ENTER');
readln;
end;
//---------------------------------------------------------------------------------------
//----------вторая часть: создание типизированного файла из текстового
Procedure CreateTypedFile2();
var
Group: TGroup;
ft: TextFile; // текстовый файл
fg: file of TGroup; // типизированный файл - файл записей
n, m, kol, c: integer;
i, l : byte;
ch: char;
FileName, FileNameF, Name:string[80];
begin
if ParamCount<2 then
begin
writeln('Мало параметров '#13#10'Press enter');
readln;exit
end;
FileNameF := Paramstr(1);
FileName:= Paramstr(2);
 AssignFile(ft, FileName);
Try Reset(ft);
Except
writeln('Error: не удалось открыть текстовый файл ', FileName);
write('Press ENTER'); readln;exit
end;
 AssignFile(fg, FileNameF);
Try ReWrite(fg);
Except
writeln('Error: не удалось создать типизированный файл ',FileNameF);
write('Press ENTER'); readln;exit
end;
kol:=0;
repeat
readln(ft, Group.Name);
readln(ft, n); Group.Subject:=TSubject(n);
readln(ft, m); Group.Mark:=TMark(m);
Group.Number := 0;
write(fg, Group); // запись записи целиком в файл
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
writeln('Создан типизированный файл из ',kol,' записей');
CloseFile(ft);
write('Press ENTER');
readln;
end;
////--------------------------------------------------------------------------------------------------------------------------------
////-------------- третья часть: поиск в типизированном файле ----
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
writeln('Мало параметров '#13#10'Press enter');
readln;exit
end;
FileName := ParamStr(1);
AssignFile(fg, FileName);
Try ReSet(fg);
Except
writeln('Error: не удалось открыть типизированный файл ',FileName);
write('Press ENTER'); readln;exit
end;


writeln('Введите предмет(1 - Физика, 2 - Математика, 3 - Английский, 4 - Программирование)');
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

writeln('Найдена группа ', Found,' с минимальным числом двоек за предмет ', min);
 //Изменение


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
1: Subj := 'Физика';
2: Subj := 'Математика';
3: Subj := 'Английский';
4: Subj := 'Программирование';
 end;

 case Ord(Group.Mark) of
2: Mar := 'Неуд.';
3: Mar := 'Удов.';
4: Mar := 'Хор.';
5: Mar := 'Отл.';
 end;
writeln('Найдена запись о группе ', Group.Name,' ',
' предмет ', Subj,
' оценка ', Mar);


if j = Filesize(fg) then write ('Запись уже на последнем месте') else
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
//-------------- просмотр типизированного файла ----
Procedure ViewFile();
var
Group: TGroup;
fg: file of TGroup;
n, m, kol, st: integer;
FileName, Sub, Mar, Gr:string[80];
begin
if ParamCount<1 then
begin
writeln('Мало параметров '#13#10'Press enter');
readln;exit
end;
FileName := ParamStr(1);
AssignFile(fg, FileName);
Try ReSet(fg);
Except
writeln('Error: не удалось открыть типизированный файл ',FileName);
write('Press ENTER'); readln;exit
end;
kol:=0;

while not eof(fg) do
begin
read(fg, Group);


 case Ord(Group.Subject) of
1: Sub := 'Физика';
2: Sub := 'Математика';
3: Sub := 'Английский';
4: Sub := 'Программирование';
 end;

 case Ord(Group.Mark) of
2: Mar := 'Неуд.';
3: Mar := 'Удов.';
4: Mar := 'Хор.';
5: Mar := 'Отл.';
 end;
writeln('Найдена группа ', Group.Name,' ',
' предмет ', Sub,
' оценка ', Mar);
inc(kol);
end;
if kol=0 then
writeln('Данные не найдены')
else
writeln('Найдено ',kol, ' записей', #13#10'Также, студентов по запросу найдено ', Group.Number);
CloseFile(fg);
write('Press ENTER');readln;
end;
end.
