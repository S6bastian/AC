## Fibonacci.asm

# SECCION DE INSTRUCCIONES (.text)
.text
.globl __start

#USANDO MULTICICLO LOS CICLOS QUE VALEN 3 PASAN A VALER 2

__start:
la $a0, Fiboprt		#4+4 = 8
li $v0, 4		#4
syscall			#3
li $v0, 5		#4
syscall			#3
addi $t8,$v0,0         	#4
li $t0,0		#4
li $t1,1		#4

la $a0,Fibost1		#4+4=8
li $v0,4		#4
syscall               	#3
addi $a0,$t8,0		#4
li $v0,1		#4
syscall               	#3
la $a0,Fibost2		#8
li $v0,4 		#4
syscall              	#3
li $a0,1		#4
li $v0,1		#4
syscall               	#3
la $a0,coma		#8
li $v0,4		#4
syscall			#3
      li   $t4,2	#4
      beq  $t8,$0,fin	#3
      bltz $t8,fin	#3
      
      			#CONTEO CICLOS = 111
      			#CONTEO INSTRUCCIONES = 30
      			#CONTEO DE CICLOS USANDO ALU = 102
      
loop: add  $t2,$t0,$t1  #4
      addi $a0,$t2,0  	#4
      li $v0,1		#4
      syscall		#3
      beq $t4,$t8,fin	#3
      
      #CICLOS ANTES DE BIFURCACI�N = 18
      #INSTRUCIONES ANTES DE BIFURCACI�N = 5
      #CICLOS CON ALU ANTES DE BIFURCACI�N = 16
            
      #HASTA AQUI LLEGA EL LOOP SI n = 2
      
      la $a0,coma	#8
      li $v0,4		#4
      syscall		#3
      addi $t4,$t4,1	#4
      addi $t0,$t1,0	#4
      addi $t1,$t2,0	#4
      
      j loop 		#3
      
      #CICLOS NO BIFURCADOS = 30
      #INSTRUCCIONES NO BIFURCADOS = 8
      #CICLOS ALU NO BIFURCADOS = 28
			
			
			
			#CONTEO CICLOS SOLO LOOP = 48
			#CONTEO INSTRUCCIONES SOLO LOOP = 13
			#CONTEO CICLOS ALU SOLO LOOP = 44
			
			
			#CONTEO CICLOS DEL LOOP si n = 5, entoces hay 162 ciclos
			#CONTEO INSTRUCCIONES DEL LOOP si n = 5, entoces hay 41 instrucciones
			#CONTEO CICLOS ALU DEL LOOP si n = 5, entoces hay 148 ciclos
			
fin:  
      la $a0,endl	#8
      li $v0,4		#4
      syscall		#3
      li $v0,10		#4
      syscall		#3

			#CONTEO CICLOS SOLO FIN = 22
			#CONTEO INSTRUCCIONES SOLO FIN = 6
			#CONTEO CICLOS ALU SOLO FIN = 20
			
			
			
			#TOTALES----------------------------------------------------
			
			#295 CICLOS TOTALES CON n = 5
			#80 INSTRUCCIONES TOTALES CON n = 5
			#270 CICLOS ALU TOTALES CON n = 5

# SECCION DE VARIABLES EN MEMORIA (.data)
.data
Fiboprt: .asciiz "Ingresar n:"
Fibost1: .asciiz "La serie Fibonacci de "
Fibost2: .asciiz " terminos es: "
coma:    .asciiz ", "
endl:    .asciiz "\n"
