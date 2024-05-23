clear;

Fs = 16000;

f1 = 1000;
A1 = 2;
np1 = Fs / f1;
n1 = 0 : (np1 * 5 - 1);
w1 = 2 * pi * f1;
wt1 = w1 * n1 / Fs;
x1 = A1 * sin(wt1);

f2 = 500;
A2 = 1;
np2 = Fs / f2;
n2 = 0 : (np2 * 3 - 1);
w2 = 2 * pi * f2;
wt2 = w2 * n2 / Fs;
x2 = A2 * sin(wt2);

t = 4 * 10^-3 * Fs;
xsum = x1(1:t) + x2(1:t);
xmult = x1(1:t) .* x2(1:t);

x3 = x2;
x3(np2 + 1 : np2 * 2) = x1(np1 + 1 : np1 * 3);
x3(np2 * 2 + 10) = x3(np2 * 2 + 10) * 2;

h = [1 1 1 1 1];
h = h / 5;

for n = 1 : np2 * 3
    y(n) = 0; %#ok<SAGROW>
    for j = 1 : 5
        m = n - j + 1;
        if (m > 0) && (m < np2 * 3)
            y(n) = y(n) + h(j) * x3(m);
        end
    end
end

x5 = x3;
x5 = x5 * 16;
x5 = round(x5);
x5 = x5 / 16;
x6 = x5 - x3;
disp = std(x6)^2

figure;
grid on;
hold on;
plot(n1 / Fs * 1000, x1, 'g'); 
plot(n2 / Fs * 1000, x2, 'r');

figure;
grid on;
hold on;
plot(xsum, 'b'); 
plot(xmult, 'm');

figure;
grid on;
hold on;
plot(n2 / Fs * 1000, x3, 'b'); 
plot(n2 / Fs * 1000, y, 'r');

figure;
grid on;
hold on;
plot(n2 / Fs * 1000, x5, 'b'); 
plot(n2 / Fs * 1000, x6, 'r');
plot(n2 / Fs * 1000, disp, 'g');