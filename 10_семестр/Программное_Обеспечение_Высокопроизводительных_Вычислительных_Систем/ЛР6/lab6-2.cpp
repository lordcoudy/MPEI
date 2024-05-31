#include <thread>
#include <mutex>
#include <atomic>
#include <vector>
#include <string>
#include <fcntl.h>
#include <unistd.h>

static constexpr int bufSize = 32;

std::vector<char> buf(bufSize);
std::atomic<bool> dataReady{false};
std::mutex memGuard;

void child() {
    while (true) {
        while (!dataReady) {
            std::this_thread::yield();
        }
        std::unique_lock<std::mutex> lock(memGuard);
        ssize_t nbytes = buf[bufSize*sizeof(char)];
        if (nbytes > 0) {
            write(1, buf.data(), nbytes);
        } else {
            lock.unlock();
            break;
        }
        lock.unlock();
        std::this_thread::sleep_for(std::chrono::nanoseconds(11));
    }
}

void parent() {
    int file;
    file = open("../file.txt", O_RDONLY);
    if (file == -1) {
        perror("open");
        exit(1);
    }

    while (true) {
        std::unique_lock<std::mutex> lock(memGuard);
        ssize_t nbytes = read(file, buf.data(), bufSize);
        buf[bufSize*sizeof(char)] = nbytes;
        dataReady = true;
        lock.unlock();

        if (nbytes == 0) {
            close(file);
            break;
        }
        std::this_thread::sleep_for(std::chrono::nanoseconds(10));
    }
}

int main() {
    std::thread childThread(child);
    std::thread parentThread(parent);

    parentThread.join();
    childThread.join();

    return 0;
}