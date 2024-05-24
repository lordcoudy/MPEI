#include	<stdio.h>
#include	<stdlib.h>
#include	<string.h>
#include	<time.h>

#define		T	char
#define		MAX_S	0x1000000
#define		L	101

volatile T A[MAX_S];
int m_rand[0xFFFFFF];

int trash (){
	static struct timespec t1, t2;

	memset ((void*)A, 0, sizeof (A));

	srand(time(NULL));

	int v, M;
	int i, j, k, m, x;

	for (k = 1024; k < MAX_S;) {
		M = k / L;

		printf("%g\t", (k+M*4)/(1024.*1024));

		for (i = 0; i < M; i++) m_rand[i] = L * i;
		for (i = 0; i < M/4; i++)	{
			j = rand() % M;
			x = rand() % M;

			m = m_rand[j];
			m_rand[j] = m_rand[i];
			m_rand[i] = m;
			
		}

		if (k < 100*1024) j = 1024;
		else if (k < 300*1024) j = 128;
		else j = 32;

		clock_gettime (CLOCK_PROCESS_CPUTIME_ID, &t1);
		for (i = 0; i < j; i++) {

			for (m = 0; m < L; m++) {
				for (x = 0; x < M; x++){
					v = A[ m_rand[x] + m ];
				}
			}
			
		}
		clock_gettime (CLOCK_PROCESS_CPUTIME_ID, &t2);

		printf ("%g\n",1000000000. * (((t2.tv_sec + t2.tv_nsec * 1.e-9) - (t1.tv_sec + t1.tv_nsec * 1.e-9)))/(double)(L*M*j));

		if (k > 100*1024)	k += k/16;
		else			k += 4*1024;
	}
	return 0;
}

int main(){ 
	printf("Counting...\n");
    trash();
    printf("Done!\n");
    return 0; 
}