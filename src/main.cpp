#include <iostream>
#include <vector>
#include <string>

using namespace std;

/**
 * Compiling:
 * clang++ -std=c++17 main.cpp
 */
int main()
{
    vector<string> msg {"Hello", "C++", "World", "from", "VS Code", "and the C++ extension!"};

    for (const string& word : msg)
    {
        cout << word << " ";
    }
    cout << endl;
}