#include <cstdio>
#include "func.h"


int main(int argc, char *argv[]) {
    FILE *fin=fopen(argv[1], "rt");//файл чтения
    FILE *fout=fopen(argv[2], "wt");//файл записи
    int n;  //количество строк и столбцов
    fscanf(fin,"%d",&n);    //считывание n

    int **A = new int* [n];
    CrMem(A, n);
    Enter(A, n, fin);
    fprintf(fout,"Lab №6\nEntered matrix:\n");
    for (int i=0;i<n;i++)
    {
        for (int j=0;j<n;j++) fprintf(fout,"%3d ",A[i][j]);
        fprintf(fout,"\n");
    }

    int *B = new int [n];
    if(min(A, n)){
        fprintf(fout, "Элемент с минимальным значением лежит ниже главной диагонали\n");
        fprintf(fout, "Созданный массив:\n");
        create(A, n, B, fout);
    } else fprintf(fout, "Элемент с минимальным значением не лежит ниже главной диагонали\n");
    fclose(fin);
    fclose(fout);
    Exit(A, n, B);
    return 0;
}


