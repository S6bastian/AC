.data
coefficients: .space 400
result_prompt: .asciiz "Ingrese el valor de x (float): "
result_format: .asciiz "El resultado de P(x) es: "

.text
.globl main

main:
    # Pida al usuario el grado del polinomio
    li $v0, 4
    la $a0, degree_prompt
    syscall

    # Lea el grado del polinomio desde la entrada estándar
    li $v0, 5
    syscall
    move $s0, $v0  # $s0 contiene el grado del polinomio

    # Reserve espacio para almacenar los coeficientes
    li $v0, 9
    li $a0, 4       # Cada coeficiente es un entero (4 bytes)
    mul $a0, $a0, $s0  # Reservar espacio para todos los coeficientes
    syscall
    move $s1, $v0  # $s1 contiene la dirección base de los coeficientes

    # Pida al usuario ingresar los coeficientes
    la $t0, coefficients
    li $t1, 0       # Inicializar el índice del coeficiente en 0

input_coefficients:
    beq $t1, $s0, input_x
    li $v0, 4
    la $a0, coefficient_prompt
    syscall

    li $v0, 5
    lw $a0, 0($t0)
    syscall

    sw $a0, 0($s1)  # Almacene el coeficiente en la memoria
    addi $t0, $t0, 4
    addi $s1, $s1, 4
    addi $t1, $t1, 1
    j input_coefficients

input_x:
    # Pida al usuario ingresar el valor de x
    li $v0, 4
    la $a0, result_prompt
    syscall

    li $v0, 6
    syscall
    move $s2, $v0  # $s2 contiene el valor de x

    # Calcular el resultado del polinomio
    li $t1, 0
    li $t2, 0
    li $t3, 1

calculate_polynomial:
    beq $t1, $s0, print_result
    lw $t4, 0($s1)
    mul $t5, $t4, $t3  # $t5 = coefficient * x^n
    mul $t2, $t2, $s2  # $t2 = result * x
    add $t2, $t2, $t5  # $t2 += coefficient * x^n
    addi $t3, $t3, 1
    addi $t1, $t1, 1
    addi $s1, $s1, 4
    j calculate_polynomial

print_result:
    li $v0, 4
    la $a0, result_format
    syscall

    move $a0, $t2  # $a0 contiene el resultado
    li $v0, 1
    syscall

    # Salir del programa
    li $v0, 10
    syscall
