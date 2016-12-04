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
	jal fib
	move $a0, $v0
	li $v0, 1
	syscall
	li $v0, 10
	syscall

fib:
	bgt $a0, 2, fib_recursive
	li $v0, 1
	jr $ra
	
fib_recursive:
	subu $sp, $sp, 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addi $fp, $sp, 8
	sw $a0, ($fp)
	subi $a0, $a0, 1
	jal fib
	
	sw $v0, 4($fp)
	subi $a0, $a0, 1
	
	jal fib
	lw $a0, ($fp)
	lw $v1, 4($fp)
	add $v0, $v1, $v0
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra

	