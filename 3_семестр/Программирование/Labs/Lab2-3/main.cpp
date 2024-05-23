#include <iostream>
#include <vector>
#include "post.h"

using namespace std;


void AddFullAddress(Post & post)
{
    string country, city, street, house;   // Переменные почтового адреса
    string name_company;    // Переменная названия компании
    string index;
    string population;  // Переменная количества работников
        cout << "Enter address" << endl;
        cout << "Enter country:" << endl;
        cin >> country;
        cout << country << endl;
        post.ChangeCountry(country);
        cout << "Enter city:" << endl;
        cin >> city;
        cout << city << endl;
        post.ChangeCity(city);
        cout << "Enter street:" << endl;
        cin >> street;
        cout << street << endl;
        post.ChangeStreet(street);
        cout << "Enter house number:" << endl;
        cin >> house;
        cout << house << endl;
        post.ChangeHouseNumber(house);
        cout << "Enter post index:" << endl;
        cin >> index;
        cout << index << endl;
        post.ChangePostIndex(index);
        cout << "Enter name of company:" << endl;
        cin >> name_company;    // Считывание названия компании из консоли
        cout << name_company << endl;
        post.ChangeName(name_company);
        cout << "Enter population of company:" << endl;
        cin >> population;
        cout << population << endl;
        post.ChangePopulation(population);
    cout << "Address have been added:" << endl;
    cout << post.GetAddress() << endl; // Вывод обработанной информации
}

int main()
{
    Post post;
    char input; // Переменная выбора
    bool end = false;   // Переменная, отвечающая за окончание работы программы
    bool check = true;
    while (check)
    try
    {
        AddFullAddress(post);
        check = false;
    } catch (const invalid_argument & invalid_argument) {
        cout << invalid_argument.what() << endl;
        check = true;
    }
    while (!end) {
        cout
                << "Choose, what you want to do:\n"
                   "F - add new full address with company info\n"
                   "C - change country\n"
                   "T - change city\n"
                   "S - change street\n"
                   "H - change house number\n"
                   "I - change post index\n"
                   "N - change company name\n"
                   "P - change population of company\n"
                   "V - show full address\n"
                   "B - to clear all\n"
                   "E - to exit" << endl;
        cin.get(input);   // Считывание переменной второго выбора из консоли
        input = toupper(input); // Перевод переменной в верхний регистр
        try {
            switch (input)  // Меню действий, которые может совершить программа над переменной класса
            {
                case 'F': {
                    AddFullAddress(post);
                    break;
                }
                case 'C': {
                    string country; // Переменная страны
                    cout << "Enter country:" << endl;
                    cin >> country;
                    cout << country << endl;
                    post.ChangeCountry(country);
                    break;
                }
                    //// Аналогично стране происходит обработка города, района, улицы, номера дома, почтового индекса, названия компании и количества работников
                case 'T': {
                    string city;
                    cout << "Enter city:" << endl;
                    cin >> city;
                    cout << city << endl;
                    post.ChangeCity(city);
                    break;
                }
                case 'S': {
                    string street;
                    cout << "Enter street:" << endl;
                    cin >> street;
                    cout << street << endl;
                    post.ChangeStreet(street);
                    break;
                }
                case 'H': {
                    string house_number;
                    cout << "Enter house number:" << endl;
                    cin >> house_number;
                    cout << house_number << endl;
                    post.ChangeHouseNumber(house_number);
                    break;
                }
                case 'I': {
                    string index;
                    cout << "Enter post index:" << endl;
                    cin >> index;
                    cout << index << endl;
                    post.ChangePostIndex(index);
                    break;
                }
                case 'N': {
                    string name_company;
                    cout << "Enter name of company:" << endl;
                    cin >> name_company;    // Считывание названия компании из консоли
                    cout << name_company << endl;
                    post.ChangeName(name_company);
                    break;
                }
                case 'P': {
                    string population;
                    cout << "Enter population of company:" << endl;
                    cin >> population;
                    cout << population << endl;
                    post.ChangePopulation(population);
                    break;
                }
                case 'V': {
                    cout << "Full address with company info:" << endl;
                    cout << post.GetAddress() << endl; // Вывод информации, которую содержит класс адреса
                    // с помощью специального метода этого класса
                    break;
                }
                case 'B': {
                    post.ClearAll();
                    cout << "All clear" << endl;
                    break;
                }
                case 'E': {
                    end = true; // Переменная окончания программы переводится в положение true
                    break;
                }
                default: {
                    cout << "Unknown command, please try again." << endl;
                    break;
                }
            }
        } catch (const invalid_argument &i) // Поиск выброса исключений
        {
            cout << i.what() << endl;   // Вывод расшифровки исключений
        }
    }
    return 0;
}