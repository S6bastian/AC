#include <iostream>
#include <bitset>
using namespace std;

int main() {
    float fx = 2.5; // Valor float
    float fy = 5.25;

    // Convierte el valor float a un número entero sin signo de 32 bits
    uint32_t castx = *reinterpret_cast<uint32_t*>(&fx);
    uint32_t casty = *reinterpret_cast<uint32_t*>(&fy);

    // Crea un objeto bitset a partir del valor entero
    bitset<32> fpx(castx);
    bitset<32> fpy(casty);

    cout << "Valor float: " << fx << endl;
    cout << "Representación binaria de 32 bits: " << fpx << endl;
    cout << "Valor float: " << fy << endl;
    cout << "Representación binaria de 32 bits: " << fpy << endl;

    return 0;
}