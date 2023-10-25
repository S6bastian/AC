## Fibonacci.asm

# SECCION DE INSTRUCCIONES (.text)
.text
.globl __start

__start:
la $a0, Fiboprt
li $v0, 4
syscall
li $v0, 5
syscall
addi $t8,$v0,0         # valor de teclado en $t8
li $t0,0
li $t1,1

la $a0,Fibost1
li $v0,4
syscall               # "La serie Fibonacci de "
addi $a0,$t8,0
li $v0,1
syscall               # n
la $a0,Fibost2
li $v0,4 
syscall               # " terminos es: "
li $a0,1
li $v0,1
syscall               # 1, ...
la $a0,coma
li $v0,4
syscall
      li   $t4,2
      beq  $t8,$0,fin
      bltz $t8,fin
      
      #CONTEO INSTRUCCIONES = 30
      
loop: add  $t2,$t0,$t1  # fibonacci
      addi $a0,$t2,0  
      li $v0,1
      syscall
      beq $t4,$t8,fin
      
      #INSTRUCIONES ANTES DE BIFURCACIÓN = 5
      #HASTA AQUI LLEGA EL LOOP SI n = 2
      
      la $a0,coma
      li $v0,4
      syscall
      addi $t4,$t4,1
      addi $t0,$t1,0
      addi $t1,$t2,0
      
      j loop
      
      #INSTRUCCIONES NO BIFURCADOS = 8

		#CONTEO INSTRUCCIONES SOLO LOOP = 13
		
		#CONTEO INSTRUCCIONES DEL LOOP si n = 5, entoces hay 41 instrucciones

fin:  
      la $a0,endl
      li $v0,4
      syscall
      li $v0,10
      syscall
      
      		#CONTEO INSTRUCCIONES SOLO FIN = 6
      		
      		
      		#TOTAL----------------------------------------------------
      		#80 INSTRUCCIONES TOTALES CON n = 5
      		

# SECCION DE VARIABLES EN MEMORIA (.data)
.data
Fiboprt: .asciiz "Ingresar n:"
Fibost1: .asciiz "La serie Fibonacci de "
Fibost2: .asciiz " terminos es: "
coma:    .asciiz ", "
endl:    .asciiz "\n"
