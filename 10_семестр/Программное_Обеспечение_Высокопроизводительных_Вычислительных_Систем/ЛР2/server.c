#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/un.h>
#define msgSize 256

/// Структура для настройки сокета
struct ip_config
{
    char address[16];
    uint16_t port;
};

/// Процедура предка для распределения данных между потомками и отправки результата клиенту
void controller(int pipe_fd[6][2], char *mem, int socket_id);

/// Процедура потомка для обработки данных
void worker(int pipefd_in_1, int pipefd_out_1, int pipefd_in_2, int pipefd_out_2, char *mem, FILE *file);

int main()
{
    /// Настройка переменных
    struct ip_config config = { "127.0.0.1", 3245 };                // Адрес и порт сервера
    char path[3][15] =
            { "../file1.txt", "../file2.txt", "../file3.txt" };     // Пути к файлам базы данных
    char mem[msgSize];                                              // Буфер для обмена данными
    int socket_fd, new_socket_fd, pipe_fd[6][2];                    // Файлы сокета и каналов
    FILE *file1, *file2, *file3;                                    // Файлы базы данных
    pid_t w1_pid, w2_pid, w3_pid;                                   // Идентификаторы потомков
    /// Создание сокета
    struct sockaddr_in address;
    address.sin_family = AF_INET;                                   // Присвоение типа семейства сокетов
    address.sin_port = htons(config.port);                          // Номер сетевого порта
    inet_aton(config.address, &address.sin_addr);                   // Адрес
    socket_fd = socket(AF_INET, SOCK_STREAM, 0);                    // Создание сокета
    if (socket_fd < 0)
    {
        perror("socket");
        exit(1);
    }
    /// Привязка сокета
    int bind_status = bind(
            socket_fd,
            (const struct sockaddr *) &address,
                    sizeof(address)
                    );
    if (bind_status < 0)
    {
        perror("bind");
        exit(1);
    }
    /// Прослушивание сокета и принятие соединения
    listen(socket_fd, 1);
    new_socket_fd = accept(socket_fd, NULL, NULL);

    /// Создание каналов
    for (int i = 0; i < 6; ++i) {
        if(pipe(pipe_fd[i]) < 0) {
            perror("pipe");
            exit(1);
        }
    }

    /// Открытие файлов
    file3 = fopen(path[2], "r");
    if (file3 == NULL)
    {
        perror("file3");
        exit(1);
    }
    file2 = fopen(path[1], "r");
    if (file2 == NULL)
    {
        perror("file2");
        exit(1);
    }
    file1 = fopen(path[0], "r");
    if (file1 == NULL)
    {
        perror("file1");
        exit(1);
    }

    /// Запуск потомков и процедуры предка
    if ((w1_pid = fork()) != 0)
    {
        if ((w2_pid = fork()) != 0)
        {
            if ((w3_pid = fork()) != 0)
            {
                /// Процедура предка
                controller(pipe_fd, mem, new_socket_fd);
                /// Закрытие сокета, каналов и потомков
                close(socket_fd);
                for (int i = 0; i < 6; ++i) {
                    close(pipe_fd[i][0]);
                    close(pipe_fd[i][1]);
                }
                waitpid(w1_pid, NULL, 0);
                waitpid(w2_pid, NULL, 0);
                waitpid(w3_pid, NULL, 0);
            }else
            {
                /// Потомок 3
                worker(pipe_fd[4][0], pipe_fd[4][1], pipe_fd[5][0], pipe_fd[5][1], mem, file3);
            }
        } else
        {
            /// Потомок 2
            worker(pipe_fd[2][0], pipe_fd[2][1], pipe_fd[3][0], pipe_fd[3][1], mem, file2);
        }
    } else
    {
        /// Потомок 1
        worker(pipe_fd[0][0], pipe_fd[0][1], pipe_fd[1][0], pipe_fd[1][1], mem, file1);
    }
    return 0;
}

void worker(int pipefd_in_1, int pipefd_out_1, int pipefd_in_2, int pipefd_out_2, char *mem, FILE *file) {
    char str[msgSize], *str2 = NULL;
    /// Чтение искомого слова из канала
    close(pipefd_in_2);
    close(pipefd_out_1);
    read(pipefd_in_1, mem, msgSize);
    close(pipefd_in_1);
    /// Поиск искомого слова
    while (fgets(str, msgSize, file) != NULL)
    {
        str2 = strstr(str, mem);
        if (str2 != NULL)
        {
            /// Запись результата в канал
            char s[msgSize];
            sprintf(s,"%d - %s", getpid(), str);
            write(pipefd_out_2, s, msgSize);
            close(pipefd_out_2);
            fclose(file);
            break;
        }
    }
    fclose(file);
    close(pipefd_out_2);
    exit(0);
}

void controller(int pipe_fd[6][2], char *mem, int socket_id) {
    /// Получение искомого слова от клиента
    read(socket_id, mem, msgSize);
    close(pipe_fd[0][0]);
    close(pipe_fd[2][0]);
    close(pipe_fd[4][0]);
    /// Запись искомого слова в канал потомка 1
    write(pipe_fd[0][1], mem, msgSize);
    close(pipe_fd[0][1]);
    /// Запись искомого слова в канал потомка 2
    write(pipe_fd[2][1], mem, msgSize);
    close(pipe_fd[2][1]);
    /// Запись искомого слова в канал потомка 1
    write(pipe_fd[4][1], mem, msgSize);
    close(pipe_fd[4][1]);
    char found[3][msgSize];
    close(pipe_fd[1][1]);
    close(pipe_fd[3][1]);
    close(pipe_fd[5][1]);
/// Чтение результата из канала потомка 1
    read(pipe_fd[1][0], found[0], msgSize);
    close(pipe_fd[1][0]);
/// Чтение результата из канала потомка 2
    read(pipe_fd[3][0], found[0], msgSize);
    close(pipe_fd[3][0]);
/// Чтение результата из канала потомка 3
    read(pipe_fd[5][0], found[0], msgSize);
    close(pipe_fd[5][0]);
    char msg_to_client[msgSize];
    /// Формирование результата
    for (int i = 0; i < 2; ++i) {
        if(found[i] != NULL)
        {
            sprintf(msg_to_client, "%s", found[i]);
            break;
        }
    }
    /// Отправка результата и закрытие сокета
    write(socket_id, msg_to_client, msgSize);
    close(socket_id);
}
