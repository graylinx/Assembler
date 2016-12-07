.data
	Intro: .asciiz "Introducimos un numero: "
	New_Line: .asciiz "\n"
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
	la $a0, Intro
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $a0, $v0
	jal fibiteras
	move $a0, $v0
	li $v0, 1
	syscall
	li $v0, 10 
	syscall

fibiteras:
	move $t0, $a0
	li $t1, 0
	li $t2, 1
loop:
	add $t3, $t1, $t2
	move $t4, $t2
	move $t2, $t1
	move $t1, $t4
	subi $t0, $t0, 1
	bnez $t0, loop 
	move $v0, $t1
	
	

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
	
	lw $a0, ($fp)
	sw $v0, 4($fp)
	
	subi $a0, $a0, 2
	
	jal fib
	
	lw $v1, 4($fp)
	
	add $v0, $v1, $v0
	

	
	
	
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra
	