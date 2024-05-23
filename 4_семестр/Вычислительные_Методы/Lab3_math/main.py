from math import cos, pi, sin, sqrt, pow, asinh


def f(x):
    return sin(x) * (1 + cos(x)) / sqrt(1 + pow(cos(x), 2))


def trap(func, a, b, k, x):
    h = 1.0 * (b - a) / pow(10, k)
    Ik = 0.5 * (func(a) + func(b))
    for i in range(1, int(pow(10, k))):
        Ik += func(x + i * h)

    return Ik * h


J = -1 + sqrt(2) + asinh(1)
print(J)
for i in range(1, 10):
    tmp = trap(f, 0, pi/2, i, 0)
    print('I(', i, ') = ', tmp)
    print('J - I(', i, ') = ', abs(J - tmp))


def d(x):
    return (-pow(sin(x), 2) + pow(cos(x), 4) +
     pow(cos(x), 3) + pow(cos(x), 2) +
     cos(x) * (1 + pow(sin(x), 2))) / (
        pow(1 + pow(cos(x), 2), 3 / 2))


D = d(0)
print('D = ', d(0))


def dif(func, a, b, k):
    h = 1.0 * (b - a) / pow(10, k)
    return (func(a) - func(a - h)) / h


for i in range(1, 15):
    tmp = dif(f, 0, pi/2, i)
    print('d(', i, ') = ', tmp)
    print('D - d(', i, ') = ', abs(D - tmp))


def half_trap(func, a, b, k, x):
    h = 1.0 * (b - a) / pow(10, k)
    xk = x + 0.5*h
    Ik = 0
    for i in range(1, int(pow(10, k))):
        Ik += func(x + i * h)
    return Ik*0.5*h


def simpson(func, a, b, k, eps, x):
    old_sum = trap(func, a, b, k, x)
    new_sum = half_trap(func, a, b, k, x)
    ans = (4 * new_sum - old_sum) / 3
    err_est = max(1, abs(ans))
    while (err_est > abs(eps * ans)):
        old_ans = ans
        old_sum = new_sum
        new_sum = half_trap(func, a, b, k, x)
        ans = (4 * new_sum - old_sum) / 3
        err_est = abs(old_ans - ans)
    return ans


for i in range(1, 10):
    tmp = simpson(f, 0, pi/2, i, 0.0001, 0)
    print('simp(', i, ') = ', tmp)
    print('J - simp(', i, ') = ', abs(J - tmp))