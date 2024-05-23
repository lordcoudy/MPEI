*version 9.1 3024608439
u 100
Q? 2
R? 5
C? 4
V? 3
@libraries
@analysis
.LIB C:\Autodesk\lr4\Schematic6.lib
@targets
@attributes
@translators
a 0 u 13 0 0 0 hln 100 PCBOARDS=PCB
a 0 u 13 0 0 0 hln 100 PSPICE=PSPICE
a 0 u 13 0 0 0 hln 100 XILINX=XILINX
@setup
unconnectedPins 0
connectViaLabel 0
connectViaLocalLabels 0
NoStim4ExtIFPortsWarnings 1
AutoGenStim4ExtIFPorts 1
@index
pageloc 1 0 3912 
@status
n 0 121:03:15:02:21:30;1618442490 e 
s 2832 121:03:15:02:21:30;1618442490 e 
*page 1 0 970 720 iA
@ports
port 11 EGND 280 360 h
@parts
part 8 c 320 210 u
a 0 sp 0 0 0 10 hlb 100 PART=c
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=C2
a 0 ap 9 0 15 0 hln 100 REFDES=C2
a 0 u 13 0 15 25 hln 100 VALUE=22u
part 9 c 310 320 u
a 0 sp 0 0 0 10 hlb 100 PART=c
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=C3
a 0 ap 9 0 15 0 hln 100 REFDES=C3
a 0 u 13 0 15 25 hln 100 VALUE=22u
part 7 c 130 190 v
a 0 sp 0 0 0 10 hlb 100 PART=c
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=C1
a 0 ap 9 0 15 0 hln 100 REFDES=C1
a 0 u 13 0 5 -3 hln 100 VALUE=220u
part 6 r 280 360 v
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 u 13 0 7 -1 hln 100 VALUE=50
a 0 x 0:13 0 0 0 hln 100 PKGREF=Rem
a 0 xp 9 0 15 0 hln 100 REFDES=Rem
part 3 r 280 200 v
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 u 13 0 -1 -5 hln 100 VALUE=200
a 0 x 0:13 0 0 0 hln 100 PKGREF=Rcol
a 0 xp 9 0 15 0 hln 100 REFDES=Rcol
part 4 r 170 200 v
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=R1
a 0 u 13 0 -5 39 hln 100 VALUE=8400
a 0 xp 9 0 11 32 hln 100 REFDES=R1
part 2 QbreakN 260 250 h
a 0 sp 0 0 0 50 hln 100 PART=QbreakN
a 0 a 0:13 0 0 0 hln 100 PKGREF=Q1
a 0 ap 9 0 5 5 hln 100 REFDES=Q1
a 0 sp 13 0 5 40 hln 100 MODEL=QbreakN-X
part 5 r 170 360 v
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 u 13 0 5 1 hln 100 VALUE=1600
a 0 x 0:13 0 0 0 hln 100 PKGREF=R2
a 0 xp 9 0 15 0 hln 100 REFDES=R2
part 14 VSIN 310 320 h
a 0 a 0:13 0 0 0 hln 100 PKGREF=V2
a 1 ap 9 0 20 10 hcn 100 REFDES=V2
a 1 u 0 0 0 0 hcn 100 VOFF=0
a 1 u 0 0 0 0 hcn 100 FREQ=0
a 1 u 0 0 0 0 hcn 100 VAMPL=0
a 1 u 0 0 0 0 hcn 100 AC=0
part 10 VDC 390 220 h
a 0 sp 0 0 22 37 hln 100 PART=VDC
a 0 a 0:13 0 0 0 hln 100 PKGREF=V1
a 1 ap 9 0 24 7 hcn 100 REFDES=V1
a 1 u 13 0 -11 18 hcn 100 DC=10V
part 1 titleblk 970 720 h
a 1 s 13 0 350 10 hcn 100 PAGESIZE=A
a 1 s 13 0 180 60 hcn 100 PAGETITLE=
a 1 s 13 0 300 95 hrn 100 PAGENO=1
a 1 s 13 0 340 95 hrn 100 PAGECOUNT=1
@conn
w 24
a 0 up 0:33 0 0 0 hln 100 V=
s 280 230 280 210 23
a 0 up 33 0 282 220 hlt 100 V=
s 280 210 280 200 27
s 290 210 280 210 25
w 29
a 0 up 0:33 0 0 0 hln 100 V=
s 320 210 340 210 28
s 280 360 310 360 15
s 310 360 340 360 17
s 390 360 390 260 19
s 340 360 390 360 32
s 340 210 340 360 30
a 0 up 33 0 342 285 hlt 100 V=
s 280 360 170 360 12
w 22
a 0 up 0:33 0 0 0 hln 100 V=
s 280 320 280 270 21
a 0 up 33 0 284 287 hlt 100 V=
w 34
a 0 up 0:33 0 0 0 hln 100 V=
s 390 220 390 160 33
s 390 160 280 160 35
s 280 160 170 160 37
a 0 up 33 0 283 129 hct 100 V=
s 170 160 130 160 39
w 42
a 0 up 0:33 0 0 0 hln 100 V=
s 260 250 170 250 41
a 0 up 33 0 215 261 hct 100 V=
s 170 250 170 200 43
s 170 250 170 320 45
s 170 250 130 250 49
s 130 250 130 190 51
@junction
j 130 160
+ p 7 2
+ w 34
j 390 220
+ p 10 +
+ w 34
j 170 160
+ p 4 2
+ w 34
j 280 160
+ p 3 2
+ w 34
j 290 210
+ p 8 2
+ w 24
j 280 200
+ p 3 1
+ w 24
j 280 210
+ w 24
+ w 24
j 280 270
+ p 2 e
+ w 22
j 280 230
+ p 2 c
+ w 24
j 260 250
+ p 2 b
+ w 42
j 170 320
+ p 5 2
+ w 42
j 170 360
+ p 5 1
+ w 29
j 280 320
+ p 9 2
+ p 6 2
j 280 360
+ s 11
+ p 6 1
j 280 360
+ p 6 1
+ w 29
j 280 320
+ p 6 2
+ w 22
j 310 320
+ p 14 +
+ p 9 1
j 280 320
+ p 9 2
+ w 22
j 310 360
+ p 14 -
+ w 29
j 280 360
+ s 11
+ w 29
j 170 200
+ p 4 1
+ w 42
j 170 250
+ w 42
+ w 42
j 130 190
+ p 7 1
+ w 42
j 320 210
+ p 8 1
+ w 29
j 390 260
+ p 10 -
+ w 29
j 340 360
+ w 29
+ w 29
@attributes
a 0 s 0:13 0 0 0 hln 100 PAGETITLE=
a 0 s 0:13 0 0 0 hln 100 PAGENO=1
a 0 s 0:13 0 0 0 hln 100 PAGESIZE=A
a 0 s 0:13 0 0 0 hln 100 PAGECOUNT=1
@graphics
