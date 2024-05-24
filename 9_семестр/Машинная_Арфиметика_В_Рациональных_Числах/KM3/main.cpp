#include <stdcpp.h>
using namespace std;
int main() {
    int a, b, n;
    cin >> n;
    vector<int> fractions(n);
    cin >> a >> b;
    for (auto &fraction: fractions) {
        cin >> fraction;
    }
    for (const auto &fr: fractions) {
        cout << "(a + b) mod " << fr << " = " << (a + b)%fr << endl;
        cout << "(a - b) mod " << fr << " = " << (fr + (a - b))%fr << endl;
        cout << "(a * b) mod " << fr << " = " << (a * b)%fr << endl;
        cout << "a mod " << fr << " = " << a % fr << endl;
        cout << "b mod " << fr << " = " << b % fr << endl;
    }
    return 0;
}
