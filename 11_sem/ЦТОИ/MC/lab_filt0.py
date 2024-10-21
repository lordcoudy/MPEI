import sys
from PIL import Image
import numpy as numpy



filename = "2g.bmp"
image=Image.open(filename).convert('L')
width, height = image.size
print(width)
print(height)

im = image.load()

N=19
M=N//2
h=numpy.zeros((N,N))
for i in range(0,N):
    for j in range(0,N):
        h[i,j]=1/N/N

pic_out=numpy.zeros((height,width))
im_out=numpy.zeros((height,width),'bytes')
for i in range(0,height):
    for j in range(0,width):
        pix=0
        for ii in range(-M,M+1):
            for jj in range(-M,M+1):
                if ((i+ii)>(-1))&((j+jj)>(-1))&((i+ii)<(height))&((j+jj)<(width)):
                    pix=pix+float(im[j+jj,i+ii])*h[jj+M,ii+M]                     
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
image_out=Image.frombytes('L', (width,height), im_out)
savepath = 'resultOOO.png'
image_out.save(savepath,'png')
