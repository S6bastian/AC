#include <iostream>
#include <bitset>
using namespace std;

template<int T>
void c2(bitset<T>& x){
    x.flip();
    x = x.to_ulong() + 1;
}

template<int T>
bitset<T> suma(bitset<T> a, bitset<T> b) {
    bitset<T> resultado;
    bool carry = false; // Inicialmente no hay acarreo

    for (int i = 0; i < T; i++) {
        bool bit_a = a[i];
        bool bit_b = b[i];

        bool suma = bit_a ^ bit_b ^ carry; // Suma de bits usando XOR
        carry = (bit_a & bit_b) | (carry & (bit_a ^ bit_b));

        resultado[i] = suma;
    }

    return resultado;
}

template<int T>
bitset<T> resta(bitset<T> a, bitset<T> b) {
    bitset<T> resultado;
    bool carry = false; // Inicialmente no hay acarreo
    c2<T>(b);

    for (int i = 0; i < T; i++) {
        bool bit_a = a[i];
        bool bit_b = b[i];

        bool suma = bit_a ^ bit_b ^ carry; // Suma de bits usando XOR
        carry = (bit_a & bit_b) | (carry & (bit_a ^ bit_b));

        resultado[i] = suma;
    }
    
    c2<T>(b);
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
        }
        else if(q.test(0) == false && q_1.test(0) == true){
            q = suma<n>(q, m);
            cout<<"Q "<<q<<" "<<q_1<<endl;
        }    

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
    const int n = 8;
    bitset<n> A; //palabra binaria auxiliar
    bitset<n> M(25); //multiplicando
    bitset<n> Q(13); //multiplicador

    bitset<n*2> resultado;
    bitset<n> resultado_suma;
    bitset<n> resultado_resta;
    
    

    resultado = multiplicacion<n>(M, Q);
    cout<<"Resultado multiplicacion: "<<M.to_ulong()<<" x "<<Q.to_ulong()<<" = "<<resultado.to_ulong()<<endl<<endl;

    resultado_suma=suma<n>(M,Q);
    cout<<"Resultado suma: "<<M.to_ulong()<<" + "<<Q.to_ulong()<<" = "<<resultado_suma.to_ulong()<<endl<<endl;
    
    resultado_resta=resta<n>(M,Q);
    cout<<"Resultado resta: "<<M.to_ulong()<<" - "<<Q.to_ulong()<<" = "<<resultado_resta.to_ulong()<<endl<<endl;

    return 0;
}