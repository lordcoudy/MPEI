#include "post.h"
#include <sstream>

void CheckForCorrectInput(const string & input)
{
    for (const auto & character : input)
    {
        if (!isalpha(character))
        {
            throw invalid_argument("Incorrect symbol");
        }
    }
}
void CheckForCorrectNumber(const string & number)
{
    for (const auto & character : number)
    {
        if (!isdigit(character))
        {
            throw invalid_argument("Incorrect symbol");
        }
    }
}


Post::Post() = default;

Post::Post(const string &address, const string & name, const string & pop)
{
    FullChange(address, name, pop);
}

void Post::FullChange(const string & address, const string & name, const string & pop)
{
    ChangeCompanyInfo(name, pop);
    ChangeAddress(address);
}
void Post::ChangeAddress(const string & address)
{
    stringstream stream(address);   // Создание потока из строки адреса
    string country, city, street, number, index;  // Отдельные переменные адреса
    getline(stream, country, ',');  // Считывание переменной до знака запятой
    if (stream.peek() == ' ')   // Пропуск пробела, если существует
    {
        stream.ignore(1);
    }
    //// Аналогично с остальными переменными
    getline(stream, city, ',');
    if (stream.peek() == ' ')
    {
        stream.ignore(1);
    }
    getline(stream, street, ',');
    if (stream.peek() == ' ')
    {
        stream.ignore(1);
    }
    getline(stream, number, ',');
    if (stream.peek() == ' ')
    {
        stream.ignore(1);
    }
    getline(stream, index, '\n');
    //// Обработка отдельных переменных адреса с помощью соответствующих методов
    ChangeCountry(country);
    ChangeCity(city);
    ChangeStreet(street);
    ChangeHouseNumber(number);
    ChangePostIndex(index);
}
void Post::ChangeCountry(const string & country)
{
    if (!country.empty())   // Проверка на пустоту
    {
        CheckForCorrectInput(country);
        country_ = country; // Присвоение переменной
    } else
        throw invalid_argument("Invalid name of country");  // Выброс исключения
}
void Post::ChangeCity(const string &city)
{
    if (!city.empty())
    {
        CheckForCorrectInput(city);
        city_ = city;
    } else
        throw invalid_argument("Invalid name of city");
}
void Post::ChangeStreet(const string &street)
{
    if (!street.empty())
    {
        CheckForCorrectInput(street);
        street_ = street;
    } else
        throw invalid_argument("Invalid name of street");
}
void Post::ChangeHouseNumber(const string &number)
{
    if (!number.empty())
    {
        if (!isdigit(number[0]))
        {
            throw invalid_argument("Invalid number of house");
        }
        house_number_ = number;
    } else
        throw invalid_argument("Invalid number of house");
}
void Post::ChangePostIndex(const string &index)
{
    if (index.size() == 6)
    {
        CheckForCorrectNumber(index);
        post_index_ = index;
    } else
        throw invalid_argument("Invalid index of post");
}
void Post::ClearAll()
{
    country_.clear();
    city_.clear();
    street_.clear();
    house_number_.clear();
    post_index_.clear();
    ClearInfo();
}

string Post::GetAddress() const
{
    return "Address: " + GetCountry() + ", " + GetCity()
    + ", " + GetStreet()+ ", "
    + GetHouseNumber() + ", " + GetPostIndex() + "\nCompany: " + GetName() + " (" + GetPopulation() + ");";
}
string Post::GetCountry() const
{
    if (!country_.empty())
    {
        return country_;
    } else
        throw invalid_argument("No country name");
}
string Post::GetCity() const
{
    if (!city_.empty())
    {
        return city_;
    } else
        throw invalid_argument("No city name");
}
string Post::GetStreet() const
{
    if (!street_.empty())
    {
        return street_;
    } else
        throw invalid_argument("No street name");
}
string Post::GetHouseNumber() const
{
    if (!house_number_.empty())
    {
        return house_number_;
    } else
        throw invalid_argument("No house number");
}
string Post::GetPostIndex() const
{
    if (!post_index_.empty())
    {
        return post_index_;
    } else
        throw invalid_argument("No post index");
}