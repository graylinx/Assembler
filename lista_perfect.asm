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
	
	move $s0, $v0
	move $s1, $v0
	
loop:
	li $v0, 5
	syscall
	
	move $a0, $s0
	beqz $v0, Print
	
	move $a0, $s1
	move $a1, $v0
	
	jal Insert
	
	move $s1, $v0
	
	b loop

Create:
	move $t0, $a0
	
	li $v0, 9
	la $a0, 8
	syscall
	
	beqz $v0, Exit

	sw $t0, 0($v0)
	sw $a1, 4($v0)
	
	jr $ra

Insert:
	subu $sp, $sp, 32
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addi $fp, $sp, 8
	
	sw $a0, 0($fp)
	
	move $a0, $a1
	move $a1, $zero
	
	jal Create
	
	lw $a0, 0($fp)
	
	sw $v0, 4($a0)	
	
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	addi $sp, $sp, 32
	
	jr $ra
	
Print:
	move $t0, $a0
	lw $a0, 0($t0)
	li $v0, 1
	syscall
	
	lw $t0, 4($t0)
	beqz $t0, Exit
	
	la $a0, Space
	li $v0, 4
	syscall
	
	move $a0, $t0
	
	b Print
Exit:
	li $v0, 10
	syscall
	
	
