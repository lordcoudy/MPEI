*version 9.2 313797100
u 187
R? 11
V? 2
@libraries
@analysis
.LIB C:\KP_2021\bipolar.lib
+ C:\KP_2021\Diodes.lib
+ C:\KP_2021\RUS_Q.LIB
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
pageloc 1 0 2749 
@status
n 0 121:04:08:14:32:37;1620473557 e 
s 0 121:04:08:14:32:40;1620473560 e 
c 121:04:08:14:33:47;1620473627
*page 1 0 1520 970 iB
@ports
port 100 GND_ANALOG 130 170 h
@parts
part 27 R 90 60 v
a 0 u 13 0 15 25 hln 100 VALUE=1200
a 0 x 0:13 0 0 0 hln 100 PKGREF=R1
a 0 xp 9 0 11 -2 hln 100 REFDES=R1
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
part 26 R 90 140 v
a 0 u 13 0 15 25 hln 100 VALUE=220
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R2
a 0 ap 9 0 15 0 hln 100 REFDES=R2
part 50 R 130 160 v
a 0 u 13 0 15 25 hln 100 VALUE=190
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=R4
a 0 xp 9 0 15 0 hln 100 REFDES=R4
part 52 R 130 60 v
a 0 x 0:13 0 0 0 hln 100 PKGREF=R3
a 0 xp 9 0 15 0 hln 100 REFDES=R3
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 u 13 0 15 25 hln 100 VALUE=560
part 22 VDC 190 105 u
a 1 u 13 0 23 29 hcn 100 DC=24
a 0 sp 0 0 22 37 hln 100 PART=VDC
a 0 x 0:13 0 0 0 hln 100 PKGREF=V1
a 1 xp 9 0 26 19 hcn 100 REFDES=V1
part 21 QbreakP 110 90 h
a 0 x 0:13 0 0 0 hln 100 PKGREF=Q
a 0 xp 9 0 5 5 hln 100 REFDES=Q
a 0 sp 13 0 5 40 hln 100 MODEL=KT814V
part 1 titleblk 1520 970 h
a 1 s 13 0 350 10 hcn 100 PAGESIZE=B
a 1 s 13 0 180 60 hcn 100 PAGETITLE=
a 1 s 13 0 300 95 hrn 100 PAGENO=1
a 1 s 13 0 340 95 hrn 100 PAGECOUNT=1
@conn
w 32
a 0 up 0:33 0 0 0 hln 100 V=
s 90 170 90 140 37
s 90 170 130 170 14
s 130 170 190 170 10
s 190 170 190 105 12
a 0 up 0:33 0 192 137 hlt 100 V=
s 130 160 130 170 64
w 56
a 0 up 0:33 0 0 0 hln 100 V=
s 90 20 130 20 55
s 130 20 190 20 57
a 0 up 0:33 0 210 37 hct 100 V=
s 190 20 190 65 58
w 63
a 0 up 0:33 0 0 0 hln 100 V=
a 0 sr 0 0 0 0 hln 100 LABEL=Ý
s 130 110 130 120 62
a 0 up 33 0 140 117 hlt 100 V=
a 0 sr 3 0 122 121 hln 100 LABEL=Ý
w 61
a 0 up 0:33 0 0 0 hln 100 V=
a 0 sr 0 0 0 0 hln 100 LABEL=Ê
s 130 60 130 70 60
a 0 up 33 0 140 67 hlt 100 V=
a 0 sr 3 0 122 65 hln 100 LABEL=Ê
w 17
a 0 up 0:33 0 0 0 hln 100 V=
a 0 sr 0 0 0 0 hln 100 LABEL=Á
s 90 90 110 90 18
a 0 sr 3 0 110 88 hcn 100 LABEL=Á
s 90 90 90 100 30
s 90 60 90 90 28
a 0 up 0:33 0 56 71 hlt 100 V=
@junction
j 130 60
+ p 52 1
+ w 61
j 90 90
+ w 17
+ w 17
j 130 20
+ p 52 2
+ w 56
j 90 60
+ p 27 1
+ w 17
j 90 20
+ p 27 2
+ w 56
j 130 170
+ s 100
+ w 32
j 190 105
+ p 22 +
+ w 32
j 190 65
+ p 22 -
+ w 56
j 130 120
+ p 50 2
+ w 63
j 130 160
+ p 50 1
+ w 32
j 90 100
+ p 26 2
+ w 17
j 90 140
+ p 26 1
+ w 32
j 110 90
+ p 21 b
+ w 17
j 130 70
+ p 21 c
+ w 61
j 130 110
+ p 21 e
+ w 63
@attributes
a 0 s 0:13 0 0 0 hln 100 PAGETITLE=
a 0 s 0:13 0 0 0 hln 100 PAGENO=1
a 0 s 0:13 0 0 0 hln 100 PAGESIZE=B
a 0 s 0:13 0 0 0 hln 100 PAGECOUNT=1
@graphics
