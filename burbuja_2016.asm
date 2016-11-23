.data
Array: .word 2,5,1,4,7
.text

main:
	la $a0, Array
	jal burbuja
	move $v0, $a0
	jal print
	li $v0, 10
	syscall

burbuja:
	li $t0, 0
loop:
	addi $t0, $t0, 1
	li $t1, 0
	ble $t1, 4, loop_1
	la $v0, Array
	jr $ra
loop_1:
	
	lw $t2, Array($t1)
	addi $t1,$t1, 1
	lw $t3, Array($t1)
	bge $t2, $t3, loop_1
	mul $t4, $t1, 4
	addi $t5, $t4, 4
	sw $t3, Array($t4)
	sw $t2, Array($t5)
	b loop_1
	
print:
	la $a0, ($a0)
	li $v0, 1
	syscall
	addi $a0, $a0, 4
	addi $t0, $t0, 1
	blt $t0, 5, print 
	jr $ra
		
	
