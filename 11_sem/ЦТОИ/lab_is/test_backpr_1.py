import numpy as numpy
import matplotlib.pyplot as pyplot
import math as math
import random
from sklearn.neural_network import MLPClassifier
from sklearn.model_selection import GridSearchCV



responses=numpy.zeros((5000,200))
responses_type=numpy.zeros(5000)
dQ=0.055

dt=1
Q=dQ

#filling the database
for i in range(0,5000):
    Q=random.random()
    w0=random.random()*0.25
    V=(random.random()-0.5)*10
    V1=(random.random()-0.5)*10
    V2=(random.random()-0.5)*10
    p=(random.random()-0.5)*3
    if Q<0.5:
        responses_type[i]=-1
        D=math.sqrt(w0*w0*(1/(Q*Q)-4))
        l1=(-w0/Q-D)/2
        l2=(-w0/Q+D)/2
        for j in range (0, 200):
            t=(j)*dt
            responses[i,j]=V1*math.exp(l1*t)+V2*math.exp(l2*t)+V
    if Q>0.5:
        responses_type[i]=1
        D=math.sqrt(w0*w0*(4-1/(Q*Q)))
        l1=(-w0/Q)/2
        l2=D/2
        for j in range (0, 200):
            t=(j)*dt
            responses[i,j]=V1*(math.exp(l1*t)*math.sin(l2*t+p))+V            
   
pyplot.plot(responses[12,:], 'o')
pyplot.show()
#train the net

param_grid = {'max_iter':[1000], 'activation': ['tanh'], 'alpha':[0.65], 'hidden_layer_sizes':[(25),(15),(5)], 'solver': ['lbfgs'], 'verbose':[True]}
grid_search = GridSearchCV(MLPClassifier(), param_grid, cv = 2)
grid_search.fit(responses, responses_type)


#filling the test database


dt=1
test_responses=numpy.zeros((50,200))
test_responses_type=numpy.zeros(50)
for i in range(0,50):
    Q = random.random()
    w0=random.random()*0.25
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
        for j in range (0, 200):
            t=(j)*dt
            test_responses[i,j]=V1*math.exp(l1*t)-V2*math.exp(l2*t)+V
    if Q>0.5:
        test_responses_type[i]=1
        D=math.sqrt(w0*w0*(4-1/(Q*Q)))
        l1=(-w0/Q)/2
        l2=D/2
        for j in range (0, 200):
            t=(j)*dt
            test_responses[i,j]=V1*(math.exp(l1*t)*math.sin(l2*t+p))+V            
   


print(test_responses_type)

score = grid_search.predict(test_responses)
print(score)
print(abs(score-test_responses_type))

