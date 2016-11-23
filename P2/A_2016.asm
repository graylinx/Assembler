.data
Intro1: .asciiz "Introduce un numero"
Intro2: .asciiz "Introduce otro numero" 
Resulado: .asciiz "Resultado: "
.text

main:
	la $a0, Intro1
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s0, $v0
	
	la $a0, Intro2
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s1, $v0
	
	move $a0, $s0
	move $a1, $s1
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
	add $v0, $a0, $a1
	jr $ra
