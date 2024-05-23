#include <iostream>
#include <cmath>

using namespace std;

unsigned long long u1 = 354655000; // Начальная затравка
unsigned long long u2 = 889899976; // Начальная затравка

double generate1() {
    u1 = (u1 * u1 >> 16) & 0xffffffff;
    if (u1 == 0)
    {
        u1 = rand() % (4294967296 + 1);
    }
    return double(u1) / 4294967295;
}

double generate2()
{
    u2 = (u2*u2 >> 16) & 0xffffffff;
    if (u2 == 0)
    {
        u2 = rand() % (4294967296 + 1);
    }
    return double(u2) / 4294967295;
}

int main()
{

    // Входные данные
    int N = 10000;      // Максимальное число входящих заявок
    int NK = 4;         // Количество каналов
    int LMAX = 0;       // Максимально допустимый размер очереди
    double lambda = 2;  // Интенсивность потока событий
    double TOBS = 2;    // Среднее время обслуживания
    // Накапливаемые данные
    double T = 0;	// Текущее модельное время, изменяющееся скачком между моментами возникновения событий в системе
    double TA = 0;  // Момент прихода очередной заявки (время, прошедшее с начала моделирования)
    int K = 0;      // Счетчик пришедших заявок
    int KS = 0;     // Счетчик обслуженных заявок
    int L = 0;      // Текущая длина очереди
    int LOS = 0;    // Счетчик отказов (заявок, поучивших отказ в обслуживании)
    // Массивы
    int* OCP = new int[NK] {};					// Признак занятости i-го канала (0 — канал свободен, 1 — канал занят)
    double* TD = new double[NK] {};				// Ожидаемый момент выхода заявки из i-го канала (время, прошедшее с начала моделирования)
    double* TOS = new double[NK] {};			// Счетчик суммарного времени занятости i-го канала — сколько единиц модельного времени в течение всего процесса моделирования канал был занят.
    double* TL = new double[NK + LMAX + 1]{};	// Суммарное время пребывания системы в состоянии, когда в ней ровно M заявок.
    // Вспомогательные данные
    double TMIN = 0;	// Ближайший момент выхода обслуженной заявки из канала, считая от текущего модельного времени.
    int S = 0;			// Номер канала, который в текущем состоянии системы освободится первым(в момент времени TMIN)
    double DTA = 0;		// Время между приходами заявок (генерируемая в процессе моделирования случайная величина)
    double DTS = 0;		// Время обслуживания заявки в канале (генерируемая в процессе моделирования случайная величина)
    int M = 0;			// Текущее кол-во заявок в СМО
    bool f = true;		// Условие окончания

    // Заполнение массива TD
    for (int i = 0; i < NK; i++) TD[i] = 999999999;

    // Основной цикл
    while (K < N) // Пока не обслужено N заявок продолжаем цикл
    {
        if (f)
        {
            K++;
            DTA = -log(generate1()) / lambda;
            TA += DTA;
        }
        S = 0;
        TMIN = TD[S];
        // Если заявка выйдет раньше
        for (int i = 1; i < NK; i++)
        {
            if (TD[i] < TMIN)
            {
                S = i;
                TMIN = TD[i];
            }
        }
        M = L;
        // Если канал занят, увеличиваем кол-во заявок в СМО
        for (int i = 0; i < NK; i++) M += OCP[i];

        // Если новая заявка придет раньше выхода предыдущей
        if (TMIN > TA)
        {
            TL[M] += TA - T;
            T = TA;
            int k = 0;
            for (k; k < NK; k++)
            {
                if (OCP[k] == 0)
                {
                    OCP[k] = 1;
                    DTS = -log(generate2()) * TOBS;
                    TD[k] = T + DTS;
                    TOS[k] += DTS;
                    break;
                }
            }
            // В случае, если нет свободных каналов
            if (k >= NK)
            {
                if (L < LMAX) L++;
                else LOS++;
            }
            f = true;
        }
        // Если новая заявка придёт позже, чем выйдет старая
        else
        {
            TL[M] += TD[S] - T;
            T = TD[S];
            KS++;

            if (L > 0)
            {
                L--;
                DTS = -log(generate2()) * TOBS;
                TD[S] = T + DTS;
                TOS[S] += DTS;
            }
            else // если в очереди нет заявок
            {
                OCP[S] = 0;
                TD[S] = 999999999;
            }
            f = false;
        }
    }


    double C = 0;   // Время, проведенное всеми заявками в каналах
    double B = 0;   // Время, проведенное всеми заявками в системе
    double sum = 0; // Время пребывания системы в состояниях с непустой очередью

    for (int i = 0; i < NK + LMAX + 1; i++)
    {
        B += i * TL[i];
        if (i < NK)  C += TOS[i];
        else sum += TL[i] * (i - NK);
    }

    std::cout << "---------------Input Data--------------\n" <<
              "Number of channels in SMU (NK): " << NK << '\n' <<
              "Maximum length of stack in SMU (LMAX): " << LMAX << '\n' <<
              "Intensity (lambda): " << lambda << '\n' <<
              "Aveage time of utilisation (TOBS): " << TOBS << " c.u. of time\n\n" <<
              "----------Modeling results---------\n" <<
              "Number of applications (LOS+KS): " << LOS + KS << '\n' <<
              "Number of dealt applications (KS): " << KS << '\n' <<
              "Number of rejected applications (LOS): " << LOS << '\n' <<
              "Time spended: " << T << " c.u. of time\n" <<
              "Possibility of rejection: " << double(LOS) / (LOS + KS) << '\n' <<
              "Throughtput: " << double(KS) / T << '\n' <<
              "Average number of busy channels: " << C / T << '\n' <<
              "Average waiting time: " << abs((B - C) / (LOS + KS)) << " c.u. of time\n" <<
              "Average length od stack: " << sum / T << "\n\n" <<
              "-----Possibilities of states [0, ..., n]-----\n";
    for (int i = 0; i < NK + LMAX + 1; i++)
    {
        std::cout << "S" << i << ": " << TL[i] / T << '\n';
    }

    //-------------------Очистка памяти-------------------
    delete[] TD;
    delete[] TOS;
    delete[] TL;
    delete[] OCP;
}