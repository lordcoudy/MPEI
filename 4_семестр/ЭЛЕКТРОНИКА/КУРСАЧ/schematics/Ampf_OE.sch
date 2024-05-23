*version 9.2 662671701
u 1073
M? 2
V? 11
? 43
J? 2
I? 2
Q? 11
R? 29
C? 25
PM? 9
@libraries
@analysis
.AC 0 3 0
+0 101
+1 10
+2 3meg
.DC 0 0 0 0 0 2
+ 0 0 v3
+ 0 4 -2
+ 0 5 5
+ 0 6 0.01
+ 1 0 i1
+ 1 4 20u
+ 1 5 200u
+ 1 6 20u
+ 1 7 0 5 10
.TRAN 0 0 0 0
+0 20ns
+1 188u
+2 62u
+3 2u
.STEP 0 0 4
+ 0 RL
+ 4 10
+ 5 10k
+ 6 20
+ -1 1 1k
.OP 1 
.PROBE 0 0 1 1 0 2
.LIB C:\KP_2021\bipolar.lib
+ C:\KP_2021\RUS_Q.LIB
+ C:\KP_2021\Diodes.lib
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
pageloc 1 0 5982 
@status
n 0 121:05:10:12:20:51;1623316851 e 
s 2832 121:05:10:12:20:51;1623316851 e 
c 121:05:10:12:19:57;1623316797
*page 1 0 970 720 iA
@ports
port 1071 EGND 285 195 h
@parts
part 999 c 410 165 v
a 0 sp 0 0 0 10 hlb 100 PART=c
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=C23
a 0 ap 9 0 15 0 hln 100 REFDES=C23
a 0 u 13 0 15 25 hln 100 VALUE=0.9n
part 1068 PARAM 170 25 h
a 0 a 0:13 0 0 0 hln 100 PKGREF=PM8
a 1 ap 0 0 10 -2 hcn 100 REFDES=PM8
a 0 u 13 0 0 20 hln 100 NAME1=Ampl
a 0 u 13 0 0 30 hln 100 NAME2=R7
a 0 u 13 0 50 22 hlb 100 VALUE1=100m
a 0 u 13 0 50 32 hlb 100 VALUE2=2k
part 1000 c 310 185 v
a 0 sp 0 0 0 10 hlb 100 PART=c
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 u 13 0 15 25 hln 100 VALUE=15u
a 0 x 0:13 0 0 0 hln 100 PKGREF=C3
a 0 xp 9 0 15 0 hln 100 REFDES=C3
part 998 c 315 85 h
a 0 sp 0 0 0 10 hlb 100 PART=c
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 u 13 0 15 25 hln 100 VALUE=0.39u
a 0 x 0:13 0 0 0 hln 100 PKGREF=C2
a 0 xp 9 0 15 0 hln 100 REFDES=C2
part 997 c 175 105 h
a 0 sp 0 0 0 10 hlb 100 PART=c
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=CK05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 u 13 0 15 25 hln 100 VALUE=0.39u
a 0 x 0:13 0 0 0 hln 100 PKGREF=C1
a 0 xp 9 0 15 0 hln 100 REFDES=C1
part 996 R 130 105 h
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 u 13 0 15 25 hln 100 VALUE=200
a 0 x 0:13 0 0 0 hln 100 PKGREF=R6
a 0 xp 9 0 15 0 hln 100 REFDES=R6
part 991 R 285 75 v
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 u 13 0 15 25 hln 100 VALUE=680
a 0 x 0:13 0 0 0 hln 100 PKGREF=R3
a 0 xp 9 0 15 0 hln 100 REFDES=R3
part 992 R 285 195 v
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 u 13 0 15 25 hln 100 VALUE=390
a 0 x 0:13 0 0 0 hln 100 PKGREF=R4
a 0 xp 9 0 15 0 hln 100 REFDES=R4
part 995 R 235 195 v
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 u 13 0 15 25 hln 100 VALUE=4300
a 0 x 0:13 0 0 0 hln 100 PKGREF=R2
a 0 xp 9 0 15 0 hln 100 REFDES=R2
part 990 QbreakP 265 105 h
a 0 x 0:13 0 0 0 hln 100 PKGREF=Q
a 0 xp 9 0 5 5 hln 100 REFDES=Q
a 0 sp 13 0 19 18 hln 100 MODEL=KT361g
part 994 R 235 75 v
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 u 13 0 15 25 hln 100 VALUE=11k
a 0 x 0:13 0 0 0 hln 100 PKGREF=R1
a 0 xp 9 0 15 0 hln 100 REFDES=R1
part 1001 VDC 455 125 u
a 0 sp 0 0 22 37 hln 100 PART=VDC
a 1 u 13 0 -11 18 hcn 100 DC=20V
a 0 x 0:13 0 0 0 hln 100 PKGREF=V2
a 1 xp 9 0 24 7 hcn 100 REFDES=V2
part 993 R 375 175 v
a 0 sp 0 0 0 10 hlb 100 PART=R
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 u 13 0 15 25 hln 100 VALUE={R7}
a 0 x 0:13 0 0 0 hln 100 PKGREF=R7
a 0 xp 9 0 15 0 hln 100 REFDES=R7
part 1002 VSIN 130 135 h
a 1 u 0 0 0 0 hcn 100 AC=1
a 1 u 0 0 0 0 hcn 100 VOFF=0
a 1 u 0 0 0 0 hcn 100 VAMPL={Ampl}
a 1 u 0 0 0 0 hcn 100 FREQ=5k
a 0 x 0:13 0 0 0 hln 100 PKGREF=V1
a 1 xp 9 0 20 10 hcn 100 REFDES=V1
part 1 titleblk 970 720 h
a 1 s 13 0 350 10 hcn 100 PAGESIZE=A
a 1 s 13 0 180 60 hcn 100 PAGETITLE=
a 1 s 13 0 340 95 hrn 100 PAGECOUNT=1
a 1 s 13 0 300 95 hrn 100 PAGENO=1
part 1069 nodeMarker 375 85 h
a 0 s 0 0 0 0 hln 100 PROBEVAR=
a 0 a 0 0 4 22 hlb 100 LABEL=41
part 1070 nodeMarker 130 105 h
a 0 s 0 0 0 0 hln 100 PROBEVAR=
a 0 a 0 0 4 22 hlb 100 LABEL=42
@conn
w 1006
a 0 up 0:33 0 0 0 hln 100 V=
s 170 105 175 105 1005
a 0 up 0:33 0 172 104 hct 100 V=
w 1004
a 0 sr 0 0 0 0 hln 100 LABEL=1
a 0 up 0:33 0 0 0 hln 100 V=
s 130 135 130 105 1003
a 0 sr 3 0 132 120 hln 100 LABEL=1
a 0 up 0:33 0 132 121 hlt 100 V=
w 1020
a 0 up 0:33 0 0 0 hln 100 V=
s 130 175 130 195 1019
s 235 195 285 195 1014
s 285 195 310 195 1016
s 455 195 455 125 1017
s 130 195 235 195 1021
a 0 up 0:33 0 182 194 hct 100 V=
s 310 195 375 195 1038
s 310 185 310 195 1036
s 375 195 410 195 1047
s 375 175 375 195 1045
s 410 195 455 195 1050
s 410 165 410 195 1048
w 1060
a 0 sr 0 0 0 0 hln 100 LABEL=2
a 0 up 0:33 0 0 0 hln 100 V=
s 345 85 375 85 1041
a 0 sr 3 0 360 83 hcn 100 LABEL=2
a 0 up 0:33 0 360 84 hct 100 V=
s 375 85 375 135 1062
s 410 135 410 85 1051
s 410 85 375 85 1053
w 1029
a 0 up 0:33 0 0 0 hln 100 V=
s 285 75 285 85 1028
s 315 85 285 85 1058
a 0 up 33 0 316 48 hct 100 V=
w 1031
a 0 up 0:33 0 0 0 hln 100 V=
s 285 125 285 155 1030
a 0 up 33 0 299 134 hlt 100 V=
s 310 155 285 155 1032
w 1008
a 0 up 0:33 0 0 0 hln 100 V=
s 205 105 235 105 1007
s 235 105 265 105 1011
s 235 75 235 105 1009
s 235 105 235 155 1012
a 0 up 33 0 241 112 hlt 100 V=
w 1024
a 0 up 0:33 0 0 0 hln 100 V=
s 235 35 285 35 1023
s 285 35 455 35 1025
a 0 up 0:33 0 370 34 hct 100 V=
s 455 35 455 85 1026
@junction
j 130 105
+ p 996 1
+ w 1004
j 130 135
+ p 1002 +
+ w 1004
j 175 105
+ p 997 1
+ w 1006
j 170 105
+ p 996 2
+ w 1006
j 265 105
+ p 990 b
+ w 1008
j 205 105
+ p 997 2
+ w 1008
j 235 75
+ p 994 1
+ w 1008
j 235 105
+ w 1008
+ w 1008
j 235 155
+ p 995 2
+ w 1008
j 285 35
+ p 991 2
+ w 1024
j 235 35
+ p 994 2
+ w 1024
j 455 85
+ p 1001 -
+ w 1024
j 285 85
+ p 990 c
+ w 1029
j 285 75
+ p 991 1
+ w 1029
j 285 155
+ p 992 2
+ w 1031
j 285 125
+ p 990 e
+ w 1031
j 310 155
+ p 1000 2
+ w 1031
j 345 85
+ p 998 2
+ w 1060
j 315 85
+ p 998 1
+ w 1029
j 375 135
+ p 993 2
+ w 1060
j 410 135
+ p 999 2
+ w 1060
j 375 85
+ w 1060
+ w 1060
j 375 85
+ p 1069 pin1
+ w 1060
j 130 105
+ p 1070 pin1
+ p 996 1
j 130 105
+ p 1070 pin1
+ w 1004
j 285 195
+ s 1071
+ p 992 1
j 130 175
+ p 1002 -
+ w 1020
j 285 195
+ p 992 1
+ w 1020
j 235 195
+ p 995 1
+ w 1020
j 455 125
+ p 1001 +
+ w 1020
j 310 185
+ p 1000 1
+ w 1020
j 310 195
+ w 1020
+ w 1020
j 375 175
+ p 993 1
+ w 1020
j 375 195
+ w 1020
+ w 1020
j 410 165
+ p 999 1
+ w 1020
j 410 195
+ w 1020
+ w 1020
j 285 195
+ s 1071
+ w 1020
@attributes
a 0 s 0:13 0 0 0 hln 100 PAGETITLE=
a 0 s 0:13 0 0 0 hln 100 PAGENO=1
a 0 s 0:13 0 0 0 hln 100 PAGESIZE=A
a 0 s 0:13 0 0 0 hln 100 PAGECOUNT=1
@graphics
