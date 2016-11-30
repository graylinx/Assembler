.data
	IntroOne: .asciiz "Introduce un numero: "
	IntroTwo: .asciiz "Introduce otro numero: "
	Empate: .asciiz "EMPATE"
.text

main:
	la $a0, IntroOne
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s0, $v0
	la $a0, IntroTwo
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s1, $v0
	move $a0, $s0
	move $a1, $s1
	jal mayor
	move $a0, $v0
	jal print
	li $v0, 10
	syscall
print:
	beqz $v0, empate
	li $v0, 1
	syscall
	jr $ra
empate:
	la $a0, Empate
	li $v0, 4
	syscall

mayor:
	bgt $a0, $a1, mayora
	blt $a0, $a1, mayorb
	li $v0, 0
	jr $ra
	
mayora:
	move $v0, $a0
	jr $ra
mayorb:
	move $v0, $a1
	jr $ra
	