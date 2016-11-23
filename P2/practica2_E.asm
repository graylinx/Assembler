.data
str:  .asciiz "El resulTADO es: "
op1:  .space 2
op2:  .space 2
      
      .text
main: 
      	la $a0, op1
      	li $v0, 5
   	syscall
   	
    	move $t1, $a0 
	
	li $v0, 5
      	la $a0, op2
   	syscall
   	
    	move $t2, $a0 

      
      	
       
      	add $t3, $t2, $t1
      
        la $a0, str
      	li $v0, 4
      	syscall
      
      	la $a0, ($t3) 
      	li $v0, 1
      	syscall 
