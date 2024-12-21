from PIL import Image
import numpy as numpy
import math

lut = numpy.zeros((9,9,9,3))

filename = 'трпкрп/LUT9A.txt'
count=0
with open(filename) as file:
    for i in range(0,9):
        for j in range(0,9):
            for k in range(0,9):
                for c in range(0,3):
                    lut[i,j,k,c]= float(file.readline())

  
        

def gamma(r,g,b):
    r=float(r/32)
    g=float(g/32)
    b=float(b/32)


    if r==8:
        r1=8
        r2=8
    if r<8:
        r1=int(math.floor(r))
        r2= r1+1

    if g==8:
        g1=8
        g2=8
    if g<8:
        g1=int(math.floor(g))
        g2= g1+1


    if b==8:
        b1=8
        b2=8
    if b<8:
        b1=int(math.floor(b))
        b2= b1+1


    Kub111=lut[r1,g1,b1]
    Kub112=lut[r1,g1,b2]
    Kub121=lut[r1,g2,b1]
    Kub122=lut[r1,g2,b2]
    Kub211=lut[r2,g1,b1]
    Kub212=lut[r2,g1,b2]
    Kub221=lut[r2,g2,b1]
    Kub222=lut[r2,g2,b2]


    resR=(Kub111[0]*(r2-r)*(g2-g)*(b2-b)/((r2-r1)*(g2-g1)*(b2-b1))+
          Kub112[0]*(r2-r)*(g2-g)*(b-b1)/((r2-r1)*(g2-g1)*(b2-b1))+
          Kub121[0]*(r2-r)*(g-g1)*(b2-b)/((r2-r1)*(g2-g1)*(b2-b1))+
          Kub122[0]*(r2-r)*(g-g1)*(b-b1)/((r2-r1)*(g2-g1)*(b2-b1))+
          Kub211[0]*(r-r1)*(g2-g)*(b2-b)/((r2-r1)*(g2-g1)*(b2-b1))+
          Kub212[0]*(r-r1)*(g2-g)*(b-b1)/((r2-r1)*(g2-g1)*(b2-b1))+
          Kub221[0]*(r-r1)*(g-g1)*(b2-b)/((r2-r1)*(g2-g1)*(b2-b1))+
          Kub222[0]*(r-r1)*(g-g1)*(b-b1)/((r2-r1)*(g2-g1)*(b2-b1)))


    resB=(Kub111[2]*(r2-r)*(g2-g)*(b2-b)/((r2-r1)*(g2-g1)*(b2-b1))+
          Kub112[2]*(r2-r)*(g2-g)*(b-b1)/((r2-r1)*(g2-g1)*(b2-b1))+
          Kub121[2]*(r2-r)*(g-g1)*(b2-b)/((r2-r1)*(g2-g1)*(b2-b1))+
          Kub122[2]*(r2-r)*(g-g1)*(b-b1)/((r2-r1)*(g2-g1)*(b2-b1))+
          Kub211[2]*(r-r1)*(g2-g)*(b2-b)/((r2-r1)*(g2-g1)*(b2-b1))+
          Kub212[2]*(r-r1)*(g2-g)*(b-b1)/((r2-r1)*(g2-g1)*(b2-b1))+
          Kub221[2]*(r-r1)*(g-g1)*(b2-b)/((r2-r1)*(g2-g1)*(b2-b1))+
          Kub222[2]*(r-r1)*(g-g1)*(b-b1)/((r2-r1)*(g2-g1)*(b2-b1)))


    resG=(Kub111[0]*(r2-r)*(g2-g)*(b2-b)/((r2-r1)*(g2-g1)*(b2-b1))+
          Kub112[0]*(r2-r)*(g2-g)*(b-b1)/((r2-r1)*(g2-g1)*(b2-b1))+
          Kub121[0]*(r2-r)*(g-g1)*(b2-b)/((r2-r1)*(g2-g1)*(b2-b1))+
          Kub122[0]*(r2-r)*(g-g1)*(b-b1)/((r2-r1)*(g2-g1)*(b2-b1))+
          Kub211[0]*(r-r1)*(g2-g)*(b2-b)/((r2-r1)*(g2-g1)*(b2-b1))+
          Kub212[0]*(r-r1)*(g2-g)*(b-b1)/((r2-r1)*(g2-g1)*(b2-b1))+
          Kub221[0]*(r-r1)*(g-g1)*(b2-b)/((r2-r1)*(g2-g1)*(b2-b1))+
          Kub222[0]*(r-r1)*(g-g1)*(b-b1)/((r2-r1)*(g2-g1)*(b2-b1)))

    return int(resR*256),int(resG*256),int(resB*256)

filename = "tiger.png"
image = Image.open(filename)
width, height = image.size
print(width)
print(height)

im = image.load()

arr = numpy.asarray(image)
arr1 = numpy.zeros((height, width, 3), 'uint8')


for i in range (0,height):
    for j in range(0,width):
        rs,gs,bs=gamma(arr[i,j,0],arr[i,j,1],arr[i,j,2])
        arr1[i,j,0]=rs #Red
        arr1[i,j,1]=gs#Green
        arr1[i,j,2]=bs #Blue

image_out = Image.frombuffer('RGB', (width, height), arr1)
image_out.save('out.png', 'png')
