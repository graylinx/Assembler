.data
str:  .asciiz "El resulTADO es: "
op1:  .half 3
op2:  .half 5
      
      .text
main: 
      lh $t0, op1
      lh $t1, op2
       
      add $t2, $t0, $t1
      
      la $a0, str
      li $v0, 4
      syscall
      
      la $a0, ($t2) 
      li $v0, 1
      syscall 
