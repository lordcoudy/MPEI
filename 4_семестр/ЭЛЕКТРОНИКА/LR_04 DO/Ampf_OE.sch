*version 9.2 4058841107
u 828
M? 2
V? 7
? 38
J? 2
I? 2
Q? 10
R? 17
C? 17
PM? 7
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
pageloc 1 0 5196 
@status
n 0 121:03:13:16:59:39;1618322379 e 
s 2832 121:03:13:16:59:43;1618322383 e 
c 121:03:13:16:59:24;1618322364
*page 1 0 970 720 iA
@ports
port 817 EGND 380 250 h
@parts
part 738 QbreakP 380 180 h
a 0 sp 13 0 23 38 hln 100 MODEL=KT814V
a 0 x 0:13 0 0 0 hln 100 PKGREF=Q
a 0 xp 9 0 5 5 hln 100 REFDES=Q
part 748 VAC 210 200 h
a 0 sp 0 0 0 50 hln 100 PART=VAC
a 0 x 0:13 0 0 0 hln 100 PKGREF=VG
a 1 xp 9 0 24 10 hcn 100 REFDES=VG
part 739 r 240 180 h
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=RG
a 0 xp 9 0 15 0 hln 100 REFDES=RG
a 0 u 13 0 15 25 hln 100 VALUE=200
part 742 r 340 250 v
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=R2
a 0 xp 9 0 15 0 hln 100 REFDES=R2
a 0 u 13 0 15 25 hln 100 VALUE=6.2k
part 743 r 400 250 v
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=RE
a 0 xp 9 0 15 0 hln 100 REFDES=RE
a 0 u 13 0 15 25 hln 100 VALUE=100
part 740 r 400 130 v
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=RK
a 0 xp 9 0 15 0 hln 100 REFDES=RK
a 0 u 13 0 15 25 hln 100 VALUE=400
part 741 r 340 130 v
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=R1
a 0 xp 9 0 15 0 hln 100 REFDES=R1
a 0 u 13 0 15 25 hln 100 VALUE=30000
part 745 C 300 180 h
a 0 sp 0 0 0 10 hlb 100 PART=C
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=CP1
a 0 xp 9 0 15 0 hln 100 REFDES=CP1
a 0 u 13 0 15 25 hln 100 VALUE=5u
part 746 C 440 240 v
a 0 sp 0 0 0 10 hlb 100 PART=C
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=CE
a 0 xp 9 0 15 0 hln 100 REFDES=CE
a 0 u 13 0 15 25 hln 100 VALUE=50u
part 749 VDC 570 180 u
a 0 sp 0 0 22 37 hln 100 PART=VDC
a 0 x 0:13 0 0 0 hln 100 PKGREF=VPit
a 1 xp 9 0 24 7 hcn 100 REFDES=VPit
a 1 u 13 0 -11 18 hcn 100 DC=15V
part 744 r 500 220 v
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=RH
a 0 xp 9 0 15 0 hln 100 REFDES=RH
a 0 u 13 0 5 33 hln 100 VALUE=1200
part 747 C 460 150 u
a 0 sp 0 0 0 10 hlb 100 PART=C
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=CP2
a 0 xp 9 0 15 0 hln 100 REFDES=CP2
a 0 u 13 0 15 25 hln 100 VALUE=5u
part 820 C 530 220 v
a 0 sp 0 0 0 10 hlb 100 PART=C
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 u 13 0 15 25 hln 100 VALUE=1n
a 0 x 0:13 0 0 0 hln 100 PKGREF=C4
a 0 xp 9 0 29 2 hln 100 REFDES=C4
part 1 titleblk 970 720 h
a 1 s 13 0 350 10 hcn 100 PAGESIZE=A
a 1 s 13 0 180 60 hcn 100 PAGETITLE=
a 1 s 13 0 340 95 hrn 100 PAGECOUNT=1
a 1 s 13 0 300 95 hrn 100 PAGENO=1
part 819 nodeMarker 500 150 h
a 0 s 0 0 0 0 hln 100 PROBEVAR=
a 0 a 0 0 4 22 hlb 100 LABEL=37
@conn
w 769
a 0 up 0:33 0 0 0 hln 100 V=
s 340 130 340 180 768
a 0 up 33 0 342 155 hlt 100 V=
s 340 180 340 210 788
s 380 180 340 180 786
s 340 180 330 180 789
w 792
a 0 up 0:33 0 0 0 hln 100 V=
s 300 180 280 180 791
a 0 up 33 0 290 179 hct 100 V=
w 763
a 0 up 0:33 0 0 0 hln 100 V=
s 570 140 570 70 762
s 570 70 400 70 764
a 0 up 33 0 485 69 hct 100 V=
s 340 70 340 90 766
s 400 70 340 70 797
s 400 90 400 70 795
w 799
a 0 up 0:33 0 0 0 hln 100 V=
s 400 200 400 210 798
s 400 200 440 200 800
a 0 up 33 0 420 199 hct 100 V=
s 440 200 440 210 802
w 794
a 0 up 0:33 0 0 0 hln 100 V=
s 400 160 400 150 793
s 400 150 400 130 816
s 430 150 400 150 814
a 0 up 33 0 415 149 hct 100 V=
w 751
a 0 up 0:33 0 0 0 hln 100 V=
a 0 sr 0 0 0 0 hln 100 LABEL=1
s 210 180 210 200 752
a 0 sr 3 0 212 190 hln 100 LABEL=1
s 240 180 210 180 750
a 0 up 33 0 225 179 hct 100 V=
w 755
a 0 up 0:33 0 0 0 hln 100 V=
s 210 240 210 250 754
s 210 250 340 250 756
a 0 up 33 0 275 249 hct 100 V=
s 400 250 440 250 758
s 340 250 380 250 759
s 570 250 570 180 760
s 440 250 500 250 806
s 440 240 440 250 804
s 500 250 530 250 809
s 500 220 500 250 807
s 380 250 400 250 818
s 530 250 570 250 823
s 530 220 530 250 821
w 825
a 0 up 0:33 0 0 0 hln 100 V=
a 0 sr 0 0 0 0 hln 100 LABEL=2
s 500 180 500 150 810
a 0 sr 3 0 502 165 hln 100 LABEL=2
s 530 190 530 150 824
s 500 150 460 150 812
a 0 up 33 0 480 149 hct 100 V=
s 530 150 500 150 826
@junction
j 400 250
+ p 743 1
+ w 755
j 340 250
+ p 742 1
+ w 755
j 570 180
+ p 749 +
+ w 755
j 340 210
+ p 742 2
+ w 769
j 340 130
+ p 741 1
+ w 769
j 570 140
+ p 749 -
+ w 763
j 340 90
+ p 741 2
+ w 763
j 240 180
+ p 739 1
+ w 751
j 380 180
+ p 738 b
+ w 769
j 340 180
+ w 769
+ w 769
j 330 180
+ p 745 2
+ w 769
j 280 180
+ p 739 2
+ w 792
j 300 180
+ p 745 1
+ w 792
j 400 130
+ p 740 1
+ w 794
j 400 160
+ p 738 c
+ w 794
j 400 90
+ p 740 2
+ w 763
j 400 70
+ w 763
+ w 763
j 400 210
+ p 743 2
+ w 799
j 400 200
+ p 738 e
+ w 799
j 440 210
+ p 746 2
+ w 799
j 440 240
+ p 746 1
+ w 755
j 440 250
+ w 755
+ w 755
j 500 250
+ w 755
+ w 755
j 400 150
+ w 794
+ w 794
j 380 250
+ s 817
+ w 755
j 430 150
+ p 747 2
+ w 794
j 500 220
+ p 744 1
+ w 755
j 210 200
+ p 748 +
+ w 751
j 210 240
+ p 748 -
+ w 755
j 530 220
+ p 820 1
+ w 755
j 530 250
+ w 755
+ w 755
j 530 190
+ p 820 2
+ w 825
j 500 180
+ p 744 2
+ w 825
j 460 150
+ p 747 1
+ w 825
j 500 150
+ p 819 pin1
+ w 825
@attributes
a 0 s 0:13 0 0 0 hln 100 PAGETITLE=
a 0 s 0:13 0 0 0 hln 100 PAGENO=1
a 0 s 0:13 0 0 0 hln 100 PAGESIZE=A
a 0 s 0:13 0 0 0 hln 100 PAGECOUNT=1
@graphics
