unit UnLAB1;
Interface       // раздел описани€ межмодульного интерфейса

Uses     
  SysUtils;   

Const
  SymbTable = ' abcdefghijklmnopqrstuvwxyzјЅ¬√ƒ≈®∆«»… ЋћЌќѕ–—“”‘’÷„ЎўЏџ№Ёёя';

Const
  Spc : set of char = [' '];
  WKir1: set of char = ['ј'.. '≈'];
  WKir2: set of char = ['®'];
  WKir3: set of char = ['∆'..'я'];
  WLat: set of char = ['a'.. 'z'];

Function Chck1(const s: ANSIString): Byte; // проверка без SymbTable
Function Chck2(const s: ANSIString): Byte; // проверка с SymbTable
Procedure Srt1(var s: ANSIString);  // сортировка без SymbTable
Procedure Srt2(var s: ANSIString);  // сортировка с SymbTable

Implementation  // раздел реализации и описани€ закрытых процедур

Function Chck1; // проверка без SymbTable
Var
  Nom: byte; // номер аномалии
  i,Len: word; // текущий символ и длина строки
Begin
  Nom:=0; len:= Length(S);
  If Len=0 then Nom:=1
  Else
    Begin
      i:=1;
      while (i<=Len) and (Nom=0) do
      begin
        if Not ((S[i] in Spc) or (S[i] in WKir1) or (S[i] in WKir2) or (S[i] in WKir3) or (S[i] in WLat)) then Nom:=2;
        Inc(i);
      end;
    End;
  Chck1:=Nom;
End;

Function Chck2; // проверка с SymbTable
Var
  Nom: byte; // номер аномалии
  i,Len: word; // текущий символ и длина строки
Begin
  Nom:=0; len:= Length(S);
  If Len=0 then Nom:=1
  Else
    Begin
      i:=1;
      while (i<=Len) and (Nom=0) do
      begin
        if Not (Pos(S[i], SymbTable)>0) then Nom:=2;
        Inc(i);
      end;
    End;
  Chck2:=Nom;
End;

Procedure Srt1;  // сортировка без SymbTable
Var 
  i, z, len: Word; // номер текущего символа, номер итерации (шага), длина строки
  flag: Boolean; // упор€дочено? (нет обменов?)
  ch: char; // дл€ обмена
Begin
  Z:=1;  len:=length(s);
  Repeat // пузырЄк
    flag:=true;
    for i:=1 to len-z do
      if ((s[i] in WKir1) or (s[i] in WKir2) or (s[i] in WKir3)) and ((s[i+1] in WLat) or (s[i+1] in Spc)) or
         (s[i] in WLat) and (s[i+1] in Spc) or
         (s[i] in WKir1) and (s[i+1] in WKir1) and (s[i]>s[i+1]) or
         (s[i] in WKir3) and (s[i+1] in WKir3) and (s[i]>s[i+1]) or
         (s[i] in WKir2) and (s[i+1] in WKir1) or
         (s[i] in WKir3) and (s[i+1] in WKir1) or
         (s[i] in WKir3) and (s[i+1] in WKir2)

      then
      begin // обмен
        ch:=s[i]; s[i]:=s[i+1]; s[i+1]:=ch; flag:= false;
      end;
    inc(z);
  Until flag or (z=len);
End; 

Procedure Srt2;  // сортировка с SymbTable
Var 
  i, z, len: Word; // номер текущего символа, номер итерации (шага), длина строки
  flag: Boolean; // упор€дочено? (нет обменов?)
  ch: char; // дл€ обмена
Begin
  z:=1;  len:=length(s);
  Repeat // пузырЄк
    flag:=true;
    for i:=1 to len-z do
      if (Pos(s[i], SymbTable) > Pos(s[i+1], SymbTable))  // неправильный пор€док по своей Ђтаблицеї
        and not ((s[i] in WLat) and (s[i+1] in WLat)) // но латиницу не упор€дочивать
      then
      begin // обмен
        ch:=s[i]; s[i]:=s[i+1]; s[i+1]:=ch; flag:= false;
      end;
    inc(z);
  Until flag or (z=len);
End; 

end.

