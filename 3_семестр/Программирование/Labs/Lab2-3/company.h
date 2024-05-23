//
// Created by Lord Coudy on 04/10/2020.
//

#ifndef WHITE_BELT_COMPANY_H
#define WHITE_BELT_COMPANY_H

#include <string>

using namespace std;

// Дочерний класс, содержащий информацию о компании
class CompanyInfo
{
public:
    CompanyInfo();
    void ChangeCompanyInfo(const string & company, const string & pop);    // Функци изменения названия и числа работников компании
    void ChangeName(const string & name);   // Функция изменения названия компании
    void ChangePopulation(const string & population);  // Функция изменения числа работников компании
    void ClearInfo();   // Функция очистки информации, содержащейся в классе
    string GetCompanyInfo() const;  // Функция возврата информации, содержащейся в классе
    string GetName() const; // Функция возврата названия компании
    string GetPopulation() const;  // Функция возврата числа работников
private:
    string name_;   // Переменная, содержащая название компании
    string population_;    // Переменная, содержащая число работников
};


#endif //WHITE_BELT_COMPANY_H
