#$s0--> Nodo Raiz
#$s1--> Siguiente numero introducido por el usuario
#$s2--> Valor Centinela
main:
	li $s2, 0
	move $a0, $s2
	move $a1, $zero
	move $a2, $zero
	jal tree_node_create
	move $s0, $v0
loop:
	li $v0, 5
	syscall
	move $s1, $v0
	beqz $s1, exit
	move $a0, $s1
	move $a1, $s0
	jal tree_insert
	b loop

#(val, left, rght)
tree_node_create:
	subu $sp, $sp, 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addi $fp, $sp, 8
	sw $a0, ($fp)
	sw $a1, 4($fp)
	sw $a2, 8($fp)
	
	li $v0, 9
	li $a0, 12
	syscall
	
	lw $a0, ($fp)
	sw $a0, ($v0)
	sw $a1, 4($v0)
	sw $a1, 8($v0)
	
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra
	
#(val, root)
tree_insert:
	subu $sp, $sp, 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addi $fp, $sp, 8
	sw $a0, ($fp)
	sw $a1, 4($fp)
	
	lw $t0, ($a1)
	bgt $a0, $t0, right
	lw $t1, 4($a1)
	bnez $t1, insert_left
	lw $a0, ($fp)
	move $a1, $zero
	move $a2, $zero
	jal tree_node_create	
	lw $a1, 4($fp)
	sw $v0, 4($a1)
	b return

right:
	lw $t1, 8($a1)
	bnez $t1, insert_right
	lw $a0, ($fp)
	move $a1, $zero
	move $a2, $zero
	jal tree_node_create	
	lw $a1, 4($fp)
	sw $v0, 8($a1)
	b return

insert_left:
	lw $a0, ($fp)
	lw $t0, 4($fp)
	lw $a1, 4($t0)
	jal tree_insert
	b return

insert_right:
	lw $a0, ($fp)
	lw $t0, 4($fp)
	lw $a1, 8($t0)
	jal tree_insert
	b return
	
return:
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra

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
	sw $ra, ($sp)
	sw $fp, 4($sp)
	addi $fp, $sp, 8
	sw $a0, ($fp)
	lw $a0, 8($a0)
	jal print
	lw $t0, ($fp)
	lw $a0, ($t0)
	li $v0, 1
	syscall
	lw $a0, ($fp)
	lw $a0, 4($a0)
	jal print
	
	lw $ra, 0($sp)    # Free the Stack
	lw $fp, 4($sp)
	addi $sp, $sp, 32
	jr $ra
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
