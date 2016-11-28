.data
Intro: .asciiz "Introduce un numero: "
Es_primo: .asciiz "Es primo"
No_es_primo: .asciiz "No es primo"
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
	beq $v0, 1, esprimo
	la $a0, No_es_primo
	li $v0, 4
	syscall
	subi $s0, $s0, 1
	bne $s0, 1, loop_main
esprimo:
	la $a0, Es_primo
	li $v0, 4
	syscall
	subi $s0, $s0, 1
	bne $s0, 1, loop_main
	
	li $v0, 10
	syscall  

test_prime:
	move $t0, $a0
check:
	subi $t0, $t0, 1
	ble $t0, 1, prime 
	div $a0, $t0
	mfhi $t1
	beqz $t1, no_prime
	b check
	
no_prime:
	li $v0, 0
	b return
	
prime:
	li $v0, 1
	b return
	
return:
	jr $ra
