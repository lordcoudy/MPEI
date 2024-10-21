from PIL import Image
import numpy as numpy
import matplotlib.pyplot as pyplot
import math as math
import random
 

from sklearn.model_selection import train_test_split
from sklearn.neural_network import MLPClassifier
from sklearn.model_selection import KFold
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import GridSearchCV
from sklearn import preprocessing
from sklearn.preprocessing import StandardScaler


responses=numpy.zeros((1000,100))
responses_type=numpy.zeros(1000)
#dQ=0.055
w0=0.1
dt=0.1/w0
#Q=dQ

#filling the database
for i in range(0,1000):
    Q = random.random()
    w0=0.05+0.1*random.random()    
    V=random.randint(0,2)
    if Q<0.5:
        responses_type[i]=-1
        D=math.sqrt(w0*w0*(1/(Q*Q)-4))
        l1=(-w0/Q-D)/2
        l2=(-w0/Q+D)/2
        for j in range (0, 100):
            t=(j)*dt
            if V==0:
                responses[i,j]=1*math.exp(l1*t)-1*math.exp(l2*t)
            if V>0:
                responses[i,j]=V-0.75*V*math.exp(l1*t)-0.25*V*math.exp(l2*t)
    if Q>0.5:
        responses_type[i]=1
        D=math.sqrt(w0*w0*(4-1/(Q*Q)))
        l1=(-w0/Q)/2
        l2=D/2
        for j in range (0, 100):
            t=(j)*dt
            if V==0:
                responses[i,j]=1*(math.exp(l1*t)*math.sin(l2*t))
            if V>0:
                responses[i,j]=V-V*(math.exp(l1*t)*math.sin(l2*t+3.14159265/2))            

pyplot.plot(responses[12,:], 'o')
pyplot.show()
#train the net

param_grid = {'max_iter':[1000], 'activation': ['tanh'], 'alpha':[0.65], 'hidden_layer_sizes':[(10),(10),(10)], 'solver': ['lbfgs'], 'verbose':[True]}
grid_search = GridSearchCV(MLPClassifier(), param_grid, cv = 4)
grid_search.fit(responses, responses_type)


#filling the test database


dt=0.1/w0
test_responses=numpy.zeros((500,100))
test_responses_type=numpy.zeros(500)
for i in range(0,500):
    Q = random.random()
    w0=0.05+0.1*random.random()
    V=random.randint(0,2)
    if Q<=0.5:
        test_responses_type[i]=-1
        D=math.sqrt(w0*w0*(1/(Q*Q)-4))
        l1=(-w0/Q-D)/2
        l2=(-w0/Q+D)/2
        for j in range (0, 100):
            t=(j)*dt
            if V==0:
                test_responses[i,j]=1*math.exp(l1*t)-1*math.exp(l2*t)
            if V>0:
                test_responses[i,j]=V-0.75*V*math.exp(l1*t)-0.25*V*math.exp(l2*t)
    if Q>0.5:
        test_responses_type[i]=1
        D=math.sqrt(w0*w0*(4-1/(Q*Q)))
        l1=(-w0/Q)/2
        l2=D/2
        for j in range (0, 100):
            t=(j)*dt
            if V==0:
                test_responses[i,j]=1*(math.exp(l1*t)*math.sin(l2*t))
            if V>0:
                test_responses[i,j]=V-V*(math.exp(l1*t)*math.sin(l2*t+3.14159265/2))             
   


print(test_responses_type)

score = grid_search.predict(test_responses)
print(score)
print(abs(score-test_responses_type))
pyplot.plot(test_responses[7,:], 'o')
pyplot.show()
