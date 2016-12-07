.data
	Intro: .asciiz "introduce un numero: "
	New_Line: .asciiz "\n"
.text

main:
	la $a0, Intro
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $a0, $v0
	move $a1, $zero
	jal create
	move $s0, $v0
	move $s1, $v0
loop:
	la $a0, Intro
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	beqz $v0, exit
	move $a0, $s1
	move $a1, $v0
	jal insert
	move $s1, $v0
	b loop
 exit:
 	move $a0, $s0
 	jal print
 	li $v0, 10
 	syscall 
 
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
	
	la $a0, New_Line
	li $v0, 4
	syscall
	
	lw $a0, ($fp)
	lw $a0, ($a0)
	li $v0, 1
	syscall
	
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra

insert:
	subu $sp, $sp, 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addi $fp, $sp, 8
	sw $a0, ($fp)
	sw $a1, 4($fp)
	
	lw $a0, 4($fp)
	move $a1, $zero
	jal create
	
	lw $a0, ($fp)
	sw $v0, 4($a0)
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra
	

create:
	move $t0, $a0
	li $a0, 8
	li $v0, 9
	syscall
	sw $t0, ($v0)
	sw $a1, 4($v0)
	jr $ra

