.data
arr: 12, 255, 200, 150, 50, 33, 133, 100, 17, 15, 33, 188, 0, 10, 12, 40, 201, 7, 9, 10
strmax:  .asciiz "El maximo es: "
strarr:  .asciiz "Del arreglo:\n"
salto: 	 .asciiz "\n"
espacio: .asciiz " "

.text
li $t0, 0		# contador en 0.
la $t1, arr        	# direccion del arreglo.
subi $t7, $t1, 4
lw $t2, 0($t1)        	# cargamos el primer valor del arreglo.

ciclo: 
lw $t3, 0($t1)		# cargar el valor 0 de la direccion del arreglo.
addi $t1, $t1, 4	# sumar 4 a la direccion para la proxima vez leer el valor siguiente.
addi  $t0, $t0, 1	# sumar 1 al contador.
bgt $t3, $t2, mayor	# si el valor de arr[contador] es mayor al maximo ir a la etiqueta mayor.
j vuelve		# ir a la etiqueta vuelve.

mayor:
move $t2, $t3		# poner el valor del numero mayor en t2.
j vuelve		# saltar a la etiqueta vuelve.

vuelve:
bne $t0, 19, ciclo	# si el contador es distinto a 19 salta a la etiqueta ciclo.

sw $t2, 0($t7)		# guardamos el maximo en la direccion anterior al primer elemento.

# impresiones en consola

li $v0, 4		# indicamos que vamos a imprimir un string
la $a0, strarr		# indicamos la direccion del string en el registro para imprimir.
syscall			# hacemos el syscall para imprimir el string.

la $t6, arr		# direccion en memoria del arreglo.
li $t0, 0		# contador en 0.

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
syscall			# indicamos que vamos a imprimir un string

la $a0, strmax		# indicamos la direccion del string en el registro para imprimir
syscall			# hacemos el syscall para imprimir el string. 

li $v0, 1		# indicamos que vamos a imprimir un entero.
addi $a0, $t2, 0	# ponemos en el registro el valor que se quiere imprimir, este caso el maximo($t2)
syscall			# hacemos el syscall para imprimir el entero.