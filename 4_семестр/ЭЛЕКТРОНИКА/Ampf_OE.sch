*version 9.2 914173272
u 931
M? 2
V? 7
? 39
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
pageloc 1 0 5619 
@status
n 2407 121:03:13:17:34:24;1618324464 e 
s 2833 121:03:13:16:59:43;1618322383 e 
c 121:03:16:19:02:02;1618588922
*page 1 0 970 720 iA
@ports
port 817 EGND 380 250 h
@parts
part 748 VAC 210 200 h
a 0 x 0:13 0 0 0 hln 100 PKGREF=VG
a 1 xp 9 0 24 10 hcn 100 REFDES=VG
a 0 sp 0 0 0 50 hln 100 PART=VAC
a 1 u 0 0 0 0 hcn 100 DC=1.3V
a 0 u 13 0 31 -193 hcn 100 ACMAG=Åã
part 738 QbreakP 360 140 h
a 0 x 0:13 0 0 0 hln 100 PKGREF=Q
a 0 xp 9 0 5 5 hln 100 REFDES=Q
a 0 sp 13 0 21 22 hln 100 MODEL=KT814V
part 747 C 460 120 u
a 0 x 0:13 0 0 0 hln 100 PKGREF=Cð2
a 0 sp 0 0 0 10 hlb 100 PART=C
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 u 13 0 5 129 hln 100 VALUE=5u
a 0 xp 9 0 11 20 hln 100 REFDES=Cð2
part 922 C 530 170 d
a 0 sp 0 0 0 10 hlb 100 PART=C
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=Cí
a 0 u 13 0 -165 9 hln 100 VALUE=1n
a 0 xp 9 0 9 6 hln 100 REFDES=Cí
part 749 VDC 570 180 u
a 0 x 0:13 0 0 0 hln 100 PKGREF=Eïèò
a 0 sp 0 0 22 37 hln 100 PART=VDC
a 1 xp 9 0 -8 33 hcn 100 REFDES=Eïèò
a 1 u 13 0 -7 10 hcn 100 DC=36V
part 744 r 490 200 v
a 0 x 0:13 0 0 0 hln 100 PKGREF=Rí\
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 u 13 0 3 29 hln 100 VALUE=1200
a 0 xp 9 0 33 24 hln 100 REFDES=Rí\
part 743 r 400 250 v
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=Rý2
a 0 u 13 0 245 23 hln 100 VALUE=100
a 0 xp 9 0 31 28 hln 100 REFDES=Rý2
part 746 C 440 240 v
a 0 x 0:13 0 0 0 hln 100 PKGREF=Cý
a 0 sp 0 0 0 10 hlb 100 PART=C
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 u 13 0 231 13 hln 100 VALUE=50u
a 0 xp 9 0 21 26 hln 100 REFDES=Cý
part 903 r 400 200 v
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=Rý1
a 0 xp 9 0 33 30 hln 100 REFDES=Rý1
a 0 u 13 0 -13 7 hln 100 VALUE=510
part 740 r 380 120 v
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=Rê
a 0 u 13 0 5 25 hln 100 VALUE=470
a 0 xp 9 0 31 22 hln 100 REFDES=Rê
part 741 r 340 130 v
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=R1
a 0 u 13 0 3 29 hln 100 VALUE=1300
a 0 xp 9 0 31 24 hln 100 REFDES=R1
part 742 r 340 250 v
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 x 0:13 0 0 0 hln 100 PKGREF=R2
a 0 u 13 0 5 25 hln 100 VALUE=300
a 0 xp 9 0 31 24 hln 100 REFDES=R2
part 745 C 250 140 h
a 0 x 0:13 0 0 0 hln 100 PKGREF=Cð1
a 0 sp 0 0 0 10 hlb 100 PART=C
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 u 13 0 39 -123 hln 100 VALUE=5u
a 0 xp 9 0 19 6 hln 100 REFDES=Cð1
part 846 r 210 180 v
a 0 x 0:13 0 0 0 hln 100 PKGREF=Rã
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=
a 0 u 13 0 5 27 hln 100 VALUE=200
a 0 xp 9 0 31 24 hln 100 REFDES=Rã
part 1 titleblk 970 720 h
a 1 s 13 0 350 10 hcn 100 PAGESIZE=A
a 1 s 13 0 180 60 hcn 100 PAGETITLE=
a 1 s 13 0 340 95 hrn 100 PAGECOUNT=1
a 1 s 13 0 300 95 hrn 100 PAGENO=1
part 930 nodeMarker 530 120 h
a 0 s 0 0 0 0 hln 100 PROBEVAR=
a 0 s 0 0 0 0 hln 100 PROBEVAR=
a 0 s 0 0 0 0 hln 100 PROBEVAR=
a 0 a 0 0 4 22 hlb 100 LABEL=38
@conn
w 792
a 0 up 0:33 0 0 0 hln 100 V=
s 250 140 210 140 851
a 0 up 33 0 240 139 hct 100 V=
w 794
a 0 up 0:33 0 0 0 hln 100 V=
s 430 120 380 120 814
a 0 up 33 0 405 119 hct 100 V=
w 896
a 0 up 0:33 0 0 0 hln 100 V=
s 440 210 400 210 800
a 0 up 33 0 420 209 hct 100 V=
s 400 200 400 210 908
w 755
a 0 up 0:33 0 0 0 hln 100 V=
s 570 250 570 180 760
s 490 250 530 250 876
s 490 200 490 250 807
s 400 250 440 250 885
s 440 240 440 250 804
s 380 250 400 250 806
s 340 250 380 250 759
s 210 250 340 250 756
a 0 up 33 0 275 249 hct 100 V=
s 210 240 210 250 754
s 440 250 490 250 901
s 530 250 570 250 929
s 530 200 530 250 927
w 751
a 0 up 0:33 0 0 0 hln 100 V=
s 210 180 210 200 752
w 825
a 0 up 0:33 0 0 0 hln 100 V=
s 490 160 490 120 810
s 490 120 460 120 812
a 0 up 33 0 475 119 hct 100 V=
s 490 120 530 120 923
s 530 120 530 170 925
w 902
a 0 up 0:33 0 0 0 hln 100 V=
a 0 sr 0 0 0 0 hln 100 LABEL=Ý
s 400 160 380 160 856
a 0 sr 3 0 382 170 hcn 100 LABEL=Ý
w 763
a 0 up 0:33 0 0 0 hln 100 V=
a 0 sr 0 0 0 0 hln 100 LABEL=Ê
s 380 80 380 70 795
a 0 sr 3 0 382 129 hln 100 LABEL=Ê
s 340 70 340 90 766
s 570 140 570 70 762
s 570 70 380 70 797
a 0 up 33 0 475 69 hct 100 V=
s 380 70 340 70 869
w 769
a 0 up 0:33 0 0 0 hln 100 V=
a 0 sr 0 0 0 0 hln 100 LABEL=Á
s 360 140 340 140 786
a 0 sr 3 0 344 148 hcn 100 LABEL=Á
s 340 130 340 140 768
a 0 up 33 0 342 155 hlt 100 V=
s 340 140 280 140 789
s 340 140 340 210 788
@junction
j 210 200
+ p 748 +
+ w 751
j 340 130
+ p 741 1
+ w 769
j 570 180
+ p 749 +
+ w 755
j 340 90
+ p 741 2
+ w 763
j 210 180
+ p 846 1
+ w 751
j 280 140
+ p 745 2
+ w 769
j 250 140
+ p 745 1
+ w 792
j 210 140
+ p 846 2
+ w 792
j 340 210
+ p 742 2
+ w 769
j 340 140
+ w 769
+ w 769
j 360 140
+ p 738 b
+ w 769
j 380 120
+ p 740 1
+ p 738 c
j 570 140
+ p 749 -
+ w 763
j 380 80
+ p 740 2
+ w 763
j 380 70
+ w 763
+ w 763
j 430 120
+ p 747 2
+ w 794
j 380 120
+ p 738 c
+ w 794
j 380 120
+ p 740 1
+ w 794
j 400 210
+ p 743 2
+ w 896
j 440 210
+ p 746 2
+ w 896
j 380 160
+ p 738 e
+ w 902
j 400 160
+ p 903 2
+ w 902
j 400 200
+ p 903 1
+ w 896
j 490 200
+ p 744 1
+ w 755
j 210 240
+ p 748 -
+ w 755
j 340 250
+ p 742 1
+ w 755
j 380 250
+ s 817
+ w 755
j 400 250
+ p 743 1
+ w 755
j 440 240
+ p 746 1
+ w 755
j 490 250
+ w 755
+ w 755
j 440 250
+ w 755
+ w 755
j 490 160
+ p 744 2
+ w 825
j 460 120
+ p 747 1
+ w 825
j 490 120
+ w 825
+ w 825
j 530 170
+ p 922 1
+ w 825
j 530 200
+ p 922 2
+ w 755
j 530 250
+ w 755
+ w 755
j 530 120
+ p 930 pin1
+ w 825
@attributes
a 0 s 0:13 0 0 0 hln 100 PAGETITLE=
a 0 s 0:13 0 0 0 hln 100 PAGENO=1
a 0 s 0:13 0 0 0 hln 100 PAGESIZE=A
a 0 s 0:13 0 0 0 hln 100 PAGECOUNT=1
@graphics
