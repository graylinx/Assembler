.data
str:  .asciiz "El resulTADO es: "
      
      .text
main: li $v0, 5
      syscall
      move $t1, $v0
      li $v0, 5
      syscall
      move $t2, $v0
      add $t3, $t1, $t2
      
      la $a0, str
      li $v0, 4
      syscall
      
      la $a0, ($t3) 
      li $v0, 1
      syscall 