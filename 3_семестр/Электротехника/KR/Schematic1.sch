*version 9.2 2016661988
u 52
V? 2
I? 4
R? 6
L? 2
C? 2
PRINT? 5
@libraries
@analysis
.AC 1 1 0
+0 2
+1 318.31
+2 1500
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
pageloc 1 0 4937 
@status
n 0 120:09:29:15:11:53;1603973513 e 
s 2832 120:09:29:15:11:57;1603973517 e 
*page 1 0 1520 970 iB
@ports
port 11 AGND 320 330 h
@parts
part 4 R 180 260 v
a 0 u 13 0 1 27 hln 100 VALUE=700
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R1
a 0 ap 9 0 15 0 hln 100 REFDES=R1
part 5 R 330 260 v
a 0 u 13 0 15 25 hln 100 VALUE=700
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R2
a 0 ap 9 0 15 0 hln 100 REFDES=R2
part 9 l 200 190 h
a 0 sp 0 0 0 10 hlb 100 PART=l
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=L2012C
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=L1
a 0 ap 9 0 15 0 hln 100 REFDES=L1
a 0 u 13 0 15 25 hln 100 VALUE=0.105
part 10 c 350 260 h
a 0 u 13 0 15 25 hln 100 VALUE=0.495uF
a 0 sp 0 0 0 10 hlb 100 PART=c
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=C1
a 0 ap 9 0 15 0 hln 100 REFDES=C1
part 6 R 400 260 v
a 0 u 13 0 15 25 hln 100 VALUE=300
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R3
a 0 ap 9 0 15 0 hln 100 REFDES=R3
part 12 VPRINT1 280 190 h
a 0 u 0 0 0 30 hcn 100 AC=y
a 0 u 0 0 0 20 hlb 100 MAG=y
a 0 u 0 0 0 30 hlb 100 PHASE=y
a 0 u 0 0 0 40 hlb 100 REAL=y
a 0 u 0 0 0 50 hlb 100 IMAG=y
a 0 sp 0 0 0 40 hlb 100 PART=VPRINT1
a 0 a 0:13 0 0 0 hln 100 PKGREF=PRINT1
a 0 ap 0 0 30 0 hcn 100 REFDES=PRINT1
part 13 VPRINT1 400 260 d
a 0 u 0 0 0 30 hcn 100 AC=y
a 0 u 0 0 0 20 hlb 100 MAG=y
a 0 u 0 0 0 30 hlb 100 PHASE=y
a 0 u 0 0 0 40 hlb 100 REAL=y
a 0 u 0 0 0 50 hlb 100 IMAG=y
a 0 sp 0 0 0 40 hlb 100 PART=VPRINT1
a 0 a 0:13 0 0 0 hln 100 PKGREF=PRINT2
a 0 ap 0 0 30 0 hcn 100 REFDES=PRINT2
part 15 VPRINT1 280 260 v
a 0 u 0 0 0 30 hcn 100 AC=y
a 0 u 0 0 0 20 hlb 100 MAG=y
a 0 u 0 0 0 30 hlb 100 PHASE=y
a 0 u 0 0 0 40 hlb 100 REAL=y
a 0 u 0 0 0 50 hlb 100 IMAG=y
a 0 sp 0 0 0 40 hlb 100 PART=VPRINT1
a 0 a 0:13 0 0 0 hln 100 PKGREF=PRINT4
a 0 ap 0 0 30 0 hcn 100 REFDES=PRINT4
part 47 IAC 280 220 h
a 0 sp 0:11 0 0 50 hln 100 PART=IAC
a 0 a 0:13 0 0 0 hln 100 PKGREF=I2
a 1 ap 9 0 20 10 hcn 100 REFDES=I2
a 0 u 13 0 -8 22 hcn 100 ACMAG=4mA
part 8 R 280 330 v
a 0 u 13 0 15 25 hln 100 VALUE=400
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R5
a 0 ap 9 0 15 0 hln 100 REFDES=R5
part 7 R 400 330 v
a 0 u 13 0 15 25 hln 100 VALUE=400
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R4
a 0 ap 9 0 15 0 hln 100 REFDES=R4
part 14 VPRINT1 280 330 u
a 0 u 0 0 0 30 hcn 100 AC=y
a 0 u 0 0 0 20 hlb 100 MAG=y
a 0 u 0 0 0 30 hlb 100 PHASE=y
a 0 u 0 0 0 40 hlb 100 REAL=y
a 0 u 0 0 0 50 hlb 100 IMAG=y
a 0 sp 0 0 0 40 hlb 100 PART=VPRINT1
a 0 a 0:13 0 0 0 hln 100 PKGREF=PRINT3
a 0 ap 0 0 30 0 hcn 100 REFDES=PRINT3
part 1 titleblk 1520 970 h
a 1 s 13 0 350 10 hcn 100 PAGESIZE=B
a 1 s 13 0 180 60 hcn 100 PAGETITLE=
a 1 s 13 0 300 95 hrn 100 PAGENO=1
a 1 s 13 0 340 95 hrn 100 PAGECOUNT=1
@conn
w 17
a 0 up 0:33 0 0 0 hln 100 V=
s 180 220 180 190 16
a 0 up 33 0 182 205 hlt 100 V=
s 180 190 200 190 18
w 36
a 0 sr 0 0 0 0 hln 100 LABEL=3
a 0 up 0:33 0 0 0 hln 100 V=
s 400 260 400 290 37
a 0 sr 3 0 402 275 hln 100 LABEL=3
a 0 up 33 0 402 276 hlt 100 V=
s 380 260 400 260 35
w 33
a 0 sr 0 0 0 0 hln 100 LABEL=2
a 0 up 0:33 0 0 0 hln 100 V=
s 280 290 280 260 43
a 0 sr 3 0 282 275 hln 100 LABEL=2
a 0 up 33 0 282 276 hlt 100 V=
s 280 260 330 260 32
s 330 260 350 260 34
w 21
a 0 sr 0 0 0 0 hln 100 LABEL=1
a 0 up 0:33 0 0 0 hln 100 V=
s 280 190 330 190 24
a 0 sr 3 0 287 188 hcn 100 LABEL=1
a 0 up 33 0 287 189 hct 100 V=
s 260 190 280 190 20
s 280 190 280 220 22
s 330 190 330 220 26
s 330 190 400 190 28
s 400 190 400 220 30
w 46
a 0 up 0:33 0 0 0 hln 100 V=
a 0 sr 0 0 0 0 hln 100 LABEL=4
s 280 330 180 330 41
a 0 sr 3 0 272 338 hcn 100 LABEL=4
a 0 up 33 0 272 339 hct 100 V=
s 400 330 320 330 39
s 320 330 280 330 42
s 180 260 180 330 50
a 0 up 33 0 182 275 hlt 100 V=
@junction
j 180 220
+ p 4 2
+ w 17
j 200 190
+ p 9 1
+ w 17
j 260 190
+ p 9 2
+ w 21
j 280 190
+ w 21
+ w 21
j 330 220
+ p 5 2
+ w 21
j 330 190
+ w 21
+ w 21
j 400 220
+ p 6 2
+ w 21
j 400 260
+ p 6 1
+ w 36
j 400 290
+ p 7 2
+ w 36
j 180 260
+ p 4 1
+ w 46
j 280 190
+ p 12 1
+ w 21
j 280 330
+ p 14 1
+ p 8 1
j 380 260
+ p 10 2
+ w 36
j 400 260
+ p 13 1
+ p 6 1
j 400 260
+ p 13 1
+ w 36
j 280 260
+ p 47 -
+ p 15 1
j 280 220
+ p 47 +
+ w 21
j 350 260
+ p 10 1
+ w 33
j 330 260
+ p 5 1
+ w 33
j 280 290
+ p 8 2
+ w 33
j 280 260
+ p 15 1
+ w 33
j 280 260
+ p 47 -
+ w 33
j 280 330
+ p 8 1
+ w 46
j 400 330
+ p 7 1
+ w 46
j 320 330
+ s 11
+ w 46
j 280 330
+ p 14 1
+ w 46
@attributes
a 0 s 0:13 0 0 0 hln 100 PAGETITLE=
a 0 s 0:13 0 0 0 hln 100 PAGENO=1
a 0 s 0:13 0 0 0 hln 100 PAGESIZE=B
a 0 s 0:13 0 0 0 hln 100 PAGECOUNT=1
@graphics
