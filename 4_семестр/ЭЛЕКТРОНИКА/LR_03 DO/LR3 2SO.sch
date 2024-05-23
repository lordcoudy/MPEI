*version 9.2 3742069229
u 36
D? 3
I? 2
? 4
R? 2
V? 2
@libraries
@analysis
.DC 0 0 0 0 1 1
+ 0 0 v1
+ 0 4 -7.05
+ 0 5 7.05
+ 0 6 0.1
.TRAN 1 0 0 0
+0 10ns
+1 2m
+3 3u
.OP 0 
.LIB C:\Diodes.lib
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
pageloc 1 0 1783 
@status
n 0 121:02:22:15:50:40;1616417440 e 
s 2832 121:02:22:15:50:44;1616417444 e 
c 121:02:22:15:50:37;1616417437
*page 1 0 970 720 iA
@ports
port 33 EGND 65 115 h
@parts
part 19 R 50 60 h
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R1
a 0 ap 9 0 15 0 hln 100 REFDES=R1
a 0 u 13 0 15 25 hln 100 VALUE=1040
part 17 DbreakZ 90 60 d
a 0 x 0:13 0 0 0 hln 100 PKGREF=D1
a 0 xp 9 0 -5 -16 hln 100 REFDES=D1
a 0 sp 13 0 23 -5 hln 100 MODEL=KS147
part 18 DbreakZ 90 115 v
a 0 x 0:13 0 0 0 hln 100 PKGREF=D2
a 0 xp 9 0 17 32 hln 100 REFDES=D2
a 0 sp 13 0 21 65 hln 100 MODEL=KS147
part 22 VSIN 45 65 h
a 0 a 0:13 0 0 0 hln 100 PKGREF=V1
a 1 ap 9 0 -8 2 hcn 100 REFDES=V1
a 1 u 0 0 0 0 hcn 100 AC=0
a 1 u 0 0 0 0 hcn 100 VOFF=0
a 1 u 0 0 0 0 hcn 100 FREQ=1k
a 1 u 0 0 0 0 hcn 100 DC=0
a 1 u 0 0 0 0 hcn 100 VAMPL=7.05
part 1 titleblk 970 720 h
a 1 s 13 0 350 10 hcn 100 PAGESIZE=A
a 1 s 13 0 180 60 hcn 100 PAGETITLE=
a 1 s 13 0 340 95 hrn 100 PAGECOUNT=1
a 1 s 13 0 300 95 hrn 100 PAGENO=1
part 31 nodeMarker 90 60 h
a 0 s 0 0 0 0 hln 100 PROBEVAR=
a 0 s 0 0 0 0 hln 100 PROBEVAR=
a 0 a 0 0 4 22 hlb 100 LABEL=2
part 35 nodeMarker 45 60 h
a 0 s 0 0 0 0 hln 100 PROBEVAR=
a 0 s 0 0 0 0 hln 100 PROBEVAR=
a 0 a 0 0 4 22 hlb 100 LABEL=3
@conn
w 21
s 90 90 90 85 20
w 28
s 45 105 45 115 27
s 45 115 65 115 29
s 65 115 90 115 34
w 24
s 45 65 45 60 23
s 45 60 50 60 25
@junction
j 45 65
+ p 22 +
+ w 24
j 50 60
+ p 19 1
+ w 24
j 45 105
+ p 22 -
+ w 28
j 90 60
+ p 31 pin1
+ p 19 2
j 65 115
+ s 33
+ w 28
j 90 60
+ p 17 1
+ p 19 2
j 90 90
+ p 17 2
+ w 21
j 90 60
+ p 31 pin1
+ p 17 1
j 90 85
+ p 18 2
+ w 21
j 90 115
+ p 18 1
+ w 28
j 45 60
+ p 35 pin1
+ w 24
@attributes
a 0 s 0:13 0 0 0 hln 100 PAGETITLE=
a 0 s 0:13 0 0 0 hln 100 PAGENO=1
a 0 s 0:13 0 0 0 hln 100 PAGESIZE=A
a 0 s 0:13 0 0 0 hln 100 PAGECOUNT=1
@graphics
