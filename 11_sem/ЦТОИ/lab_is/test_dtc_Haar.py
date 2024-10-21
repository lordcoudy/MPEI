import numpy as numpy
import matplotlib.pyplot as pyplot
import math as math
import random
from sklearn.neural_network import MLPClassifier
from sklearn.model_selection import GridSearchCV
import scipy
from scipy.fftpack import idct, dct
from sklearn import preprocessing
from sklearn.preprocessing import StandardScaler
from sklearn.tree import DecisionTreeClassifier

responses=numpy.zeros((1000,256))
signal=numpy.zeros(2048)
signalH=numpy.zeros(1024)
signalL=numpy.zeros(1024)
signalLH=numpy.zeros(512)
signalLL=numpy.zeros(512)
signalLLH=numpy.zeros(256)
signalLLL=numpy.zeros(256)
responses_type=numpy.zeros(1000)
dQ=0.055
w0=0.1
dt=0.1/w0
Q=dQ
AN=0
#filling the database
for i in range(0,1000):
    Q=random.random()
    V=(random.random()-0.5)*10
    V1=(random.random()-0.5)*10
    V2=(random.random()-0.5)*10
    p=(random.random()-0.5)*3
    if Q<0.5:
        responses_type[i]=-1
        D=math.sqrt(w0*w0*(1/(Q*Q)-4))
        l1=(-w0/Q-D)/2
        l2=(-w0/Q+D)/2
        for j in range (0, 2048):
            t=(j)*dt
            if V1+V2>2:
                signal[j]=V1*math.exp(l1*t)+V2*math.exp(l2*t)+V+(random.random()-0.5)*AN
            if V1+V2<2:
                signal[j]=V1*math.exp(l1*t)+V2*math.exp(l2*t)+V
                
    if Q>0.5:
        responses_type[i]=1
        D=math.sqrt(w0*w0*(4-1/(Q*Q)))
        l1=(-w0/Q)/2
        l2=D/2
        for j in range (0, 2048):
            t=(j)*dt
            if V1+V2>2:
                signal[j]=V1*(math.exp(l1*t)*math.sin(l2*t+p))+V+(random.random()-0.5)*AN            
            if V1+V2<2:
                signal[j]=V1*(math.exp(l1*t)*math.sin(l2*t+p))+V    
##    signal=dct(signal)
##    for j in range (0, 32):
##        responses[i,j]=signal[j+0]
    for j in range (0, 1024):
        signalH[j]=0.5*(signal[2*j+1]-signal[2*j])
    for j in range (0, 1024):
        signalL[j]=0.5*(signal[2*j+1]+signal[2*j])
    for j in range (0, 512):
        signalLH[j]=0.5*(signalL[2*j+1]-signalL[2*j])
    for j in range (0, 512):
        signalLL[j]=0.5*(signalL[2*j+1]+signalL[2*j])
    for j in range (0, 256):
        signalLLH[j]=0.5*(signalLL[2*j+1]-signalLL[2*j])
    for j in range (0, 256):
        signalLLL[j]=0.5*(signalLL[2*j+1]+signalLL[2*j])
    for j in range (0, 256):
        responses[i,j]=signalLLH[j+0]      
#min_max_scaler = preprocessing.MinMaxScaler()
#responses = min_max_scaler.fit_transform(responses)

##pyplot.plot(responses[12,:], 'o')
##pyplot.show()
#train the net

##param_grid = {'max_iter':[1000], 'activation': ['tanh'], 'alpha':[0.65], 'hidden_layer_sizes':[(5)], 'solver': ['lbfgs'], 'verbose':[True]}
##grid_search = GridSearchCV(MLPClassifier(), param_grid, cv = 2)
##grid_search.fit(responses, responses_type)
dtc = DecisionTreeClassifier(random_state=0, max_depth=4)
dtc.fit(responses, responses_type)
#filling the test database
AN=0.1
w0=0.1
dt=0.1/w0
test_responses=numpy.zeros((50,256))
test_responses_type=numpy.zeros(50)
for i in range(0,50):
    Q = random.random()
    V=(random.random()-0.5)*10
    V1=(random.random()-0.5)*10
    V2=(random.random()-0.5)*10
    p=(random.random()-0.5)*3
    #print(Q)
    if Q<=0.5:
        test_responses_type[i]=-1
        D=math.sqrt(w0*w0*(1/(Q*Q)-4))
        l1=(-w0/Q-D)/2
        l2=(-w0/Q+D)/2
        for j in range (0, 2048):
            t=(j)*dt
            signal[j]=V1*math.exp(l1*t)-V2*math.exp(l2*t)+V+(random.random()-0.5)*AN
    if Q>0.5:
        test_responses_type[i]=1
        D=math.sqrt(w0*w0*(4-1/(Q*Q)))
        l1=(-w0/Q)/2
        l2=D/2
        for j in range (0, 2048):
            t=(j)*dt
            signal[j]=V1*(math.exp(l1*t)*math.sin(l2*t+p))+V+(random.random()-0.5)*AN            
   
    for j in range (0, 1024):
        signalH[j]=0.5*(signal[2*j+1]-signal[2*j])
    for j in range (0, 1024):
        signalL[j]=0.5*(signal[2*j+1]+signal[2*j])
    for j in range (0, 512):
        signalLH[j]=0.5*(signalL[2*j+1]-signalL[2*j])
    for j in range (0, 512):
        signalLL[j]=0.5*(signalL[2*j+1]+signalL[2*j])
    for j in range (0, 256):
        signalLLH[j]=0.5*(signalLL[2*j+1]-signalLL[2*j])
    for j in range (0, 256):
        signalLLL[j]=0.5*(signalLL[2*j+1]+signalLL[2*j])
    for j in range (0, 256):
        responses[i,j]=signalLLH[j+0]  

print(test_responses_type)

#test_responses = min_max_scaler.fit_transform(test_responses)
score = dtc.predict(test_responses)
print(score)
print(abs(score-test_responses_type))

