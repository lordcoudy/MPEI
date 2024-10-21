#!/usr/bin/env python3
import sys
from PIL import Image
import numpy as numpy
import scipy
from scipy.fftpack import idctn, dctn

#img = Image.open(path)     
# On successful execution of this statement, 
# an object of Image type is returned and stored in img variable) 
filename = "2g.bmp"
image=Image.open(filename).convert('L')
width, height = image.size 
print(width)
print(height)
im = image.load()
#print(im[4,4])
# allocate memory
M=1
pic_out=numpy.zeros((width,height))
pic_in=numpy.zeros((width,height))
im_out=numpy.zeros((width,height),'bytes')
for i in range(0,(width)):
    for j in range(0,(height)):
        pic_in[i,j]=float(im[i,j])
dct_im=dctn(pic_in)

for i in range(450,(width)):  #N
    for j in range(450,(height)):  #N
        dct_im[i,j]=float(dct_im[i,j]*0)

        
pic_out=idctn(dct_im)

POMAX=0;
POMIN=0;
for i in range(200,(width)):
    for j in range(200,(height)):
        if pic_out[i,j]>POMAX:
            POMAX=pic_out[i,j]
        if pic_out[i,j]<POMIN:
            POMIN=pic_out[i,j]
            
for i in range(150,(width)):
    for j in range(150,(height)):
        pix=pic_out[i,j]
        pix=255*(pix-POMIN)/(POMAX-POMIN)
        im_out[i,j]=bytes([int(pix)])
image_out=Image.frombytes('L', (width,height), im_out)
savepath = 'resгде.png'
image_out.save(savepath,'png') 
