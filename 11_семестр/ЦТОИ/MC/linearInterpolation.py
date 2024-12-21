def LinearInterpolation(x, lutL, lutH):
    index = x // 32
    x0 = index * 32
    coef = float(x - x0) / 32
    return (lutH - lutL) * coef + lutL

def triLinear(R, G, B, lut):
    Ridx = R // 32
    Rfrac = float(R % 32) / 32
    Gidx = R // 32
    Gfrac = float(R % 32) / 32
    Bidx = R // 32
    Bfrac = float(R % 32) / 32
    Ridx1 = min(Ridx + 1, 8)
    Gidx1 = min(Gidx + 1, 8)
    Bidx1 = min(Bidx + 1, 8)
    c000_0 = lut[Ridx, Gidx, Bidx, 0]
    c001_0 = lut[Ridx, Gidx, Bidx, 0]
    c010_0 = lut[Ridx, Gidx, Bidx, 0]
    c011_0 = lut[Ridx, Gidx, Bidx, 0]
    c100_0 = lut[Ridx, Gidx, Bidx, 0]
    c101_0 = lut[Ridx, Gidx, Bidx, 0]
    c110_0 = lut[Ridx, Gidx, Bidx, 0]
    c111_0 = lut[Ridx, Gidx, Bidx, 0]

    c00_0 = c000_0 * (1 - Bfrac) + c001_0 * Bfrac
    c01_0 = c010_0 * (1 - Bfrac) + c011_0 * Bfrac
    c10_0 = c100_0 * (1 - Bfrac) + c101_0 * Bfrac
    c11_0 = c110_0 * (1 - Bfrac) + c111_0 * Bfrac

    c0_0 = c00_0 * (1 - Gfrac) + c01_0 * Gfrac
    c1_0 = c10_0 * (1 - Gfrac) + c11_0 * Gfrac

    c_0 = c0_0 * (1 - Rfrac) + c1_0 * Rfrac

    c000_1 = lut[Ridx, Gidx, Bidx, 1]
    c001_1 = lut[Ridx, Gidx, Bidx, 1]
    c010_1 = lut[Ridx, Gidx, Bidx, 1]
    c011_1 = lut[Ridx, Gidx, Bidx, 1]
    c100_1 = lut[Ridx, Gidx, Bidx, 1]
    c101_1 = lut[Ridx, Gidx, Bidx, 1]
    c110_1 = lut[Ridx, Gidx, Bidx, 1]
    c111_1 = lut[Ridx, Gidx, Bidx, 1]

    c00_1 = c000_1 * (1 - Bfrac) + c001_1 * Bfrac
    c01_1 = c010_1 * (1 - Bfrac) + c011_1 * Bfrac
    c10_1 = c100_1 * (1 - Bfrac) + c101_1 * Bfrac
    c11_1 = c110_1 * (1 - Bfrac) + c111_1 * Bfrac

    c0_1 = c00_1 * (1 - Gfrac) + c01_1 * Gfrac
    c1_1 = c10_1 * (1 - Gfrac) + c11_1 * Gfrac

    c_1 = c0_1 * (1 - Rfrac) + c1_1 * Rfrac

    c000_2 = lut[Ridx, Gidx, Bidx, 2]
    c001_2 = lut[Ridx, Gidx, Bidx, 2]
    c010_2 = lut[Ridx, Gidx, Bidx, 2]
    c011_2 = lut[Ridx, Gidx, Bidx, 2]
    c100_2 = lut[Ridx, Gidx, Bidx, 2]
    c101_2 = lut[Ridx, Gidx, Bidx, 2]
    c110_2 = lut[Ridx, Gidx, Bidx, 2]
    c111_2 = lut[Ridx, Gidx, Bidx, 2]


    c00_2 = c000_2 * (1 - Bfrac) + c001_2 * Bfrac
    c01_2 = c010_2 * (1 - Bfrac) + c011_2 * Bfrac
    c10_2 = c100_2 * (1 - Bfrac) + c101_2 * Bfrac
    c11_2 = c110_2 * (1 - Bfrac) + c111_2 * Bfrac

    c0_2 = c00_2 * (1 - Gfrac) + c01_2 * Gfrac
    c1_2 = c10_2 * (1 - Gfrac) + c11_2 * Gfrac

    c_2 = c0_2 * (1 - Rfrac) + c1_2 * Rfrac

    return [c_0, c_1, c_2]
