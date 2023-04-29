.data
	arr: 12, 255, 200, 150, 50, 33, 133, 100, 17, 15, 33, 188, 0, 10, 12, 40, 201, 7, 9, 10
	bub: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	salto: 	 .asciiz "\n"
	espacio: .asciiz " "
	ordenado: .asciiz "El arreglo ordenado:\n"
	original: .asciiz "El arreglo original:\n"

.text
main:
	la $s0, arr 		# Carga la direccion de la primer posicion de arr en $s0.
	la $s1, bub 		# Carga la direccion de la primer posicion de bub en $s1.
	li $t0, 0   		# Contador en 0.
	li $t6, 0		# Contador en 0.

copiar:
	lw $t1, 0($s0)		# Carga en $t1 la palabra en la direccion $s0.
	sw $t1, 0($s1) 		# Almaceno la palabra en $t1 en la direccion en $s1.
	addi $s0, $s0, 4 	# Suma posicion del incial.
	addi $s1, $s1, 4 	# Suma posicion del bub.
	addi  $t0, $t0, 1 	# Suma de contador a +1.
	bne $t0, 20, copiar	# Si $t0 no es 20 salta a copiar. 

	li $t6, 0		# Contador en 0.

cicloG:
	beq $t6, 20, finCiclo	# Contador == 20 -> salta a impresion.
	li $t0, 0		# Contador = 0.
	la $t1, bub		# Carga la direccion de bub en $t1.
	addi $t2, $t1, 4	# Suma + 4 a la direccion de bub de $t2.

cicloP:
	beq $t0, 19, contadorG	# Contador == 19 -> salta a contadorG.
	lw $t3, 0($t1)		# Carga en $t3 el valor en la direccion $t1.
	lw $t4, 0($t2)		# Carga en $t4 el valor en la direccion $t2.
	bgt $t4, $t3, cambio	# $t4 > $t3 -> salta a cambio.
	j contadorP		# Salta a contadorP.

cambio:
	sw $t4, 0($t1)		# Guarda $t4 en la direccion guardada en $t1.
	sw $t3, 0($t2)		# Guarda $t3 en la direccion guardada en $t2.
	j contadorP		# Salta a contadorP.

contadorP:
	addi $t0, $t0, 1	# Suma 1 en contador.
	addi $t1, $t1, 4	# Suma 4 en la direccion guardada en $t1, "avanza una posicion".
	addi $t2, $t2, 4	# Suma 4 en la direccion guardada en $t2, "avanza una posicion".
	j cicloP		# Salta a cicloP.

contadorG:
	addi $t6, $t6, 1	# Suma 1 en contador.
	j cicloG		# Salta a cicloG.

finCiclo:

impresion: 			# Impresiones en consola
	la $a0, original	# Indicamos la direccion del string en el registro para imprimir.
	jal printStr		# Salta a printStr y guarda la direccion en $ra.

	la $t6, arr		# Direccion en memoria del arreglo.
	jal printArr		# Salta a printarr y guarda la direccion.
	
	la $a0, salto		# Indicamos la direccion del string en el registro para imprimir.
	jal printStr		# Salta a printStr y guarda la direccion en $ra.

	la $a0, ordenado	# Indicamos la direccion del string a imprimir.
	jal printStr		# Salta a printStr y guarda la direccion en $ra.

	la $t6, bub		# Dirreccion de memoria del arreglo.
	jal printArr		# Salta a printarr y guarda la direccion.
	j fin			# Salta a fin.

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