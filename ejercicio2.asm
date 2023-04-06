.data
arr: 12, 255, 200, 150, 50, 33, 133, 100, 17, 15, 33, 188, 0, 10, 12, 40, 201, 7, 9, 10
ord: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

# Falta crear valor auxialiar para no modificar el original

.text
la $t5, ord
li $t6, 0
ciclo:
li $t0, 0	# contador en 0
la $t1, arr	# direccion del arreglo
lw $t2, 0($t1)	# cargamos el primer valor del arreglo.

contador: 
lw $t3, 0($t1)
addi  $t0, $t0, 1
bgt $t3, $t2, mayor
j vuelve

mayor: 
move $t2, $t3
move $t4, $t1
j vuelve

vuelve:
addi $t1, $t1, 4 
bne $t0, 20, contador

sw $zero, 0($t4)

sw $t2, 0($t5) 
addi $t5, $t5, 4
addi $t6, $t6, 1
bne $t6, 20, ciclo



