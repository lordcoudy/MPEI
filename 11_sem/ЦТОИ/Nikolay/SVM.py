import numpy
import matplotlib.pyplot as pyplot
import math as math
import random
from sklearn.neural_network import MLPClassifier
from sklearn.model_selection import GridSearchCV
import scipy
from scipy.fftpack import idct, dct
from sklearn import preprocessing
from sklearn.preprocessing import StandardScaler
from sklearn.svm import SVC
from sklearn.pipeline import make_pipeline

w0 = 0.1        # ������� ������� (��� ���������� ������ "���������" � X=0)
dt = 0.1 / w0

V = 0           # �������� ������� �� ��� Y
V1 = 1          # ����������� ��� ���������� 1
V2 = -1         # ����������� ��� ���������� 1
p = 0           # �������� ������� �� ��� X (�������� ������ ��� �������������� ��������)
AN = 0          # ���������� ��� ����������� ���������� ���� (���������� �������� �����)

countOflearningSet = 80         # ���������� ����������� � ��������� ������
countOfTestSet = 20             # ���������� ����������� � ����������� ������
countOfPoints = 100             # ���������� ����� ��� ���������� ��������
countOfPointsInSignal = 2048    # ���������� ����� � �������

signal = numpy.zeros(countOfPointsInSignal)  # ������, ������� �� ����� �� ������� ��������� �����

responses = numpy.zeros((countOflearningSet, countOfPoints))    # ������ �������� ��� �������� ���������
responses_type = numpy.zeros(countOflearningSet)                # ��� ������� (1 - �������������; -1 - ��������������)

test_responses = numpy.zeros((countOfTestSet, countOfPoints))   # ������ �������� ��� �������� ���������
test_responses_type = numpy.zeros(countOfTestSet)               # ��� ������� (1 - �������������; -1 - ��������������)

numberOfGraphForShowing = 12

# Q < 0.5 - �������������� ������� (��� ������, ��� ��������� �������� ������)
# Q > 0.5 - ������������� ������� (��� ������, ��� ������ �������� ���������)

# ���������� ���������� ������:
for i in range(0, countOflearningSet):
    Q = random.random()
    if Q < 0.5:
        responses_type[i] = -1
        D = math.sqrt(w0 * w0 * (1 / (Q * Q) - 4))
        l1 = (-w0 / Q - D) / 2
        l2 = (-w0 / Q + D) / 2
        for j in range(0, countOfPointsInSignal):
            t = (j) * dt
            signal[j] = V1 * math.exp(l1 * t) + V2 * math.exp(l2 * t) + V + (random.random() - 0.5) * AN
            
    if Q > 0.5:
        Q = (Q - 0.5) * 19 + 0.5
        responses_type[i] = 1
        D = math.sqrt(w0 * w0 * (4 - 1 / (Q * Q)))
        l1 = (-w0 / Q) / 2
        l2 = D / 2
        for j in range(0, countOfPointsInSignal):
            t = (j) * dt
            signal[j] = V1 * (math.exp(l1 * t) * math.sin(l2 * t + p )) + V + (random.random() - 0.5) * AN

    signal = dct(signal)
    for j in range (0, countOfPoints):
        responses[i, j] = signal[j + 0]
        
# ���������� ������ �� ��������� �������� ("o-" - ���������� ����� �� ������� ����������, ����� �����������):
pyplot.plot(responses[numberOfGraphForShowing, :], "o-")
pyplot.show()

# ��������:
cl = make_pipeline(StandardScaler(), SVC(kernel = 'rbf', gamma = 'auto'))
cl.fit(responses, responses_type)

# ���������� ������������ ������:
for i in range(0, countOfTestSet):
    Q = random.random()
    if Q <= 0.5:
        test_responses_type[i] = -1
        D = math.sqrt(w0 * w0 * (1 / (Q * Q) - 4))
        l1 = (-w0 / Q - D) / 2
        l2 = (-w0 / Q + D) / 2
        for j in range(0, countOfPointsInSignal):
            t = (j) * dt
            signal[j] = V1 * math.exp(l1 * t) + V2 * math.exp(l2 * t) + V + (random.random() - 0.5) * AN
            
    if Q > 0.5:
        Q = (Q - 0.5) * 19 + 0.5
        test_responses_type[i] = 1
        D = math.sqrt(w0 * w0 * (4 - 1 / (Q * Q)))
        l1 = (-w0 / Q) / 2
        l2 = D / 2
        for j in range(0, countOfPointsInSignal):
            t = (j) * dt
            signal[j] = V1 * (math.exp(l1 * t) * math.sin(l2 * t + p )) + V + (random.random() - 0.5) * AN

    signal = dct(signal)
    for j in range (0, countOfPoints):
        responses[i, j] = signal[j + 0]
        
# ������������ ������ ��� ��������:
test_responses = min_max_scaler.fit_transform(test_responses)

# ��������� ������� � ��������:
score = cl.predict(test_responses)

TP = 0  # TruePositive - ����� �������� �������, ��� ������� �������������, � �� �������������
TN = 0  # TrueNegative - ����� �������� �������, ��� ������� ��������������, � �� ��������������
FP = 0  # FalsePositive - ����� �������� �������, ��� ������� �������������, � �� ��������������
FN = 0  # FalseNegative - ����� �������� �������, ��� ������� ��������������, � �� �������������

for i in range(0, countOfTestSet):
    if score[i] == -1:
        if test_responses_type[i] == score[i]:
            TN += 1
        else:
            FN += 1
    # score[i] == 1
    else:
        if test_responses_type[i] == score[i]:
            TP += 1
        else:
            FP += 1
            
print("TP = ", TP, ",  TN = ", TN, ",  FP = ", FP, ",  FN = ", FN)

# ������� ������:
accuracy = (TP + TN) / (TP + TN + FP + FN)
precision = TP / (TP + FP)
sensetivity = TP / (TP + FN)
specificity = TN / (TN + FP)

Pr = TP / (TP + FP)
Re = TP / (TP + FN)
F_mera = (2 * Pr * Re) / (Pr + Re)

print("accuracy = ", accuracy)
print("precision = ", precision)
print("sensetivity = ", sensetivity)
print("specificity = ", specificity)
print("F_mera = ", F_mera)

print(test_responses_type)
print(score)
print(abs(score - test_responses_type))