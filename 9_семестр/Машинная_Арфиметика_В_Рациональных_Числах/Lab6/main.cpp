#include "Euclid.h"

using namespace euclid;

int main() {
    vector<Euclid> euclids = {Euclid(371, 243), Euclid(26, 17), Euclid(31, 43)};
    vector<Euclid> euclids2 = {Euclid(55, 67), Euclid(113, 27), Euclid(17, 311)};
    Euclid result(0, 1);
    double dResult = 0;
    for (int i = 0; i < euclids.size(); i++) {
        result = result + euclids[i] * euclids2[i];
        auto da = double (euclids[i].getNumerator()) / double (euclids[i].getDenominator());
        auto db = double (euclids2[i].getNumerator()) / double (euclids2[i].getDenominator());
        dResult += da * db;
    }
    cout << setprecision(20);
    cout << result << endl;
    cout << "Euclid arifmetics: " << double(result.getNumerator()) / double (result.getDenominator()) << endl;
    cout << "Double precision: " << dResult << endl;
    return 0;
}
