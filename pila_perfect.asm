	.data
Space: .asciiz "\n"
	.text

Main:

	li $v0, 5
	syscall
	
	beqz $v0, Exit
	
	move $a0, $v0
	move $a1, $zero
	
	jal Create
	
loop:	
	move $s0, $v0
	
	li $v0, 5
	syscall
	
	move $a0, $s0
	
	beqz $v0, Print_Time
	
	move $a1, $v0
	
	jal Push
	
	b loop
	
Print_Time:
	jal Print

Exit:
	li $v0, 10
	syscall

Create:
	move $t0, $a0
	
	li $v0, 9
	la $a0, 8
	syscall
	
	beqz $v0, Exit

	sw $t0, 0($v0)
	sw $a1, 4($v0)
	
	jr $ra

Push:

	subu $sp, $sp, 32
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addi $fp, $sp, 8
	
	move $t0, $a0
	
	move $a0, $a1
	move $a1, $t0
	
	jal Create
		
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	addi $sp, $sp, 32
	
	jr $ra
	
Print:
	bnez $a0, Print_recursive
	jr $ra
	
Print_recursive: 

	subu $sp, $sp, 32
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addi $fp, $sp, 8
	
	sw $a0, 0($fp)
	
	lw $a0, 4($a0)
	
	jal Print
	
	lw $t0, 0($fp)
	lw $a0, 0($t0)
	li $v0, 1
	syscall
	
	la $a0, Space
	li $v0, 4
	syscall
	
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	addi $sp, $sp, 32
	
	jr $ra
	
	
