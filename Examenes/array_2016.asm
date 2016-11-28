.data
	array: .word  4, 1, 0, 3, 2, 5, 8, 7, 6, 9
.text

main:
	#direccion del array
	la $a0, array
	#el valor a buscar
	li $a1, 1
	#pos que se empieza a buscar
	li $a2, 0
	#longitud total del array
	li $a3, 10
	jal buscardesde
	beq $v0, -1, exit
	
	move $a0, $v0
	addi $a1, $a0, 1
	la $a2, array 
	jal intercambiar
	la $a0, array
	jal print 
exit:
	li $v0, 10 
	syscall
	
print:
	li $t0, 1
loop:
	bgt $t0, 10, exit
	subu $sp, $sp, 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addi $fp, $sp, 28
	sw $a0, ($fp)
	lw $a0, ($a0)
	li $v0, 1
	syscall
	addi $t0, $t0, 1
	lw $a0, ($fp)
	add $a0, $a0, 4
	b loop
	
intercambiar:
	#$t0 4Xpos
	mul $t0, $a0, 4
	#$t1 pos array
	add $t1, $t0, $a2
	#$t2 valor pos array 
	lw $t2, ($t1)
	#$t3 4Xpos
	mul $t3, $a1, 4
	#$t4 pos array
	add $t4, $t3, $a2 
	#$t5 valor pos array 
	lw $t5, ($t4)
	sw $t2, ($t4)
	sw $t5, ($t1) 
	jr $ra
	
	
buscardesde:
	subu $sp, $sp, 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addi $fp, $sp, 28
	sw $a0, ($fp)
	sw $a1, -4($fp)
	sw $a2, -8($fp)
	sw $a3, -12($fp)
	bgt $a2, $a3, buscardesdereturn
	mul $t0, $a2, 4
	add $t1, $t0, $a0 
	lw $t2, ($t1)
	beq $t2, $a1, returnpos
	addi $a2, $a2, 1
	jal buscardesde
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra
	
buscardesdereturn:
	li $v0, -1
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra
	
returnpos:
	move $v0, $a2
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra
	