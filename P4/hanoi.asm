.data
	Intro: .asciiz "Introduce un numero de discos(1-8): "
	Move: .asciiz "Move disk "
	From: .asciiz " From peg "
	To: .asciiz " To peg "
	New_Line: .asciiz "\n"
.text

main:
	la $a0, Intro
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $a0, $v0
	li $a1, 1
	li $a2, 2
	li $a3, 3
	jal hanoi
	li $v0, 10
	syscall

hanoi:
	bnez $a0, hanoi_recursive
	jr $ra

hanoi_recursive:
	subu $sp, $sp, 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addi $fp, $sp, 8
	sw $a0, ($fp)
	sw $a1, 4($fp)
	sw $a2, 8($fp)
	sw $a3, 12($fp)
	
	subi $a0, $a0, 1
	lw $a2, 12($fp)
	lw $a3, 8($fp)
	jal hanoi
	
	la $a0, Move 
	li $v0, 4
	syscall
	lw $a0, ($fp)
	li $v0, 1
	syscall
	
	la $a0, From
	li $v0, 4
	syscall
	lw $a0, 4($fp)
	li $v0, 1
	syscall
	
	la $a0, To
	li $v0, 4
	syscall
	lw $a0, 8($fp)
	li $v0, 1
	syscall
	
	la $a0, New_Line
	li $v0, 4
	syscall
	
	lw $a0, ($fp)
	subi $a0, $a0, 1
	lw $a1, 12($fp)
	lw $a2, 8($fp)
	lw $a3, 4($fp)
	jal hanoi
	
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra
	
	
	