//
// Created by savva on 11/12/2020.
//

#ifndef MODEL_SATA_H
#define MODEL_SATA_H


class Star {
public:
    Star (double temp, double dens);
    void Simulate();
    void CheckState();

private:
    double temperature;
    double density;
};


#endif //MODEL_SATA_H
