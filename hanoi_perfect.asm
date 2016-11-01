	.data
Move: .asciiz "Move disk "
From: .asciiz " from peg "
To: .asciiz " to peg "
Fin: .asciiz ".\n"
Intro: .asciiz "Introduce el número de discos: "
	.text

Main:
	li $v0, 4
	la $a0, Intro
	syscall
	
	li $v0, 5
	syscall
	
	move $a0, $v0
	
	li $a1, 1
	li $a2, 3
	li $a3, 2
	
	jal Hanoi

Exit:
	li $v0, 10
	syscall

Hanoi:
	bnez $a0, Hanoi_recursive
	jr $ra

Hanoi_recursive:
	subu $sp, $sp, 32
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addi $fp, $sp, 8
	
	sw $a0, 0($fp)
	sw $a1, 4($fp)
	sw $a2, 8($fp)
	sw $a3, 12($fp)
	
	sub $a0, $a0, 1
	
	move $t0, $a3
	move $a3, $a2
	move $a2, $t0
	
	jal Hanoi
	
	la $a0, Move
	li $v0, 4
	syscall
	
	lw $a0, 0($fp)
	li $v0, 1
	syscall
	
	la $a0, To
	li $v0, 4
	syscall
	
	lw $a0, 4($fp)
	li $v0, 1
	syscall
	
	la $a0, From
	li $v0, 4
	syscall
	
	lw $a0, 8($fp)
	li $v0, 1
	syscall
	
	la $a0, Fin
	li $v0, 4
	syscall
	
	lw $a0, 0($fp)
	
	subi $a0, $a0, 1
	
	lw $a1, 12($fp)
	lw $a2, 8($fp)
	lw $a3, 4($fp)
	
	jal Hanoi
	
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	addi $sp, $sp, 32
	
	jr $ra
