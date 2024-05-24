// Балашов, А-08-19, Вариант 4
/*
ЗАДАНИЕ
В узлах 0, 2 и 8 имеются двухмерные массивы A(в 0-м), B(в 2-м) и C (в 8-м) размером 18x18 с исходными данными. 
Передать в узлы 1,3,4,5,6 и 7 исходные данные, которые разместить в них в одномерных массивах aa, bb, cc. 
Выполнить на указанных узлах вычисления по формуле aai=aai*bbi+cci, и вернуть результат в массив A узла 8.

Краткий путь решения
6 узлов для вычисления => по 3 строки массивов на узел
По узлам распределить, желательно не затрагивая нерабочие 0, 2, 8
Посчитать и отправить всё в узел 8 по возможным маршрутам
*/

#include <iostream>
#include "/opt/homebrew/Cellar/open-mpi/4.1.5/include/mpi.h"

#define N 18

int *A, *B, *C;
int *aa, *bb, *cc;
int batchSize = 3*N;

// Функция заполнения массива (двумерный массив заполняется 100)
int* FillArray ()
{
    int *tmp = (int *)(malloc(N * N * sizeof(int)));
    for (int i = 0; i < N; ++i)
    {
        for (int j = 0; j < N; ++j)
        {
            tmp[j+i*N] = 100;
        }
                    
    }
    return tmp;
}

// Функция расчёта (нужная часть исходных данных вычисляется согласно варианту)
int* Solve (int* a, int* b, int* c)
{
    int *tmp = (int *)(malloc(3*N * sizeof(int)));
    for (int i = 0; i < 3*N; ++i)
    {
        tmp[i] = a[i] * b[i] + c[i];
    }
    return tmp;
}

// Вывод получившегося массива
void PrintResult (int *X)
{
    double sum = 0;
    for (int i = 0; i < N; ++i)
    {
        for (int j = 0; j < N; ++j)
        {
            std::cout<<"Xi = "<<A[j+i*N]<<std::endl;
            sum += X[i];
        }
    }
    std::cout<<"Sum = "<<sum<<std::endl;
    std::cout<<"------------------------------------------------------------------"<<std::endl;
}

// Очистка массивов
void FreeVectors()
{
    free(A);
    free(B);
    free(C);
    free(aa);
    free(bb);
    free(cc);
}

// Основная процедура
void Calculate (int world_size, int world_rank)
{
    aa = (int *)(malloc(N * N * sizeof(int)));
    bb = (int *)(malloc(N * N * sizeof(int)));
    cc = (int *)(malloc(N * N * sizeof(int)));
    A = (int *)(malloc(N * N * sizeof(int)));
    B = (int *)(malloc(N * N * sizeof(int)));
    C = (int *)(malloc(N * N * sizeof(int)));
    // Выбор действия согласно рангу
    /*
        Если 0, 2 или 8, то заполнение нужного массива и отправка согласно схеме
        Если другие, то получение и отправка согласно схеме, а затем расчёт и отправка результата
    */
    switch (world_rank)
    {
        case 0:
            {
                /*
                схема распределения данных массива А
                (в какой узел какие части отправлять)
                aa1
                aa3 = aa3 + aa4 + aa6

                aa4 = aa4 + aa5
                aa6 = aa6 + aa7
                */
                std::cout << "Rank 0. Filling Array A..." << std::endl;
                A = FillArray();
                std::cout << "Rank 0. Array A filled successfully" << std::endl;
                std::cout << "Rank 0. Sending Array A..." << std::endl;
                // aa1
                MPI_Send(A , batchSize, MPI_INT, 1, 1, MPI_COMM_WORLD);
                // aa3
                MPI_Send(A + batchSize , 5*batchSize, MPI_INT, 3, 2, MPI_COMM_WORLD);
                std::cout << "Rank 0. Sent!" << std::endl;

                /*
                схема распределения данных массива C
                aa7 = aa7 + aa6
                aa5 = aa5 + aa4 + aa2

                aa6 = aa6 + aa3
                aa2 = aa1
                */
                std::cout << "Rank 8. Filling Array C..." << std::endl;
                C = FillArray();
                std::cout << "Rank 8. Array C filled successfully" << std::endl;
                std::cout << "Rank 8. Sending Array C..." << std::endl;
                // aa5
                MPI_Send(C , 3*batchSize, MPI_INT, 5, 17, MPI_COMM_WORLD);
                // aa7
                MPI_Send(C + 3*batchSize , 3*batchSize, MPI_INT, 7, 28, MPI_COMM_WORLD);
                std::cout << "Rank 8. Sent!" << std::endl;

                std::cout << "Rank 8. Receiving result..." << std::endl;
                // 4 1 3 6 5 2
                MPI_Recv(A + 4*batchSize,batchSize,MPI_INT,5,18,MPI_COMM_WORLD,MPI_STATUS_IGNORE);
                MPI_Recv(A + batchSize,batchSize,MPI_INT,5,19,MPI_COMM_WORLD,MPI_STATUS_IGNORE);
                MPI_Recv(A + 3*batchSize,batchSize,MPI_INT,5,20,MPI_COMM_WORLD,MPI_STATUS_IGNORE);
                MPI_Recv(A + 6*batchSize,batchSize,MPI_INT,7,29,MPI_COMM_WORLD,MPI_STATUS_IGNORE);
                MPI_Recv(A + 5*batchSize,batchSize,MPI_INT,7,30,MPI_COMM_WORLD,MPI_STATUS_IGNORE);
                MPI_Recv(A + 2*batchSize,batchSize,MPI_INT,7,31,MPI_COMM_WORLD,MPI_STATUS_IGNORE);
                // PrintResult(A);
                std::cout << "--------ALL DONE!!!----------" << std::endl;
                break;
            }
        case 1:
            {
                std::cout << "Rank 1. Receiving Array aa..." << std::endl;
                MPI_Recv(aa, batchSize, MPI_INT, 0, 1, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                std::cout << "Received!" << std::endl;
                std::cout << "Rank 1. Receiving Array bb..." << std::endl;
                MPI_Recv(bb, batchSize, MPI_INT, 2, 3, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                std::cout << "Received!" << std::endl;
                std::cout << "Rank 1. Receiving Array cc..." << std::endl;
                MPI_Recv(cc, batchSize, MPI_INT, 2, 4, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                std::cout << "Rank 1. Received!" << std::endl;

                aa = Solve(aa, bb, cc);

                std::cout << "Rank 1. Sending result..." << std::endl;
                MPI_Send(aa , batchSize, MPI_INT, 2, 5, MPI_COMM_WORLD);
                std::cout << "Rank 1. Sent!" << std::endl;
                break;
            }
        case 2:
            {
                /*
                схема распределения данных массива B
                aa1
                aa5 = aa5 + aa4

                aa4 = aa3 + aa4
                aa3 = aa3 + aa6

                aa6 = aa7 + aa6
                */
                std::cout << "Rank 2. Filling Array B..." << std::endl;
                B = FillArray();
                std::cout << "Rank 2. Array B filled successfully" << std::endl;
                std::cout << "Rank 2. Sending Array B..." << std::endl;
                // aa1
                MPI_Send(B , batchSize, MPI_INT, 1, 3, MPI_COMM_WORLD);
                // aa5
                MPI_Send(B + batchSize , 5*batchSize, MPI_INT, 5, 6, MPI_COMM_WORLD);
                std::cout << "Rank 2. Sent!" << std::endl;
                // aa2 = aa1
                std::cout << "Rank 2. Transfering Array cc to Rank 1..." << std::endl;
                MPI_Recv(cc, batchSize, MPI_INT, 5, 5, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                std::cout << "Rank 2. Received!" << std::endl;
                MPI_Send(cc, batchSize, MPI_INT, 1, 4, MPI_COMM_WORLD);
                std::cout << "Rank 2. Done!" << std::endl;
                // result from 1
                std::cout << "Rank 2. Transfering Array aa to Rank 5..." << std::endl;
                MPI_Recv(aa, batchSize, MPI_INT, 1, 5, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                std::cout << "Rank 2. Received!" << std::endl;
                MPI_Send(aa, batchSize, MPI_INT, 5, 7, MPI_COMM_WORLD);
                std::cout << "Rank 2. Done!" << std::endl;
                break;
            }
        case 3:
            {
                std::cout << "Rank 3. Receiving and Transfering Array aa..." << std::endl;
                MPI_Recv(aa, 5*batchSize, MPI_INT, 0, 2, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                std::cout << "Rank 3. Received!" << std::endl;
                MPI_Send(aa + batchSize, 2*batchSize, MPI_INT, 4, 8, MPI_COMM_WORLD);
                MPI_Send(aa + 3*batchSize, 2*batchSize, MPI_INT, 6, 9, MPI_COMM_WORLD);
                std::cout << "Rank 3. Done!" << std::endl;
                std::cout << "Rank 3. Receiving and Transfering Array bb..." << std::endl;
                MPI_Recv(bb, 3*batchSize, MPI_INT, 4, 14, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                std::cout << "Rank 3. Received!" << std::endl;  
                MPI_Send(bb + batchSize, 2*batchSize, MPI_INT, 6, 11, MPI_COMM_WORLD); 
                std::cout << "Rank 3. Done!" << std::endl;
                std::cout << "Rank 3. Receiving Array cc..." << std::endl;
                MPI_Recv(cc, batchSize, MPI_INT, 6, 24, MPI_COMM_WORLD, MPI_STATUS_IGNORE);  
                std::cout << "Rank 3. Received!" << std::endl;

                aa = Solve(aa, bb, cc);

                std::cout << "Rank 3. Sending result..." << std::endl;
                MPI_Send(aa , batchSize, MPI_INT, 6, 25, MPI_COMM_WORLD);
                std::cout << "Rank 3. Sent!" << std::endl;
                break;
            }
        case 4:
            {
                std::cout << "Rank 4. Receiving and Transfering Array aa..." << std::endl;
                MPI_Recv(aa, 2*batchSize, MPI_INT, 3, 8, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                std::cout << "Rank 4. Received!" << std::endl;
                MPI_Send(aa + batchSize, batchSize, MPI_INT, 5, 12, MPI_COMM_WORLD);
                std::cout << "Rank 4. Done!" << std::endl;
                std::cout << "Rank 4. Receiving and Transfering Array bb..." << std::endl;
                MPI_Recv(bb, 4*batchSize, MPI_INT, 5, 13, MPI_COMM_WORLD, MPI_STATUS_IGNORE); 
                std::cout << "Rank 4. Received!" << std::endl;
                MPI_Send(bb + batchSize, 3*batchSize, MPI_INT, 3, 14, MPI_COMM_WORLD); 
                std::cout << "Rank 4. Done!" << std::endl;
                std::cout << "Rank 4. Receiving Array cc..." << std::endl;
                MPI_Recv(cc, batchSize, MPI_INT, 5, 15, MPI_COMM_WORLD, MPI_STATUS_IGNORE);  
                std::cout << "Rank 4. Received!" << std::endl;

                aa = Solve(aa, bb, cc);

                std::cout << "Rank 4. Sending result..." << std::endl;
                MPI_Send(aa , batchSize, MPI_INT, 5, 16, MPI_COMM_WORLD);
                std::cout << "Rank 4. Sent!" << std::endl;
                break;
            }
        case 5:
            {
                std::cout << "Rank 5. Receiving Array aa..." << std::endl;
                MPI_Recv(aa, batchSize, MPI_INT, 4, 12, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                std::cout << "Rank 5. Received!" << std::endl;
                std::cout << "Rank 5. Receiving and Transfering Array bb..." << std::endl;
                MPI_Recv(bb, 5*batchSize, MPI_INT, 2, 6, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                std::cout << "Rank 5. Received!" << std::endl;
                MPI_Send(bb + batchSize, 4*batchSize, MPI_INT, 4, 13, MPI_COMM_WORLD);
                std::cout << "Rank 5. Done!" << std::endl;
                std::cout << "Rank 5. Receiving and Transfering Array cc..." << std::endl;
                MPI_Recv(cc, 3*batchSize, MPI_INT, 0, 17, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                std::cout << "Rank 5. Received!" << std::endl;
                MPI_Send(cc + batchSize, batchSize, MPI_INT, 4, 15, MPI_COMM_WORLD);
                MPI_Send(cc + 2*batchSize, batchSize, MPI_INT, 2, 5, MPI_COMM_WORLD);
                std::cout << "Rank 5. Done!" << std::endl;

                aa = Solve(aa, bb, cc);
                std::cout << "Rank 5. Sending result..." << std::endl;
                // 4
                MPI_Send(aa , batchSize, MPI_INT, 0, 18, MPI_COMM_WORLD);
                // 1
                MPI_Recv(aa, batchSize, MPI_INT, 2, 7, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                MPI_Send(aa , batchSize, MPI_INT, 0, 19, MPI_COMM_WORLD);
                // 3
                MPI_Recv(aa, batchSize, MPI_INT, 4, 16, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                MPI_Send(aa , batchSize, MPI_INT, 0, 20, MPI_COMM_WORLD);
                std::cout << "Rank 5. Sent!" << std::endl;
                break; 
            }
        case 6:
            {
                std::cout << "Rank 6. Receiving and Transfering Array aa..." << std::endl;
                MPI_Recv(aa, 2*batchSize, MPI_INT, 3, 9, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                std::cout << "Rank 6. Received!" << std::endl;
                MPI_Send(aa + batchSize, batchSize, MPI_INT, 7, 21, MPI_COMM_WORLD);
                std::cout << "Rank 6. Done!" << std::endl;
                std::cout << "Rank 6. Receiving and Transfering Array bb..." << std::endl;
                MPI_Recv(bb, 2*batchSize, MPI_INT, 3, 11, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                std::cout << "Rank 6. Received!" << std::endl;
                MPI_Send(bb + batchSize, batchSize, MPI_INT, 7, 22, MPI_COMM_WORLD);
                std::cout << "Rank 6. Done!" << std::endl;
                std::cout << "Rank 6. Receiving and Transfering Array cc..." << std::endl;
                MPI_Recv(cc, 2*batchSize, MPI_INT, 7, 23, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                std::cout << "Rank 6. Received!" << std::endl;
                MPI_Send(cc + batchSize, batchSize, MPI_INT, 3, 24, MPI_COMM_WORLD);
                std::cout << "Rank 6. Done!" << std::endl;

                aa = Solve(aa, bb, cc);

                std::cout << "Rank 6. Sending result..." << std::endl;
                MPI_Send(aa , batchSize, MPI_INT, 7, 26, MPI_COMM_WORLD);
                MPI_Recv(aa, batchSize, MPI_INT, 3, 25, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                MPI_Send(aa , batchSize, MPI_INT, 7, 27, MPI_COMM_WORLD);
                std::cout << "Rank 6. Sent!" << std::endl;
                break;
            }
        case 7:
            {
                std::cout << "Rank 7. Receiving Array aa..." << std::endl;
                MPI_Recv(aa, batchSize, MPI_INT, 6, 21, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                std::cout << "Rank 7. Received!" << std::endl;
                std::cout << "Rank 7. Receiving Array bb..." << std::endl;
                MPI_Recv(bb, batchSize, MPI_INT, 6, 22, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                std::cout << "Rank 7. Received!" << std::endl;
                std::cout << "Rank 7. Receiving and Transfering Array cc..." << std::endl;
                MPI_Recv(cc, 3*batchSize, MPI_INT, 0, 28, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                std::cout << "Rank 7. Received!" << std::endl;
                MPI_Send(cc + batchSize, 2*batchSize, MPI_INT, 6, 23, MPI_COMM_WORLD);
                std::cout << "Rank 7. Done!" << std::endl;

                aa = Solve(aa, bb, cc);

                std::cout << "Rank 7. Sending result..." << std::endl;
                // 6
                MPI_Send(aa , batchSize, MPI_INT, 0, 29, MPI_COMM_WORLD);
                // 5
                MPI_Recv(aa, batchSize, MPI_INT, 6, 26, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                MPI_Send(aa , batchSize, MPI_INT, 0, 30, MPI_COMM_WORLD);
                // 2
                MPI_Recv(aa, batchSize, MPI_INT, 6, 27, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                MPI_Send(aa , batchSize, MPI_INT, 0, 31, MPI_COMM_WORLD);
                std::cout << "Rank 7. Sent!" << std::endl;
                break; 
            }
        default:
            break;

    }
}


int main() {
    MPI_Init(nullptr, nullptr);

    int world_size, world_rank;
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);
    MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);
    std::cout << world_rank << " | " << world_size << std::endl;
    Calculate(world_size, world_rank);   

    FreeVectors();

    MPI_Finalize();
    return 0;
}
