from PIL import Image
import numpy as numpy
import math

from PIL.Image import Resampling

filename="lenna.png"
image=Image.open(filename)
width, height = image.size
print(width)
print(height)

im = image.load()
cropSize = 8
crop = numpy.zeros((cropSize, cropSize), 'uint8')
xShift = 30
yShift = 30
arr = numpy.asarray(image.convert('L'))

def findEye(lennaSize, eyeSize, lenaArr, eyeArr):
    M = numpy.average(lenaArr)
    Mcrop = numpy.average(eyeArr)
    out_arr = numpy.zeros((lennaSize, lennaSize))
    maxV = 0
    maxI, maxJ = 0, 0
    for i in range(0, lennaSize - eyeSize + 1):
        for j in range(0, lennaSize - eyeSize + 1):
            for ii in range(0, eyeSize):
                for jj in range(0, eyeSize):
                    out_arr[i, j] += (lenaArr[i + ii, j + jj] - M) * (eyeArr[ii, jj] - Mcrop)
            if maxV < out_arr[i, j]:
                maxV = out_arr[i, j]
                maxI = i
                maxJ = j
    print("lena size: ",lennaSize, " corr: ",maxV, ": ", maxI, " ", maxJ)
    im_out = numpy.zeros((lennaSize, lennaSize), 'bytes')
    POMAX = 0
    POMIN = 0
    for i in range(0, (lennaSize)):
        for j in range(0, (lennaSize)):
            if out_arr[i, j] > POMAX:
                POMAX = out_arr[i, j]
            if out_arr[i, j] < POMIN:
                POMIN = out_arr[i, j]

    for i in range(0, (lennaSize)):
        for j in range(0, (lennaSize)):
            pix = out_arr[i, j]
            pix = 255 * (pix - POMIN) / (POMAX - POMIN)
            im_out[i, j] = bytes([int(pix)])
    return im_out

# 256/32 = x/8 => x = 8*256/32 =
k = 4
cropWidth, cropHeight = int(width/k), int(height/k)
arrResized = numpy.asarray(image.convert('L').resize((cropWidth, cropHeight), resample=Resampling.LANCZOS))
print(arrResized)

for i in range (0,cropSize):
    for j in range(0,cropSize):
        crop[i,j] = arrResized[i + xShift,j + yShift]

# resize crop
image_out=Image.fromarray(crop, mode='L')
image_out.convert('L').save('lenna_crop.png', 'PNG')
image_out=Image.fromarray(arr, mode='L')
image_out.convert('L').save('lenna_1.png', 'PNG')
image_out=Image.fromarray(arrResized, mode='L')
image_out.convert('L').save('lenna_resized.png', 'PNG')

maxK = 32
i = 2
while i <= maxK:
    arrTmp = numpy.asarray(image.convert('L').resize((int(width/i), int(height/i)), resample=Resampling.LANCZOS))
    image_out = Image.fromarray(arrTmp, mode='L')
    image_out.convert('L').save(f'lenna_re_{i}.png', 'PNG')
    tmp_out = findEye(int(width/i), cropSize, arrTmp, crop)
    image_out = Image.frombytes('L', (int(width/i), int(height/i)), tmp_out)
    savepath = f'lenna_out_resize_{i}.png'
    image_out.save(savepath, 'png')
    i *= 2



