
main: 
	li $v0, 5
	syscall
	move $a0, $v0
	jal fib_itera
	move $a0, $v0
	li $v0, 1
	syscall
	li $v0, 10
	syscall

fib_itera:
	li $t0, 0
	li $t1, 1
	li $t2, 1
	li $t3, 1
loop:
	beq $t2, $a0, end_loop
	add $t3, $t0, $t1
	move $t0, $t1
	move $t1, $t3
	addi $t2, $t2, 1
	b loop
end_loop:	
	move $v0, $t1
	jr $ra