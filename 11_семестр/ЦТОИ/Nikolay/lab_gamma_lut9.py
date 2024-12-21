from PIL import Image
import numpy as numpy
import math


def LinearInterpolation(x, lut9):
    x0 = (int)(x / 32) * 32
    x1 = ((int)(x / 32) + 1) * 32
    if x1 == 256:
        x1 = 255

    y0 = lut9[(int)(x / 32)]
    y1 = lut9[(int)(x / 32) + 1]
    return y0 * ((x - x1) / (x0 - x1)) + y1 * ((x - x0) / (x1 - x0))
    # return y0 + (x - x0) * (y1 - y0) / (x1 - x0)


filename = "tiger.png"
image = Image.open(filename)
width, height = image.size
print("ширина:", width)
print("высота:", height)

gamma = 1

# Преобразование с LUT_9
lut9 = numpy.zeros(9)
for i in range(0, 8):
    lut9[i] = int(255 * math.pow(float(i * 32) / 255, gamma))
lut9[8] = int(255 * math.pow(float(255) / 255, gamma))

arr = numpy.asarray(image)
l = numpy.zeros((height, width, 3), "uint8")

for i in range(0, height):
    for j in range(0, width):
        # Red
        x = arr[i, j, 0]
        x0 = (int)(x / 32) * 32
        x1 = ((int)(x / 32) + 1) * 32
        if x1 == 256:
            x1 = 255

        y0 = lut9[(int)(x / 32)]
        y1 = lut9[(int)(x / 32) + 1]
        l[i, j, 0] = y0 * ((x - x1) / (x0 - x1)) + y1 * ((x - x0) / (x1 - x0))
        # l[i, j, 0] = y0 + (x - x0) * (y1 - y0) / (x1 - x0)
        # или через ф-цию l[i, j, 0] = LinearInterpolation(arr[i, j, 0], lut9)

        # Green
        x = arr[i, j, 1]
        x0 = (int)(x / 32) * 32
        x1 = ((int)(x / 32) + 1) * 32
        if x1 == 256:
            x1 = 255

        y0 = lut9[(int)(x / 32)]
        y1 = lut9[(int)(x / 32) + 1]
        l[i, j, 1] = y0 * ((x - x1) / (x0 - x1)) + y1 * ((x - x0) / (x1 - x0))
        # l[i, j, 1] = y0 + (x - x0) * (y1 - y0) / (x1 - x0)
        # или через ф-цию l[i, j, 1] = LinearInterpolation(arr[i, j, 0], lut9)

        # Blue
        x = arr[i, j, 2]
        x0 = (int)(x / 32) * 32
        x1 = ((int)(x / 32) + 1) * 32
        if x1 == 256:
            x1 = 255

        y0 = lut9[(int)(x / 32)]
        y1 = lut9[(int)(x / 32) + 1]
        l[i, j, 2] = y0 * ((x - x1) / (x0 - x1)) + y1 * ((x - x0) / (x1 - x0))
        # l[i, j, 2] = y0 + (x - x0) * (y1 - y0) / (x1 - x0)
        # или через ф-цию l[i, j, 2] = LinearInterpolation(arr[i, j, 0], lut9)

image_out1 = Image.frombuffer("RGB", (width, height), l)
image_out1.save("result1.png", "png")


# Эталонное преобразование с LUT_256
lut = numpy.zeros(256)
for i in range(0, 256):
    lut[i] = int(255 * math.pow(float(i) / 255, gamma))

l_ref = numpy.zeros((height, width, 3), "uint8")

for i in range(0, height):
    for j in range(0, width):

        l_ref[i, j, 0] = lut[arr[i, j, 0]]  # Red
        l_ref[i, j, 1] = lut[arr[i, j, 1]]  # Green
        l_ref[i, j, 2] = lut[arr[i, j, 2]]  # Blue

image_out2 = Image.frombuffer("RGB", (width, height), l_ref)
image_out2.save("result2.png", "png")


# Сравнение l и l_ref
maxErr = 0
sum = 0

for i in range(0, height):
    for j in range(0, width):
        for k in range(0, 3):
            sum += math.pow(abs(l_ref[i, j, k] - l[i, j, k]), 2)
            curVal = abs(l_ref[i, j, k] - l[i, j, k])
            if curVal > maxErr:
                maxErr = curVal

MSE = sum / (height * width)
print("sum=", sum, "MSE=", MSE)

PSNR = 100
if MSE != 0:
    PSNR = 20 * math.log10(255 / math.sqrt(MSE))

print("Максимальная ошибка отклонения:", maxErr)
print("Среднекватратичное отклонение:", MSE)
print("Пиковое отн. сигнал-шум:", PSNR)