.data
Cadena: .space 256
overflow_advice: .asciiz "Se ha producido desbordamiento"
.text

main:
	la $a0, Cadena
	li $a1, 32
	li $v0, 8
	syscall
	jal atoi
	move $a0, $v0
	move $a1, $v1
	jal print
exit:
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
	lb $t2, ($t0)
	li $t1, 0
	beq $t2, 45, Negative
	li $v1, 1
	b loop
	
Negative:
	li $v1, -1
	addi $t0, $t0, 1
	
loop:
	lb $t2, ($t0)
	blt $t2, 48, return
	bgt $t2, 57, return 
	addi $t0, $t0, 1
	#cont * 10
	mul $t1, $t1, 10
	
	mfhi $t4
	mflo $t5
	
	bnez $t4, overflow 
	blt $t5, 0, overflow
 
	#consigo num
	sub $t2, $t2, '0'
	add $t1, $t1, $t2	
	blt $t1, 0, overflow 
	b loop

overflow:
	la, $a0, overflow_advice
	li $v0, 4
	syscall
	b exit

return:
	move $v0, $t1
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra

print:
	move $t0, $a0
	beq $a1, 1, positive
	mul $a0, $a0, $a1
	li $v0, 1
	syscall
	jr $ra
 positive: 
 	mul $a0, $a0, $a1
	li $v0, 1
	syscall
	jr $ra
	
