#include <iostream>
#include "/opt/homebrew/Cellar/open-mpi/4.1.5/include/mpi.h"
#include <chrono>

// Зерно для генератора псевдорандомных чисел
#define seed 0
#define debug 0
#define printres 0
#define rounds 1000

// Объявление массивов для задачи
// Указатели на текущие элементы массивов
// Массив индексов для частей массивов (при разбиении)
// Переменные для задачи
int *A, *B, *C;
int *Acur, *Bcur, *Ccur, *Y, *YRes;
int S1, S2;
int* VIndex;


// Типы данных для счёта времени при однопроцессорном режиме
typedef std::chrono::high_resolution_clock Time;
typedef std::chrono::duration<float> secs;

// Процедура расчёта заданного уравнения
// Принимает на вход 3 массива, 2 переменные и размер массивов
void SolveY (int *A, int *B, int *C, int S1, int S2, int size)
{
    YRes = (int *)(malloc(size * sizeof(int)));
    for (int i = 0; i < size; i++)
    {
        YRes[i] = (A[i] + B[i] + C[i]) * S1 * S2;
    }
}

// Функция заполнения массива. 
// Возвращает заполненный массив. 
// Принимает размер массива.
int *FillVector (int size)
{
    int *X = (int *)(malloc(size * sizeof(int)));
    for (int i = 0; i < size; ++i)
    {
        X[i] = rand() %20;
    }
    return X;
}

// Функция расчёта количества разделений
// Возвращает массив с индексами начала сегмента
// Принимает количество процессоров и размер
int* indexes (int cpus, int size)
{
    int *ind = (int *)(malloc((cpus + 1) * sizeof(int)));
    ind[cpus] = size;
    for (int i = 0; i < cpus; i++)
    {
        ind[i] = i*size/cpus;
    }
    return ind;
}

// Процедура вывода полученного массива и суммы всех его элементов
// Принимает на вход массив
void PrintResult (int *X)
{
    double sum = 0;
    int size = sizeof(*X)/sizeof(int);
    std::cout<<size<<std::endl;
    for (int i = 0; i < size; ++i)
    {
        std::cout<<"Yi = "<<X[i]<<std::endl;
        sum += X[i];
    }
    std::cout<<"Sum = "<<sum<<std::endl;
    std::cout<<"------------------------------------------------------------------"<<std::endl;
}

// Процедура инициализации массивов, переменных и генератора псевдорандомных чисел
void Init (int vector_size, int total_size, int total_rank)
{
    VIndex = indexes(total_size, vector_size);
    srand(seed);
    S1 = rand()%20;
    S2 = rand()%20;
    A = FillVector(vector_size);
    B = FillVector(vector_size);
    C = FillVector(vector_size);
    Y = (int *)(malloc(vector_size * sizeof(int)));
    if (total_rank != 0)
    {
        int curBatchSize = VIndex[total_rank+1] - VIndex[total_rank];
        Acur = (int *)(malloc(curBatchSize * sizeof(int)));
        Bcur = (int *)(malloc(curBatchSize * sizeof(int)));
        Ccur = (int *)(malloc(curBatchSize * sizeof(int)));
    }
}

// Процедура очистки памяти после использования
void FreeVectors()
{
    free(Acur);
    free(Bcur);
    free(Ccur);
    free(Y);
    free(YRes);
}

// Процедура однопроцессорного расчёта.
// Принимает размер массивов
void ClassicalCalc (int size)
{
    Acur = A;
    Bcur = B;
    Ccur = C;
    SolveY(A, B, C, S1, S2, size);
    Y = YRes;
    YRes = nullptr;
    #ifdef printres
    if (printres)
    {
        PrintResult(Y);
    }
    #endif
}

// Процедура многопроцессорного расчёта
// Принимает размеры многопроцессорной системы и размер массивов
void ParallelCalc (int vector_size, int total_size, int total_rank)
{
    // Условие однопроцессорного расчёта
    if (total_size == 1)
    {
        #ifdef debug
        if (debug)
        {
            std::cout<<"Classical"<<std::endl;
        }
        #endif
        ClassicalCalc(vector_size);
        return;
    }

    // Текущий размер "сегмента"
    int curBatchSize = VIndex[total_rank+1] - VIndex[total_rank];

    // Нулевой ранг
    // Расчёт размера сегментов
    // Отправка в память по адресам массивов и переменных
    // Приёем из памяти по адресам массивов и переменных
    // Частичные расчёты для каждого сегмента и отправка их в память
    // Заполнение первого сегмента результата
    // Загрузка из памяти остальных сегментов
    if (total_rank == 0)
    {
        Acur = A;
        Bcur = B;
        Ccur = C;

        #ifdef debug
        if (debug)
        {
            std::cout<<"Proccess 0 count: "<<curBatchSize<<std::endl;
        }
        #endif

        for(int i = 1; i< total_size; i++) 
        {
            int batchSize = VIndex[i + 1] - VIndex[i];
            #ifdef debug
            if (debug)
            {
                std::cout<<"Send to proccess "<<i<<"  from "<<VIndex[i]<<" to "<<VIndex[i]+batchSize<<" (count: "<<batchSize<<") of "<<vector_size<<std::endl;
            }
            #endif
            MPI_Send(A + VIndex[i], batchSize, MPI_INT, i, 1, MPI_COMM_WORLD);
            MPI_Send(B + VIndex[i], batchSize, MPI_INT, i, 2, MPI_COMM_WORLD);
            MPI_Send(C + VIndex[i], batchSize, MPI_INT, i, 3, MPI_COMM_WORLD);
            MPI_Send(&S1, 1, MPI_INT, i, 4, MPI_COMM_WORLD);
            MPI_Send(&S2, 1, MPI_INT, i, 5, MPI_COMM_WORLD);
        }
    } else 
    {
        MPI_Recv(Acur, curBatchSize, MPI_INT, 0, 1, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        MPI_Recv(Bcur, curBatchSize, MPI_INT, 0, 2, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        MPI_Recv(Ccur, curBatchSize, MPI_INT, 0, 3, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        MPI_Recv(&S1, 1, MPI_INT, 0, 4, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        MPI_Recv(&S2, 1, MPI_INT, 0, 5, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    }

    #ifdef debug
    if(debug)
    {
        std::cout<<total_rank<<" received data size: "<<curBatchSize<<std::endl;
    }
    #endif

    SolveY(Acur, Bcur, Ccur, S1, S2, curBatchSize);

    if (total_rank == 0){

        for (int i = 0; i < curBatchSize; ++i)
        {
            Y[i] = YRes[i];
        }

        for(int i = 1; i < total_size; i++){
            int batchSize = VIndex[i+1] - VIndex[i];
            #ifdef debug
            if (debug)
            {
                std::cout<<"Receive from process "<<i<<" from "<<VIndex[i]<<" to "<<VIndex[i]+batchSize<<" of "<<vector_size<<std::endl;
            }
            #endif
            MPI_Recv(Y + VIndex[i],batchSize,MPI_INT,i,6,MPI_COMM_WORLD,MPI_STATUS_IGNORE);
        }
        #ifdef printres
        if (printres)
        {
            PrintResult(Y);
        }
        #endif
    }
    else{
        MPI_Send(YRes,curBatchSize,MPI_INT,0,6,MPI_COMM_WORLD);
    }
}

// Основная процедура
// Запуск процедуры инициализации
// Получение информации о системе
// Расчёт времени выполнения расчётов
// Запуск процедуры очистки при каждом прохождении
int main () {
    MPI_Init(nullptr, nullptr);

    int total_size, total_rank;
    MPI_Comm_size(MPI_COMM_WORLD, &total_size);
    MPI_Comm_rank(MPI_COMM_WORLD, &total_rank);
    std::cout << total_rank << " | " << total_size << std::endl;

    const int v_sizes[] = {8, 64, 256, 1024, 4096, 16384, 65536, 262144};
    for (int v_size : v_sizes){
        Init(v_size,total_size, total_rank);
        std::chrono::time_point<std::chrono::steady_clock> t0 = Time::now();
        double tm0 = MPI_Wtime();
        for(int j = 0; j < rounds; j++)
            ParallelCalc(v_size, total_size, total_rank);
        std::chrono::time_point<std::chrono::steady_clock> t1 = Time::now();
        double tm1 = MPI_Wtime();
        secs dif = t1 - t0;
        double difm = tm1 - tm0;
        if (total_rank == 0)
        {
            std::cout<<"Vector size = "<<v_size<<"\nClocks passed: "<<dif.count()<<" seconds"<<std::endl;
            std::cout<<"Clocks in MPI passed: "<<difm<<" seconds"<<std::endl;
        }
        FreeVectors();
    }
    MPI_Finalize();

    return 0;
}
