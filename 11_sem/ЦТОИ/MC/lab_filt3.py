import sys
from PIL import Image
import numpy as numpy



filename = "2g.bmp"
image=Image.open(filename).convert('L')
width, height = image.size
print(width)
print(height)
im = image.load()
N=3
M=1
h=numpy.ones((3,3))/9
print(h)
#h[0,0]=-307
#h[1,0]=-307
#h[0,1]=-307
#h[1,1]=1024

pic_out=numpy.zeros((height,width))
im_out=numpy.zeros((height,width),'bytes')
for i in range(0,height):
    for j in range(0,width):
        pix=0
        for ii in range(-M,M+1):
            for jj in range(-M,M+1):
                if ((i+ii)>(-1))&((j+jj)>(-1))&((i+ii)<(height))&((j+jj)<(width)):
                    index_i=i+ii
                    index_j=jj+j
                if ((i+ii)<(0)):
                    index_i=i-ii
                if ((j+jj)<(0)):
                    index_j=j-jj
                if ((i+ii)>(height-1)):
                    index_i=i-ii
                if ((j+jj)>(width-1)):
                    index_j=j-jj
                pix+=float(im[index_j,index_i])*h[jj+M,ii+M]                     
        pic_out[i,j]=pix

POMAX=0;
POMIN=0;
for i in range(0,(height)):
    for j in range(0,(width)):
        if pic_out[i,j]>POMAX:
            POMAX=pic_out[i,j]
        if pic_out[i,j]<POMIN:
            POMIN=pic_out[i,j]
           
for i in range(0,(height)):
    for j in range(0,(width)):
        pix=pic_out[i,j]
        pix=255*(pix-POMIN)/(POMAX-POMIN)
        im_out[i,j]=bytes([int(pix)])

result = numpy.array(im) - im_out
image_out=Image.frombytes('L', (width,height), result)
savepath = 'blured.png'
image_out.save(savepath,'png')
