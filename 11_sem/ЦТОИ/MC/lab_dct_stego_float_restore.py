#!/usr/bin/env python3
import sys
from PIL import Image
import numpy as numpy
import scipy
from scipy.fftpack import idctn, dctn

text_2_unhide=''
#img = Image.open(path)     
# On successful execution of this statement, 
# an object of Image type is returned and stored in img variable) 
filename = "lab_dct_stego_result.png"
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


for i in range(0,(width)):
    for j in range(0,(height)):
        pic_in[i,j]=float(im[i,j])
dct_im=dctn(pic_in)



for i in range(0,43):
    text_2_unhide=chr(int(dct_im[450,425+i]/1000+0.5))
    print(text_2_unhide)

