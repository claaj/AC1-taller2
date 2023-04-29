.data
	arr: 12, 255, 200, 150, 50, 33, 133, 100, 17, 15, 33, 188, 0, 10, 12, 40, 201, 7, 9, 10
	aux: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	ord: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	salto: 	 .asciiz "\n"
	espacio: .asciiz " "
	ordenado: .asciiz "El arreglo ordenado:\n"
	original: .asciiz "El arreglo original:\n"

.text
main:
	la $s0, arr 		# Carga la direccion de la primer posicion de arr en $s0.
	la $s1, aux 		# Carga la direccion de la primer posicion de aux en $s1.
	la $s2, ord 		# Carga la direccion de la primer posicion de ord en $s2.
	li $t0, 0   		# Contador en 0.
	li $t6, 0		# Contador en 0.
	
	jal copiar		# Salta a copiar y guarda la direccion en $ra.
	
	la $t0, ord		# Guarda en $t0 la direccion de ord.
	li $t5, 0		# Carga un 0 en $t5.
ciclo:
	beq $t5, 20, finCiclo	# Si $t5 == 20, salta a finCiclo.
	jal mayorArr		# Salta al mayorArr y guarda la direccion en $ra.
	sw $t2, 0($t0)		# Guarda el valor de $t2 en la direccion $t0.
	addi $t5, $t5, 1	# $t5 = $t5 + 1.
	addi $t0, $t0, 4	# Avanza una posicion en el arreglo.
	j ciclo			# Salta al ciclo.
	
finCiclo:
	jal impresion		# Salta a impresion y guarda el retorno.
	j fin			# Salta a fin.

copiar:
	lw $t1, 0($s0)		# Carga en $t1 la palabra en la direccion $s0.
	sw $t1, 0($s1) 		# Almaceno la palabra en $t1 en la direccion en $s1.
	addi $s0, $s0, 4 	# Suma posicion del incial.
	addi $s1, $s1, 4 	# Suma posicion del aux.
	addi  $t0, $t0, 1 	# Suma de contador a +1.
	bne $t0, 20, copiar	# Si $t0 no es 20 salta a copiar.
	jr $ra			# Salta a la direccion en $ra.

mayorArr:
	li $t4, 0		# Contador en 0.
	la $t1, aux		# Carga en $t1 la direccion de aux.
	move $t7, $t1		# Carga la direccion de la primer posicion de aux en $s1.
	lw $t2, 0($t1)		# Cargamos el primer valor del arreglo.
cicloMayor:
	lw $t3, 0($t1)		# Carga en $t3 el valor en la direccion en $t1.
	bgt $t3, $t2, mayor	# Si el valor de arr[contador] es mayor al maximo ir a la etiqueta mayor.
	j vuelve		# Ir a la etiqueta vuelve.
mayor:
	move $t2, $t3		# Poner el valor del numero mayor en $t2.
	move $t7, $t1		# Pone el valor de $t1 en $t7. 
	j vuelve		# Saltar a la etiqueta vuelve.
vuelve:
	addi $t1, $t1, 4	# Sumar 4 a la direccion para la proxima vez leer el valor siguiente.
	addi  $t4, $t4, 1	# Sumar 1 al contador.
	bne $t4, 20, cicloMayor	# Si el contador es distinto a 19 salta a la etiqueta ciclo.
	sw $zero, 0($t7)	# Pone en 0 el valor alojado en la direccion dentro $t7. 
	jr $ra			# Salta a la direccion en $ra.
		
	
impresion:
	subi $sp, $sp, 4	# Se "retrocede" el stack pointer para almacenar un valor 4 bytes.
	sw $ra, 0($sp)		# Guarda en el stack la direccion de memoria.
	la $a0, original	# Indicamos la direccion del string en el registro para imprimir.
	jal printStr		# Salta a printStr y guarda la direccion $ra.

	la $t6, arr		# Direccion en memoria del arreglo.
	jal printArr		# Salta a printArr y guarda la direccion.

	la $a0, salto		# Carga el string para imprimir.
	jal printStr		# Salta a printStr y guarda la direccion.

	la $a0, ordenado	# Indicamos la direccion del string a imprimir.
	jal printStr		# Salta a printStr y guarda la direccion.

	la $t6, ord		# Dirreccion de memoria del arreglo.
	jal printArr		# Salta a printarr y guarda la direccion.

	lw $ra, 0($sp)		# Cargar en $ra la direccion guarda para volver.
	addi, $sp, $sp 4	# Avanzar el stack pointer las posiciones antes retrocedidas.
	jr $ra			# Salta a fin.

printArr:
	li $t0, 0		# Contador en 0.
	subi $sp, $sp, 4	# "Retroceder" 4 posiciones para almacenar 4 bytes.
	sw $ra, 0($sp)		# Guardar en el stack la direccion de retorno.
cicloPrint:
	lw $a0, 0($t6)		# Indicamos el primer valor de la direccion para que sea impreso.
	jal printNum
	la $a0, espacio		# Indicamos que vamos a imprmir un espacio.
	jal printStr
	addi $t6, $t6, 4	# Sumamos 4 a la direccion.
	addi $t0, $t0, 1	# Sumamos uno al contador.
	bne $t0, 20, cicloPrint	# Si contador no es igual a 20 ir a printarr.
	lw $ra, 0($sp)		# Guardar la en $ra la direccion.
	addi $sp, $sp 4		# Avanzar el stack pointer antes retrocedidos. 
	jr $ra			# Salta a la direccion en $ra.

printStr:
	li $v0, 4		# Indicamos que se va a imprimir un String.
	syscall			# Se realiza el syscall.
	jr $ra			# Se salta a la direccion en $ra.

printNum:
	li $v0, 1		# Indicamos que se imprime un numero.
	syscall			# Se realiza el syscall.
	jr $ra			# Salta a la direccion guardada en $ra.

fin: