*version 9.2 206297518
u 91
Q? 12
V? 3
I? 3
? 12
HB? 2
@libraries
@analysis
.DC 1 1 0 0 0 2
+ 0 0 v1
+ 0 4 0
+ 0 5 40
+ 0 6 15m
+ 1 0 i1
+ 1 4 50u
+ 1 5 500u
+ 1 6 50u
+ 1 7 0 5
.OP 0 
.LIB C:\KP_2021\bipolar.lib
+ C:\KP_2021\RUS_Q.LIB
+ C:\Diodes.lib
@targets
@attributes
@translators
a 0 u 13 0 0 0 hln 100 PCBOARDS=PCB
a 0 u 13 0 0 0 hln 100 PSPICE=PSPICE
a 0 u 13 0 0 0 hln 100 XILINX=XILINX
a 0 u 13 0 0 0 hln 100 TANGO=PCB
a 0 u 13 0 0 0 hln 100 SCICARDS=PCB
a 0 u 13 0 0 0 hln 100 PROTEL=PCB
a 0 u 13 0 0 0 hln 100 PCAD=PCB
a 0 u 13 0 0 0 hln 100 PADS=PCB
a 0 u 13 0 0 0 hln 100 ORCAD=PCB
a 0 u 13 0 0 0 hln 100 EDIF=PCB
a 0 u 13 0 0 0 hln 100 CADSTAR=PCB
@setup
unconnectedPins 0
connectViaLabel 0
connectViaLocalLabels 0
NoStim4ExtIFPortsWarnings 1
AutoGenStim4ExtIFPorts 1
@index
pageloc 1 0 1550 
@status
n 0 121:04:03:13:17:26;1620037046 e 
s 0 121:04:03:13:17:30;1620037050 e 
c 121:04:03:13:17:18;1620037038
*page 1 0 970 720 iA
@ports
port 5 EGND 440 270 h
@parts
part 86 IDC 400 230 h
a 0 sp 11 0 0 50 hln 100 PART=IDC
a 0 x 0:13 0 0 0 hln 100 PKGREF=I1
a 1 xp 9 0 20 10 hcn 100 REFDES=I1
part 83 QbreakP 420 220 h
a 0 x 0:13 0 0 0 hln 100 PKGREF=Q
a 0 xp 9 0 5 5 hln 100 REFDES=Q
a 0 sp 13 0 5 40 hln 100 MODEL=KT814V
part 84 VDC 480 245 u
a 0 sp 0 0 22 37 hln 100 PART=VDC
a 0 x 0:13 0 0 0 hln 100 PKGREF=V1
a 1 xp 9 0 26 19 hcn 100 REFDES=V1
a 1 u 13 0 25 29 hcn 100 DC=60
part 1 titleblk 970 720 h
a 1 s 13 0 350 10 hcn 100 PAGESIZE=A
a 1 s 13 0 180 60 hcn 100 PAGETITLE=
a 1 s 13 0 340 95 hrn 100 PAGECOUNT=1
a 1 s 13 0 300 95 hrn 100 PAGENO=1
part 85 iMarker 440 200 h
a 0 s 0 0 0 0 hln 100 PROBEVAR=
a 0 s 0 0 0 0 hln 100 PROBEVAR=
a 0 a 0 0 6 20 hlb 100 LABEL=11
@conn
w 58
a 0 sr 0 0 0 0 hln 100 LABEL=2
s 440 190 480 190 16
a 0 sr 3 0 472 200 hcn 100 LABEL=2
s 440 200 440 190 14
s 480 190 480 205 18
w 57
s 440 240 440 270 20
s 440 270 480 270 22
s 480 270 480 245 12
s 400 270 440 270 10
w 7
a 0 sr 0:3 0 392 227 hln 100 LABEL=1
s 400 230 400 220 89
a 0 sr 3 0 404 229 hln 100 LABEL=1
s 400 220 420 220 40
@junction
j 440 270
+ s 5
+ w 57
j 440 240
+ p 83 e
+ w 57
j 440 200
+ p 83 c
+ w 58
j 420 220
+ p 83 b
+ w 7
j 440 200
+ p 85 pin1
+ p 83 c
j 440 200
+ p 85 pin1
+ w 58
j 480 205
+ p 84 -
+ w 58
j 480 245
+ p 84 +
+ w 57
j 400 270
+ p 86 -
+ w 57
j 400 230
+ p 86 +
+ w 7
@attributes
a 0 s 0:13 0 0 0 hln 100 PAGETITLE=
a 0 s 0:13 0 0 0 hln 100 PAGENO=1
a 0 s 0:13 0 0 0 hln 100 PAGESIZE=A
a 0 s 0:13 0 0 0 hln 100 PAGECOUNT=1
@graphics
