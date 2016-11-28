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
	
	
	la $a0, Destino
	la $a1, Origen
	jal strcpy
	
	la $a0, Destino
	li $v0, 4
	syscall
	
	li $v0,10
	syscall

read_string:
	li $v0, 8
	syscall
	jr $ra	

strcpy:
	subu $sp, $sp, 32
	addi $fp, $sp,28
	sw $ra, 0($fp)
	sw $fp, -4($fp)
	sw $a0, -8($fp)
	sw $a1, -12($fp)
	
	lw $a0, -12($fp)
	move $v0, $zero
	jal strlen
	lw $a0, -8($fp)
loop:
	lb $t0, ($a1)
	sb $t0, ($a0)
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	subi $v0, $v0, 1
	bnez $v0, loop
	sb $zero, ($a0)
	#desmontamos la pila
	lw $fp, -4($fp)
	lw $ra, 0($fp)
	addiu $sp, $sp, 32
	addi $fp, $sp, 28
	jr $ra 
	
	
strlen:
	lb $t0, ($a0)
	addi $a0, $a0, 1
	addi $v0, $v0, 1
	bnez $t0, strlen
	subi $v0, $v0, 1
	jr $ra
	
	
	
	
	
	