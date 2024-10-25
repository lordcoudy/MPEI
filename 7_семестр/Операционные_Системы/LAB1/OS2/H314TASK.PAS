unit h314task;

interface

  const MaxThread=10;
        maxCritical=10;
  type TCriticalNum=0..maxCritical;

  function RegisterThread( ThreadAddr:pointer;
                          StackSize:word):integer;
  {��������� ����� - ����ᥭ�� � ��।�. �����頥��� ����� �����}

  procedure ExecuteRegisteredThreads(UseTimer:boolean);
  {�믮���� ��ॣ����஢���� �����.
   �����  ॣ���������� ��⨢�묨, �.�. ������ ᯮᮡ�� �������
   �ࠢ�����. �믮������ �४�頥���, ����� �� ����� ����
   �४�饭� � ������� StopThread. UseTimer 㪠�뢠��, ���� ��
   ��४������� ����� �� ⠩���� (�������� ���������筮���) ���
   "���஢��쭮", �.�. ��⥬ �맮�� SwitchThreads ����� ᥡ�}

  procedure StopThread(ThreadNumber:byte);{����頥� ��।��� �ࠢ����� �����}
  procedure RunThread(ThreadNumber:byte); {����蠥� ��।��� �ࠢ����� �����}
  procedure SwitchThreads; {����筮 �⤠�� �ࠢ����� ��ᯥ���� �����}

  procedure EnterCritical(num:TCriticalNum); {���� � ������� ᥪ��}
  procedure LeaveCritical(num:TCriticalNum); {�������� ������� ᥪ��}

  procedure LoopBack; {��᪮���� 横�, �ᯮ������ � ���� �����
                       ����� ������� RET}

  procedure ClearThreads;


implementation

  uses dos;

  type TThreadStateWord=record
       BP_reg, ES_reg, DS_reg, DI_reg, SI_reg, DX_reg,
       CX_reg, BX_reg, AX_reg, IP_reg, CS_reg, Flags:  word;
       Stack:pointer;
       Active:boolean;
     end;

  var TS:array [0..MaxThread-1] of TThreadStateWord;
      Stacks: array [0..MaxThread-1] of record
                sze:word; {ࠧ���� �⥪��}
                ptr:pointer; {㪠��⥫� �� ����, �뤥����� ��� �⥪}
              end;

  const ThreadsRegistered:byte=0;

  var oldvec8:procedure;

  const ParallelFinished:boolean=true;
        parallelStart:boolean=false;
        stepcount:longint=0;

        preemptiveSwitch:boolean=true; {��४����� ��⮪� �� ⠩����}
        DisableHardwareEvents:boolean=false;
          {�� ���������� 䫠�� ���� ��ࠡ��稪 �� ��뢠����}

  var curflags:word;

const
  criticalTable:array [TCriticalNum] of byte=(0,0,0,0,0,0,0,0,0,0,0);
  criticalTableWait:array [TCriticalNum] of byte=(0,0,0,0,0,0,0,0,0,0,0);

procedure EnterCritical(num:TCriticalNum); {���� � ������� ᥪ��}
begin
  asm cli end;
  if num<=maxCritical then begin
    if criticalTable[num]<>0 then begin
      inc(criticalTableWait[num]); {����� �� �室 � ��}
      while criticalTable[num]>0 do begin {���� �� ����� ���-�}
        {�⤠�� �ࠢ����� ��㣮�� ������ � ����� �᢮�������� ��}
        asm sti end;
        SwitchThreads;
        asm cli end;
      end;
      dec(criticalTableWait[num]);
    end;
    criticalTable[num]:=1;
  end;
  asm sti end;
end;

procedure LeaveCritical(num:TCriticalNum); {�������� ������� ᥪ��}
begin
  asm cli end;
  if num<=maxCritical then
    criticalTable[num]:=0;
  asm sti end;

  if criticalTableWait[num]>0 then {�᫨ ��-� ���� ��}
    switchThreads;
end;

procedure TimerHandler(flags,cs,ip,ax,bx,cx,dx,si,di,ds,es,bp:word); interrupt;
  {������騥 ⨯���஢���� ����⠭�� ����� �� ᠬ�� ����
   ����᪨�� ������묨 ��६���묨, ����� ࠧ������� � ᥣ����
   ������ � ��࠭��� ᢮� ���祭�� ����� �맮���� ��楤���}
  const ThreadNumber:byte=0;
  const NumPrev:byte=0;
  const tsoffset:word=0;
        mainSP:word=0;
        mainSS:word=0;
begin
  if not DisableHardwareEvents then begin
    asm pushf end;
    oldvec8;
    {�맢�� ���� ��ࠡ��稪 ���뢠��� �� ⠩���. �� ��ᨫ
     ����஫��� ���뢠���.}
  end;

  if preemptiveSwitch or DisableHardwareEvents then
    if (ThreadsRegistered>1) or (parallelStart) then begin
      {��ॣ����஢��� ����� ����� �����}
      asm cli end;

      if ParallelStart then begin
        {�᫨ ���� ����� ����� ��ࠫ������ ���᫥���}
        StepCount:=0;
        asm
          mov       ParallelFinished,false {���� 䫠�� �����襭��}
          mov       mainsp,bp {�⥪ �������� ��⮪� ��� ������ �� ����砭��}
          mov       mainss,ss {�ᯮ������ ��ࠫ������ ��⮪��}
        end;
      end;

      inc(StepCount);

      if {ts[ThreadNumber].active and} not ParallelStart then begin
        {���࠭���� ���ﭨ� ⥪�饣� (��ࢠ�����) ��⮪�.
        �� �ந�������� �� ���������� 䫠�� ParallelStart, �.�.
        �।����������, �� � �⮬ ��砥 �뫠 ��ࢠ�� �᭮���� �ணࠬ��}

        {���饭�� ⥪�魣� ��⮪� � ⠡��� ��ॣ����஢����� ��⮪��}
        tsoffset:=ThreadNumber*sizeof(TThreadStateWord);
        asm
          push      ds
             {��� ��࠭⨩, �� �� ���뢠��� DS 㪠�뢠��
              �� ᥣ���� ������ �ணࠬ��!}
          mov       ax,seg ts
          mov       es,ax
          mov       di,offset ts
          add       di,tsoffset

          mov       ax,ss
          mov       ds,ax
          mov       si,bp {ds:si 㪠�뢠�� �� ॣ�����, ��࠭���� � �⥪�}

          cld
          mov       cx,12
      rep movsw     {��࠭���� ���ﭨ� ��ࢠ����� ��⮪� (�஬� �⥪�)}
          pop       ds

          {es:di �த���㫮�� �� 24 ���� ���। � 㪠�뢠�� �� ����
          ��� ��࠭���� ���ﭨ� �⥪�}
          mov       ax,bp  {BP ᮤ�ন� ���ﭨ� �⥪� ��᫥ 12 ��࠭���� ॣ���஢}
          add       ax,12*2
          stosw  {SP �����}
          mov       ax,ss
          stosw  {SS �����}
        end;
      end;

      {���� ᫥���饩 ��⨢��� �����}
      NumPrev:=ThreadNumber;
      repeat
        ThreadNumber:=(ThreadNumber+1) mod ThreadsRegistered;
      until (ThreadNumber=NumPrev) or TS[ThreadNumber].active;

      if ts[ThreadNumber].active and ((ThreadNumber<>NumPrev) or parallelStart)
      then begin
        {����⠭������� ����� �����, �᫨ ��� �⫨筠 �� �०���.
        �ந�������� �� ���������� 䫠�� ParallelStart, ���� �᫨
        ����� ᮢ������ � 类�� �०���, �.�. �����
        ���������, �� �����⢥���� ��⨢��� ����祩 � ��।� ����
        ����� ����� 0}
        tsOffset:=(ThreadNumber+1)*sizeof(TThreadStateWord) - 3;
        asm
          mov       dx,ds

          mov       ax,seg TS
          mov       ds,ax
          mov       si,offset TS
          add       si,tsOffset  {ds:si 㪠�뢠�� �� ���ﭨ� ��⨢����㥬��� ��⮪�}
          std

          lodsw
          mov       ss,ax
          lodsw
          mov       sp,ax
          mov       bp,ax    {��४��祭�� �� �⥪ ������ ��⮪�}
          sub       bp,12*2

          {������� ॣ���஢ � �⥪� �� ���ﭨ� ������ ��⮪�. ��᫥
           ������ �� ��楤��� �㤥� �ᯮ������� ��� � ⮩ �窨,
           ��� �� �� ��ࢠ� �� ����⨢�樨 ��⨢����㥬��� ᥩ��
           ��⮪�}
          mov       cx,12
      @m1:
          lodsw
          push      ax
          loop      @m1
          cld

          mov       ds,dx
        end;
      end
      else if (not ts[Threadnumber].active) and (Threadnumber=NumPrev) then begin
        {�� ����� �����襭�}
        setintvec($8,@oldvec8);
        asm
          mov   parallelfinished,true
          mov   ax,mainss
          mov   ss,ax
          mov   bp,mainsp
          mov   sp,bp
        end;
      end;
      parallelstart:=false;
    end;

  DisableHardwareEvents:=false;
end;

procedure SwitchThreads;
begin
  if not parallelFinished then
    asm
      cli
      mov DisableHardwareEvents,1
      int 08h
      sti
    end;
end;

procedure ExecuteRegisteredThreads(useTimer:boolean);
begin
  parallelfinished:=false;
  parallelstart:=true;
  fillchar(criticalTable,sizeof(criticaltable),0);
  fillchar(criticalTableWait,sizeof(criticaltable),0);
  PreemptiveSwitch:=useTimer;
  getintvec($08,@oldvec8);
  setintvec($08,@TimerHandler);
  if not useTimer then SwitchThreads;
  repeat until parallelFinished;
  setintvec($08,@oldvec8);
end;

procedure StopThread(ThreadNumber:byte);
begin
  ts[ThreadNumber].active:=false;
  SwitchThreads;
end;

procedure RunThread(ThreadNumber:byte);
begin
  ts[ThreadNumber].active:=true;
end;

procedure LoopBack;
begin
  repeat
    SwitchThreads; {�⤠�� �ࠢ����� ��㣮��}
  until false;
end;

function RegisterThread(ThreadAddr:pointer; StackSize:word):integer;
begin
  asm
    sti
    pushf
    cli
    pop  ax  {ࠧ���� ���뢠��� � ������������ ���ﭨ� 䫠���}
    mov  curflags,ax
  end;
  ts[ThreadsRegistered].ip_reg:=word(ThreadAddr);
  ts[ThreadsRegistered].cs_reg:=word(longint(ThreadAddr) shr 16);
  ts[ThreadsRegistered].ds_reg:=dseg;
  ts[ThreadsRegistered].flags:=curflags;

  getmem(ts[ThreadsRegistered].stack,StackSize);    {�⥪ �����}
  stacks[ThreadsRegistered].sze:=StackSize;
  stacks[ThreadsRegistered].ptr:=ts[ThreadsRegistered].stack;
  inc(word(ts[ThreadsRegistered].stack),StackSize and $FFFE-2);
  {�⥪ ����⠥� "����", �������� ᫮����!}

  ts[ThreadsRegistered].active:=true;
  registerThread:=ThreadsRegistered;
  inc(ThreadsRegistered);
  if Threadsregistered>maxThread then runerror(0);
  asm
    sti
  end;
end;

procedure ClearThreads;
  var i:integer;
begin
  for i:=0 to threadsregistered-1 do
    freemem(stacks[i].ptr,stacks[i].sze);
  ThreadsRegistered:=0;
  fillchar(ts,sizeof(ts),0);
end;

begin
  ClearThreads;
end.