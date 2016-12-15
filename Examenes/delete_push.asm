#Mario Fernandez Guerrero
.data
	Intro: .asciiz "Introduce un numero: "
	Delete: .asciiz "Introduce un valor para eliminarlo de la pila: "
	New_Line2: .asciiz "\n \n"
	New_Line: .asciiz "\n"
.text

main:
move $s0, $zero
loop:
	la $a0, Intro
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	beqz $v0, exit
	move $a0, $s0
	move $a1, $v0
	jal push
	move $s0, $v0
	b loop

exit:
	la $a0, Delete
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $a0, $s0
	move $a1, $v0
	jal delete
	move $a0, $v0
	li $v0, 1
	syscall

	la $a0, New_Line2
	li $v0, 4
	syscall
	move $a0, $s0
	jal print
	li $v0, 10
	syscall

push:
	move $t0, $a0
	
	li $v0, 9
	li $a0, 8
	syscall
	
	sw $a1, ($v0)
	sw $t0, 4($v0)
	
	jr $ra	
	

delete:
	move $t0, $zero
	lw $t1, 4($a0)

loop_delete:
	lw $t2, ($a0)
	beq $t2, $a1, find
	move $t0, $a0
	lw $a0, 4($a0)
	lw $t1, 4($a0)
	bnez $a0, loop_delete
	move $v0, $zero
	jr $ra
find:
	beqz $t0, primer_lista
	beqz $t2, ultimo_lista
	sw $t1, 4($t0)
	move $v0, $a1
	jr $ra
ultimo_lista:
	sw $zero, 4($a0)
	move $v0, $a1
	jr $ra
primer_lista:
	move $v0, $a1
	move $s0, $t1
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
 	
 	la $a0, New_Line
 	li $v0, 4
 	syscall
 	
 	 
 	 
 	lw $fp, ($sp)
 	lw $ra, 4($sp)
 	addi $sp, $sp, 32
 	jr $ra 
	
	
	
