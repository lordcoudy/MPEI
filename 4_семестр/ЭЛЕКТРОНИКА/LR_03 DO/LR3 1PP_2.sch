*version 8.0 617417404
u 23
V? 2
D? 3
R? 2
? 3
C? 2
@libraries
@analysis
.TRAN 1 0 0 1
+0 20ns
+1 5m
+3 5u
+4 1k
+5 v(2)
+6 5
.OP 0 
.LIB D:\LagutinaSV\DesignLab files\LIB\Diodes.lib
+ D:\LagutinaSV\DesignLab files\LR3 1PP_1_DL8.lib
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
pageloc 1 0 2161 
@status
n 0 121:02:12:17:47:25;1615560445 e 
s 2832 121:02:12:17:47:25;1615560445 e 
*page 1 0 970 720 iA
@ports
port 5 EGND 250 180 h
@parts
part 2 VSIN 210 140 h
a 0 a 0:13 0 0 0 hln 100 PKGREF=V1
a 1 ap 9 0 20 10 hcn 100 REFDES=V1
a 1 u 0 0 0 0 hcn 100 VOFF=0
a 1 u 0 0 0 0 hcn 100 VAMPL=20
a 1 u 0 0 0 0 hcn 100 FREQ=1k
part 4 R 280 180 v
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R1
a 0 ap 9 0 29 32 hln 100 REFDES=R1
part 15 Dbreak 230 140 h
a 0 sp 13 0 7 -21 hln 100 MODEL=Dbreak
a 0 a 0:13 0 0 0 hln 100 PKGREF=D2
a 0 ap 9 0 15 0 hln 100 REFDES=D2
part 16 C 260 170 v
a 0 sp 0 0 0 10 hlb 100 PART=C
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=C1
a 0 ap 9 0 15 0 hln 100 REFDES=C1
a 0 u 13 0 5 -1 hln 100 VALUE=50u
part 1 titleblk 970 720 h
a 1 s 13 0 350 10 hcn 100 PAGESIZE=A
a 1 s 13 0 180 60 hcn 100 PAGETITLE=
a 1 s 13 0 300 95 hrn 100 PAGENO=1
a 1 s 13 0 340 95 hrn 100 PAGECOUNT=1
part 13 nodeMarker 210 140 h
a 0 s 0 0 0 0 hln 100 PROBEVAR=
a 0 a 0 0 4 22 hlb 100 LABEL=1
part 14 nodeMarker 280 140 h
a 0 s 0 0 0 0 hln 100 PROBEVAR=
a 0 a 0 0 4 22 hlb 100 LABEL=2
@conn
w 7
a 0 sr 0 0 0 0 hln 100 LABEL=1
a 0 up 0:33 0 0 0 hln 100 V=
s 210 140 230 140 6
a 0 sr 3 0 220 138 hcn 100 LABEL=1
a 0 up 33 0 220 139 hct 100 V=
w 9
a 0 sr 0 0 0 0 hln 100 LABEL=2
a 0 up 0:33 0 0 0 hln 100 V=
s 260 140 280 140 8
a 0 sr 3 0 270 138 hcn 100 LABEL=2
a 0 up 33 0 270 139 hct 100 V=
w 11
a 0 up 0:33 0 0 0 hln 100 V=
s 210 180 250 180 10
a 0 up 33 0 230 179 hct 100 V=
s 250 180 260 180 18
s 260 180 280 180 22
s 260 170 260 180 20
@junction
j 210 140
+ p 2 +
+ w 7
j 280 140
+ p 4 2
+ w 9
j 210 180
+ p 2 -
+ w 11
j 280 180
+ p 4 1
+ w 11
j 250 180
+ s 5
+ w 11
j 210 140
+ p 13 pin1
+ p 2 +
j 210 140
+ p 13 pin1
+ w 7
j 280 140
+ p 14 pin1
+ p 4 2
j 280 140
+ p 14 pin1
+ w 9
j 260 140
+ p 15 2
+ w 9
j 230 140
+ p 15 1
+ w 7
j 260 140
+ p 16 2
+ p 15 2
j 260 140
+ p 16 2
+ w 9
j 260 170
+ p 16 1
+ w 11
j 260 180
+ w 11
+ w 11
@attributes
a 0 s 0:13 0 0 0 hln 100 PAGETITLE=
a 0 s 0:13 0 0 0 hln 100 PAGENO=1
a 0 s 0:13 0 0 0 hln 100 PAGESIZE=A
a 0 s 0:13 0 0 0 hln 100 PAGECOUNT=1
@graphics
