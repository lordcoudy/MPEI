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
print(arr)

for i in range (0,cropSize):
    for j in range(0,cropSize):
        crop[i,j] = arr[i + xShift,j + yShift]

image_out=Image.fromarray(crop, mode='L')
image_out.convert('L').save('lenna_crop.png', 'PNG')
image_out=Image.fromarray(arr, mode='L')
image_out.convert('L').save('lenna_1.png', 'PNG')

M = numpy.average(arr)
Mcrop = numpy.average(crop)

out_arr = numpy.zeros((width, height))
maxV = 0
maxI, maxJ = 0, 0
for i in range (0,height-cropSize):
    for j in range(0,width-cropSize):
        for ii in range (0, cropSize):
            for jj in range (0, cropSize):
                out_arr[i,j] += (arr[i+ii,j+jj] - M)*(crop[ii,jj] - Mcrop)
        if maxV < out_arr[i,j]:
            maxV = out_arr[i,j]
            maxI = i
            maxJ = j
print(maxV, ": ",maxI," ", maxJ)
im_out = numpy.zeros((width, height), 'bytes')
POMAX = 0;
POMIN = 0;
for i in range(0, (width)):
    for j in range(0, (height)):
        if out_arr[i, j] > POMAX:
            POMAX = out_arr[i, j]
        if out_arr[i, j] < POMIN:
            POMIN = out_arr[i, j]

for i in range(0, (width)):
    for j in range(0, (height)):
        pix = out_arr[i, j]
        pix = 255 * (pix - POMIN) / (POMAX - POMIN)
        im_out[i, j] = bytes([int(pix)])
image_out = Image.frombytes('L', (width, height), im_out)
savepath = 'lenna_out_rev.png'
image_out.save(savepath, 'png')
