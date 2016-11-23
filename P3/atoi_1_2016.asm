.data
Cadena: .space 1024
Resultado: .space 1024
.text

main:
	la $a0, Cadena
	li $a1, 256
	li $v0, 8
	syscall
	jal atoi
	move $a0, $v0
	jal print
	li $v0, 10
	syscall

atoi:
	subu $sp, $sp, 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addi $fp, $sp, 28
	sw $a0, ($fp)
	#dir de memoria origen
	lw $t0, ($fp)
	#contado
	li $t1, 0
	
loop:
	lb $t2, ($t0)
	addi $t0, $t0, 1
	beq $t2, 10, return 
	#cont * 10
	mul $t1, $t1, 10
	#consigo num
	sub $t2, $t2, '0'
	add $t1, $t1, $t2	
	b loop
return:
	move $v0, $t1
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra

print:
	li $v0, 1
	syscall
	jr $ra
	