.data
	Intro: .asciiz "Introduce un numero: "
	Elimina: .asciiz "Introduce un numero que quieras eliminar: "
	New_Line: .asciiz "\n"
.text

main:
	li $a0, 8
	li $v0, 9
	syscall
	move $s0, $v0
	move $s1, $v0
	#nodo centinela
	sw $zero, ($s0)
	sw $zero, 4($s0)

loop:
	la $a0, Intro
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall	
	beqz $v0, delete
	move $a0, $s1
	move $a1, $v0
	jal insert
	move $s1, $v0
	b loop

delete:
	la $a0, Elimina
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall	
	
	move $a0, $s0
	move $a1, $v0
	jal remove
	move $a0, $v0
	li $v0, 1
	syscall
	lw $a0, 4($s0)
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
		
remove:
	lw $t0, 4($a0)
loop_remove:
	lw $t1, ($t0)
	beq $a1, $t1, find
	lw $t0, 4($t0)
	bnez $t0, loop_remove
	li $v0, 0
	jr $ra
	 
find:
	move $v0, $t0
	subi $t2, $t0, 8
	lw $t0, 4($t0)
	sw $t0, 4($t2)
	jr $ra	

insert:
	subu $sp, $sp, 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addi $fp, $sp, 8
	sw $a0, ($fp)
	sw $a1, 4($fp)
	
	li $a0, 8
	li $v0, 9
	syscall
	
	lw $a0, ($fp)
	lw $a1, 4($fp)
	sw $a1, ($v0)
	sw $zero, 4($v0)
	sw $v0, 4($a0)
	
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra
	
	