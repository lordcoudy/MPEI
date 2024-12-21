from PIL import Image
import numpy as np
import math

# Билинейная интерполяция — это метод интерполяции, который использует значения в четырех ближайших точках
#   для оценки значения в произвольной точке.
# В контексте цветовой обработки изображений, билинейная интерполяция используется для плавного перехода
#   между цветами, основываясь на значениях из таблицы поиска.

def applut_belinear(R: float, G: float, B: float, LUT: list) -> list:
    """apply LUT with bilinear interpolation"""

    # Нормализуем значения R, G и B в диапазоне от 0 до 1
    if R == 1:
        iR  = 8
        iRa = 8
        print('!')

    if R < 1:
        iR  = int(math.floor(R * 8))
        iRa = iR + 1 # Соседний индекс

    if G == 1:
        iG  = 8
        iGa = 8
        print('!!')

    if G < 1:
        iG  = int(math.floor(G * 8))
        iGa = iG + 1

    if B == 1:
        iB  = 8
        iBa = 8
        print('!!!')

    if B < 1:
        iB  = int(math.floor(G * 8))
        iBa = iB + 1

    # Выбираем значения из таблицы LUT для 8-ми соседних точек
    C000 = LUT[iR, iG, iB, 0]
    C001 = LUT[iR, iG, iBa, 0]
    C010 = LUT[iR, iGa, iB, 0]
    C100 = LUT[iRa, iG, iB, 0]
    C011 = LUT[iR, iGa, iBa, 0]
    C101 = LUT[iRa, iG, iBa, 0]
    C110 = LUT[iRa, iGa, iB, 0]
    C111 = LUT[iRa, iGa, iBa, 0]

    # Интерполированное значение по формуле билейное интерполяции
    r = C000 * (float(iRa) / 8 - R) * (float(iGa) / 8 - G) * (float(iBa) / 8 - B) + C100 * (R-float(iR)/8)*(float(iGa)/8-G)*(float(iBa)/8-B) + C101*(R-float(iR)/8)*(float(iGa)/8-G)*(B-float(iB)/8) + C110*(R-float(iR)/8)*(G-float(iG)/8)*(float(iBa)/8-B) + C111*(R-float(iR)/8)*(G-float(iG)/8)*(B-float(iB)/8) + C010*(float(iRa)/8-R)*(G-float(iG)/8)*(float(iBa)/8-B) + C001*(float(iRa)/8-R)*(float(iGa)/8-G)*(B-float(iB)/8) + C011*(float(iRa)/8-R)*(G-float(iG)/8)*(B-float(iB)/8)

    # Для масштабирования умножаем
    r *= 8 * 8 * 8

    C000 = LUT[iR, iG, iB, 1]
    C001 = LUT[iR, iG, iBa, 1]
    C010 = LUT[iR, iGa, iB, 1]
    C100 = LUT[iRa, iG, iB, 1]
    C011 = LUT[iR, iGa, iBa, 1]
    C101 = LUT[iRa, iG, iBa, 1]
    C110 = LUT[iRa, iGa, iB, 1]
    C111 = LUT[iRa, iGa, iBa, 1]

    g = C000*(float(iRa)/8-R)*(float(iGa)/8-G)*(float(iBa)/8-B)+C100*(R-float(iR)/8)*(float(iGa)/8-G)*(float(iBa)/8-B)+C101*(R-float(iR)/8)*(float(iGa)/8-G)*(B-float(iB)/8)+C110*(R-float(iR)/8)*(G-float(iG)/8)*(float(iBa)/8-B)+C111*(R-float(iR)/8)*(G-float(iG)/8)*(B-float(iB)/8)+C010*(float(iRa)/8-R)*(G-float(iG)/8)*(float(iBa)/8-B)+C001*(float(iRa)/8-R)*(float(iGa)/8-G)*(B-float(iB)/8)+C011*(float(iRa)/8-R)*(G-float(iG)/8)*(B-float(iB)/8)
    g *= 8 * 8 * 8

    C000 = LUT[iR, iG, iB, 2]
    C001 = LUT[iR, iG, iBa, 2]
    C010 = LUT[iR, iGa, iB, 2]
    C100 = LUT[iRa, iG, iB, 2]
    C011 = LUT[iR, iGa, iBa, 2]
    C101 = LUT[iRa, iG, iBa, 2]
    C110 = LUT[iRa, iGa, iB, 2]
    C111 = LUT[iRa, iGa, iBa, 2]

    b = C000*(float(iRa)/8-R)*(float(iGa)/8-G)*(float(iBa)/8-B)+C100*(R-float(iR)/8)*(float(iGa)/8-G)*(float(iBa)/8-B)+C101*(R-float(iR)/8)*(float(iGa)/8-G)*(B-float(iB)/8)+C110*(R-float(iR)/8)*(G-float(iG)/8)*(float(iBa)/8-B)+C111*(R-float(iR)/8)*(G-float(iG)/8)*(B-float(iB)/8)+C010*(float(iRa)/8-R)*(G-float(iG)/8)*(float(iBa)/8-B)+C001*(float(iRa)/8-R)*(float(iGa)/8-G)*(B-float(iB)/8)+C011*(float(iRa)/8-R)*(G-float(iG)/8)*(B-float(iB)/8)
    b *= 8 * 8 * 8

    return r, g, b


def applut_linear(R, G, B, LUT):
    """apply LUT with linear interpolation"""

    # Нормализация значений RGB
    R = R / 255.0
    G = G / 255.0
    B = B / 255.0

    # Вычисление индексов и соседних индексов
    iR = int(R * 8)
    iG = int(G * 8)
    iB = int(B * 8)

    iRa = min(iR + 1, 8)
    iGa = min(iG + 1, 8)
    iBa = min(iB + 1, 8)

    # Линейная интерполяция для каждого канала
    if iRa == iR: # Избегаем деления на 0, берем значение пикселя для канала Red напрямую из LUT
        r = LUT[iR, iG, iB, 0]
    else: # Формула линейно интерполяции для канала Red
        r = (LUT[iR, iG, iB, 0] * (iRa / 8 - R) + LUT[iRa, iG, iB, 0] * (R - iR / 8)) / (iRa / 8 - iR / 8)

    if iGa == iG:
        g = LUT[iR, iG, iB, 1]
    else:
        g = (LUT[iR, iG, iB, 1] * (iGa / 8 - G) + LUT[iR, iGa, iB, 1] * (G - iG / 8)) / (iGa / 8 - iG / 8)

    if iBa == iB:
        b = LUT[iR, iG, iB, 2]
    else:
        b = (LUT[iR, iG, iB, 2] * (iBa / 8 - B) + LUT[iR, iG, iBa, 2] * (B - iB / 8)) / (iBa / 8 - iB / 8)

    return r, g, b


def applut_trilinear(R, G, B, LUT):
    """apply LUT with trilinear interpolation"""

    # Нормализация значений RGB
    R = R / 255.0
    G = G / 255.0
    B = B / 255.0

    # Вычисление индексов и соседних индексов
    iR = int(R * 8)
    iG = int(G * 8)
    iB = int(B * 8)

    iRa = min(iR + 1, 8)
    iGa = min(iG + 1, 8)
    iBa = min(iB + 1, 8)

    # Вычисление весов для интерполяции
    wR = (R - iR / 8) / (iRa / 8 - iR / 8) if iRa != iR else 0
    wG = (G - iG / 8) / (iGa / 8 - iG / 8) if iGa != iG else 0
    wB = (B - iB / 8) / (iBa / 8 - iB / 8) if iBa != iB else 0

    # Трилинейная интерполяция для каждого канала
    r = (1 - wR) * (1 - wG) * (1 - wB) * LUT[iR, iG, iB, 0] + \
        (1 - wR) * (1 - wG) * wB * LUT[iR, iG, iBa, 0] + \
        (1 - wR) * wG * (1 - wB) * LUT[iR, iGa, iB, 0] + \
        (1 - wR) * wG * wB * LUT[iR, iGa, iBa, 0] + \
        wR * (1 - wG) * (1 - wB) * LUT[iRa, iG, iB, 0] + \
        wR * (1 - wG) * wB * LUT[iRa, iG, iBa, 0] + \
        wR * wG * (1 - wB) * LUT[iRa, iGa, iB, 0] + \
        wR * wG * wB * LUT[iRa, iGa, iBa, 0]

    g = (1 - wR) * (1 - wG) * (1 - wB) * LUT[iR, iG, iB, 1] + \
        (1 - wR) * (1 - wG) * wB * LUT[iR, iG, iBa, 1] + \
        (1 - wR) * wG * (1 - wB) * LUT[iR, iGa, iB, 1] + \
        (1 - wR) * wG * wB * LUT[iR, iGa, iBa, 1] + \
        wR * (1 - wG) * (1 - wB) * LUT[iRa, iG, iB, 1] + \
        wR * (1 - wG) * wB * LUT[iRa, iG, iBa, 1] + \
        wR * wG * (1 - wB) * LUT[iRa, iGa, iB, 1] + \
        wR * wG * wB * LUT[iRa, iGa, iBa, 1]

    b = (1 - wR) * (1 - wG) * (1 - wB) * LUT[iR, iG, iB, 2] + \
        (1 - wR) * (1 - wG) * wB * LUT[iR, iG, iBa, 2] + \
        (1 - wR) * wG * (1 - wB) * LUT[iR, iGa, iB, 2] + \
        (1 - wR) * wG * wB * LUT[iR, iGa, iBa, 2] + \
        wR * (1 - wG) * (1 - wB) * LUT[iRa, iG, iB, 2] + \
        wR * (1 - wG) * wB * LUT[iRa, iG, iBa, 2] + \
        wR * wG * (1 - wB) * LUT[iRa, iGa, iB, 2] + \
        wR * wG * wB * LUT[iRa, iGa, iBa, 2]

    return r, g, b


filename = "C:/Users/dunajkin-d-m/Downloads/11_Semestr/ЦТОИ/MC_rar (ЛР LUT)/MC/lenna.png"
image = Image.open(filename)
width, height = image.size
print("Ширина изображения: ", width)
print("Высота изображения: ", height)

im = image.load()
arr = np.asarray(image)
arr1 = np.zeros((height, width, 3), 'uint8')
arr2 = np.zeros((height, width, 3), 'uint8')
arr3 = np.zeros((height, width, 3), 'uint8')

LUT = np.zeros((9, 9, 9, 3))
LUT_path = "C:/Users/dunajkin-d-m/Downloads/11_Semestr/ЦТОИ/A_07M_22_TSTOI_Nechayev_Shumakov_lab3-4/LUT9K.txt"
# 'C:/Users/dunajkin-d-m/Downloads/11_Semestr/ЦТОИ/MC_rar (ЛР LUT)/MC/LUT9B.txt'
f = open(LUT_path,'r')

for i in range (0, 9):
    for j in range (0, 9):
        for k in range (0, 9):
            for l in range (0, 3):
                LUT[i, j, k, l] = float(f.readline())

for i in range (0, width):
    for j in range(0, height):

        [r, g, b] = applut_linear(float(arr[i, j, 0]), float(arr[i, j, 1]), float(arr[i, j, 2]), LUT)
        arr1[i, j, 0] = np.uint8(max(0, min(255, 255 * r)))
        arr1[i, j, 1] = np.uint8(max(0, min(255, 255 * g)))
        arr1[i, j, 2] = np.uint8(max(0, min(255, 255 * b)))


        [r, g, b] = applut_belinear(float(arr[i, j, 0]) / 256, float(arr[i, j, 1]) / 255, float(arr[i, j, 2]) / 255, LUT)
        arr2[i,j,0] = np.uint8(255 * r)
        arr2[i,j,1] = np.uint8(255 * g)
        arr2[i,j,2] = np.uint8(255 * b)


        [r, g, b] = applut_trilinear(float(arr[i, j, 0]), float(arr[i, j, 1]), float(arr[i, j, 2]), LUT)
        arr3[i, j, 0] = np.uint8(max(0, min(255, 255 * r)))
        arr3[i, j, 1] = np.uint8(max(0, min(255, 255 * g)))
        arr3[i, j, 2] = np.uint8(max(0, min(255, 255 * b)))


image_out = Image.frombuffer('RGB', (width, height), arr1)
image_out.save('C:/Users/dunajkin-d-m/Documents/resultK1_Linear.png', 'png')

image_out = Image.frombuffer('RGB', (width, height), arr2)
image_out.save('C:/Users/dunajkin-d-m/Documents/resultK2_Belinear.png', 'png')

image_out = Image.frombuffer('RGB', (width, height), arr3)
image_out.save('C:/Users/dunajkin-d-m/Documents/resultK3_Trilinear.png', 'png')