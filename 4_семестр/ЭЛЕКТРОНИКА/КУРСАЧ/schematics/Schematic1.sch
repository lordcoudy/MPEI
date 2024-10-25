*version 9.2 893491113
u 198
V? 4
C? 5
R? 11
Q? 2
? 54
PM? 3
@libraries
@analysis
.AC 1 3 0
+0 101
+1 10
+2 10Meg
.DC 0 0 0 0 1 1
.TRAN 0 0 0 1
+0 10ns
+1 5ms
+3 1us
+4 5k
+5 V(2)
+6 5
.STEP 1 2 4
+ 0 R7
+ 4 1
+ 5 10k
+ 6 10
.OP 1 
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
pageloc 1 0 6160 
@status
c 121:05:13:21:06:24;1623607584
n 0 121:05:13:21:06:45;1623607605 e 
s 2832 121:05:13:21:06:45;1623607605 e 
*page 1 0 1520 970 iB
@ports
port 70 EGND 280 325 h
@parts
part 6 c 380 275 v
a 0 u 13 0 3 33 hln 100 VALUE=0.7n
a 0 s 0 0 0 10 hlb 100 PART=c
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=C4
a 0 a 9 0 27 28 hln 100 REFDES=C4
part 13 R 350 275 v
a 0 s 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 u 13 0 15 25 hln 100 VALUE={R7}
a 0 x 0:13 0 0 0 hln 100 PKGREF=R7
a 0 x 9 0 33 24 hln 100 REFDES=R7
part 2 VDC 405 240 u
a 0 sp 0 0 22 37 hln 100 PART=VDC
a 1 u 13 0 -5 8 hcn 100 DC=40
a 0 x 0:13 0 0 0 hln 100 PKGREF=V2
a 1 xp 9 0 0 39 hcn 100 REFDES=V2
part 113 R 155 215 h
a 0 u 13 0 15 25 hln 100 VALUE=200
a 0 s 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=R6
a 0 x 9 0 15 0 hln 100 REFDES=R6
part 7 R 230 185 v
a 0 a 9 0 31 28 hln 100 REFDES=R1
a 0 s 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R1
a 0 u 13 0 11 27 hln 100 VALUE=3000
part 8 R 230 300 v
a 0 a 9 0 35 28 hln 100 REFDES=R2
a 0 s 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R2
a 0 u 13 0 3 29 hln 100 VALUE=1000
part 127 R 280 280 v
a 0 s 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=R4
a 0 x 9 0 31 26 hln 100 REFDES=R4
a 0 u 13 0 5 29 hln 100 VALUE=91
part 3 c 195 215 h
a 0 a 9 0 19 4 hln 100 REFDES=C1
a 0 s 0 0 0 10 hlb 100 PART=c
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=C1
a 0 u 13 0 17 23 hln 100 VALUE=1.5u
part 4 c 310 190 h
a 0 s 0 0 0 10 hlb 100 PART=c
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=C2
a 0 a 9 0 19 4 hln 100 REFDES=C2
a 0 u 13 0 15 25 hln 100 VALUE=0.68u
part 14 VSIN 150 235 h
a 1 u 0 0 0 0 hcn 100 VOFF=0
a 1 u 0 0 0 0 hcn 100 VAMPL={Ampl}
a 0 x 0:13 0 0 0 hln 100 PKGREF=V1
a 1 xp 9 0 20 10 hcn 100 REFDES=V1
a 1 u 0 0 0 0 hcn 100 AC=1
a 1 u 0 0 0 0 hcn 100 FREQ=5k
part 97 PARAM 175 160 h
a 0 u 13 0 0 20 hln 100 NAME1=R7
a 0 u 13 0 0 30 hln 100 NAME2=Ampl
a 0 a 0:13 0 0 0 hln 100 PKGREF=PM2
a 1 ap 0 0 10 -2 hcn 100 REFDES=PM2
a 0 u 13 0 50 32 hlb 100 VALUE2=100m
a 0 u 13 0 50 22 hlb 100 VALUE1=5k
part 5 c 305 325 v
a 0 s 0 0 0 10 hlb 100 PART=c
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=C3
a 0 a 9 0 23 24 hln 100 REFDES=C3
a 0 u 13 0 5 41 hln 100 VALUE=15u
part 11 R 280 325 v
a 0 s 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R5
a 0 a 9 0 31 26 hln 100 REFDES=R5
a 0 u 13 0 5 29 hln 100 VALUE=390
part 9 R 280 185 v
a 0 u 13 0 7 27 hln 100 VALUE=430
a 0 a 9 0 29 28 hln 100 REFDES=R3
a 0 s 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R3
part 15 QbreakP 260 215 h
a 0 sp 13 0 15 22 hln 100 MODEL=KT814V
a 0 a 0:13 0 0 0 hln 100 PKGREF=Q1
a 0 ap 9 0 5 5 hln 100 REFDES=Q1
part 1 titleblk 1520 970 h
a 1 s 13 0 350 10 hcn 100 PAGESIZE=B
a 1 s 13 0 180 60 hcn 100 PAGETITLE=
a 1 s 13 0 340 95 hrn 100 PAGECOUNT=1
a 1 s 13 0 300 95 hrn 100 PAGENO=1
part 195 vdb 350 190 h
a 0 s 0 0 0 0 hln 100 PROBEVAR=VDB(2)
a 0 a 0 0 4 22 hlb 100 LABEL=52
@conn
w 21
a 0 up 0:33 0 0 0 hln 100 V=
s 150 275 150 325 20
s 150 325 230 325 22
s 405 325 405 240 26
a 0 up 0:33 0 407 282 hlt 100 V=
s 230 325 280 325 37
s 230 300 230 325 35
s 350 325 380 325 58
s 380 325 405 325 61
s 380 275 380 325 59
s 350 275 350 325 157
a 0 up 0:33 0 352 300 hlt 100 V=
s 280 325 305 325 171
a 0 up 0:33 0 292 324 hct 100 V=
s 305 325 350 325 173
w 140
a 0 up 0:33 0 0 0 hln 100 V=
s 280 240 280 235 147
a 0 up 33 0 300 247 hlt 100 V=
w 142
a 0 up 0:33 0 0 0 hln 100 V=
s 280 285 305 285 143
a 0 up 0:33 0 292 284 hct 100 V=
s 305 285 305 295 145
s 280 280 280 285 149
w 29
a 0 up 0:33 0 0 0 hln 100 V=
s 280 145 230 145 172
s 405 200 405 145 28
s 405 145 280 145 170
a 0 up 0:33 0 354 132 hct 100 V=
w 17
a 0 up 0:33 0 0 0 hln 100 V=
a 0 sr 0 0 0 0 hln 100 LABEL=1
s 150 215 150 235 18
a 0 up 0:33 0 152 225 hlt 100 V=
a 0 sr 3 0 152 225 hln 100 LABEL=1
s 155 215 150 215 116
w 34
a 0 up 0:33 0 0 0 hln 100 V=
a 0 sr 0 0 0 0 hln 100 LABEL=4
s 230 215 260 215 41
a 0 sr 3 0 245 213 hcn 100 LABEL=4
s 230 185 230 215 33
s 230 215 230 260 40
a 0 up 33 0 234 219 hlt 100 V=
s 225 215 230 215 38
w 44
a 0 up 0:33 0 0 0 hln 100 V=
a 0 sr 0 0 0 0 hln 100 LABEL=3
s 280 190 310 190 45
a 0 sr 3 0 295 188 hcn 100 LABEL=3
a 0 up 33 0 315 149 hct 100 V=
s 280 195 280 190 43
s 280 190 280 185 47
w 49
a 0 up 0:33 0 0 0 hln 100 V=
a 0 sr 0 0 0 0 hln 100 LABEL=2
s 340 190 350 190 48
a 0 sr 3 0 345 188 hcn 100 LABEL=2
s 380 190 380 245 54
a 0 up 0:33 0 382 217 hlt 100 V=
s 350 190 350 235 98
s 350 190 380 190 196
@junction
j 350 190
+ w 49
+ w 49
j 380 245
+ p 6 2
+ w 49
j 230 215
+ w 34
+ w 34
j 260 215
+ p 15 b
+ w 34
j 280 190
+ w 44
+ w 44
j 280 195
+ p 15 c
+ w 44
j 280 235
+ p 15 e
+ w 140
j 280 280
+ p 127 1
+ w 142
j 280 240
+ p 127 2
+ w 140
j 280 325
+ p 11 1
+ s 70
j 280 285
+ p 11 2
+ w 142
j 405 200
+ p 2 -
+ w 29
j 350 235
+ p 13 2
+ w 49
j 155 215
+ p 113 1
+ w 17
j 405 240
+ p 2 +
+ w 21
j 230 325
+ w 21
+ w 21
j 350 325
+ w 21
+ w 21
j 380 325
+ w 21
+ w 21
j 280 325
+ s 70
+ w 21
j 380 275
+ p 6 1
+ w 21
j 280 325
+ p 11 1
+ w 21
j 350 275
+ p 13 1
+ w 21
j 305 295
+ p 5 2
+ w 142
j 305 325
+ p 5 1
+ w 21
j 150 235
+ p 14 +
+ w 17
j 150 275
+ p 14 -
+ w 21
j 230 145
+ p 7 2
+ w 29
j 230 185
+ p 7 1
+ w 34
j 230 260
+ p 8 2
+ w 34
j 230 300
+ p 8 1
+ w 21
j 195 215
+ p 3 1
+ p 113 2
j 225 215
+ p 3 2
+ w 34
j 310 190
+ p 4 1
+ w 44
j 340 190
+ p 4 2
+ w 49
j 280 145
+ p 9 2
+ w 29
j 280 185
+ p 9 1
+ w 44
j 350 190
+ p 195 pin1
+ w 49
@attributes
a 0 s 0:13 0 0 0 hln 100 PAGETITLE=
a 0 s 0:13 0 0 0 hln 100 PAGENO=1
a 0 s 0:13 0 0 0 hln 100 PAGESIZE=B
a 0 s 0:13 0 0 0 hln 100 PAGECOUNT=1
@graphics
