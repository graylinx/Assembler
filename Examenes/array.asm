.data
	Array: .space 1024
	New_Line: .asciiz "\n"
	Intro: .asciiz "Introduce un numero: "
.text

main:
	la $a0, Array
	li $a1, 6
	jal inicializar
	#array
	la $a0, Array
	#valor
	li $a1, 1
	#pos
	li $a2, 0
	#lng
	li $a3, 5
	jal buscardesde
	move $a0, $v0
	addi $a1, $a0, 1
	la $a2, Array
	jal intercambiar
	la $a0, Array
	li $a1, 6
	jal print
	li $v0, 10
	syscall

inicializar:
	move $t0, $a0
loop:
	la $a0, Intro
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	sw $v0, ($t0)
	addi $t0, $t0, 4
	subi $a1, $a1, 1
	bnez $a1, loop
	jr $ra
	
print:
	bnez $a1, print_recursive
	jr $ra

print_recursive:
	subu $sp, $sp, 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addi $fp, $sp, 8
	sw $a0, ($fp)
	sw $a1, 4($fp)
	
	addi $a0, $a0, 4
	subi $a1, $a1, 1
	jal print
		
	lw $a0, ($fp)
	lw $a0, ($a0)
	li $v0, 1
	syscall
	
	la $a0, New_Line
	li $v0, 4
	syscall
	
	
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	
	jr $ra
	
	 
		
intercambiar:
	beq $a0, -1, return
	mul $t0, $a0, 4
	mul $t1, $a1, 4
	add $t2, $a2, $t0
	add $t3, $a2, $t1
	lw $t4, ($t3)
	lw $t5, ($t2)
	sw $t4, ($t2)
	sw $t5, ($t3)
return:
	jr $ra

buscardesde:
	bgt $a2, $a1, notfound
	mul $t0, $a2, 4
	add $t0, $a0, $t0
	lw $t0, ($t0)
	beq $t0, $a1, found
	
buscardesde_recursive:
	subu $sp, $sp, 32
	sw $fp, ($sp)
	sw $ra, 4($sp)
	addi $fp, $sp, 8
	sw $a0, ($fp)
	sw $a1, 4($fp)
	sw $a2, 8($fp)
	sw $a3, 12($fp)
	
	addi $a2, $a2, 1 	
	
	jal buscardesde
	lw $fp, ($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 32
	jr $ra
found:
	move $v0, $a2
	jr $ra
notfound:
	li $v0, -1
	jr $ra 	
	
