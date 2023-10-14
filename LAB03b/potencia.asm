.data

.text
    .globl main
    
main:
    # Llama al procedimiento "pot" con base = 2 y exponente = 3
    li $a0, 2
    li $a1, 3
    jal pot
    
    # Imprime el resultado
    move $a0, $v0
    li $v0, 1
    syscall
    
    # Termina el programa
    li $v0, 10
    syscall

pot:
    # Inicializa $v0 a 
    li $v0, 1
    
    loop:
        
        beq $a1, $zero, done
        mul $v0, $v0, $a0
        subi $a1, $a1, 1
        
        j loop
        
    done:
        jr $ra
