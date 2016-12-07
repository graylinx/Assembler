.data
	Intro: .asciiz "Introduce un numero: "
.text

main:
	#Creamos un nodo centinela
	move $a0, $zero
	move $a1, $zero
	move $a2, $zero
	jal tree_node_create
	move $s0, $v0
loop:
	la $a0, Intro
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	beqz $v0, exit
	move $a0, $v0
	move $a1, $s0
	jal tree_insert
	b loop

exit:
	lw $a0, 8($s0)
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
	lw $a0, ($fp)
	lw $a0, ($a0)
	li $v0, 1
	syscall
	
	lw $a0, ($fp)
	lw $a0, 8($a0)
	jal print
	
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra
	
	

tree_insert:
	subu $sp, $sp, 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addi $fp, $sp, 8
	sw $a0, ($fp)
	sw $a1, 4($fp)
	move $a1, $zero
	move $a2, $zero
	jal tree_node_create
	#val
	lw $t0, ($fp)
	#root
	lw $t1, 4($fp)
loop_create:
	lw $t2, ($t1)
	bgt $t0, $t2, right
	blt $t0, $t2, left

right:
	lw $t3, 8($t1)
	beqz $t3, insert_right
	move $t1, $t3
	b loop_create

insert_right:
	sw $v0, 8($t1)
	b return 

left:
	lw $t3, 4($t1)
	beqz $t3, insert_left
	move $t1, $t3
	b loop_create

insert_left:
	sw $v0, 4($t1)
	b return 

return:
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra
	

tree_node_create:
	move $t0, $a0
	li $v0, 9
	li $a0, 12
	syscall
	sw $t0, ($v0)
	sw $a1, 4($v0)
	sw $a2, 8($v0)
	jr $ra
	
	
	