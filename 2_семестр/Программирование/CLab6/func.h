//
// Created by Lord Coudy on 28/03/2020.
//

#ifndef CLAB6_FUNC_H
#define CLAB6_FUNC_H


#include <cstdio>

void CrMem(int** A, int n);
void Enter(int** A, int n, FILE* f);
int count(int ** A, int n, int i);
bool min(int ** A, int n);
void create(int **A, int n, int *B, FILE *f);
void Exit(int** A, int n,int* B);

#endif //CLAB6_FUNC_H
