import matplotlib.pyplot as plt
from matplotlib.ticker import FormatStrFormatter
import numpy as np

xArray = []
yArray = []

# f = open('.\\build\\data.txt')
f = open('data.txt')

for line in f:
    args = line.split(' ')
    xArray.append(float(args[0]))
    yArray.append(float(args[1].split('\n')[0]))


for i in range(len(xArray)):
    print(str(xArray[i]) + " " + str(yArray[i]))

fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)

x_major_ticks = np.arange(0, xArray[len(xArray) - 1] + 1,  xArray[len(xArray) - 1] / 10)
x_minor_ticks = np.arange(0, xArray[len(xArray) - 1] + 1,  xArray[len(xArray) - 1] / 40)
y_major_ticks = np.arange(0, yArray[len(yArray) - 1] + 1,  yArray[len(yArray) - 1] / 10)
y_minor_ticks = np.arange(0, yArray[len(yArray) - 1] + 1,  yArray[len(yArray) - 1] / 40)


ax.set_xticks(x_major_ticks)
ax.set_xticks(x_minor_ticks, minor = True)
ax.set_yticks(y_major_ticks)
ax.set_yticks(y_minor_ticks, minor = True)

ax.set_xscale('log')

# ax.grid(which = 'both')
ax.grid(which = 'minor', alpha = 0.2)
ax.grid(which = 'major', alpha = 1.0)
ax.xaxis.set_major_formatter(FormatStrFormatter('% 1.2f'))
ax.yaxis.set_major_formatter(FormatStrFormatter('% 1.2f'))
ax.plot(xArray, yArray)

ax.set_xlabel('size (Mb)')
ax.set_ylabel('delay')
plt.savefix('plot.png')
