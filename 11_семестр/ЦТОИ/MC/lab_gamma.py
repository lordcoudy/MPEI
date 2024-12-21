from PIL import Image
import numpy as numpy
import math
import linearInterpolation as li
filename = "tiger.png"
lutfile = "трпкрп/LUT9A.txt"
image=Image.open(filename)
width, height = image.size 
print(width)
print(height)

im = image.load()

gamma = 2

lut = numpy.zeros(9)
for i in range (0,9):
    lut[i]=int(255*math.pow(float(i*32 - (i*32)//255)/255,gamma))
    print(i,": ", lut[i])

lu9a = open(lutfile)

arr = numpy.asarray(image.convert('RGB'))
l = numpy.zeros((height, width, 3), 'uint8')

for i in range (0,height):
    for j in range(0,width):

        l[i,j,0]=li.LinearInterpolation(arr[i,j,0], lut) #Hue
        l[i,j,1]=li.LinearInterpolation(arr[i,j,1], lut) #Saturation
        l[i,j,2]=li.LinearInterpolation(arr[i,j,2], lut) #Vividness

image_out=Image.fromarray(l, mode='RGB')
image_out.convert('RGB').save('interpol.png', 'PNG')

# image_out=Image.frombuffer('RGB', (width,height), l)
# image_out.save('result.png','png')

# Эталон
lut256 = numpy.zeros(256)
for i in range (0,256):
    lut256[i]=int(255*math.pow(float(i)/255,gamma))

l_ref = numpy.zeros((height, width, 3), "uint8")

for i in range (0,height):
    for j in range(0,width):

        l_ref[i,j,0]=lut256[arr[i,j,0]] #Hue
        l_ref[i,j,1]=lut256[arr[i,j,1]] #Saturation
        l_ref[i,j,2]=lut256[arr[i,j,2]] #Vividness

image_out2=Image.fromarray(l_ref, mode='RGB')
image_out2.convert('RGB').save('reference.png', 'PNG')


# Сравнение l и l_ref
maxErr = 0
sum = 0

for i in range(0, height):
    for j in range(0, width):
        for k in range(0, 3):
            curVal = abs(int(l[i, j, k]) - int(l_ref[i, j, k]))
            sum += math.pow(curVal, 2)
            if curVal > maxErr:
                maxErr = curVal

MSE = math.sqrt(sum / (height * width * 3))
# MSE = numpy.square(numpy.subtract(l_ref,l)).mean() 

PSNR = 100
if MSE != 0:
    PSNR = 20 * math.log10(255 / math.sqrt(MSE))

print("Максимальная ошибка отклонения:", maxErr)
print("Среднекватратичное отклонение:", MSE)
print("Пиковое отн. сигнал-шум:", PSNR)


