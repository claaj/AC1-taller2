.data
	numero: .word 5
	imp:	.asciiz "Factorial de "
	dosP:	.asciiz ": "

.text
main:
	lw $s0, numero			# Cargamos el numero desde la memoria en el registro $s0.

	la $a0, imp			# Cargamos la direccion del string en el registro especial para imprmirlo.
	jal printStr			# Saltamos a la etiqueta printStr, se guarda la direccion actual en $ra.

	move $a0, $s0			# Copiamos el valor de $s0 a $a0.
	jal printNum			# Saltamos a la etiqueta printNum, se guarda la direccion actual en $ra.

	la $a0, dosP			# Cargamos la direccion del string en el registro especial para imprmirlo.
	jal printStr			# Saltamos a la etiqueta printStr, se guarda la direccion actual en $ra.

	jal fact			# Saltamos a la etiqueta fact, se guarda la direccion actual en $ra.
	move $a0, $t0			# Copiamos el valor de $t0 a $a0.
	jal printNum			# Saltamos a la etiqueta printNum, se guarda la direccion actual en $ra.
	j fin				# Saltamos a la etiqueta fin
  
fact:
	subi $sp, $sp, 8		# Se "retrocede" el stack pointer para almacenar en el stack dos valores de 4 bytes.
	sw $ra, 4($sp)			# Guardamos en el stack el contenido de $ra en desde el bit 4 en adelante.
	sw $s0, 0($sp)			# Guardamos en el stack el contenido de $s0 en desde el bit 0 en adelante.
	bge $s0, 1, calcular		# Si $s0 >= 1, salta a calcular.
	addi $t0, $zero, 1		# Se pone $t0 en 1.
	j retorno			# Salta a la etiqueta retorno.

calcular: 
	subi $s0, $s0, 1		# $s0 = $s0 - 1.
	jal fact			# Salta a fact y guarda el valor en $ra.
# Cuando se llega a este punto todos los valores entre 0 (inclusive) hasta el numero (inclusive)
# y las direcciones de donde se salto a fact estan guardados en memoria.
# Los valores guardados van de 0 hasta el numero, hasta el numero, pero este no se puede modificar, porque restaura
# el valor original,  por lo tanto se tiene que sumar 1 para que vaya desde uno hasta el numero.
	addi $t1, $s0, 1		# Sumamos uno al valor en $t1.
	mult $t1, $t0			# Multiplicacion entre $t1 y $t0.
	mflo $t0			# Se guarda el resultado $t0.

retorno:
	lw $ra, 4($sp)			# Cargamos la direccion que anteriormente fue guardada en memoria.
	lw $s0, 0($sp)			# Cargamos el valor que fue guardado anteriormente en memoria. 
	addi, $sp, $sp, 8		# "Avanzamos" el stack pointer para que "apunte" a los valores otros valores guardados.
	jr $ra				# Salta a la direccion guardada en $ra.

printStr:
	li $v0, 4			# Indicamos que se va a imprimir un String.
	syscall				# Se realiza el syscall.
	jr $ra				# Se salta a la direccion en $ra.

printNum:
	li $v0, 1			# Indicamos que se imprime un numero.
	syscall				# Se realiza el syscall.
	jr $ra				# Salta a la direccion guardada en $ra.

fin: