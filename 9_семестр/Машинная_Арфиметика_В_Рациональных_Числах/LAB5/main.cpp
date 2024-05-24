#include "Fraction.h"
using boost::multiprecision::cpp_dec_float_100;
using namespace farey;

vector<pair<int,int>> findLesser(Fraction &f) {
    int a = f.getNumerator();
    int b = f.getDenominator();
    vector<pair<int, int>> lesserFractions;
    int t, s;
    while (a != 0 && b != 0) {
        f.gcdex(a, b, t, s);                    // Расширенный алгоритм Евклида для поиска соотношения Безу
        if (abs(t) > abs(s))
            swap(t, s);
        a = -t;
        b = s;
        if (a < 0 && b < 0) {
            a = -a;
            b = -b;
        }
        lesserFractions.push_back({a, b});
    }
    return lesserFractions;
}

int main() {
//    TASK1
//    Составить программу,
//    которая для заданной дроби Фарея выводит её подходящие дроби меньших порядков
//    и их представления в модулярной системе счисления по заданному модулю.
    int n, numerator, denominator, order, mod;
    cout << "Введите числитель: ";
    cin >> numerator;
    cout << "Введите знаменатель: ";
    cin >> denominator;
    order = max(numerator, denominator);
    cout << "Введите модуль: ";
    cin >> mod;                                 // 1307
    while (!checkMod(order, mod))
    {
        cout << "Введите модуль: ";
        cin >> mod;
    }
    Fraction f1(numerator, denominator, mod, order);
    cout << "Дробь: " << f1 << endl;
    vector<pair<int, int>> lesser = findLesser(f1);
    for (int i = 0; i < lesser.size(); i++) {
        Fraction lesserFraction(lesser[i].first, lesser[i].second, mod, order);
        cout << "Дроби меньших порядков [" << i + 1 << "]: " << lesserFraction << endl;
    }

//    TASK2
//    Найти скалярное произведение векторов из примера прошлой лабораторной работы
//    с использованием библиотеки высокоточных вычислений.
//    Показать при какой минимальной длине мантиссы точность результатов в этой библиотеке
//    выше чем одинарная точность и двойная точность.
    cout << "\nЗадание 2:\n\n";
    cout << "Введите n: ";
    cin >> n;
    cout << "Введите порядок дробей: ";
    cin >> order;   // 301
    cout << "Введите модуль: ";
    cin >> mod;     // 2*pow(301, 2) + 1
    while (!checkMod(order, mod))
    {
        cout << "Введите модуль: ";
        cin >> mod;
    }
    vector<pair<int, int>> autogen = generate(order);
//    vector<pair<int, int>> autogen = {{1,1417001486786908321}, {1,1417001486786908321}, {1,1417001486786908321}, {1,1417001486786908321}};
//    n = autogen.size();
//    order = autogen[3].second;
//    mod = floor(2*pow(order, 2) + 1);
    vector<Fraction> v1(n), v2(n);
    int j = 0;
    cout << "[ ";
    for (int i = 0; i < n; i++) {
        v1[i].setOrder(order);
        v2[i].setOrder(order);
        v1[i].setNumerator(autogen[i + j].first);
        v1[i].setDenominator(autogen[i + j].second);
        v2[i].setNumerator(-autogen[i + j].first);
        v2[i].setDenominator(autogen[i + j].second);
        v1[i].setMod(mod);
        v2[i].setMod(mod);
        cout << autogen[i].first << "/" << autogen[i].second << " ";
    }
    cout << "]\n";
    cpp_dec_float_100 result = 0;
    float fResult = 0;
    double dResult = 0;

    for (int i = 0; i < n; i++) {
        cpp_dec_float_100 a = cpp_dec_float_100(v1[i].getNumerator()) / cpp_dec_float_100(v1[i].getDenominator());
        cpp_dec_float_100 b = cpp_dec_float_100(v2[i].getNumerator()) / cpp_dec_float_100(v2[i].getDenominator());
        result += a * b;
        float fa = float (v1[i].getNumerator()) / float (v1[i].getDenominator());
        float fb = float (v2[i].getNumerator()) / float (v2[i].getDenominator());
        fResult += fa * fb;
        double da = double (v1[i].getNumerator()) / double (v1[i].getDenominator());
        double db = double (v2[i].getNumerator()) / double (v2[i].getDenominator());
        dResult += da * db;
    }
    cout << setprecision(std::numeric_limits<cpp_dec_float_100>::digits10) << "\n\nResults:\n[BOOST MULTIPRECISION]: " << result << "\n[FLOAT]: " << fResult << "\n[DOUBLE]: " << dResult << endl;

    return 0;
}
