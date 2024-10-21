import numpy
import matplotlib.pyplot as pyplot
import math as math
import random
from sklearn.neural_network import MLPClassifier
from sklearn.model_selection import GridSearchCV
from sklearn import preprocessing
from sklearn.preprocessing import StandardScaler

w0 = 0.1        # угловая частота (при увеличении график "сжимается" к X=0)
dt = 0.1 / w0

V = 0           # смещение графика по оси Y
V1 = 1          # коэффициент при экспоненте 1
V2 = -1         # коэффициент при экспоненте 1
p = 0           # смещение графика по оси X (работает только для колебательного процесса)
AN = 0          # переменная для дальнейшего добавления шума (случайного смещения точек)

countOflearningSet = 80     # количество экземпляров в обучающем наборе
countOfTestSet = 20         # количество экземпляров в проверочном наборе
countOfPoints = 100         # количество точек для построения графиков

responses = numpy.zeros((countOflearningSet, countOfPoints))    # массив графиков для обучения нейросети
responses_type = numpy.zeros(countOflearningSet)                # тип графика (1 - колебательный; -1 - апериодический)

test_responses = numpy.zeros((countOfTestSet, countOfPoints))   # массив графиков для проверки нейросети
test_responses_type = numpy.zeros(countOfTestSet)               # тип графика (1 - колебательный; -1 - апериодический)

numberOfGraphForShowing = 12

# Q < 0.5 - апериодический процесс (чем меньше, тем медленнее затухает график)
# Q > 0.5 - колебательный процесс (чем больше, тем слабее затухают колебания)

# заполнение обучающего набора:
for i in range(0, countOflearningSet):
    Q = random.random()
    if Q < 0.5:
        responses_type[i] = -1
        D = math.sqrt(w0 * w0 * (1 / (Q * Q) - 4))
        l1 = (-w0 / Q - D) / 2
        l2 = (-w0 / Q + D) / 2
        for j in range(0, countOfPoints):
            t = (j) * dt
            responses[i, j] = V1 * math.exp(l1 * t) + V2 * math.exp(l2 * t) + V
            
    if Q > 0.5:
        Q = (Q - 0.5) * 19 + 0.5
        responses_type[i] = 1
        D = math.sqrt(w0 * w0 * (4 - 1 / (Q * Q)))
        l1 = (-w0 / Q) / 2
        l2 = D / 2
        for j in range(0, countOfPoints):
            t = (j) * dt
            responses[i, j] = V1 * (math.exp(l1 * t) * math.sin(l2 * t + p)) + V

# нормализация данных для обучения:
min_max_scaler = preprocessing.MinMaxScaler()
responses = min_max_scaler.fit_transform(responses)

# построение одного из созданных графиков ("o-" - отображать точки на графики кружочками, линия неприрывная):
pyplot.plot(responses[numberOfGraphForShowing, :], "o-")
pyplot.show()

# обучение нейросети ("многоклеточный" перцептрон):
param_grid = {"max_iter": [1000], "activation": ["tanh"], "alpha": [0.65],
              "hidden_layer_sizes": [(3), (5), (2)], "solver": ["lbfgs"], "verbose": [True],}
grid_search = GridSearchCV(MLPClassifier(), param_grid, cv=2)
grid_search.fit(responses, responses_type)

# заполнение проверочного набора:
for i in range(0, countOfTestSet):
    Q = random.random()
    if Q <= 0.5:
        test_responses_type[i] = -1
        D = math.sqrt(w0 * w0 * (1 / (Q * Q) - 4))
        l1 = (-w0 / Q - D) / 2
        l2 = (-w0 / Q + D) / 2
        for j in range(0, countOfPoints):
            t = (j) * dt
            test_responses[i, j] = V1 * math.exp(l1 * t) + V2 * math.exp(l2 * t) + V
            
    if Q > 0.5:
        Q = (Q - 0.5) * 19 + 0.5
        test_responses_type[i] = 1
        D = math.sqrt(w0 * w0 * (4 - 1 / (Q * Q)))
        l1 = (-w0 / Q) / 2
        l2 = D / 2
        for j in range(0, countOfPoints):
            t = (j) * dt
            test_responses[i, j] = V1 * (math.exp(l1 * t) * math.sin(l2 * t + p)) + V

# нормализация данных для проверки:
test_responses = min_max_scaler.fit_transform(test_responses)

# получение массива с ответами нейросети для всех тестов:
score = grid_search.predict(test_responses)

TP = 0  # TruePositive - когда нейронка сказала, что процесс колебательный, а он колебательный
TN = 0  # TrueNegative - когда нейронка сказала, что процесс апериодический, а он апериодический
FP = 0  # FalsePositive - когда нейронка сказала, что процесс колебательный, а он апериодический
FN = 0  # FalseNegative - когда нейронка сказала, что процесс апериодический, а он колебательный

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

# подсчет метрик:
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