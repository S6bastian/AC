## Fibonacci.asm

# SECCION DE INSTRUCCIONES (.text)
.text
.globl __start

__start:
la $a0, Fiboprt		#2 ciclos
li $v0, 4		#1 ciclos 
syscall			#1
li $v0, 5		#1
syscall
addi $t8,$v0,0         # valor de teclado en $t8
li $t0,0
li $t1,1

la $a0,Fibost1		#2
li $v0,4
syscall               # "La serie Fibonacci de "
addi $a0,$t8,0
li $v0,1
syscall               # n
la $a0,Fibost2		#2
li $v0,4 
syscall               # " terminos es: "
li $a0,1
li $v0,1
syscall               # 1, ...
la $a0,coma		#2
li $v0,4
syscall

      li   $t4,2
      
      beq  $t8,$0,fin	#TIPO 2		Acierta que no se cumple ya que n = 5
      #li   $t4,2 	reordenado
      
      
      # 1 retraso
      bltz $t8,fin	#TIPO 2		Acierta que no se cumple ya que n = 5
      # 1 retraso
      
      #32 ciclos HASTA AQUI
loop: add  $t2,$t0,$t1 	#TIPO 1
      addi $a0,$t2,0  	
      li $v0,1
      syscall
      beq $t4,$t8,fin	#TIPO 2		Acierta 3 veces que no se cumple, falla 1
      #1 retraso
      
      #6 ciclos medio loop (salida a fin)
      
      # si n=5 son 4 retrasos
      la $a0,coma	#2
      li $v0,4
      syscall
      addi $t4,$t4,1	#TIPO 1
      addi $t0,$t1,0	
      addi $t1,$t2,0
      
      j loop
	#14 ciclos loop completo
	
fin:  
      la $a0,endl	#2
      li $v0,4
      syscall
      li $v0,10
      syscall 		#2 ciclos por ser el último
	
	#7 ciclos fin
	
	#d) 84 ciclos apostando a que no se cumple

# SECCION DE VARIABLES EN MEMORIA (.data)
.data
Fiboprt: .asciiz "Ingresar n:"
Fibost1: .asciiz "La serie Fibonacci de "
Fibost2: .asciiz " terminos es: "
coma:    .asciiz ", "
endl:    .asciiz "\n"
