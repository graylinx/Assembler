.data
str:  .asciiz "El resulTADO es: "
op1:  .word 3
op2:  .word 5
      
      .text
main: 
      lw $t0, op1
      lw $t1, op2
       
      add $t2, $t0, $t1
      
      la $a0, str
      li $v0, 4
      syscall
      
      la $a0, ($t2) 
      li $v0, 1
      syscall 