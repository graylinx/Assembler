.data
Intro1: .asciiz "Introduce un numero"
Intro2: .asciiz "Introduce otro numero" 
Resulado: .asciiz "Resultado:"
opt1: .word 
opt2: .word 
.text

main:
	la $a0, Intro1
	li $v0, 4
	syscall
	
	
	li $v0, 5
	syscall
	la $a0, opt1
	sb $v0, ($a0)
	
	la $a0, Intro2
	li $v0, 4
	syscall
	la $a0, opt2
	li $v0, 5
	syscall
	la $a0, opt2
	sb $v0, ($a0)

	
	la $a0, opt1
	la $a1, opt2
	jal suma
	move $s0, $v0
	la $a0, Resulado
	li $v0, 4
	syscall
	move $a0, $s0
	li $v0, 1
	syscall
	li $v0, 10 
	syscall

suma:
	lb $t0, ($a0)
	lb $t1, ($a1)
	add $v0, $t0, $t1
	jr $ra
