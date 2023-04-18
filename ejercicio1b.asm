.data
arr: 12, 255, 200, 150, 50, 33, 133, 100, 17, 15, 33, 188, 0, 10, 12, 40, 201, 7, 9, 10
aux: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
ord: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
salto: 	 .asciiz "\n"
espacio: .asciiz " "
ordenado: .asciiz "El arreglo ordenado:\n"
original: .asciiz "El arreglo original:\n"

.text
la $s0, arr 		# carga la direccion de la primer posicion de arr en $s0
la $s1, aux 		# carga la direccion de la primer posicion de aux en $s1
la $s2, ord 		# carga la direccion de la primer posicion de ord en $s2
li $t0, 0   		# contador en 0
li $t6, 0		# contador en 0

copiar:
lw $t1, 0($s0)		# carga en $t1 la palabra en la direccion $s0
sw $t1, 0($s1) 		# almaceno la palabra en $t1 en la direccion en $s1
addi $s0, $s0, 4 	# suma posicion del incial
addi $s1, $s1, 4 	# suma posicion del aux
addi  $t0, $t0, 1 	# suma de contador a +1
bne $t0, 20, copiar	# si $t0 no es 20 salta a copiar 


ordenador:
li $t0, 0		# contador en 0
la $s1, aux 		# carga la direccion de la primer posicion de aux en $s1
lw $t2, 0($s1)		# cargamos el primer valor del arreglo.

ciclo: 
lw $t3, 0($s1)		# carga el primer de auxiliar en $t3
addi  $t0, $t0, 1	# sumamos 1 a contador.
bge $t3, $t2, mayor	# si el $t3 es mayor que $t2 salta a mayor.
j vuelve		# salta a vuelve.

mayor: 
move $t2, $t3		# mueve el contenido de del valor de aux a $t2.
move $t4, $s1		# mueve la dirrecion de la posicion de aux a $t4. 
j vuelve		# salta a vuelve.

vuelve:
addi $s1, $s1, 4 	# suma 4 a la direccion de aux "avanza una posicion"
bne $t0, 20, ciclo	# si contador != 20, salta a ciclo.

sw $zero, 0($t4)	# ponemos en 0 el valor en aux.
sw $t2, 0($s2)		# guarda el valor del arreglo en el arreglo ordenado.
 
addi $s2, $s2, 4	# "avanza una posicion" en el arreglo ordenado.
addi $t6, $t6, 1	# suma uno en el contador.
bne $t6, 20, ordenador	# si el contador != salta a ordenador.

# impresiones en consola

li $v0, 4		# indicamos que vamos a imprimir un string
la $a0, original	# indicamos la direccion del string en el registro para imprimir.
syscall			# hacemos el syscall para imprimir el string.

la $t6, arr		# direccion en memoria del arreglo.
li $t0, 0		# contador en 0.
jal printarr		# salta a printarr y guarda la direccion.

li $v0, 4		# indicamos que vamos a imprimir un string.
la $a0, ordenado	# indicamos la direccion del string a imprimir.
syscall			# hacemos el syscall para imprimir el string.

la $t6, ord		# dirreccion de memoria del arreglo.
li $t0, 0		# contador 0.
jal printarr		# salta a printarr y guarda la direccion.
j fin			# salta a fin.

printarr:
li $v0, 1		# indicamos para imprimir en 1.
lw $a0, 0($t6)		# indicamos el primer valor de la direccion para que sea impreso.
syscall			# imprimimos el valor.
li $v0, 4		# indicamos que vamos a imprimir un string
la $a0, espacio		# indicamos que vamos a imprmir un espacio.
syscall			# hacemos el syscall para imprimir.
addi $t6, $t6, 4	# sumamos 4 a la direccion.
addi $t0, $t0, 1	# sumamos uno al contador.
bne $t0, 20, printarr	# si contador no es igual a 20 ir a printarr.
li $v0, 4		# indicar que se quiere imprimir un string.
la $a0, salto		# indicar que se va a imprimir un salto de linea.
syscall			# indicamos que vamos a imprimir un string.
jr $ra			# salta a la direccion guardada en $ra.

fin: