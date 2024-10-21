from PIL import Image
import numpy as numpy
import math
filename = "tiger.png"
image=Image.open(filename)
width, height = image.size 
print(width)
print(height)

im = image.load()

gamma = 1

lut = numpy.zeros(9)
for i in range (0,8):
    lut[i]=int(255*math.pow(float(i*32 - (i*32)//255)/255,gamma))
    print(lut[i])

arr = numpy.asarray(image.convert('HSV'))
l = numpy.zeros((height, width, 3), 'uint8')

for i in range (0,height):
    for j in range(0,width):

        l[i,j,0]=lut[(arr[i,j,0])//32] #Hue
        l[i,j,1]=lut[(arr[i,j,1])//32] #Saturation
        l[i,j,2]=lut[(arr[i,j,2])//32] #Vividness

image_out=Image.fromarray(l, mode='HSV')
image_out.convert('RGB').save('output.png', 'PNG')

# image_out=Image.frombuffer('RGB', (width,height), l)
# image_out.save('result.png','png')




