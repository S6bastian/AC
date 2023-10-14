.data
neg1:   .word   -1
zero:   .word   0
.text
.globl  main
main:
    # Inicializa los registros y la multiplicación de 64 bits
    li $v0, 0        # Inicializa el registro de resultado (parte baja)
    li $v1, 0        # Inicializa el registro de resultado (parte alta)
    li $t0, 32       # Inicializa el contador para 32 bits
    lw $t2, neg1     # Carga -1 en $t2 para usarlo en la comparación

loop:
    sll $t3, $a1, 31   # Obtiene el bit más significativo de $a1
    sra $t4, $a0, 31   # Obtiene el bit más significativo de $a0
    add $t3, $t3, $t4  # Comprueba los dos bits más significativos

    # Multiplica por 2 y suma/substrae
    sllv $t5, $a0, $t0  # $t5 = $a0 << $t0
    srav $t6, $a0, $t0  # $t6 = $a0 >> $t0
    sub $t7, $t5, $t6   # $t7 = ($a0 << $t0) - ($a0 >> $t0)

    beq $t3, $t2, shift_left
    bne $t3, $zero, shift_right

shift_right:
    addu $v0, $v0, $t6  # $v0 += ($a0 >> $t0)
    addu $v1, $v1, $t5  # $v1 += ($a0 << $t0)

    j next_iteration

shift_left:
    subu $v0, $v0, $t7  # $v0 -= ($a0 << $t0)
    addu $v1, $v1, $t5  # $v1 += ($a0 << $t0)

next_iteration:
    srl $a1, $a1, 1    # Desplaza $a1 a la derecha
    sll $a0, $a0, 1    # Desplaza $a0 a la izquierda
    subi $t0, $t0, 1    # Decrementa el contador
    bnez $t0, loop      # Si $t0 != 0, vuelve al bucle

    jr $ra