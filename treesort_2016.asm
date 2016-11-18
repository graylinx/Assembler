#$s0--> Nodo Raiz
#$s1--> Nodo Creado
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
	
	lw $a0, ($fp)
	move $a1, $zero
	move $a2, $zero
	jal tree_node_create	
	
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra
	
	
	
	
	
	
	
	
	
	