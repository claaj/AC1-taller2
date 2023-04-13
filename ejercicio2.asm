.data
arr: 12, 255, 200, 150, 50, 33, 133, 100, 17, 15, 33, 188, 0, 10, 12, 40, 201, 7, 9, 10
aux: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
ord: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0


# Falta crear valor auxialiar para no modificar el original

.text
la $s0, arr # carga la direccion de la primer posicion de arr en $s0
la $s1, aux # carga la direccion de la primer posicion de aux en $s1
la $s2, ord # carga la direccion de la primer posicion de ord en $s2
li $t0, 0   # contador en 0
li $t6, 0
copiar:
lw $t1, 0($s0)	# carga  en $t1 la palabra en la direccion $s0
sw $t1, 0($s1) #almaceno la palabra en $t1 en la direccion en $s1
addi $s0, $s0, 4 #suma posicion del incial
addi $s1, $s1, 4 # suma posicion del aux
addi  $t0, $t0, 1 #suma de contador a +1
bne $t0, 20, copiar


ordenador:
li $t0, 0	# contador en 0
la $s1, aux # carga la direccion de la primer posicion de aux en $s1
lw $t2, 0($s1)	# cargamos el primer valor del arreglo.

contador: 
lw $t3, 0($s1)
addi  $t0, $t0, 1
bge $t3, $t2, mayor
j vuelve

mayor: 
move $t2, $t3
move $t4, $s1
j vuelve

vuelve:
addi $s1, $s1, 4 
bne $t0, 20, contador

sw $zero, 0($t4)

sw $t2, 0($s2) 
addi $s2, $s2, 4
addi $t6, $t6, 1
bne $t6, 20, ordenador


