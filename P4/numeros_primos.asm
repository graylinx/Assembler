.data
	Intro: .asciiz "Introduce un numero: "
	New_line: .asciiz "\n"
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
	move $a0, $v0
	move $a1, $s0
	jal print
	subi $s0, $s0, 1
	bnez $s0, loop_main
	li $v0, 10
	syscall

print:
	beqz $a0, no_print
	la $a0, New_line
	li $v0, 4
	syscall
	move $a0, $a1
	li $v0, 1
	syscall
	jr $ra
no_print:
	jr $ra
	

test_prime:
 	move $t0, $a0
loop:
 	subi $t0, $t0, 1 
 	beq $t0, 1, esprimo
	div $a0, $t0
	mfhi $t1
	bnez $t1, loop
	li $v0, 0
	jr $ra
esprimo:
	li $v0, 1
	jr $ra

	

