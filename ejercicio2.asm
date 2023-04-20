.data
numero: .word 5
imp:	.asciiz "Factorial: "

.text
li $v0, 4
la $a0, imp
syscall

lw $s0, numero
jal fact

li $v0, 1
move $a0, $t0
syscall
j fin
  
fact:
subi $sp, $sp, 8
sw $ra, 4($sp)
sw $s0, 0($sp)
bge $s0, 1, calcular
addi $t0, $zero, 1
j retorno

calcular: 
subi $s0, $s0, 1
jal fact
addi $t1, $s0, 1
mult $t1, $t0
mflo $t0

retorno:
lw $ra, 4($sp)
lw $s0, 0($sp)
addi, $sp, $sp, 8
jr $ra

fin:
