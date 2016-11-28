.data
	Intro: .asciiz "Introduce un número: "
	New_Line: .asciiz "\n"
.text

main:
	la $a0, Intro
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s0, $v0
loop_main:
	move $a0, $s0
	jal test_prime
	move $a0, $s0
	move $a1, $v0
	jal print
	subi $s0, $s0, 1
	bne $s0, 1, loop_main
	li $v0, 10
	syscall

test_prime:
	move $t0, $a0
	subi $t1, $t0, 1
loop:
	div $t0, $t1
	mfhi $t2
	beq $t1, 1, esprimo
	subi $t1, $t1, 1
	bnez $t2, loop
	li $v0, 0
	jr $ra
esprimo:
	li $v0, 1
	jr $ra

print:
	beqz $a1, noprint
	li $v0, 1
	syscall
	la $a0, New_Line
	li $v0, 4
	syscall
	jr $ra
	
noprint:
	jr $ra
	 
	