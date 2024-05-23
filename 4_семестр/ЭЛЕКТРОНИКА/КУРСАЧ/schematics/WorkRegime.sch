*version 9.2 816306657
u 139
@libraries
@analysis
.LIB C:\KP_2021\RUS_Q.LIB
+ C:\KP_2021\Diodes.lib
+ C:\KP_2021\bipolar.lib
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
pageloc 1 0 2387 
@status
n 0 121:04:03:16:58:35;1620050315 e 
s 2832 121:04:03:16:58:39;1620050319 e 
*page 1 0 1520 970 iB
@ports
port 79 EGND 560 350 h
@parts
part 117 VDC 500 340 u
a 1 u 13 0 -19 266 hcn 100 DC=36V
a 0 sp 0 0 22 37 hln 100 PART=VDC
a 0 x 0:13 0 0 0 hln 100 PKGREF=Eñì
a 1 xp 9 0 -8 33 hcn 100 REFDES=Eñì
part 74 r 500 280 v
a 0 u 13 0 201 29 hln 100 VALUE=1600
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=Rá
a 0 xp 9 0 31 24 hln 100 REFDES=Rá
part 76 r 560 340 v
a 0 x 0:13 0 0 0 hln 100 PKGREF=Rý
a 0 xp 9 0 33 30 hln 100 REFDES=Rý
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 u 13 0 263 41 hln 100 VALUE=540
part 114 r 640 250 v
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=Rê
a 0 xp 9 0 31 22 hln 100 REFDES=Rê
a 0 u 13 0 123 31 hln 100 VALUE=560
part 78 VDC 640 340 u
a 0 x 0:13 0 0 0 hln 100 PKGREF=Eïèò
a 0 sp 0 0 22 37 hln 100 PART=VDC
a 1 xp 9 0 -8 33 hcn 100 REFDES=Eïèò
a 1 u 13 0 -21 208 hcn 100 DC=36V
part 65 QbreakP 540 240 h
a 0 xp 9 0 9 -141 hln 100 REFDES=Q
a 0 x 0:13 0 0 0 hln 100 PKGREF=Q
a 0 sp 13 0 21 28 hln 100 MODEL=KT814V
part 1 titleblk 1520 970 h
a 1 s 13 0 350 10 hcn 100 PAGESIZE=B
a 1 s 13 0 180 60 hcn 100 PAGETITLE=
a 1 s 13 0 300 95 hrn 100 PAGENO=1
a 1 s 13 0 340 95 hrn 100 PAGECOUNT=1
@conn
w 60
s 500 300 500 280 95
w 122
s 560 300 560 260 120
w 116
s 640 250 640 300 136
w 108
a 0 sr 0 0 0 0 hln 100 LABEL=Ê
s 560 210 560 220 105
a 0 sr 3 0 556 209 hln 100 LABEL=Ê
s 640 210 560 210 104
a 0 up 33 0 630 209 hct 100 V=
w 36
a 0 sr 0:3 0 548 321 hln 100 LABEL=Ý
s 560 340 560 350 118
a 0 sr 3 0 552 263 hln 100 LABEL=Ý
s 500 340 500 350 14
s 500 350 560 350 18
a 0 up 33 0 510 349 hct 100 V=
s 560 350 640 350 20
s 640 350 640 340 4
w 52
a 0 sr 0 0 0 0 hln 100 LABEL=Á
s 500 240 540 240 96
a 0 sr 3 0 540 236 hcn 100 LABEL=Á
a 0 up 33 0 495 239 hct 100 V=
@junction
j 500 240
+ p 74 2
+ w 52
j 540 240
+ p 65 b
+ w 52
j 500 280
+ p 74 1
+ w 60
j 560 350
+ s 79
+ w 36
j 560 340
+ p 76 1
+ w 36
j 560 300
+ p 76 2
+ w 122
j 560 260
+ p 65 e
+ w 122
j 500 300
+ p 117 -
+ w 60
j 500 340
+ p 117 +
+ w 36
j 640 340
+ p 78 +
+ w 36
j 640 210
+ p 114 2
+ w 108
j 560 220
+ p 65 c
+ w 108
j 640 250
+ p 114 1
+ w 116
j 640 300
+ p 78 -
+ w 116
@attributes
a 0 s 0:13 0 0 0 hln 100 PAGETITLE=
a 0 s 0:13 0 0 0 hln 100 PAGENO=1
a 0 s 0:13 0 0 0 hln 100 PAGESIZE=B
a 0 s 0:13 0 0 0 hln 100 PAGECOUNT=1
@graphics
