*version 8.0 783679210
u 31
J? 2
V? 3
? 2
M? 2
@libraries
@analysis
.DC 1 0 0 0 3 0
+ 0 0 V2
+ 0 4 -4
+ 0 5 0
+ 0 6 0.1
+ 1 0 v1
+ 1 7 5,10,15
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
pageloc 1 0 1404 
@status
n 0 108:02:29:20:29:06;1206808146 e 
s 2833 108:02:29:20:29:06;1206808146 e 
c 121:02:28:13:08:29;1616922509
*page 1 0 970 720 iA
@ports
port 22 EGND 390 280 h
@parts
part 4 VDC 310 240 h
a 0 sp 0 0 22 37 hln 100 PART=VDC
a 0 a 0:13 0 0 0 hln 100 PKGREF=V2
a 1 ap 9 0 9 -23 hcn 100 REFDES=V2
part 3 VDC 470 200 h
a 0 sp 0 0 22 37 hln 100 PART=VDC
a 0 a 0:13 0 0 0 hln 100 PKGREF=V1
a 1 ap 9 0 24 7 hcn 100 REFDES=V1
a 1 u 13 0 -11 18 hcn 100 DC=15
part 29 MbreakN3 360 220 h
a 0 a 0:13 0 0 0 hln 100 PKGREF=M1
a 0 ap 9 0 -15 10 hln 100 REFDES=M1
part 1 titleblk 970 720 h
a 1 s 13 0 350 10 hcn 100 PAGESIZE=A
a 1 s 13 0 180 60 hcn 100 PAGETITLE=
a 1 s 13 0 340 95 hrn 100 PAGECOUNT=1
a 1 s 13 0 300 95 hrn 100 PAGENO=1
part 25 iMarker 390 200 h
a 0 s 0 0 0 0 hln 100 PROBEVAR=
a 0 s 0 0 0 0 hln 100 PROBEVAR=
a 0 s 0 0 0 0 hln 100 PROBEVAR=
a 0 a 0 0 6 20 hlb 100 LABEL=1
@conn
w 17
s 390 200 390 170 16
s 470 170 470 200 20
s 390 170 470 170 18
w 10
s 470 280 470 240 11
s 390 280 470 280 15
s 390 240 390 280 13
s 310 280 390 280 9
w 6
s 310 240 310 230 5
s 310 230 360 230 7
@junction
j 470 240
+ p 3 -
+ w 10
j 390 280
+ s 22
+ w 10
j 310 280
+ p 4 -
+ w 10
j 390 200
+ p 25 pin1
+ w 17
j 470 200
+ p 3 +
+ w 17
j 390 200
+ p 29 d
+ p 25 pin1
j 390 200
+ p 29 d
+ w 17
j 390 240
+ p 29 s
+ w 10
j 310 240
+ p 4 +
+ w 6
j 360 230
+ p 29 g
+ w 6
@attributes
a 0 s 0:13 0 0 0 hln 100 PAGETITLE=
a 0 s 0:13 0 0 0 hln 100 PAGENO=1
a 0 s 0:13 0 0 0 hln 100 PAGESIZE=A
a 0 s 0:13 0 0 0 hln 100 PAGECOUNT=1
@graphics
