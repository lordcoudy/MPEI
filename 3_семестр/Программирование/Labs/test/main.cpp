#include <iostream>

int main() {
    int A[5] = {0, 3, 4, 5, 6};
    std::cout << *(3+A) << std::endl;
    std::cout << 3[A];
    return 0;
}
