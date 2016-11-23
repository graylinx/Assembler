.data
	Array: .word 8,1,2,4,0
.text

main:
	la $a0, Array
	jal burbuja
	move $a0, $v0
	jal print
exit:
	li $v0, 10
	syscall

burbuja:
	subu $sp, $sp, 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addi $fp, $sp, 8
	sw $a0, ($fp)
	
	li $t0, 0
	li $t1, 0
	
loop_i:
	
	blt $t0, 4 loop_j
	addi $t1, $t1, 1
	li $t0, 0
	blt $t1, 4 loop_i
	lw $v0, ($fp)
	lw $fp, ($sp)
	lw $fp, 4($sp)
	addi $sp, $sp, 32
	jr $ra
	
loop_j:
	
	bge $t0, 4 loop_i
	mul $t2, $t0, 4
	lw $t3, Array($t2)
	addi $t4, $t2, 4
	lw $t5, Array($t4)
	addi $t0, $t0, 1

	blt $t3, $t5, loop_j
	sw $t5, Array($t2)
	sw $t3, Array($t4)
	b loop_j


print:
	li $t0, 0
loop:
	bgt $t0, 4, exit
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
