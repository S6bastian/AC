#include <iostream>
#include <bitset>
using namespace std;

// Función para convertir un bitset de 32 bits a float
float convertirBitsetAFloat(const bitset<32>& bits) {
    uint32_t valorEntero = bits.to_ulong();
    return *reinterpret_cast<float*>(&valorEntero);
}

int main() {
    float fx = 2.5;
    float fy = 5.25;

    uint32_t castx = *reinterpret_cast<uint32_t*>(&fx);
    uint32_t casty = *reinterpret_cast<uint32_t*>(&fy);

    bitset<32> fpx(castx);
    bitset<32> fpy(casty);

    cout << "Valor float: " << fx << endl;
    cout << "Representación binaria de 32 bits: " << fpx << endl;
    cout << "Valor float: " << fy << endl;
    cout << "Representación binaria de 32 bits: " << fpy << endl;

    // Convertir los bitsets nuevamente a float
    float convertido_x = convertirBitsetAFloat(fpx);
    float convertido_y = convertirBitsetAFloat(fpy);

    cout << "Convertido de binario a float (x): " << convertido_x << endl;
    cout << "Convertido de binario a float (y): " << convertido_y << endl;

    return 0;
}