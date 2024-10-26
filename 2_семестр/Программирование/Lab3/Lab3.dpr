program Lab3;  // ���� �������� - ��� ���������� �����

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Windows,
  UnList,
  UnVar {/ �������� ������� �� ��������� R � ������������ � �������� �������� � ������};

// �������� ������� �� ��������� R � ������������ � �������� �������� � ������
procedure AddR(var ListN, ListK: PElem; r: TInfo); // ������ ������ � ����� ������ � R
var ListC: PElem;  // ������� ������� ������
begin
  if ListN = nil then CreateList(ListN, ListK, r)  // ���� ������ ����
  else
    if r <= ListN^.info then AddFirst(ListN, ListK, r)  // �������� � ������
    else
       if r >= ListK^.info then AddLast(ListN, ListK, r)  // �������� � �����
       else
         begin // ����� ����� ������
           ListC:=ListN; // � ������ ������
           while ListC^.next^.info <= r do
             ListC := ListC^.next;
           AddMedium(ListN, ListC, ListK, r)  // �������� ����� ��������
         end;
end;

//  "�������� ��������������� N ���������" � ������� ������
procedure AddN;
var n,i: integer; s:string; r: TInfo;
begin
  write('������� N=?'); readln(s);
  if not TryStrToInt(s,n) then n:=1;
  for i:=1 to n do
  begin
    r:= (-199 + Random(599+199+1))/10;
    AddR(NachaloSpiska, KonecSpiska, r);
  end;
end;

// ���������� ���� ������ �� ���������� ����� � ������� ������
procedure AddFromTextFile;
var
  f: TextFile;
  FileName : string;
  r: TInfo;
begin
  if ParamCount<1 then
  begin
    writeln('���� ���������� '#13#10'Press enter');
    readln;
    exit
  end;
  FileName := ParamStr(1);
  AssignFile(f, FileName);
  try
    Reset(f);
    try
      try
          while not eof(f) do
          begin
            readln(f, r);
            AddR(NachaloSpiska, KonecSpiska,r);
          end;
          writeln('������ ������');
      except
       writeln('������������ ������ � ��������� ����� '+ ParamStr(1));
      end;
    finally
      CloseFile(f);
    end;
  except
    writeln('�� ������� ������� ��������� ���� '+ ParamStr(1));
  end;
end;

// �������� ���� �������  � ������� ������
procedure Add1;
var
  r: TInfo;
begin
 try
  write('������� ���.����� R=?'); readln(r);
  AddR(NachaloSpiska, KonecSpiska, r);
 except
    writeln('������������ ����� ��� ������ ����������');
 end;
end;

// "����� � ������"
procedure SearchIt;
var
  ListC: PElem;
  ListTMP: PElem;
  Last : real;
  n: integer;
  tick : boolean;
begin
  ListC:=NachaloSpiska;
  tick := false;
  n := 1;
  while ListC<>nil do
  begin
    if ListC.info <> 0 then
    tick := true;
    ListC:=ListC^.next;
  end;
  ListC:=NachaloSpiska;
  if tick then
  begin
    while ListC<>nil do
    begin
      if ListC.info <> 0 then ListTMP := ListC;         // ����� �������� ������� ������� � ���������� � ��� ListC^.info
      ListC:=ListC^.next;
    end;
    ListC:=NachaloSpiska;
    while ListC <> ListTMP do
    begin
      n := n + 1;
      ListC:=ListC^.next;
    end;
    writeln('����� �������� ����� = ', n);
  end
  else writeln('��� ���������� ��������');

end;

//  "��� ������ � ������?" - ����� �� ����� �������
procedure ViewList;
var
  ListC: PElem;
begin
  writeln('������:');
  ListC:=NachaloSpiska;
  if ListC=nil then writeln('������');
  while ListC<>nil do
  begin
    writeln(ListC^.info:5:1);
    ListC:=ListC^.next;
  end;
  ListC:=KonecSpiska;
  writeln(#10#13'� �������� �������:');
  while ListC<>nil do
  begin
    writeln(ListC^.info:5:1);
    ListC:=ListC^.prev;
  end;
end;

//--------------------������� ���������-------------------------
var
  ch: char;
begin
  SetConsoleCP(1251);      // �� ������ Windows
  SetConsoleOutputCP(1251);

{ ��� ����, ����� ������ ��� ��� ������� ��������� ��������������
  ����� ������������������ ��������������� �����.
  ���� � �� �� ������������������ ������ ��� ������� ���������. }
  Randomize;

  repeat
    writeln('--------------------------------------');
    writeln('Q - �������� � ������ �� ���������� �����; ');
    writeln('W - ������������� � �������� � ������; ');
    writeln('E - �������� � ������; ');
    writeln('R - ����� � ������;');
    writeln('T - �������(��������) ������;');
    writeln('Y - ��������;');
    writeln('U - �����.');
    write('��� �����?'); readln(ch);
    writeln('--------------------------------------');

    ch:= UpCase(ch);
    case ch of
//----------������� ������ �� ���������� �����------------------
    'Q': AddFromTextFile;
//----------������������� ������ -------------------------------
    'W': AddN;
//----------�������� � ������ ----------------------------------
    'E': Add1;
//-----------�����----------------------------------------------
    'R': SearchIt;
//-----------������������ ������--------------------------------
    'T': FreeList(NachaloSpiska, KonecSpiska);
//-----------��������----------------------------------------------
    'Y': ViewList;
//-----------�����----------------------------------------------
    'U': exit;
//--------------------------------------------------------------
      else
        begin
          writeln('��� ����� �������');
          write('Press ENTER'); readln;
        end;
    end;

  until ch='U';
end.

