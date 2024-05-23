#include <iostream>
#include <cstdio>
#include <map>
#include <string>
#include <vector>

using namespace std;

//Составить программу, которая для заданной кодовой таблицы находит кодовое расстояние.
int main() {
    cout << "Enter length of code table [n m]" << endl;
    int n;
    int m;
    cin >> n >> m;
    int table[m][n];
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            cout << "Enter value for [" << i << ", " << j << "] element of table";
            int v;
            cin >> v;

        }
    }
    for (int i = 1; i <= n; ++i) {
        cout << "Enter Message for " << i << " row of table" << endl;
        string msg;
        cin >> msg;
        cout << "Enter code of this Message" << endl;
        string code;
        cin >> code;
        codeTable[msg] = code;
    }
    cout << "Table of codes:" << endl;
    vector<int> lengthVector;
    for (const auto & [key, value] : codeTable)
    {
        cout << key << " - " << value << endl;
        for (const auto & [key2, value2] : codeTable) {
            if (key != key2)
            {
                int lengthTMP = 0;
                for (int i = 0; i < value.length(); ++i) {
                    if (value[i] != value2[i])
                    {
                        lengthTMP++;
                    }
                }
                lengthVector.push_back(lengthTMP);
            }
        }
    }
    int minDistance;
    for (int i = 0; i < lengthVector.size(); ++i) {
        for (int j = 0; j < lengthVector.size(); ++j) {
            if (i != j)
            {
                int minTmp = min(lengthVector[i], lengthVector[j]);
                if (minDistance > minTmp)
                {
                    minDistance = minTmp;
                }
            }
        }
    }
    cout << "Minimal distance is " << minDistance << endl;
    return 0;
}
