.data
	Intro: .asciiz "Introduce un numero: "
.text

main:
	la $a0, Intro
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $a0, $v0
	jal fact
	move $a0, $v0
	li $v0, 1
	syscall
	li $v0, 10
	syscall

fact:
	bge $a0, 2 fact_recursive
	li $v0, 1
	jr $ra

fact_recursive:
	subu $sp, $sp, 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addi $fp, $sp, 8
	sw $a0, ($fp)
	subi $a0, $a0, 1
	
	jal fact
	
	lw $a0, ($fp)
	mul $v0, $a0, $v0
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra
	