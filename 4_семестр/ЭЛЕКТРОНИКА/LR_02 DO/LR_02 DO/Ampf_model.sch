*version 9.2 334958890
u 80
GAIN? 2
LIMIT? 2
R? 4
C? 5
V? 4
? 8
PM? 2
@libraries
@analysis
.AC 1 3 0
+0 101
+1 100
+2 1meg
.TRAN 0 0 0 0
+0 10ns
+1 100u
+3 1u
.STEP 1 3 4
+ 0 RR
+ 4 -2
+ 5 2
+ 6 0.2
+ -1 400 10k
.OP 0 
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
pageloc 1 0 4689 
@status
n 0 121:01:15:21:28:12;1613413692 e 
s 0 121:01:16:11:57:07;1613465827 e 
c 121:00:10:18:37:50;1610293070
*page 1 0 1520 970 iB
@ports
port 12 EGND 520 350 h
@parts
part 4 R 450 350 v
a 0 u 13 0 47 15 hln 100 VALUE=1k
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R1
a 0 ap 9 0 57 18 hln 100 REFDES=R1
part 8 c 470 345 v
a 0 u 13 0 41 17 hln 100 VALUE=1n
a 0 sp 0 0 0 10 hlb 100 PART=c
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=C2
a 0 ap 9 0 51 18 hln 100 REFDES=C2
part 5 R 570 310 h
a 0 u 13 0 17 1 hln 100 VALUE=1k
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R2
a 0 ap 9 0 15 -8 hln 100 REFDES=R2
part 10 c 695 345 v
a 0 ap 9 0 23 4 hln 100 REFDES=C4
a 0 sp 0 0 0 10 hlb 100 PART=c
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=C4
a 0 u 13 0 11 3 hln 100 VALUE=1n
part 2 GAIN 480 310 h
a 0 sp 0 0 0 30 hln 100 PART=GAIN
a 0 a 0:13 0 0 0 hln 100 PKGREF=GAIN1
a 1 ap 0 0 0 0 hln 100 REFDES=GAIN1
a 0 u 13 0 16 22 hln 100 GAIN=10
part 3 LIMIT 525 310 h
a 0 sp 0 0 14 48 hln 100 PART=LIMIT
a 0 a 0:13 0 0 0 hln 100 PKGREF=LIMIT1
a 0 ap 0 0 -12 -2 hln 100 REFDES=LIMIT1
a 0 u 13 0 16 38 hln 100 LO=-10
part 7 c 420 310 h
a 0 sp 0 0 0 10 hlb 100 PART=c
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=C1
a 0 ap 9 0 5 -8 hln 100 REFDES=C1
a 0 u 13 0 5 1 hln 100 VALUE=1u
part 9 c 605 310 h
a 0 sp 0 0 0 10 hlb 100 PART=c
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=C3
a 0 ap 9 0 9 -8 hln 100 REFDES=C3
a 0 u 13 0 11 1 hln 100 VALUE=1u
part 65 PARAM 450 230 h
a 0 a 0:13 0 0 0 hln 100 PKGREF=PM1
a 1 ap 0 0 10 -2 hcn 100 REFDES=PM1
a 0 u 13 0 0 20 hln 100 NAME1=Ampl
a 0 u 13 0 50 22 hlb 100 VALUE1=100m
a 0 u 13 0 0 30 hln 100 NAME2=RR
a 0 u 13 0 50 32 hlb 100 VALUE2=5k
part 78 VSIN 395 310 h
a 1 u 0 0 0 0 hcn 100 AC=1
a 1 u 0 0 0 0 hcn 100 VOFF=0
a 1 u 0 0 0 0 hcn 100 VAMPL={Ampl}
a 1 u 0 0 0 0 hcn 100 FREQ=5k
a 0 x 0:13 0 0 0 hln 100 PKGREF=V1
a 1 xp 9 0 20 10 hcn 100 REFDES=V1
part 6 R 665 350 v
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R3
a 0 ap 9 0 25 2 hln 100 REFDES=R3
a 0 u 13 0 15 1 hln 100 VALUE={RR}
part 1 titleblk 1520 970 h
a 1 s 13 0 350 10 hcn 100 PAGESIZE=B
a 1 s 13 0 180 60 hcn 100 PAGETITLE=
a 1 s 13 0 340 95 hrn 100 PAGECOUNT=1
a 1 s 13 0 300 95 hrn 100 PAGENO=1
part 74 nodeMarker 400 310 v
a 0 s 0 0 0 0 hln 100 PROBEVAR=
a 0 s 0 0 0 0 hln 100 PROBEVAR=
a 0 s 0 0 0 0 hln 100 PROBEVAR=
a 0 s 0 0 0 0 hln 100 PROBEVAR=
a 0 a 0 0 4 22 hlb 100 LABEL=6
part 79 vdb 695 310 h
a 0 s 0 0 0 0 hln 100 PROBEVAR=VDB(R3:2)
a 0 a 0 0 4 22 hlb 100 LABEL=7
@conn
w 32
a 0 up 0:33 0 0 0 hln 100 V=
s 525 310 530 310 30
a 0 up 33 0 527 309 hct 100 V=
w 31
a 0 up 0:33 0 0 0 hln 100 V=
s 570 310 575 310 29
a 0 up 33 0 572 309 hct 100 V=
w 35
a 0 up 0:33 0 0 0 hln 100 V=
s 605 310 610 310 34
a 0 up 33 0 607 309 hct 100 V=
w 14
a 0 up 0:33 0 0 0 hln 100 V=
s 450 310 470 310 16
a 0 up 33 0 460 309 hct 100 V=
s 470 310 480 310 44
s 470 315 470 310 38
w 23
a 0 up 0:33 0 0 0 hln 100 V=
s 695 345 695 350 22
s 470 350 450 350 46
s 470 345 470 350 42
s 695 350 665 350 49
s 520 350 470 350 51
s 450 350 395 350 28
s 665 350 520 350 58
a 0 up 33 0 592 349 hct 100 V=
w 48
a 0 sr 0 0 0 0 hln 100 LABEL=1
a 0 up 0:33 0 0 0 hln 100 V=
s 395 310 400 310 75
a 0 sr 3 0 387 314 hcn 100 LABEL=1
a 0 up 33 0 387 315 hct 100 V=
s 400 310 420 310 76
w 18
a 0 sr 0 0 0 0 hln 100 LABEL=2
a 0 up 0:33 0 0 0 hln 100 V=
s 665 310 695 310 68
a 0 sr 3 0 700 316 hcn 100 LABEL=2
a 0 up 33 0 700 317 hct 100 V=
s 695 310 695 315 20
s 635 310 665 310 73
@junction
j 480 310
+ p 2 IN
+ w 14
j 450 310
+ p 4 2
+ w 14
j 695 345
+ p 10 1
+ w 23
j 450 350
+ p 4 1
+ w 23
j 450 310
+ p 7 2
+ p 4 2
j 450 310
+ p 7 2
+ w 14
j 525 310
+ p 3 IN
+ w 32
j 530 310
+ p 2 OUT
+ w 32
j 570 310
+ p 5 1
+ w 31
j 575 310
+ p 3 OUT
+ w 31
j 605 310
+ p 9 1
+ w 35
j 610 310
+ p 5 2
+ w 35
j 470 315
+ p 8 2
+ w 14
j 470 310
+ w 14
+ w 14
j 470 345
+ p 8 1
+ w 23
j 470 350
+ w 23
+ w 23
j 520 350
+ s 12
+ w 23
j 420 310
+ p 7 1
+ w 48
j 665 350
+ p 6 1
+ w 23
j 695 315
+ p 10 2
+ w 18
j 635 310
+ p 9 2
+ w 18
j 665 310
+ p 6 2
+ w 18
j 400 310
+ p 74 pin1
+ w 48
j 395 350
+ p 78 -
+ w 23
j 395 310
+ p 78 +
+ w 48
j 695 310
+ p 79 pin1
+ w 18
@attributes
a 0 s 0:13 0 0 0 hln 100 PAGETITLE=
a 0 s 0:13 0 0 0 hln 100 PAGENO=1
a 0 s 0:13 0 0 0 hln 100 PAGESIZE=B
a 0 s 0:13 0 0 0 hln 100 PAGECOUNT=1
@graphics
r 62 r 0 420 275 635 370
