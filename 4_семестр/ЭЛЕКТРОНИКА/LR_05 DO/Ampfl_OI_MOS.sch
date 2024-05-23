*version 9.2 3239523091
u 257
M? 3
R? 7
V? 3
C? 5
PM? 5
? 6
@libraries
@analysis
.AC 0 3 0
+0 101
+1 10
+2 100k
.TRAN 1 0 0 0
+0 20ns
+1 2m
+3 20u
.STEP 1 0 4
+ 0 ampl
+ 4 -4
+ 5 4
+ 6 0.2
.OP 0 
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
pageloc 1 0 5412 
@status
n 0 121:03:05:19:50:46;1617641446 e 
s 2833 121:03:05:19:50:47;1617641447 e 
c 121:03:07:17:44:06;1617806646
*page 1 0 970 720 iA
@ports
port 8 EGND 400 325 h
@parts
part 5 R 400 220 v
a 0 u 13 0 25 35 hln 100 VALUE=1k
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R3
a 0 ap 9 0 40 35 hln 100 REFDES=R3
part 70 R 465 285 v
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R5
a 0 ap 9 0 0 40 hln 100 REFDES=R5
a 0 u 13 0 -15 45 hln 100 VALUE=100k
part 118 MbreakN3 370 240 h
a 0 sp 13 0 -30 116 hln 100 MODEL=Mbreakn
a 0 a 0:13 0 0 0 hln 100 PKGREF=M2
a 0 ap 9 0 -5 0 hln 100 REFDES=M2
part 139 PARAM 255 165 h
a 0 u 13 0 0 20 hln 100 NAME1=ampl
a 0 u 13 0 50 22 hlb 100 VALUE1=100m
a 0 a 0:13 0 0 0 hln 100 PKGREF=PM4
a 1 ap 0 0 10 -2 hcn 100 REFDES=PM4
part 89 VSIN 305 265 h
a 1 u 0 0 0 0 hcn 100 FREQ=1k
a 0 a 0:13 0 0 0 hln 100 PKGREF=V2
a 1 ap 9 0 20 10 hcn 100 REFDES=V2
a 1 u 0 0 0 0 hcn 100 AC=1
a 1 u 0 0 0 0 hcn 100 VOFF=0
a 1 u 0 0 0 0 hcn 100 VAMPL={ampl}
part 3 R 360 220 v
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R1
a 0 ap 9 0 25 0 hln 100 REFDES=R1
a 0 u 13 0 11 -2 hln 100 VALUE=1k
part 65 C 320 250 h
a 0 sp 0 0 0 10 hlb 100 PART=C
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=C1
a 0 xp 9 0 3 0 hln 100 REFDES=C1
a 0 u 13 0 3 25 hln 100 VALUE=15n
part 6 R 400 310 v
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R4
a 0 ap 9 0 15 0 hln 100 REFDES=R4
a 0 u 13 0 5 -1 hln 100 VALUE=1k
part 4 R 360 305 v
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R2
a 0 ap 9 0 15 0 hln 100 REFDES=R2
a 0 u 13 0 4 -2 hln 100 VALUE=1k
part 64 C 420 220 h
a 0 sp 0 0 0 10 hlb 100 PART=C
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=C2
a 0 xp 9 0 15 0 hln 100 REFDES=C2
a 0 u 13 0 9 26 hln 100 VALUE=2u
part 105 C 430 305 v
a 0 sp 0 0 0 10 hlb 100 PART=C
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=C3
a 0 u 13 0 1 36 hln 100 VALUE=33u
a 0 ap 9 0 15 34 hln 100 REFDES=C3
part 123 C 510 270 v
a 0 sp 0 0 0 10 hlb 100 PART=C
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=C4
a 0 ap 9 0 -5 33 hln 100 REFDES=C4
a 0 u 13 0 -17 32 hln 100 VALUE=1n
part 7 VDC 540 225 h
a 0 sp 0 0 22 37 hln 100 PART=VDC
a 0 a 0:13 0 0 0 hln 100 PKGREF=V1
a 1 ap 9 0 -2 -7 hcn 100 REFDES=V1
a 1 u 13 0 -2 -19 hcn 100 DC=15
part 1 titleblk 970 720 h
a 1 s 13 0 350 10 hcn 100 PAGESIZE=A
a 1 s 13 0 180 60 hcn 100 PAGETITLE=
a 1 s 13 0 340 95 hrn 100 PAGECOUNT=1
a 1 s 13 0 300 95 hrn 100 PAGENO=1
part 136 nodeMarker 465 220 h
a 0 s 0 0 0 0 hln 100 PROBEVAR=1
a 0 s 0 0 0 0 hln 100 PROBEVAR=
a 0 a 0 0 4 22 hlb 100 LABEL=4
@conn
w 69
a 0 up 0:33 0 0 0 hln 100 V=
s 400 220 420 220 68
a 0 up 33 0 365 204 hct 100 V=
w 171
a 0 up 0:33 0 0 0 hln 100 V=
s 400 270 400 260 216
s 430 270 400 270 210
s 430 275 430 270 208
a 0 up 33 0 357 275 hlt 100 V=
w 10
a 0 up 0:33 0 0 0 hln 100 V=
s 400 180 400 165 30
s 540 165 540 225 13
s 400 165 540 165 47
s 360 165 400 165 29
a 0 up 33 0 505 151 hct 100 V=
s 360 180 360 165 9
w 244
a 0 up 0:33 0 0 0 hln 100 V=
s 430 325 400 325 218
s 400 310 400 325 237
s 430 305 430 325 110
s 465 325 430 325 112
s 465 285 465 325 84
s 510 325 465 325 131
s 510 270 510 325 129
s 540 325 510 325 77
a 0 up 0:33 0 470 324 hct 100 V=
s 540 265 540 325 17
s 400 325 360 325 155
a 0 up 0:33 0 362 324 hct 100 V=
s 360 325 305 325 250
s 360 325 360 305 22
s 305 305 305 325 94
w 91
a 0 up 0:33 0 0 0 hln 100 V=
s 305 250 305 265 92
a 0 up 0:33 0 307 257 hlt 100 V=
s 320 250 305 250 90
w 25
a 0 up 0:33 0 0 0 hln 100 V=
s 370 250 360 250 43
s 360 250 350 250 255
s 360 250 360 265 45
s 360 220 360 250 24
a 0 up 33 0 377 235 hlt 100 V=
w 73
a 0 sr 0 0 0 0 hln 100 LABEL=1
a 0 up 0:33 0 0 0 hln 100 V=
s 465 220 510 220 169
a 0 up 33 0 490 219 hct 100 V=
a 0 sr 3 0 490 218 hcn 100 LABEL=1
s 450 220 465 220 126
s 510 220 510 240 127
s 465 245 465 220 167
@junction
j 400 180
+ p 5 2
+ w 10
j 400 220
+ p 5 1
+ w 69
j 400 220
+ p 118 d
+ p 5 1
j 400 220
+ p 118 d
+ w 69
j 370 250
+ p 118 g
+ w 25
j 540 225
+ p 7 +
+ w 10
j 510 240
+ p 123 2
+ w 73
j 420 220
+ p 64 1
+ w 69
j 450 220
+ p 64 2
+ w 73
j 465 245
+ p 70 2
+ w 73
j 465 220
+ w 73
+ w 73
j 400 260
+ p 118 s
+ w 171
j 430 275
+ p 105 2
+ w 171
j 400 270
+ p 6 2
+ w 171
j 400 310
+ p 6 1
+ w 244
j 430 305
+ p 105 1
+ w 244
j 400 325
+ w 244
+ w 244
j 465 285
+ p 70 1
+ w 244
j 430 325
+ w 244
+ w 244
j 510 270
+ p 123 1
+ w 244
j 540 265
+ p 7 -
+ w 244
j 465 325
+ w 244
+ w 244
j 510 325
+ w 244
+ w 244
j 400 325
+ s 8
+ w 244
j 350 250
+ p 65 2
+ w 25
j 400 165
+ w 10
+ w 10
j 360 305
+ p 4 1
+ w 244
j 360 325
+ w 244
+ w 244
j 305 305
+ p 89 -
+ w 244
j 305 265
+ p 89 +
+ w 91
j 320 250
+ p 65 1
+ w 91
j 360 180
+ p 3 2
+ w 10
j 360 265
+ p 4 2
+ w 25
j 360 250
+ w 25
+ w 25
j 360 220
+ p 3 1
+ w 25
j 465 220
+ p 136 pin1
+ w 73
@attributes
a 0 s 0:13 0 0 0 hln 100 PAGETITLE=
a 0 s 0:13 0 0 0 hln 100 PAGENO=1
a 0 s 0:13 0 0 0 hln 100 PAGESIZE=A
a 0 s 0:13 0 0 0 hln 100 PAGECOUNT=1
@graphics
