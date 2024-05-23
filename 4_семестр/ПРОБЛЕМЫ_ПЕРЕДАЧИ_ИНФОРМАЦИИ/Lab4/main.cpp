#include <iostream>
#include <cmath>

using namespace std;

unsigned long long u1 = 354655000; // Начальная затравка

double generate1() {
    u1 = (u1 * u1 >> 16) & 0xffffffff;
    if (u1 == 0)
    {
        u1 = rand() % (4294967296 + 1);
    }
    return double(u1) / 4294967295;
}

double SetLambda(int i, int j, double lambda, double TOBS, int NK)
{
    if (j == i + 1) return lambda;
    else if (j == i - 1)
    {
        if (i <= NK) return i / TOBS;
        else return NK / TOBS;
    }
    else return 0;
}


int main()
{
    // Входные данные
    int N = 10000;                  // Максимальное число входящих заявок
    int NK = 3;                     // Количество каналов
    int LMAX = 0;                   // Максимально допустимый размер очереди
    double lambda = 2;              // Интенсивность потока событий
    double TOBS = 1.8;              // Среднее время обслуживания
    int maxstate = NK + LMAX + 1;   // Максимальное количество состояний

    //Массивы
    double* TL = new double[maxstate]{};	// Суммарное время пребывания системы в состоянии, когда в ней ровно M заявок.

    // Расчетные данные
    double T = 0;                   // Счётчик модельного времени
    int KS = 0;                     // Счетчик обслуженных заявок
    int currstate = 0;              // Текущее состояние
    double timetonextstate = 0;     // Время до перехода в следующее состояние
    double minttns = -1;            // Минимальное время до перехода в следующее состояние
    int nextstate = 0;              // Следующее состояние, в которое перейдёт система
    double currlambda = 0;          // Текущее значение интенсивности потока событий

    // Основной цикл
    while (KS < N) // Пока не обслужено N заявок продолжаем цикл
    {
        nextstate = 0;
        minttns = -1;

        // Перебор состояний
        for (int j = 0; j < maxstate; j++)
        {
            currlambda = SetLambda(currstate, j, lambda, TOBS, NK);
            if (currlambda != 0)
            {
                timetonextstate = -1 / currlambda * log(generate1());
                if (minttns == -1 || timetonextstate < minttns)
                {
                    nextstate = j;
                    minttns = timetonextstate;
                }
            }
        }

        T += minttns;
        TL[currstate] += minttns;
        if (nextstate < currstate) KS++;
        currstate = nextstate;
    }

    double ANA;       // Среднее число заявок и обработанных заявок
    ANA = (TL[1] + 2 * TL[2] + 3 * TL[3]) / T;

    std::cout << "---------------Input Data--------------\n" <<
              "Number of channels in SMU (NK): " << NK << '\n' <<
              "Maximum length of stack in SMU (LMAX): " << LMAX << '\n' <<
              "Intensity (lambda): " << lambda << '\n' <<
              "Aveage time of utilisation (TOBS): " << TOBS << " c.u. of time\n\n" <<
              "----------Modeling results---------\n" <<
              "Number of applications: " << N << '\n' <<
              "Number of dealt applications (KS): " << KS << '\n' <<
              "Number of rejected applications: "  << N-KS << '\n' <<
              "Time spended: " << T << " c.u. of time\n" <<
              "Possibility of rejection: " << TL[3] / T<< '\n' <<
              "Coeff of waiting: " << TL[0] / T << '\n' <<
              "Coeff of load: " << 1 - TL[0] / T << '\n' <<
              "Throughtput: " << lambda * (1 - TL[3] / T)<< '\n' <<
              "Average number of applications (ANA): " << ANA << '\n' <<
              "Average number of dealt applications (ANDA): " << ANA << '\n' <<
              "Average length of stack: " << 0 << "\n\n" <<
              "-----Possibilities of states [0, ..., n]-----\n";

    for (int i = 0; i < maxstate; i++)
    {
        std::cout << "S" << i << ": " << TL[i] / T << '\n';
    }
    //-------------------Очистка памяти-------------------
    delete[] TL;
}
