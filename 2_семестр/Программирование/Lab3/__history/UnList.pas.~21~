unit UnList;
interface

type
  TInfo = real;

  PElem = ^TElem;
  TElem = record
      info: TInfo;                                                              //Information in element
      next: PElem;                                                              //Next element
      prev: PElem;                                                              //Previous element
  end;

// создать список из одного элемента
procedure CreateList(var ListN, ListK: PElem; r: TInfo);
// добавить новый элемент перед первым
procedure AddFirst(var ListN: PElem; ListK: PElem; r: TInfo);
// добавить новый элемент в конец списка
procedure AddLast(ListN: PElem; var ListK: PElem; r: TInfo);
// добавить новый элемент в середину после ListC (не в конец)
procedure AddMedium(ListN,ListC,ListK: PElem; r: TInfo);
// очистить список
procedure FreeList(var ListN, ListK: PElem);

implementation

// создать список из одного элемента
procedure CreateList(var ListN, ListK: PElem; r: TInfo);
begin
  New(ListN);
  ListK:=ListN; // конец и начало совпадают
  ListN^.info:=r;
  ListN^.next:=nil;                                                             //Next element doesn't exist
  ListN^.prev:=nil;                                                             //Previous element doesn't exist
end;

// добавить новый элемент перед первым
procedure AddFirst(var ListN: PElem; ListK: PElem; r: TInfo);
var Elem: PElem;
begin
  new(Elem);
  Elem^.info:=r;
  Elem^.next:=ListN;                                                            //Next element is the first
  Elem^.prev:=nil;                                                              //Previous element doesn't exist
  ListN^.prev:=Elem;
  ListN:=Elem; // теперь он 1-ый
          //
end;




// добавить новый элемент в конец
procedure AddLast(ListN: PElem; var ListK: PElem; r: TInfo);
var ListT : PElem;
begin
  new(ListK^.next);
  ListT:=ListK^.next;
  ListT^.info:=r;
  ListT^.next:=nil;                                                             //Next element doesn't exist
  ListT^.prev:=ListK;                                                           //Previous element is the previous last
  ListK:= ListT;
end;


// добавить новый элемент в середину после ListC (не в конец)
procedure AddMedium(ListN,ListC,ListK: PElem; r: TInfo);
var Elem: PElem;
begin
  new(Elem);
  Elem^.info:=r;
  Elem^.next:=ListC^.next;                                                      // после него то, что было после ListC
  ListC^.next^.prev:=Elem;
  Elem^.prev:=ListC;
  ListC^.next:=Elem;                                                            // а он сам после ListC
end;

// очистить список
procedure FreeList(var ListN, ListK: PElem);
var Elem: PElem;
begin
  Elem:=ListN;
  while Elem<>nil do
  begin
    ListN:=ListN^.next;
    Dispose(Elem);
    Elem:=ListN;
  end;
  ListK:=nil;
end;

end.

