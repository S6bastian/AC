#include <iostream>
#include <bitset>
using namespace std;

// Función para sumar dos bitsets de 32 bits y devolver el resultado
bitset<32> sumarBitsets(const bitset<32>& bits1, const bitset<32>& bits2) {
    bitset<32> resultado;
    bool carry = false;

    for (int i = 31; i >= 0; --i) {
        bool bit1 = bits1[i];
        bool bit2 = bits2[i];

        // Realizar la suma de bits considerando el acarreo
        bool suma = bit1 ^ bit2 ^ carry;
        
        // Calcular el nuevo acarreo
        carry = (bit1 & bit2) | (carry & (bit1 ^ bit2));

        // Establecer el resultado en el bit correspondiente
        resultado[i] = suma;
    }

    return resultado;
}

// Función para multiplicar dos bitsets de 32 bits y devolver el resultado
bitset<32> multiplicarBitsets(const bitset<32>& bits1, const bitset<32>& bits2) {
    bitset<32> resultado(0);

    for (int i = 0; i < 32; ++i) {
        if (bits2[i]) {
            // Si el bit en bits2 es 1, suma bits1 al resultado desplazado
            resultado ^= (bits1 << i);
        }
    }

    return resultado;
}

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

    // Sumar los bitsets
    bitset<32> resultadoSuma = sumarBitsets(fpx, fpy);

    cout << "Suma de las representaciones binarias: " << resultadoSuma << endl;
    float c_resultadoSuma = convertirBitsetAFloat(resultadoSuma);
    cout << "Convertido de binario a float (): " << c_resultadoSuma << endl;

    // Multiplicar los bitsets
    bitset<32> resultadoMultiplicacion = multiplicarBitsets(fpx, fpy);

    cout << "Multiplicación de las representaciones binarias: " << resultadoMultiplicacion << endl;
    float c_resultadoMultiplicacion = convertirBitsetAFloat(resultadoMultiplicacion);
    cout << "Convertido de binario a float (): " << c_resultadoMultiplicacion << endl;

    return 0;
}