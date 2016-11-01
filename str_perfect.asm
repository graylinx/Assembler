	.data
Origen: .space 1024
Destino: .space 1024
	.text

Main:
	la $a0, Origen
	li $a1, 256
	jal read_string
	
	la $a0, Destino
	li $a1, 256
	jal read_string
	
	la $a1, Origen
	la $a0, Destino
	jal strcpy
	
	la $a0, Destino
	li $v0, 4
	syscall
	
Exit:
	li $v0, 10
	syscall
	

read_string:
	li $v0, 8
	syscall
	
strlen:
	li $v0, 0
loop:
	lb $t0, 0($a0)
	addi $a0, $a0, 1
	addi $v0, $v0, 1
	bnez $t0, loop
	subi $v0, $v0, 1
	jr $ra

strcpy:
	subu $sp, $sp, 32
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addi $fp, $sp, 8
	
	sw $a0, 0($fp)
	move $a0, $a1
	
	jal strlen
	
	lw $a0, 0($fp)
	
copia:
	lb $t0, 0($a1)
	sb $t0, 0($a0)
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	subi $v0, $v0, 1
	bnez $v0, copia
	sb $zero, 0($a0)
	
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	addi $sp, $sp, 32
	
	jr $ra
	
	
