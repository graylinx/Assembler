.data
Intro_1: .asciiz "Introduce un numero: "
Intro_2: .asciiz "Introduce otro numero: "
Resultado: .asciiz "El resultado es: "
Iguales: .asciiz "Iguales"
.text

main:
	la $a0, Intro_1
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s0, $v0
	
	la $a0, Intro_2
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
	
mayor:
	bgt $a0, $a1, primero
	beq $a0, $a1, iguales
	move $v0, $a1
	jr $ra

iguales:
	li $v0, 0
	jr $ra

primero:
	move $v0, $a0
	jr $ra

print:
	move $t0, $a0
	la $a0, Resultado
	li $v0, 4
	syscall
	beqz $t0, print_iguales
	move $a0, $t0
	li $v0, 1
	syscall
	jr $ra
	
print_iguales:

	la $a0, Iguales
	li $v0, 4
	syscall
	jr $ra