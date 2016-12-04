.data
	Intro: .asciiz "Introduce un numero: "
	New_line: ".\n"
.text

main:
	#Creamos nodo centinela
	li $a0, 8
	li $v0, 9
	syscall
	
	sw $zero, ($v0)
	sw $zero, 4($v0)
	addi $s0, $v0, 8
	move $s1, $v0
	
loop:
	la $a0, Intro
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s2, $v0
	beqz $s2, exit 
	move $a0, $s0
	move $a1, $s2
	jal delete
	bnez $v0, loop
	move $a0, $s1
	move $a1, $s2
	jal insert
	move $s1, $v0
	b loop
	
exit:
	move $a0, $s0
	jal print
	li $v0, 10
	syscall

insert:
	move $t0, $a0
	move $t1, $a1
	li $a0, 8
	li $v0, 9
	syscall
	sw $v0, 4($t0)
	sw $t1, ($v0)
	jr $ra
delete:
	lw $t0, ($a0)
	lw $t1, 4($a0)
	beq $t0, $a1, find
	beqz $t1, notfound
	addi $a0, $a0, 8
	b delete
	
notfound:
	move $v0, $zero
	jr $ra
find:
	subi $t0, $a0, 8
	lw $t1, 4($a0)
	sw $t1, 4($t0)
	move $v0, $a1
	jr $ra

print:
	bnez $a0, print_recursive
	jr $ra

print_recursive:
	subu $sp, $sp, 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addi $fp, $sp, 8
	sw $a0, ($fp)
	
	lw $a0, 4($a0)
	jal print
	
	lw $a0, ($fp)
	lw $a0, ($a0)
	
	li $v0, 1
	syscall
	
	la $a0, New_line
	li $v0, 4
	syscall
	
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra
	
	
	
	



	
	
	
