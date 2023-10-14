.data
neg1:   .word   -1
zero:   .word   0
.text
.globl  main
main:
    # Inicializa los registros y la multiplicación de 64 bits
    li $v0, 0       
    li $v1, 0        
    li $t0, 32       
    lw $t2, neg1     

loop:
    sll $t3, $a1, 31   
    sra $t4, $a0, 31   
    add $t3, $t3, $t4  

    # Multiplica por 2 y suma/substrae
    sllv $t5, $a0, $t0 
    srav $t6, $a0, $t0 
    sub $t7, $t5, $t6  

    beq $t3, $t2, shift_left
    bne $t3, $zero, shift_right

shift_right:
    addu $v0, $v0, $t6  
    addu $v1, $v1, $t5  

    j next_iteration

shift_left:
    subu $v0, $v0, $t7  
    addu $v1, $v1, $t5  

next_iteration:
    srl $a1, $a1, 1    
    sll $a0, $a0, 1   
    subi $t0, $t0, 1    
    bnez $t0, loop      

    jr $ra