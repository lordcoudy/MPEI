*version 8.0 830320363
u 146
DA? 2
V? 3
R? 9
? 4
C? 5
@libraries
@analysis
.AC 1 3 0
+0 101
+1 10
+2 1meg
.DC 0 0 0 0 1 1
+ 0 0 v1
+ 0 4 -10m
+ 0 5 +10m
+ 0 6 1m
.OP 0 
@targets
@attributes
@translators
a 0 u 13 0 0 0 hln 100 TANGO=PCB
a 0 u 13 0 0 0 hln 100 SCICARDS=PCB
a 0 u 13 0 0 0 hln 100 PROTEL=PCB
a 0 u 13 0 0 0 hln 100 PCBOARDS=PCB
a 0 u 13 0 0 0 hln 100 PCAD=PCB
a 0 u 13 0 0 0 hln 100 PADS=PCB
a 0 u 13 0 0 0 hln 100 ORCAD=PCB
a 0 u 13 0 0 0 hln 100 EDIF=PCB
a 0 u 13 0 0 0 hln 100 CADSTAR=PCB
a 0 u 13 0 0 0 hln 100 PSPICE=PSPICE
a 0 u 13 0 0 0 hln 100 XILINX=XILINX
@setup
unconnectedPins 0
connectViaLabel 0
connectViaLocalLabels 0
NoStim4ExtIFPortsWarnings 1
AutoGenStim4ExtIFPorts 1
@index
pageloc 1 0 3672 
@status
n 0 121:01:14:18:01:45;1613311305 e 
s 0 121:01:14:18:01:45;1613311305 e 
c 121:01:14:18:07:03;1613311623
*page 1 0 970 720 iA
@ports
port 4 EGND 380 290 h
@parts
part 2 LIMIT 380 250 h
a 0 sp 0 0 14 48 hln 100 PART=LIMIT
a 0 a 0:13 0 0 0 hln 100 PKGREF=DA1
a 0 ap 9 0 14 52 hln 100 REFDES=DA1
a 0 u 0:13 0 0 10 hlb 100 GAIN=10
part 44 VSIN 300 240 h
a 1 u 0 0 0 0 hcn 100 AC=1
a 1 u 0 0 0 0 hcn 100 VOFF=0
a 1 u 0 0 0 0 hcn 100 VAMPL=100m
a 1 u 0 0 0 0 hcn 100 FREQ=1k
a 0 x 0:13 0 0 0 hln 100 PKGREF=V1
a 1 xp 9 0 30 25 hcn 100 REFDES=V1
part 23 C 300 240 h
a 0 sp 0 0 0 10 hlb 100 PART=C
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=C1
a 0 ap 9 0 10 -5 hln 100 REFDES=C1
a 0 u 13 0 0 -20 hln 100 VALUE=1u
part 61 R 340 280 v
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=R1
a 0 xp 9 0 55 20 hln 100 REFDES=R1
a 0 u 13 0 70 20 hln 100 VALUE=100k
part 25 C 360 280 v
a 0 sp 0 0 0 10 hlb 100 PART=C
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=C2
a 0 xp 9 0 55 20 hln 100 REFDES=C2
a 0 u 13 0 70 20 hln 100 VALUE=1n
part 21 R 420 250 h
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=R3
a 0 xp 9 0 15 0 hln 100 REFDES=R3
a 0 u 13 0 15 -20 hln 100 VALUE=1k
part 24 C 450 250 h
a 0 sp 0 0 0 10 hlb 100 PART=C
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=C3
a 0 xp 9 0 10 0 hln 100 REFDES=C3
a 0 u 13 0 10 -20 hln 100 VALUE=1u
part 22 R 480 290 v
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=R4
a 0 xp 9 0 50 25 hln 100 REFDES=R4
a 0 u 13 0 70 25 hln 100 VALUE=1k
part 26 C 500 280 v
a 0 sp 0 0 0 10 hlb 100 PART=C
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=C4
a 0 ap 9 0 10 35 hln 100 REFDES=C4
a 0 u 13 0 65 25 hln 100 VALUE=1n
part 1 titleblk 970 720 h
a 1 s 13 0 350 10 hcn 100 PAGESIZE=A
a 1 s 13 0 180 60 hcn 100 PAGETITLE=
a 1 s 13 0 340 95 hrn 100 PAGECOUNT=1
a 1 s 13 0 300 95 hrn 100 PAGENO=1
part 76 nodeMarker 500 250 h
a 0 s 0 0 0 0 hln 100 PROBEVAR=C4:2
a 0 a 0 0 4 22 hlb 100 LABEL=3
@conn
w 28
a 0 up 0:33 0 0 0 hln 100 V=
s 330 240 340 240 99
a 0 up 33 0 370 239 hct 100 V=
s 360 240 380 240 111
s 360 250 360 240 27
s 340 240 360 240 116
w 130
s 420 250 430 250 128
w 131
s 450 250 460 250 129
w 35
a 0 up 0:33 0 0 0 hln 100 V=
s 480 250 500 250 34
a 0 up 33 0 525 249 hct 100 V=
w 9
a 0 up 0:33 0 0 0 hln 100 V=
s 380 260 380 290 14
s 380 290 480 290 79
a 0 up 33 0 425 289 hct 100 V=
s 360 290 380 290 107
s 360 280 360 290 31
s 340 280 340 290 67
s 340 290 360 290 70
s 500 290 500 280 42
s 480 290 500 290 135
s 300 290 340 290 47
s 300 290 300 280 85
@junction
j 380 290
+ s 4
+ w 9
j 330 240
+ p 23 2
+ w 28
j 340 240
+ p 61 2
+ w 28
j 360 280
+ p 25 1
+ w 9
j 340 280
+ p 61 1
+ w 9
j 360 290
+ w 9
+ w 9
j 360 250
+ p 25 2
+ w 28
j 360 240
+ w 28
+ w 28
j 420 250
+ p 21 1
+ w 130
j 480 250
+ p 24 2
+ w 35
j 450 250
+ p 24 1
+ w 131
j 460 250
+ p 21 2
+ w 131
j 480 250
+ p 22 2
+ p 24 2
j 480 290
+ p 22 1
+ w 9
j 480 250
+ p 22 2
+ w 35
j 500 250
+ p 26 2
+ w 35
j 500 280
+ p 26 1
+ w 9
j 500 250
+ p 76 pin1
+ p 26 2
j 500 250
+ p 76 pin1
+ w 35
j 380 260
+ p 2 IN+
+ w 9
j 380 240
+ p 2 IN-
+ w 28
j 430 250
+ p 2 OUT
+ w 130
j 300 240
+ p 44 +
+ p 23 1
j 340 290
+ w 9
+ w 9
j 300 280
+ p 44 -
+ w 9
@attributes
a 0 s 0:13 0 0 0 hln 100 PAGETITLE=
a 0 s 0:13 0 0 0 hln 100 PAGENO=1
a 0 s 0:13 0 0 0 hln 100 PAGESIZE=A
a 0 s 0:13 0 0 0 hln 100 PAGECOUNT=1
@graphics
