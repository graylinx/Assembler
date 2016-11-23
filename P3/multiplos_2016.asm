.data
Intro_A: .asciiz "Introduce un numero A: "
Intro_B: .asciiz "Introduce un numero B: "
New_Line: .asciiz "\n"
.text

main:
	la $a0, Intro_A
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s0, $v0
	
	la $a0, Intro_B
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s1, $v0
	
	move $a0, $s0
	move $a1, $s1
	jal multiplos
	li $v0, 10
	syscall

multiplos:
	beqz $a1, exit
	mul $t0, $a0, $a1
	move $t1, $a0
	li $t2, 1
loop:
	mul $t3, $t1, $t2
	move $a0, $t3
	li $v0, 1
	syscall
	
	la $a0, New_Line
	li $v0, 4
	syscall
	
	addi $t2, $t2, 1
	blt $t3, $t0, loop
	
exit:
	jr $ra 
	
