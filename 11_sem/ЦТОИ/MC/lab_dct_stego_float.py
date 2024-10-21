#!/usr/bin/env python3
import sys
from PIL import Image
import numpy as numpy
import scipy
from scipy.fftpack import idctn, dctn
text_2_hide='The quick brown fox jumps over the lazy dog'
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
dct_im_q=numpy.zeros((width,height),'int')
IMAX=0
for i in range(0,(width)):
    for j in range(0,(height)):
        if im[i,j]>IMAX:
            IMAX=im[i,j]

for i in range(0,(width)):
    for j in range(0,(height)):
        pic_in[i,j]=float(im[i,j])
dct_im=dctn(pic_in)

for i in range(400,500):
    for j in range(400,500):
        dct_im[i,j]=0
for i in range(0,len(text_2_hide)):
    dct_im[450,425+i]=ord(text_2_hide[i])*1000


        
pic_out=idctn(dct_im)#/height/width/4

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
        pix=IMAX*(pix-POMIN)/(POMAX-POMIN)
        im_out[j,i]=bytes([int(pix)])
image_out=Image.frombytes('L', (width,height), im_out)
savepath = 'lab_dct_stego_result.png'
image_out.save(savepath,'png') 
