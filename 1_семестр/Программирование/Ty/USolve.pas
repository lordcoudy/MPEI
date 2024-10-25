Unit USolve;

Interface

  Type Mass = array [1..20] of real;
  Type MassX = array [1..40] of real;
  Procedure RW( nR: byte; var AR: Mass; var finR, foutR : Textfile);
  Function Max(nM: byte; AM: Mass) : real;
  Function Min(nMi: byte; AMi: Mass) : real;
  Procedure Put(nP: byte; CP : Mass; PP : Mass; var AP: MassX; var foutP : Textfile);

Implementation

Procedure RW( nR: byte; var AR: Mass; var finR, foutR : Textfile);
var iR : byte;
begin
  for iR := 1 to nR do
    readln(finR, AR[iR]);
    writeln(foutR, 'n = ', nR:2);
  for iR := 1 to nR do
    write(foutR, '[',iR,'] = ', AR[iR]:5:1, '   ');
    writeln(foutR);
end;

Function Max;
var iM : byte;
    Ma : real;
begin
	Ma := AM[1];
  	for iM := 1 to nM do
  	begin
  	if AM[iM]>Ma then
      begin
        Ma:=AM[iM];
      end;
  	end;
    Max := Ma;
end;

Function Min;
var iMi : byte;
    Mi : real;
begin
	Mi := AMi[1];
  	for iMi := 1 to nMi do
  	begin
  	if AMi[iMi]<Mi then
      begin
        Mi:=AMi[iMi];
      end;
  	end;
    Min := Mi;
end;

Procedure Put(nP: byte; CP : Mass; PP : Mass; var AP: MassX; var foutP : Textfile);
var iP, k : byte;
begin
  for iP := 1 to (nP)do
    AP[iP] := CP[iP];
  for iP := (nP + 1) to 2*nP do
    AP[iP] := PP[(iP - nP)];
    writeln(foutP, '2n = ', 2*nP:2);
  for iP := 1 to 2*nP do
    write(foutP, '[',iP,'] = ', AP[iP]:5:1, '   ');
    writeln(foutP);
end;

end.
