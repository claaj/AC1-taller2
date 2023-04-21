.data
arr: 12, 255, 200, 150, 50, 33, 133, 100, 17, 15, 33, 188, 0, 10, 12, 40, 201, 7, 9, 10
bub: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
salto: 	 .asciiz "\n"
espacio: .asciiz " "
ordenado: .asciiz "El arreglo ordenado:\n"
original: .asciiz "El arreglo original:\n"

.text
la $s0, arr 		# carga la direccion de la primer posicion de arr en $s0
la $s1, bub 		# carga la direccion de la primer posicion de bub en $s1
li $t0, 0   		# contador en 0
li $t6, 0		# contador en 0

copiar:
lw $t1, 0($s0)		# carga en $t1 la palabra en la direccion $s0.
sw $t1, 0($s1) 		# almaceno la palabra en $t1 en la direccion en $s1.
addi $s0, $s0, 4 	# suma posicion del incial.
addi $s1, $s1, 4 	# suma posicion del bub.
addi  $t0, $t0, 1 	# suma de contador a +1.
bne $t0, 20, copiar	# si $t0 no es 20 salta a copiar. 

li $t6, 0		# contador en 0.

cicloG:
beq $t6, 20, impresion	# contador == 20 -> salta a impresion.
li $t0, 0		# contador = 0.
la $t1, bub		# carga la direccion de bub en $t1.
addi $t2, $t1, 4	# suma + 4 a la direccion de bub de $t2.

cicloP:
beq $t0, 19, contadorG	# contador == 19 -> salta a contadorG.
lw $t3, 0($t1)		# carga en $t3 el valor en la direccion $t1.
lw $t4, 0($t2)		# carga en $t4 el valor en la direccion $t2.
bgt $t4, $t3, cambio	# $t4 > $t3 -> salta a cambio.
j contadorP		# salta a contadorP.

cambio:
sw $t4, 0($t1)		# guarda $t4 en la direccion guardada en $t1.
sw $t3, 0($t2)		# guarda $t3 en la direccion guardada en $t2.
j contadorP

contadorP:
addi $t0, $t0, 1	# suma 1 en contador.
addi $t1, $t1, 4	# suma 4 en la direccion guardada en $t1, "avanza una posicion".
addi $t2, $t2, 4	# suma 4 en la direccion guardada en $t2, "avanza una posicion".
j cicloP		# salta a cicloP.

contadorG:
addi $t6, $t6, 1	# suma 1 en contador.
j cicloG		# salta a cicloG.

impresion: 		# impresiones en consola

li $v0, 4		# indicamos que vamos a imprimir un string
la $a0, original	# indicamos la direccion del string en el registro para imprimir.
syscall			# hacemos el syscall para imprimir el string.

la $t7, arr		# direccion en memoria del arreglo.
li $t0, 0		# contador en 0.
jal printarr		# salta a printarr y guarda la direccion.

li $v0, 4		# indicamos que vamos a imprimir un string.
la $a0, ordenado	# indicamos la direccion del string a imprimir.
syscall			# hacemos el syscall para imprimir el string.

la $t7, bub		# dirreccion de memoria del arreglo.
li $t0, 0		# contador 0.
jal printarr		# salta a printarr y guarda la direccion.
j fin			# salta a fin.

printarr:
li $v0, 1		# indicamos para imprimir en 1.
lw $a0, 0($t7)		# indicamos el primer valor de la direccion para que sea impreso.
syscall			# imprimimos el valor.
li $v0, 4		# indicamos que vamos a imprimir un string
la $a0, espacio		# indicamos que vamos a imprmir un espacio.
syscall			# hacemos el syscall para imprimir.
addi $t7, $t7, 4	# sumamos 4 a la direccion.
addi $t0, $t0, 1	# sumamos uno al contador.
bne $t0, 20, printarr	# si contador no es igual a 20 ir a printarr.
li $v0, 4		# indicar que se quiere imprimir un string.
la $a0, salto		# indicar que se va a imprimir un salto de linea.
syscall			# indicamos que vamos a imprimir un string.
jr $ra			# salta a la direccion guardada en $ra.

fin:
