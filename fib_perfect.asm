	.data

	.text

main:
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
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addi $fp, $sp, 8
	
	sw $a0, 0($fp)
	
	subu $a0, $a0, 1
	
	jal fib
	
	lw $a0, 0($fp)
	sw $v0, 4($fp)
	
	subu $a0, $a0, 2
	
	jal fib
	
	lw $v1, 4($fp)
	add $v0, $v0, $v1
	
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	addi $sp, $sp, 32
	jr $ra
