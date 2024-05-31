#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#define msgSize 256

/// Структура для настройки сокета
struct ip_config
{
    char address[16];
    uint16_t port;
};

int main()
{
    /// Настройка переменных
	struct ip_config config = { "127.0.0.1", 3245 };                // Адрес и порт сервера
	char MsgToServer[msgSize], MsgFromServer[msgSize];              // Сообщения для обмена
	int sockid;                                                     // Идентификатор сокета
	struct sockaddr_in addr;                                        // Структура сетевого адреса сокета
	sockid = socket(AF_INET, SOCK_STREAM, 0);                       // Создание сокета
	addr.sin_family = AF_INET;                                      // Присвоение типа
	addr.sin_port = htons(config.port);                             // Номер сетевого порта
	inet_aton(config.address, &addr.sin_addr);                      // Адрес
	/// Попытка соединения
	if (connect(sockid, &addr, sizeof(addr)) < 0)
	{
		printf("Connection error\n");
		return 1;
	}
	/// Отправка сообщения серверу
	printf("Введите слово для поиска:");
	scanf("%s", MsgToServer);
	write(sockid, MsgToServer, msgSize);
	/// Приём сообщения от сервера
	printf("Номер процесса и строка с заданным словом: ");
	read(sockid, MsgFromServer, msgSize);
	printf("%s\n", MsgFromServer);
	close(sockid);
	return 0;
}