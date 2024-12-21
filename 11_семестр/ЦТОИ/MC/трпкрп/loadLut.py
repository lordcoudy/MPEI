import numpy
from PIL import Image
import linearInterpolation as li

filename = "../tiger.png"

lutfile = open("LUT9A.txt")

lut9a = numpy.zeros((9, 9, 9, 3))

for i in range(0, 9):
    for j in range(0, 9):
        for k in range(0, 9):
            lut9a[i,j,k, 0] = float(lutfile.readline())
            lut9a[i,j,k, 1] = float(lutfile.readline())
            lut9a[i,j,k, 2] = float(lutfile.readline())

print(lut9a)

image=Image.open(filename)
width, height = image.size
print(width)
print(height)

im = image.load()

arr = numpy.asarray(image.convert('RGB'))
l = numpy.zeros((height, width, 3), 'uint8')

for i in range (0,height):
    for j in range(0,width):
        R = arr[i,j,0] // 32
        G = arr[i,j,1] // 32
        B = arr[i,j,2] // 32
        # Rc = li.LinearInterpolation(arr[i, j, 0], lut9a[R, G, B, 0], lut9a[R + 1, G, B, 0])
        # Gc = li.LinearInterpolation(arr[i, j, 1], lut9a[R, G, B, 1], lut9a[R, G + 1, B, 1])
        # Bc = li.LinearInterpolation(arr[i, j, 2], lut9a[R, G, B, 2], lut9a[R, G, B + 1, 2])\
        c = li.triLinear(arr[i, j, 0], arr[i, j, 1], arr[i, j, 2], lut9a)
        l[i,j,0]=int(c[0] * 255) #Hue
        l[i,j,1]=int(c[1] * 255)#Saturation
        l[i,j,2]=int(c[2] * 255) #Vividness
        # l[i,j,0]=int(lut9a[R, G, B, 0] * 255) #Hue
        # l[i,j,1]=int(lut9a[R, G, B, 1] * 255) #Saturation
        # l[i,j,2]=int(lut9a[R, G, B, 2] * 255) #Vividness

image_out=Image.fromarray(l, mode='RGB')
image_out.convert('RGB').save('output.png', 'PNG')