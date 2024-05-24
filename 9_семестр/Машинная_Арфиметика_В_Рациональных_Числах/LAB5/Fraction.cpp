//
// Created by Milord on 11/20/23.
//

#include "Fraction.h"

using namespace std;
namespace farey {
    Fraction::Fraction(int numerator, int denominator, int mod, int order) :
    numerator(numerator), denominator(denominator), mod(mod), order(order) {
        updateIntView();
    }

    Fraction::Fraction(Fraction &f) :
    numerator(f.numerator), denominator(f.denominator), mod(f.mod), order(f.order) {
        updateIntView();
    }

    Fraction::Fraction() :
    numerator(0), denominator(0), mod(2), order(1) {
        updateIntView();
    }

    Fraction::~Fraction() {
        Fraction::numerator = 0;
        Fraction::denominator = 0;
        Fraction::mod = 0;
        Fraction::order = 0;
        updateIntView();
    }

    void Fraction::setNumerator(int num) {
        Fraction::numerator = num;
    }

    void Fraction::setDenominator(int den) {
        Fraction::denominator = den;
    }

    void Fraction::setMod(int mod) {
        Fraction::mod = mod;
        updateIntView();
    }

    void Fraction::setOrder(int ord) {
        Fraction::order = ord;
    }

    int Fraction::getNumerator() const {
        return Fraction::numerator;
    }

    int Fraction::getDenominator() const {
        return Fraction::denominator;
    }

    int Fraction::getMod() const {
        return Fraction::mod;
    }

    int Fraction::getOrder() const {
        return Fraction::order;
    }

    void Fraction::updateIntView() {
        if (Fraction::numerator < 0)
        {
            Fraction::intView = (((Fraction::numerator + Fraction::mod) % Fraction::mod) * (reverse(Fraction::denominator) % Fraction::mod)) % Fraction::mod;
        } else
        {
            Fraction::intView = ((Fraction::numerator % Fraction::mod) * (reverse(Fraction::denominator) % Fraction::mod)) % Fraction::mod;
        }
    }

    void Fraction::setFracView(int num) {
        *this = Fraction::backReverse(num);
    }

    int Fraction::getIntView() const {
        return Fraction::intView;
    }

    int countOrder(Fraction &f1, Fraction &f2)
    {
        return max(max(abs(f1.getNumerator()), abs(f2.getNumerator())), max(abs(f1.getDenominator()), abs(f2.getDenominator())));
    }

    bool Fraction::operator==(const Fraction &rhs) const{
        return numerator == rhs.numerator &&
               denominator == rhs.denominator &&
               mod == rhs.mod &&
               order == rhs.order &&
               intView == rhs.intView;
    }

    bool Fraction::operator!=(const Fraction &rhs) const{
        return !(rhs == * this);;
    }

    std::ostream& operator<<(std::ostream &os, const Fraction &f) {
        os << "Дробь: " << f.numerator << " / " << f.denominator << "\nПорядок: " << f.order << "\nМодуль: "
           << f.mod << "\nЦелочисленное представление: " << f.intView;
        return os;
    }


    Fraction Fraction::operator+(const Fraction &rhs) {
        Fraction result(* this) ;
        result.intView = (Fraction::getIntView() + rhs.getIntView()) % Fraction::mod;
        result.setFracView(result.intView) ;
        return result;
    }

    Fraction Fraction::operator-(const Fraction &rhs) {
        Fraction result(* this);
        result.intView = (Fraction::mod + (Fraction::getIntView() - rhs.getIntView())) % Fraction::mod;
        result.setFracView(result.intView);
        return result;
    }

    Fraction Fraction::operator*(const Fraction &rhs) {
        Fraction result(* this) ;
        result.intView = (Fraction::getIntView() * rhs.getIntView()) % Fraction::mod;
        result.setFracView(result.intView) ;
        return result;
    }

    Fraction Fraction::operator/(const Fraction &rhs) {
        Fraction result(* this) ;
        result.intView = (Fraction::getIntView() * reverse(rhs.getIntView())) % Fraction::mod;
        result.setFracView(result.intView) ;
        return result;
    }

    Fraction Fraction::operator=(const Fraction &rhs) {
        Fraction::numerator = rhs.numerator;
        Fraction::denominator = rhs.denominator;
        Fraction::mod = rhs.mod;
        Fraction::order = rhs.order;
        Fraction::intView = rhs.intView;
        return * this;
    }

    int Fraction::gcdex (int a, int b, int & x, int & y) const{
        if (a == 0) {
            x = 0; y = 1;
            return b;
        }
        int x1, y1;
        int d = gcdex (b%a, a, x1, y1);
        x = y1 - (b / a) * x1;
        y = x1;
        return d;
    }

    int Fraction::reverse(int num) const
    {
        int r, y;
        int g = gcdex (num, mod, r, y);
        if (g != 1)
        {
            return 0;
        }
        else {
            r = (r % mod + mod) % mod;
            return r;
        }
    }

    Fraction Fraction::backReverse ( int num )
    {
        if ( num < 0 || num > order )
        {
            pair<int, int> middle(mod, num) ;
            int left, tmp;
            pair<int, int> right(0, 1) ;
            do {
                left = floor(middle.first / middle.second) ;
                tmp = middle.first - left * middle.second;
                middle.first = middle.second;
                middle.second = tmp;
                tmp = right.first - left * right.second;
                right.first = right.second;
                right.second = tmp;
            } while ((abs(middle.second) > order || abs(right.second) > order) && middle.second != 0) ;
            if ( right.second < 0 )
            {
                return {- middle.second, - right.second, mod, order } ;
            } else
            {
                return {middle.second, right.second, mod, order } ;
            }
        } else
        {
            return {num, 1, mod, order } ;
        }
    } ;

    bool checkMod (int n, int m)
    {
        if (m >= 2 * pow(n, 2) + 1)
        {
            return true;
        }
        return false;
    }

    vector<pair<int, int>> generate (int n, bool asc)
    {
        vector<pair<int, int>> f;
        int a = 0, b = 1, c = 1, d = n;
        // a/b, c/d, p/q
        if ( ! asc )
        {
            a = 1, b = 1, c = n - 1, d = n;
        }
        f.push_back({a, b }) ;
        while ( (asc && c <= n) || (! asc && a > 0) )
        {
            int k = (n + b) / d;
            int tmpc = c, tmpd = d;
            c = k * c - a;
            d = k * d - b;
            a = tmpc;
            b = tmpd;
            f.push_back({a, b }) ;
        }
        return f;
    }
}