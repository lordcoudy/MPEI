import sys
from PIL import Image
import numpy as numpy



filename = "2g.bmp"
image=Image.open(filename).convert('L')
width, height = image.size
print(width)
print(height)
#print(image)
im = image.load()
#print(im[4,4])
# allocate memory
M=1
hB=numpy.zeros((3,3))
for i in range(0,3):
    for j in range(0,3):
        hB[i,j]=0
hB[1,1]=1  
N=2
hA=numpy.zeros((2,2))
for i in range(0,2):
    for j in range(0,2):
        hA[i,j]=0.315
hA[0,0]=0

pic_out=numpy.zeros((width,height))
im_out=numpy.zeros((width,height),'bytes')
for i in range(0,width):
    for j in range(0,height):
        pix=0
        for ii in range(-M,M+1):
            for jj in range(-M,M+1):
                if ((i+ii)>(-1))&((j+jj)>(-1))&((i+ii)<(width))&((j+jj)<(height)):
                    index_i=i+ii
                    index_j=jj+j
                if ((i+ii)<(0)):
                    index_i=i-ii
                if ((j+jj)<(0)):
                    index_j=j-jj
                if ((i+ii)>(width-1)):
                    index_i=i-ii
                if ((j+jj)>(height-1)):
                    index_j=j-jj
                pix=pix+float(im[index_i,index_j])*hB[ii+M,jj+M]
        pic_out[i,j]=pix
        pix=pic_out[i,j]
        for ii in range(0,N):
            for jj in range(0,N):
                if ((i-ii)>(-1))&((j-jj)>(-1)):
                   pix=pix+pic_out[i-ii,j-jj]*hA[ii,jj]              
        pic_out[i,j]=pix

POMAX=0;
POMIN=0;
for i in range(0,(width)):
    for j in range(0,(height)):
        if pic_out[i,j]>POMAX:
            POMAX=pic_out[i,j]
        if pic_out[i,j]<POMIN:
            POMIN=pic_out[i,j]
           
for i in range(0,(width)):
    for j in range(0,(height)):
        pix=pic_out[i,j]
        pix=255*(pix-POMIN)/(POMAX-POMIN)
        im_out[j,i]=bytes([int(pix)])
image_out=Image.frombytes('L', (width,height), im_out)
savepath = '-result-.png'
image_out.save(savepath,'png')
