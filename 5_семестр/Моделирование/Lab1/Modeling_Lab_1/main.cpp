#include <iostream>
#include <cstdio>
#include <cstdlib>

using namespace std;

unsigned long long gen = 344655000; // Начальная затравка

// Функция-переменная возведения значения в квадрат и сдвига вправо на 16 разрядов
double generate()
{
    gen = (gen*gen >> 16) & 0xffffffff;
    if (gen == 0)
    {
        gen = rand() % (UINT_MAX + 2);
    }
    return double(gen) / UINT_MAX;
}

int main() {
    // Создание seed для рандомизатора
    srand(time(nullptr));
    // Создание выходного файла
    FILE *output;
    output = fopen("out.txt", "w");

    // Объявление переменных
    int v[25], k = 1, n1[100], n2[100], count1 = 0, count2 = 0;
    double gen_num, n1_T = 0, n2_T = 0;
    for (int & i : v) {
        i = 0;
    }
    // Основной цикл с записью 20000 значений в файл, поиском совпадений и подсчетом на интервале
    for (int i = 0; i < 100000; ++i) {
        gen_num = generate();

        if (i == 1000)
        {
            n1_T = gen_num;
        }
        if (i == 1050)
        {
            n2_T = gen_num;
        }
        if (n1_T != 0 && gen_num == n1_T)
        {
            n1[count1] = i;
            count1++;
        }
        if (n2_T != 0 && gen_num == n2_T)
        {
            n2[count2] = i;
            count2++;
        }
        while (i<20000)
        {
            if (gen_num < (1.0/25)*k)
            {
                v[k-1]++;
                break;
            }
            k++;
        }
        k = 1;
        if (i < 20000)
        {
            fprintf(output, "%.10f, %d \n", gen_num, i+1);
        }
    }

    cout << "Равны числу на 1000 позиции:" << endl;
    for (int i = 0; i < count1; ++i) {
        cout << n1[i] << endl;
    }

    cout << "Равны числу на 1050 позиции:" << endl;
    for (int i = 0; i < count2; ++i) {
        cout << n2[i] << endl;
    }
    cout << "Распределение на 25 интервалах:" << endl;
    for (int i : v) {
        cout << i << endl;
    }
    fclose(output);
    return 0;
}
