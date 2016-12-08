.data
	Intro: .asciiz "Introduce un numero: "
	Delete: .asciiz "Elimina un numero de la pila: "
	Resultado: .asciiz "El numero eliminado es: "
	New_Line: .asciiz "\n"
.text

main:
	move $s0, $zero

loop_main:
	la $a0, Intro
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	beqz $v0, exit
	move $a0, $s0
	move $a1, $v0
	jal insert
	move $s0, $v0
	b loop_main

exit:
	la $a0, Delete
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $a0, $s0
	move $a1, $v0
	jal remove
	move $s1, $v0
	la $a0, Resultado
	li $v0, 4
	syscall
	move $a0, $s1
	li $v0, 1
	syscall
	la $a0, New_Line
	li $v0, 4
	syscall
	move $a0, $s0
	jal print
	li $v0, 10
	syscall

create:
	move $t0, $a0
	li $v0, 9
	li $a0, 8
	syscall

	sw $t0, ($v0)
	sw $a1, 4($v0)
	jr $ra

insert:
	subu $sp, $sp, 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addi $fp, $sp, 8
	sw $a0, ($fp)
	sw $a1, 4($fp)

	lw $a0, 4($fp)
	lw $a1, ($fp)
	jal create
	move $s0, $v0
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra

remove:
	li $t0, 0
	move $t1, $a0
	lw $t2, 4($a0)
loop_remove:
	lw $t3, ($t1)
	beq $t3, $a1, find
	move $t0, $t1
	lw $t1, 4($t1)
	lw $t2, 4($t2)
	bnez $t1, loop_remove
	li $v0, 0
	jr $ra

find:
	sw $t2, 4($t0)
	move $v0, $a1
	jr $ra

print:
	bnez $a0, print_recursive
	jr $ra


print_recursive:
	subu $sp, $sp, 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addi $fp, $sp, 8
	sw $a0, ($fp)

	lw $a0, 4($a0)

	jal print

	lw $a0, ($fp)
	lw $a0, ($a0)
	li $v0, 1
	syscall

	la $a0, New_Line
	li $v0, 4
	syscall

	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra
