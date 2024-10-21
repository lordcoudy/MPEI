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
N=3
M=1
h=numpy.zeros((3,3))
h[1,1]=1
h[1,0]=-0.25
h[1,2]=-0.25
h[0,1]=-0.25
h[2,0]=-0.25


##hl=numpy.zeros((N,N))
##for i in range(0,N):
##    for j in range(0,N):
##        hl[i,j]=1/N/N

pic_out=numpy.zeros((height,width))
pic_out1=numpy.zeros((height,width))
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
                pix=pix+float(im[index_j,index_i])*h[ii+M,jj+M]                     
        pic_out[i,j]=pix
##for i in range(0,height):
##    for j in range(0,width):
##        pix=0
##        for ii in range(-M,M+1):
##            for jj in range(-M,M+1):
##                if ((i+ii)>(-1))&((j+jj)>(-1))&((i+ii)<(height))&((j+jj)<(width)):
##                    index_i=i+ii
##                    index_j=jj+j
##                if ((i+ii)<(0)):
##                    index_i=i-ii
##                if ((j+jj)<(0)):
##                    index_j=j-jj
##                if ((i+ii)>(height-1)):
##                    index_i=i-ii
##                if ((j+jj)>(width-1)):
##                    index_j=j-jj
##                pix=pix+float(im[index_j,index_i])*hl[ii+M,jj+M]                     
##        pic_out1[i,j]=pix
##for i in range(0,height):
##    for j in range(0,width):
##        pic_out[i,j]=pic_out[i,j]+0.5*pic_out1[i,j]
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
savepath = 'result1.png'
image_out.save(savepath,'png')
