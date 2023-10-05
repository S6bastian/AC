.data
A: .word 3, 1, 2, 0 # El arreglo A[]
n: .word 4          # Longitud del arreglo

.text
.globl main
main:
    # Inicializar registros
    la $s1, A         # Cargar la direcci�n base de A en $s1
    lw $s2, n         # Cargar la longitud del arreglo en $s2
    lw $t0, 0($s1)    # Inicializar el m�ximo en A[0]
    li $t1, 0         # Inicializar el �ndice i a 0

loop:
    addi $t1, $t1, 1   # Incrementar el �ndice i en 1
    beq $t1, $s2, done   # Si se han examinado todos los elementos, salir
    sll $t2, $t1, 2   # Calcular 4i en $t2 (desplazamiento de bits izquierdo por 2)
    add $t2, $t2, $s1   # Formar la direcci�n de A[i] en $t2
    lw $t3, 0($t2)   # Cargar el valor de A[i] en $t3
    slt $t4, $t0, $t3   # �m�ximo < A[i]?
    beq $t4, $zero, loop   # Si no, repetir sin cambios
    move $t0, $t3   # Si es as�, A[i] es el nuevo m�ximo
    j loop   # Cambio completado; repetir ahora

done:
    # El resultado (m�ximo) est� en $t0
    # Aqu� puedes hacer lo que desees con el resultado

    # Terminar el programa
    li $v0, 10
    syscall
