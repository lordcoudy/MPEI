#include <iostream>
#include <cstdio>
#include <chrono>
#include <cmath>
#include <iomanip>


using namespace std;
using namespace chrono;

double f(double x)
{
    return sin(x) * (1 + cos(x)) / sqrt(1 + pow(cos(x), 2));
}



double trap(double & a, double & b, int & k, double & x)
{
    double h = 1.0 * (b - a) / pow(10, k);
    double Ik = 0.5 * (f(a) + f(b));
    for (int i = 1; i < int(pow(10, k)); i++)
    {
        Ik += f(x + i * h);
    }
    return Ik * h;
}


double d(double x)
{
    return (-pow(sin(x), 2) + pow(cos(x), 4) +
            pow(cos(x), 3) + pow(cos(x), 2) +
            cos(x) * (1 + pow(sin(x), 2))) / (
                   pow(1 + pow(cos(x), 2), 3.0 / 2.0));
}

double dif(double & a, double & b, int & k)
{
    double h = 1.0 * (b - a) / pow(10, k);
    return (f(a) - f(a - h)) / h;
}

double simpson_rule(double & a, double & b, int & k)
{
    double h = 1.0 * (b - a) / pow(10, k);
    double simp_sum = (f(a) + 4 * f(a + h) + f(b));
    for (int i = 1; i < int(pow(10, k) / 2.0); ++i) {
        simp_sum += 2.0 * f(a + (a + (2.0 * i) * h)) + 4.0 * f(a + (2.0 * i + 1.0) * h);
    }
    return simp_sum * h / 3.0;
}


int main() {
    chrono::steady_clock sc;
    double J = -1 + sqrt(2) + asinh(1);
    cout << setprecision(20) << "Absolute integral: " << J << endl;
    double a = 0;
    double b = M_PI_2;
    double x = 0;
//    for (int i = 1; i < 15; ++i) {
//        auto start = steady_clock::now();
//        double tmp = trap(a, b, i, x);
//        cout << "I(" << i << ") = " << tmp << endl;
//        cout << "J - I(" << i << ") = " << abs(J - tmp) << endl;
//        auto end = steady_clock::now();
//        auto time_span = static_cast<chrono::duration<double>>(end - start);   // measure time span between start & end
//        cout << "Operation took: " << time_span.count() << " seconds !!!" << endl;
//    }
//    cout << endl;
//
//    double D = d(0);
//    cout << setprecision(20) << "D = " << D << endl;
//    for (int i = 1; i < 15; ++i) {
//        auto start = steady_clock::now();
//        double tmp = dif(a, b, i);
//        cout << "d(" << i << ") = " << tmp << endl;
//        cout << "D - d(" << i << ") = " << abs(D - tmp) << endl;
//        auto end = steady_clock::now();
//        auto time_span = static_cast<chrono::duration<double>>(end - start);   // measure time span between start & end
//        cout << "Operation took: " << time_span.count() << " seconds !!!" << endl;
//    }

    cout << endl;
    for (int i = 1; i < 15; ++i) {
        auto start = steady_clock::now();
        double tmp = simpson_rule(a, b, i);
        cout << setprecision(20) << "S(" << i << ") = " << tmp << endl;
        cout << "J - S(" << i << ") = " << abs(J - tmp) << endl;
        auto end = steady_clock::now();
        auto time_span = static_cast<chrono::duration<double>>(end - start);   // measure time span between start & end
        cout << "Operation took: " << time_span.count() << " seconds !!!" << endl;
    }

    return 0;
}