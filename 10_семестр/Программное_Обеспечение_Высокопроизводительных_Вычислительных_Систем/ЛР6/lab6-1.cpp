#include <pthread.h>
#include <unistd.h>
#include <fcntl.h>
#include <cstring>
#include <cstdio>
#include <cstdlib>

#define BLOCK_SIZE 32

pthread_mutex_t memGuard;
char *mem = nullptr;
pthread_cond_t dataReady;
bool isDataReady = false;

void* child(void* arg){
    while (true)
    {
        while (!isDataReady) // Wait until data is ready
        {
            pthread_cond_wait(&dataReady, &memGuard);
        }
        pthread_mutex_lock(&memGuard);
        ssize_t nbytes = mem[BLOCK_SIZE*sizeof(char)];
        if (nbytes > 0)
        {
            write(STDOUT_FILENO, mem, nbytes);
        }
        else
        {
            pthread_mutex_unlock(&memGuard);
            break;
        }
        pthread_mutex_unlock(&memGuard);
        usleep(11);
    }
    return nullptr;
}

void* parent(void* arg){
    int file;
    file = open("../file.txt", O_RDONLY);
    if (file == -1) {
        perror("open");
        exit(1);
    }

    while (true)
    {
        pthread_mutex_lock(&memGuard);
        ssize_t nbytes = read(file, mem, BLOCK_SIZE);
        mem[BLOCK_SIZE*sizeof(char)] = nbytes;
        isDataReady = true;
        pthread_cond_signal(&dataReady);
        pthread_mutex_unlock(&memGuard);
        usleep(10);

        if (nbytes == 0)
        {
            close(file);
            break;
        }
    }
    return nullptr;
}

int main ()
{
    pthread_t childThread, parentThread;
    pthread_mutex_init(&memGuard, nullptr);
    mem = (char*)malloc(BLOCK_SIZE);

    pthread_create(&childThread, nullptr, &child, nullptr);
    pthread_create(&parentThread, nullptr, &parent, nullptr);

    pthread_join(parentThread, nullptr);
    pthread_join(childThread, nullptr);

    pthread_mutex_destroy(&memGuard);
    free(mem);

    return 0;
}