import numpy as numpy
import matplotlib.pyplot as pyplot
import math as math
import random
from sklearn.neural_network import MLPClassifier
from sklearn.model_selection import GridSearchCV
from operator import * 

responses=numpy.zeros((1000,100))
responses_type=numpy.zeros(1000)
dQ=0.055
w0=0.1
dt=0.1/w0
Q=dQ

#filling the database
for i in range(0,1000):
    Q=random.random()
    V=5
    V1=1
    V2=-1
    p=0
    if Q<0.5:
        responses_type[i]=-1
        D=math.sqrt(w0*w0*(1/(Q*Q)-4))
        l1=(-w0/Q-D)/2
        l2=(-w0/Q+D)/2
        for j in range (0, 100):
            t=(j)*dt
            responses[i,j]=V1*math.exp(l1*t)+V2*math.exp(l2*t)+V
    if Q>0.5:
        Q = (Q - 0.5) * 19 + 0.5
        responses_type[i]=1
        D=math.sqrt(w0*w0*(4-1/(Q*Q)))
        l1=(-w0/Q)/2
        l2=D/2
        for j in range (0, 100):
            t=(j)*dt
            responses[i,j]=V1*(math.exp(l1*t)*math.sin(l2*t+p))+V            

#train the net

param_grid = {'max_iter':[10], 'activation': ['tanh'], 'alpha':[0.65], 'hidden_layer_sizes':[(1)], 'solver': ['lbfgs'], 'verbose':[True]}
grid_search = GridSearchCV(MLPClassifier(), param_grid, cv = 2)
grid_search.fit(responses, responses_type)

#filling the test database
w0=0.1
dt=0.1/w0
test_responses=numpy.zeros((50,100))
test_responses_type=numpy.zeros(50)
for i in range(0,50):
    Q=random.random()
    V=-2
    V1=1
    V2=-1
    p=0
    #print(Q)
    if Q<0.5:
        test_responses_type[i]=-1
        D=math.sqrt(w0*w0*(1/(Q*Q)-4))
        l1=(-w0/Q-D)/2
        l2=(-w0/Q+D)/2
        for j in range (0, 100):
            t=(j)*dt
            test_responses[i,j]=V1*math.exp(l1*t)+V2*math.exp(l2*t)+V
    if Q>0.5:
        Q = (Q - 0.5) * 19 + 0.5
        test_responses_type[i]=1
        D=math.sqrt(w0*w0*(4-1/(Q*Q)))
        l1=(-w0/Q)/2
        l2=D/2
        for j in range (0, 100):
            t=(j)*dt
            test_responses[i,j]=V1*(math.exp(l1*t)*math.sin(l2*t+p))+V            
   

# print(test_responses_type)

score = grid_search.predict(test_responses)
print('Score:', score)
print('-'*100)
print('Test responses type:', test_responses_type)
print('-'*100)
print('Score - Test responses type:', abs(score - test_responses_type))

delta = abs(score - test_responses_type)
TP = countOf(delta, 1)
TN = countOf(delta, 0)
FP = countOf(delta, -1)
FN = countOf(delta, 2)
# print(1 - (countOf(abs(score - test_responses_type), 2) / len(score)))
print("A = (TP + TN) / (TP + TN + FP + FN): ", (TP + TN) / (TP + TN + FP + FN))

# Plotting both the curves simultaneously
pyplot.plot(responses[12,:], 'o-', color='r', label='responses')
pyplot.plot(test_responses[12,:], 'o-', color='g', label='test_responses')

# Adding legend, which helps us recognize the curve according to it's color
pyplot.legend()

# To load the display window
pyplot.show()
   