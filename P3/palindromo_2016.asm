.data
Cadena: .space 1024
Es_palindromo: .asciiz "Es Palindromo"
No_es_palindromo: .asciiz "No es palindromo"
.text

main:
	la $a0, Cadena
	li $a1, 256
	li $v0, 8
	syscall
	jal palindromo
	move $a0, $v0
	jal print
exit:
	li $v0, 10
	syscall

palindromo:
	subu $sp, $sp, 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addi $fp, $sp, 28
	move $t0, $a0
	move $t1, $a0
loop:	
	lb $t2 ($t1)
	beq $t2, 10, find
	beq $t2, 32, jump
	beq $t2, ',', jump
	beq $t2, '.', jump
	blt $t2, 90, mayuscula
	addi $t1, $t1, 1
	b loop

jump:
	addi $t1, $t1, 1
	b loop

mayuscula:
	addi $t2, $t2, 32
	sb $t2, ($t1)
	addi $t1, $t1, 1
	b loop

find:
	subi $t1, $t1, 1
loop_1:
	bgt $t0, $t1, success
	lb $t3, ($t0)
	lb $t4, ($t1)
	beq $t3, ' ', jump_inicio
	beq $t4, ' ', jump_final
	beq $t3, ',', jump_inicio
	beq $t4, ',', jump_final
	beq $t3, '.', jump_inicio
	beq $t4, '.', jump_final
	addi $t0, $t0, 1
	subi $t1, $t1, 1
	beq $t3, $t4, loop_1
	li $v0, 0
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra

jump_inicio:
	addi $t0, $t0, 1
	b loop_1
jump_final:
	subi $t1, $t1, 1
	b loop_1
	
success:
	li $v0, 1
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra

print:
	beq $a0, 1, espalindromo
	la $a0, No_es_palindromo
	li $v0,4
	syscall
	b exit
espalindromo:
	la $a0, Es_palindromo
	li $v0,4
	syscall
	b exit
	
