//
// Created by Milord on 12/6/23.
//

#ifndef LAB6_EUCLID_H
#define LAB6_EUCLID_H

#include <ostream>
#include <iostream>
#include "iomanip"

namespace euclid {
    using namespace std;

    class Euclid {
    public:
        Euclid(long long numerator, long long denominator);
        Euclid();
        ~Euclid();

        long long getNumerator() const;
        long long getDenominator() const;

        friend std::ostream &operator<<(std::ostream &os, const Euclid &euclid1);

        Euclid operator+(const Euclid &euclid2) const;
        Euclid operator-(const Euclid &euclid2) const;
        Euclid operator*(const Euclid &euclid2) const;
        Euclid operator/(const Euclid &euclid2) const;

    private:
        long long numerator;
        long long denominator;
        pair<long long, long long> calc(long long b2, long long b1, long long u2, long long u1, long long v2, long long v1) const;
    };

} // euclid

#endif //LAB6_EUCLID_H
