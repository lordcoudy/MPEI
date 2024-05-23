*version 9.2 691831423
u 46
R? 3
C? 2
V? 2
? 2
@libraries
@analysis
.AC 1 1 0
+0 2000
+1 100
+2 389k
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
pageloc 1 0 2119 
@status
n 0 120:09:30:12:05:05;1604048705 e 
s 2832 120:09:30:12:05:09;1604048709 e 
*page 1 0 1520 970 iB
@ports
port 4 AGND 200 180 h
@parts
part 2 R 170 100 h
a 0 u 13 0 15 25 hln 100 VALUE=1150
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R1
a 0 ap 9 0 15 0 hln 100 REFDES=R1
part 3 c 260 150 v
a 0 sp 0 0 0 10 hlb 100 PART=c
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=C1
a 0 ap 9 0 15 0 hln 100 REFDES=C1
a 0 u 13 0 -1 31 hln 100 VALUE=5.6n
part 22 VAC 140 120 h
a 0 u 13 0 -9 23 hcn 100 ACMAG=1V
a 0 sp 0 0 0 50 hln 100 PART=VAC
a 0 a 0:13 0 0 0 hln 100 PKGREF=V1
a 1 ap 9 0 20 10 hcn 100 REFDES=V1
part 39 R 340 150 v
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R2
a 0 ap 9 0 15 0 hln 100 REFDES=R2
a 0 u 13 0 15 25 hln 100 VALUE=2k
part 1 titleblk 1520 970 h
a 1 s 13 0 350 10 hcn 100 PAGESIZE=B
a 1 s 13 0 180 60 hcn 100 PAGETITLE=
a 1 s 13 0 300 95 hrn 100 PAGENO=1
a 1 s 13 0 340 95 hrn 100 PAGECOUNT=1
part 30 nodeMarker 260 100 h
a 0 s 0 0 0 0 hln 100 PROBEVAR=
a 0 a 0 0 4 22 hlb 100 LABEL=1
@conn
w 21
a 0 up 0:33 0 0 0 hln 100 V=
s 170 100 140 100 20
a 0 up 33 0 155 99 hct 100 V=
s 140 120 140 100 23
w 10
a 0 up 0:33 0 0 0 hln 100 V=
s 260 150 260 180 9
s 260 180 200 180 19
s 140 160 140 180 25
s 200 180 140 180 28
a 0 up 33 0 170 179 hct 100 V=
s 260 180 340 180 40
s 340 180 340 150 42
w 6
a 0 sr 0 0 0 0 hln 100 LABEL=3
a 0 up 0:33 0 0 0 hln 100 V=
s 260 100 260 120 7
a 0 sr 3 0 262 110 hln 100 LABEL=3
a 0 up 33 0 262 111 hlt 100 V=
s 210 100 260 100 5
s 260 100 340 100 37
s 340 100 340 110 44
@junction
j 210 100
+ p 2 2
+ w 6
j 260 100
+ p 30 pin1
+ w 6
j 170 100
+ p 2 1
+ w 21
j 200 180
+ s 4
+ w 10
j 260 120
+ p 3 2
+ w 6
j 260 150
+ p 3 1
+ w 10
j 140 160
+ p 22 -
+ w 10
j 140 120
+ p 22 +
+ w 21
j 260 180
+ w 10
+ w 10
j 340 150
+ p 39 1
+ w 10
j 340 110
+ p 39 2
+ w 6
@attributes
a 0 s 0:13 0 0 0 hln 100 PAGETITLE=
a 0 s 0:13 0 0 0 hln 100 PAGENO=1
a 0 s 0:13 0 0 0 hln 100 PAGESIZE=B
a 0 s 0:13 0 0 0 hln 100 PAGECOUNT=1
@graphics
