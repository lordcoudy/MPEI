//
// Created by Lord Coudy on 08/09/2020.
//

#ifndef WHITE_BELT_POST_H
#define WHITE_BELT_POST_H

#include <string>
#include "company.h"

using namespace std;

void CheckForCorrectInput(const string & input);    // Функция проверки ввода на буквенные значения
void CheckForCorrectNumber(const string & number);  // Функция проверки ввода на числовые значения

//Основной класс с информацией об адресе
class Post : public CompanyInfo
{
public:
    Post(); // Конструктор по умолчанию
    Post(const string & address, const string & name, const string & pop);    // Конструктор класса
    void FullChange(const string & address, const string & name, const string & pop);  // Конструктор с входными данными (строка адреса, строка имени компании, строка с количеством работников
    void ChangeAddress(const string & address); // Функция изменения всего адреса
    void ChangeCountry(const string & country); // Функция изменения адреса без изменения информации о компании
    void ChangeCity(const string & city); // Функция изменения страны
    void ChangeStreet(const string & street); // Функция изменения города
    void ChangeHouseNumber(const string & number); // Функция изменения района
    void ChangePostIndex(const string & index); // Функция изменения улицы
    void ClearAll(); // Функция очистки всего адреса
    string GetAddress() const;  // Функция возврата всего адреса
    string GetCountry() const;  // Функция возврата страны
    string GetCity() const;  // Функция возврата города
    string GetStreet() const;  // Функция возврата улицы
    string GetHouseNumber() const;  // Функция возврата номера дома
    string GetPostIndex() const;  // Функция возврата почтового индекса

private:
    string country_;   // Переменная, содержащая название страны
    string city_;   // Переменная, содержащая название города
    string street_;   // Переменная, содержащая название улицы
    string house_number_;   // Переменная, содержащая номер дома
    string post_index_;   // Переменная, содержащая почтовый индекс
};

#endif //WHITE_BELT_POST_H
