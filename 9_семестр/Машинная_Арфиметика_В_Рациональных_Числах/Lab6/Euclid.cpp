//
// Created by Milord on 12/6/23.
//

#include "Euclid.h"

namespace euclid {
    Euclid::Euclid(long long numerator, long long denominator) : numerator(numerator), denominator(denominator)
    {

    }

    Euclid::Euclid() : numerator(0), denominator(0)
    {

    }

    Euclid::~Euclid() {

    }

    std::ostream &operator<<(std::ostream &os, const Euclid &euclid1) {
        os << "numerator: " << euclid1.numerator << " denominator: " << euclid1.denominator;
        return os;
    }

    Euclid Euclid::operator+(const Euclid &euclid2) const {
        pair<long long, long long> result = calc(numerator, denominator, euclid2.numerator, euclid2.denominator, euclid2.denominator, 0);
        return {result.first, result.second};
    }

    Euclid Euclid::operator-(const Euclid &euclid2) const {
        pair<long long, long long> result = calc(numerator, denominator, -euclid2.numerator, euclid2.denominator, euclid2.denominator, 0);
        return {result.first, result.second};
    }

    Euclid Euclid::operator*(const Euclid &euclid2) const {
        pair<long long, long long> result = calc(numerator, denominator, 0, euclid2.numerator, euclid2.denominator, 0);
        return {result.first, result.second};
    }

    Euclid Euclid::operator/(const Euclid &euclid2) const {
        pair<long long, long long> result = calc(numerator, denominator, 0, euclid2.denominator, euclid2.numerator, 0);
        return {result.first, result.second};
    }

    pair<long long, long long> Euclid::calc(long long b2, long long b1, long long u2, long long u1, long long v2, long long v1) const
    {
        long long a = b2 / b1;
        long long b = b2 % b1;
        long long u = u1 * a + u2;
        long long v = v1 * a + v2;
        if (b == 0)
        {
            return {u, v};
        }
        return calc(b1, b, u1, u, v1, v);
    }

    long long Euclid::getNumerator() const {
        return numerator;
    }

    long long Euclid::getDenominator() const {
        return denominator;
    }


} // euclid