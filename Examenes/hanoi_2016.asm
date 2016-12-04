.data
Move: .asciiz "Mover disco: "
Desde: .asciiz " Desde la torre: "
A: .asciiz " A la torre: "
New_line: .asciiz ".\n"
Intro: .asciiz "Introduce el numero de discos: "
	.text
main:
	la $a0, Intro
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	
	move $a0, $v0
	#Torre en la que empieza
	li $a1, 1
	#Torre en la que acaba
	li $a2, 2
	#Torre extra
	li $a3, 3
	
	jal hanoi
	li $v0, 10
	syscall

hanoi:
	bnez $a0, hanoi_recur
	jr $ra
	
hanoi_recur:
	subu $sp, $sp, 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addi $fp, $sp, 28
	sw $a0, ($fp)
	sw $a1, -4($fp)
	sw $a2, -8($fp)
	sw $a3, -12($fp)
	
	subi $a0, $a0, 1
	lw $a2, -12($fp)
	lw $a3, -8($fp)
	jal hanoi
	la $a0, Move
	li $v0, 4
	syscall
	lw $a0, ($fp)
	li $v0, 1
	syscall
	la $a0, Desde
	li $v0, 4
	syscall
	lw $a0, -4($fp)
	li $v0, 1
	syscall
	la $a0, A
	li $v0, 4
	syscall
	lw $a0, -8($fp)
	li $v0, 1
	syscall
	la $a0, New_line
	li $v0, 4
	syscall
	
	lw $a0, ($fp)
	lw $a1, -12($fp)
	lw $a2, -8($fp)
	lw $a3, -4($fp)
	subi $a0, $a0, 1
	jal hanoi
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra
	 
	
	
	
	
	
	
	
	
	
