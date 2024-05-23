#include "company.h"

CompanyInfo::CompanyInfo()= default;

void CompanyInfo::ChangeCompanyInfo(const string & company, const string & pop)
{
    ChangeName(company);
    ChangePopulation(pop);
}
void CompanyInfo::ChangeName(const string & name)
{
    if (!name.empty())
    {
        name_ = name;
    } else
        throw invalid_argument("Invalid name");
}
void CompanyInfo::ChangePopulation(const string & population)
{
    bool d = true;
    for (auto & p : population)
    {
        if (!isdigit(p))
        {
            d = false;
            break;
        }
    }
    if (population != "0" && d)
    {
        population_ = population;
    } else
        throw invalid_argument("Invalid population");
}
void CompanyInfo::ClearInfo()
{
    name_.clear();
    population_.clear();
}

string CompanyInfo::GetCompanyInfo() const
{
    return name_ + ' ' + population_;
}
string CompanyInfo::GetName() const
{
    return name_;
}
string CompanyInfo::GetPopulation() const
{
    return population_;
}
