//
// Created by Lord Coudy on 28/03/2020.
//

#include "func.h"
void CrMem(int** matrix, int n)
{
    for (int i=0; i<n;i++) matrix[i]=new int[n];
}

void Enter(int** A, int n, FILE* f)
{
    for (int i=0; i<n; i++) {
        for (int j=0; j<n; j++)  fscanf(f,"%d",&A[i][j]);
        printf("\n");
    }
}

bool min(int ** A, int n){
    int minEl = A[0][0];
    int minI = 0;
    int minJ = 0;
    bool flag = false;
    for (int i=0; i<n; i++) {
        for (int j=0; j<n; j++) {
            if(A[i][j] < minEl){
                minEl = A[i][j];
                minI = i;
                minJ = j;
            }
        }
    }
    flag = minI > minJ;
    return flag;
}

int count(int ** A, int n, int i){
    int sum = 0;
    for (int j = 0; j < n; j++) sum += A[j][i];
    return sum;
}

void create(int **A, int n, int *B, FILE *f){
    for (int i = 0; i < n; i++) {
        fprintf(f,"%3d", B[i] = count(A, n, i));
    }
}

void Exit(int** A, int n,int* B)
{
    for (int i=0; i<n;i++) delete []A[i];
    delete []B;
}