import numpy as np
from math import pi, sqrt

E = 40
Uka = 20
Rn = 1200
Rg = 200
Ika = 16.0 * pow(10, -3)
beta = 95.84
Iba = Ika / beta
print('R= = ', (E - Uka) / Ika)
Req = 1000
Ri = 6 / Ika
print('Rk = ', Rn * Ri / (Rn - Ri))
Rk = 560
Re = Req - Rk
print('Re = ', Re)
dIkd = 1 / Req
delta = 275 - beta
print('beta = ', beta, '\nIba = ', Iba, '\nRi = ', Ri, '\ndIkd = ', dIkd, '\ndelta = ', delta, '\n')
dT = 60
ksi = 2 * pow(10, -3)
Rb = beta * (dIkd * Re - ksi * dT) / (delta * Iba - dIkd) - Re
Rsm = Rb + (1 + beta) * Re
R1 = E * Rb / (0.7 + Iba * Rsm)
R12 = 3000
R2 = R12 * Rb / (R12 - Rb)
print('Rb = ', Rb, '\nR1 = ', R1, '\nR2 = ', R2, '\nRsm = ', Rsm, '\n')

R22 = 820
Esm = E * R22 / (R12 + R22)
Rb2 = R12 * R22 / (R12 + R22)
Ib = (Esm - 0.7) / (Rb2 + Re * (1 + beta))
Ik = Ib * beta
Ie = Ib * (1 + beta)
U = -E + Ik * Rk + Ie * Re
print('Esm = ', Esm, '\nRb = ', Rb2, '\nIb = ', Ib, '\nIk = ', Ik, '\nIe = ', Ie, '\nUka = ', U, '\n')

y = Re / (Re + Rb)
print('Gamma = ', y, '\n')
Ikdop1 = (ksi * dT) / (Rb2 + Re * (1 * beta)) * beta
Ikdop2 = (delta * Ik) / (beta * (1 + y * beta))
Ikdop = (ksi * dT) / (Rb2 + Re * (1 * beta)) * beta + (delta * Ik) / (beta * (1 + y * beta))
print('dIkdop = ', Ikdop, '\ndIkdop1 = ', Ikdop1, '\ndIkdop2 = ', Ikdop2, '\n')
dUt = Ikdop * Req
print('dUt = ', dUt, '\n')

h11 = 131.8
# 190 - 10, 11, 12, 13, 15, 16, 18, 20, 22, 24, 27,
# 30, 33, 36, 39, 43, 47, 51, 56, 62, 68, 75, 82, 91,
# 100, 110, 120, 130, 150, 160, 180
Re1 = np.array([10, 11, 12, 13, 15, 16, 18, 20, 22, 24, 27,
                30, 33, 36, 39, 43, 47, 51, 56, 62, 68, 75, 82, 91,
                100, 110, 120, 130, 150, 160, 180, 200, 220])
Rout = Rk
Rin = Rb2 * (h11 + (1 + beta) * Re1[23]) / (Rb2 + h11 + (1 + beta) * Re1[23])
ksiOut = Rn / (Rn + Rout)
ksiIn = Rin / (Rg + Rin)
Kxx = - beta * Rk / (h11 + (1 + beta) * Re1[23])
K01 = Kxx * ksiIn * ksiOut
K02 = - beta * (Rk * Rn / (Rk + Rn)) / (h11 + (1 + beta) * Re1[23])
K0 = (K01 + K02) / 2

# Ke0 тз = 3
# если K = 10 то Re1 = 27
# Re1 = 91 или 100 ->
Re2 = Re - Re1[23]

print('Rout = ', Rout, '\nRin = ', Rin, '\nksi out = ', ksiOut,
      '\nksi in = ', ksiIn, '\nKxx = ', Kxx, '\nK01 = ', K01,
      '\nK02 = ', K02, '\nK0 = ', K0, '\nRe = ', Re1[23], '\nRe2 = ', Re2, '\n')


fLow = 450
Cn = 0.7 * (10 ** -9)
tauN = 1 / (2 * pi * fLow)
tauCe = tauN1 = tauN2 = 3 * tauN
Cp1 = tauN1 / (Rg + Rin)
Cp2 = tauN2 / (Rn + Rout)
re = (h11 + Rg * Rb2 / (Rg + Rb2)) / (1 + beta)
Ce = tauCe / (Re1[23] * (Re1[23] + re))

Cep = 75 * (10 ** -12)
Ckp = 60 * (10 ** -12)
Cp12 = 1.5 * (10**-6)
Cp22 = 6.2 * (10**-7)
fHigh = 35 * 1000
fT = 3 * (10 ** 6)
K0 = abs(K0)
Cin = (Ckp * K0 + Cep)
tauIn = Cin * Rin * Rg / (Rin + Rg)
CnEq = Cn + Ckp * beta
tauOut = CnEq * Rout * Rn / (Rout + Rn)
tauT = beta / (2 * pi * fT * (1 + y * beta))
tauHigh = sqrt(tauIn**2 + tauOut**2 + tauT**2)
fHighC = 1 / (2 * pi * tauHigh)

print('tauN = ', tauN, '\ntauCe = ', tauCe, '\nCp1 = ', Cp1, '\nCp2 = ', Cp2,
      '\nre = ', re, '\nCe = ', Ce, '\nCin = ', Cin, '\ntau in = ', tauIn,
      '\nCnEq = ', CnEq, '\ntau out = ', tauOut, '\ntauT = ', tauT,
      '\ntau high = ', tauHigh, '\nf high = ', fHighC, '\n')