#$s0, first node
#$s1 last node
main:
	li $v0, 5
	syscall
	move $a0, $v0
	move $a1, $zero
	jal create
	move $s0, $v0
	move $s1, $v0
loop:
	li $v0, 5 
	syscall 
	beqz $v0, end_loop
	move $a0, $s1
	move $a1, $v0
	jal insert
	move $s1, $v0
	b loop
	
end_loop:
	move $a0, $s0
	jal print
	li $v0, 10
	syscall

print:
	lw $t0, 4($a0)
	bnez $t0, print_recur
	lw $a0, ($a0)
	li $v0, 1
	syscall
	jr $ra

print_recur:
	subu $sp, $sp, 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addiu $fp, $sp, 28
	sw $a0, ($fp)
	lw $a0, ($a0)
	li $v0, 1
	syscall
	lw $a0, ($fp)
	addiu $a0, $a0, 8
	lw $fp ($sp)
	lw $ra 4($sp)
	addiu $sp, $sp, 32
	b print

	
		
insert:
	subu $sp, $sp, 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addiu $fp, $sp, 28
	sw $a0, ($fp)
	sw $a1, -4($fp)
	
	lw $a0, -4($fp)
	move $a1, $zero
	jal create
	
	sw $v0, 4($s1)
	
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addiu $sp, $sp, 32
	jr $ra   
	
	
create:
	subu $sp, $sp, 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addiu $fp, $sp, 28
	sw $a0, ($fp)
	sw $a1, -4($fp)
	
	li $v0, 9
	li $a0, 8
	syscall
	
	lw $a0, ($fp)
	lw $a1, -4($fp)
	sw $a0, ($v0)
	sw $a1, 4($v0)
	
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addiu $sp, $sp, 32
	jr $ra

