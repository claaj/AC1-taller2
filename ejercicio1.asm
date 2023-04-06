.data
arr: 12, 255, 200, 150, 50, 33, 133, 100, 17, 15, 33, 188, 0, 10, 12, 40, 201, 7, 9, 10

.text
li $t0, 0	# contador en 0
la $t1, arr	# direccion del arreglo
lw $t2, 0($t1)	# cargamos el primer valor del arreglo.

contador: 
lw $t3, 0($t1)
addi $t1, $t1, 4
addi  $t0, $t0, 1
bgt $t3, $t2, mayor
j vuelve

mayor:
move $t2, $t3
j vuelve

vuelve:
bne $t0, 19, contador
