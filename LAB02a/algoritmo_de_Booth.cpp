#include <iostream>
#include <bitset>
using namespace std;

template<int T>
void c2(bitset<T>& x){
    //cout<<x<<endl;
    x.flip();
    //cout<<x<<endl;
    x = x.to_ulong() + 1;
    //cout<<x<<endl;
}

template<int T>
bitset<T> suma(bitset<T> a, bitset<T> b) {
    bitset<T> resultado;
    bool carry = false; // Inicialmente no hay acarreo

    for (int i = 0; i < T; i++) {
        bool bit_a = a[i];
        bool bit_b = b[i];

        // Realizar la suma de bits y considerar el acarreo
        bool suma = bit_a ^ bit_b ^ carry; // Suma de bits usando XOR
        carry = (bit_a & bit_b) | (carry & (bit_a ^ bit_b));

        // Asignar el resultado al bit correspondiente en el resultado
        resultado[i] = suma;
    }

    return resultado;
}

template<int T, int TT = 2*T>
bitset<TT> multiplicacion(bitset<T> M, bitset<T> Q){
    const int n = M.size() * 2;
    bitset<n> m; //multiplicando
    bitset<n> q; //multiplicador
    bitset<n> a; //multiplicando_c2
    bitset<1> q_1; //bit de la derecha
    
    for(int i = 0; i < n/2; i++){
        m[i+(n/2)] = M[i];
        q[i] = Q[i];
    }
    a = m;
    c2<n>(a);

    cout<<"Algoritmo de Booth"<<endl;

    cout<<"M "<<m<<" "<<q_1<<endl;
    cout<<"A "<<a<<" "<<q_1<<endl;
    cout<<"Q "<<q<<" "<<q_1<<endl;

    int counter = T;
    while(counter != 0){
        
        if(q.test(0) == true && q_1.test(0) == false){
            q = suma<n>(q, a);
            cout<<"Q "<<q<<" "<<q_1<<endl;
            //counter--;
        }
        else if(q.test(0) == false && q_1.test(0) == true){
            q = suma<n>(q, m);
            cout<<"Q "<<q<<" "<<q_1<<endl;
            //counter--;
        }

        if(counter == 0)
            break;

        

        if(q.test(0)){
            q_1.set();
        }
        else{
            q_1.reset();
        }

        q >>= 1;
        if(q_1.test(0)){
            q.set(TT-1);
        }
        cout<<"Q "<<q<<" "<<q_1<<endl;
        counter--;
        
    }
    return q;
}

int main(){
    const int n = 4;
    bitset<n> A; //palabra binaria auxiliar
    bitset<n> M(5); //multiplicando
    bitset<n> Q(3); //multiplicador

    bitset<n*2> resultado;
    
    resultado = multiplicacion<n>(M, Q);

    cout<<"Resultado: "<<resultado.to_ulong()<<endl;
    return 0;
}