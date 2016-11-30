.data

	IntroA: .asciiz "Introduce un numero A: "
	IntroB: .asciiz "Introduce un numero B: "
	Array: .word

.text

main:
	la $a0, IntroA
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s0, $v0
	
	la $a0 IntroB
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s1, $v0
	
	move $a0, $s0
	move $a1, $s1
	jal multiplos
	move $a0, $v0
	move $a1, $v1
	jal print
	li $v0, 10
	syscall

multiplos:
	beqz $a1, return
	li $t0, 1
	la $t1, Array
	mul $t2, $a0, $a1
loop:
	mul $t3, $t0, $a0
	sw $t3, ($t1)
	addi $t0, $t0, 1
	addi $t1, $t1, 4
	blt $t3, $t2, loop
return:
	la $v0, Array
	subi $t0, $t0, 1
	move $v1, $t0
	jr $ra

print:
	bnez $a1, print_recursive
	jr $ra

print_recursive:
	subu $sp, $sp, 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addi $fp, $sp, 8
	sw $a0, ($fp)
	sw $a1, 4($fp)
	addi $t0, $t0, 1
	add $a0, $a0, 4
	subi $a1, $a1, 1
	jal print
	
	
	
	lw $a0, ($fp)
	lw $a0, ($a0)
	li $v0, 1
	syscall
	
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra
	
	

