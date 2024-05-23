#include <iostream>
#include <string>
#include <map>
#include <cstdio>

using namespace std;

int main() {
    map<char, string>
            dictionary ={
            {'1', "10"},
            {'2', "00"},
            {'3', "01"},
            {'4', "110"},
            {'5', "1110"},
            {'6', "11110"},
            {'7', "11111"}
    };
    TryAgain:
    cout << "Enter line of messages (1 2 3 4 5 6 7) to encode:" << endl;
    string input;
    cin >> input;
    bool check = true;
    for (const auto &symbol : input)
    {
        if (symbol != '1' &&
            symbol != '2' &&
            symbol != '3' &&
            symbol != '4' &&
            symbol != '5' &&
            symbol != '6' &&
            symbol != '7')
        {
            check = false;
            break;
        }
    }
    if (!check)
    {
        cout << "Incorrect input!" << endl;
        goto TryAgain;
    }
    else
    {
        string output;
        for(const auto & symb : input)
        {
            output += dictionary[symb];
        }
        cout << "Encoded line is " << output << endl;
    }
    return 0;
}

