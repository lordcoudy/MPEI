unit Sound;

interface

procedure OnSound(freq:word); assembler;
procedure NoSound; assembler;

implementation

procedure OnSound(freq:word); assembler;
 asm
  push    ax
  push    bx
  push    dx
  mov     bx,freq
  mov     ax,34DDh
  mov     dx,12h
  cmp     dx,bx
  jnb     @m1
  div     bx
  mov     bx,ax
  in      al,61h
  test    al,3
  jne     @m2
  or      al,3
  out     61h,al
  mov     al,0B6h
  out     43h,al
@m2:
  mov     al,bl
  out     42h,al
  mov     al,bh
  out     42h,al
@m1:
  pop    dx
  pop    bx
  pop    ax
 end;

procedure NoSound; assembler;
 asm
  push    ax
  in      al,61h
  and     al,0FCh
  out     61h,al
  pop     ax
 end;

end.
