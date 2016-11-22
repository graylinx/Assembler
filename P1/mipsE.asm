.data
array:  .word 10,11,12,13
        .byte 0x1a,0x0b,10 #Array de tipo byte con datos en hexadecimal
texto1:        .ascii   "Simulador MARS0" #Cadena de caracteres que no acaba en /0
        .asciiz  ", MIPS320" #Cadena de caracteres que si acaba en /0
        
	

index:  .word 1
        .text
main:   lw	$t0, array($0) #Direccionamiento absoluto
	addi    $t2, $t2, 4
	lw      $t1, array($t2)
        lw      $t5, index($0)
        addi    $t4, $0, 4 #Suma $0 y 4 y lo guarda en $t4
        mul     $t6, $t4, $t5 
       # mflo    $t6 #Mueve lo que hay en la parte baja de la multiplicacion "lo" y lo mueve a $t6
        lw      $t1, array($t6)
        addi    $t5, $t5, 1
        mult    $t4, $t5
        mflo    $t6 
        lw      $t2, array($t6)
        addi    $t5, $t5, 1
        mult $t4, $t5
	mflo $t6
	#lw $t3, array($t6)
	#li $v0, 10
	#syscall
	
	
	la $a0, texto1 
      	li $v0, 4
      	syscall 
	li $v0, 10
	syscall
