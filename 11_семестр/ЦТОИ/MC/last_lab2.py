from PIL import Image
import numpy as numpy
import math
import linearInterpolation as li

filename="lenna.png"
image=Image.open(filename)
width, height = image.size
print(width)
print(height)

im = image.load()
cropSize = 25
crop = numpy.zeros((cropSize, cropSize), 'uint8')
xShift = 120
yShift = 120
arr = numpy.asarray(image.convert('L'))
dArr = arr.copy()
print(arr)

for i in range (0,cropSize):
    for j in range(0,cropSize):
        crop[i,j] = arr[i + xShift,j + yShift]
        dArr[i + xShift,j + yShift] = 0

image_out=Image.fromarray(crop, mode='L')
image_out.convert('L').save('lenna_crop.png', 'PNG')
image_out=Image.fromarray(dArr, mode='L')
image_out.convert('L').save('lenna_2.png', 'PNG')

M = numpy.average(arr)
Mcrop = numpy.average(crop)

out_arr = numpy.zeros((width, height))
maxV = 0
maxI, maxJ = 0, 0
minV = math.inf
minI, minJ = 0, 0
for i in range (0,height-cropSize):
    for j in range(0,width-cropSize):
        for ii in range (0, cropSize):
            for jj in range (0, cropSize):
                out_arr[i,j] += (dArr[i+ii,j+jj] - M)*(crop[ii,jj] - Mcrop)
        if maxV < out_arr[i,j]:
            maxV = out_arr[i,j]
            maxI = i
            maxJ = j
        if minV > abs(out_arr[i,j]):
            minV = abs(out_arr[i,j])
            minI = i
            minJ = j
print(maxV, ": ",maxI," ", maxJ)
print(minV, ": ",minI," ", minJ)
print(out_arr[120,120])

im_out = numpy.zeros((width, height), 'bytes')
POMAX = 0
POMIN = 0
for i in range(0, (width)):
    for j in range(0, (height)):
        if dArr[i, j] > POMAX:
            POMAX = dArr[i, j]
        if dArr[i, j] < POMIN:
            POMIN = dArr[i, j]

for i in range(0, (width)):
    for j in range(0, (height)):
        pix = dArr[i, j]
        if (i >= minI) & (i < minI + cropSize) & (j >= minJ) & (j < minJ + cropSize):
            pix = crop[i - xShift, j - yShift]
        pix = 255 * (pix - POMIN) / (POMAX - POMIN)
        im_out[i, j] = bytes([int(pix)])
image_out = Image.frombytes('L', (width, height), im_out)
savepath = 'lenna_out_rev_black.png'
image_out.save(savepath, 'png')
