.data
	Origen: .space 1024
	Destino: .space 1024
.text

main:
	la $a0, Origen
	li $a1, 256
	jal read_string
	
	la $a0, Destino
	li $a1, 256
	jal read_string
	
	la $a0, Origen
	la $a1, Destino
	jal strcpy
	la $a0, Destino
	li $v0, 4
	syscall
	li $v0, 10
	syscall

strlen:
	move $t0, $a0
	li $v0, 0
loop:
	lb $t1, ($t0)
	addi $t0, $t0, 1
	addi $v0, $v0, 1
	bne $t1, 10, loop
	subi $v0, $v0, 1
	jr $ra

strcpy:
	subu $sp, $sp 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addi $fp, $sp, 8
	sw $a0, ($fp)
	sw $a1, 4($fp)
	jal strlen
	move $t2, $v0
	lw $t0, ($fp)
	lw $t1, 4($fp)
loop_strcpy:
	lb $t3, ($t0)
	sb $t3, ($t1) 
	addi $t0, $t0, 1
	addi $t1, $t1, 1
	subi $t2, $t2, 1
	bnez $t2, loop_strcpy
	sb $zero, ($t1)
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra
	
read_string:
	li $v0, 8
	syscall
	jr $ra
	
	
	