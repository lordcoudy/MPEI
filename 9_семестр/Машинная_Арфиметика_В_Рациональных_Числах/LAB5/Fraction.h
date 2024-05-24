//
// Created by Milord on 11/20/23.
//

#ifndef LAB5_FRACTION_H
#define LAB5_FRACTION_H

#pragma once
#include "stdcpp.h"
#include "boost/multiprecision/cpp_dec_float.hpp"

using namespace std;
namespace farey {

    class Fraction {
    public:
        Fraction(int numerator, int denominator, int mod, int order);
        Fraction(Fraction &f);
        Fraction();
        ~Fraction();
        void setNumerator(int num);
        void setDenominator(int den);
        void setMod(int mod);
        void setOrder(int ord);
        int getNumerator() const;
        int getDenominator() const;
        int getMod() const;
        int getOrder() const;

        void updateIntView();
        void setFracView(int num);
        int getIntView() const;

        int countOrder(Fraction &f1, Fraction &f2);

        bool operator==(const Fraction &rhs) const;
        bool operator!=(const Fraction &rhs) const;

        friend std::ostream &operator<<(std::ostream &os, const Fraction &f);

        Fraction operator+(const Fraction &rhs);
        Fraction operator-(const Fraction &rhs);
        Fraction operator*(const Fraction &rhs);
        Fraction operator/(const Fraction &rhs);
        Fraction operator=(const Fraction &rhs);

        int gcdex(int a, int b, int &x, int &y) const;
        
    private:
        int numerator;
        int denominator;
        int mod;
        int order;
        int intView;

        int reverse(int num) const;
        Fraction backReverse(int num);

    };

    bool checkMod (int n, int m);
    vector<pair<int, int>> generate (int n, bool asc = true);
}

#endif //LAB5_FRACTION_H
