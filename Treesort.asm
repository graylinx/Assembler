
###############################################################################
###################           s0 Pointer to Root           ####################
###################         s1 Pointer to New Node         ####################
###################       s2 Pointer to Run the Tree       ####################
###################  Pointer Left | Value | Pointer Right  ####################
###############################################################################

	.data

Right:  .asciiz "Right "
Left:   .asciiz "Left "
Tree:   .asciiz "Tree: "
Space:  .asciiz " "
Eol:    .asciiz "\n"

	.text

Main:

	jal Tree_Node_Create
	
	move $s0, $s1     # S0 always pointing to Root Node
	
	jal Tree_Insert   # jal... but could be just b

	
###############################################################################
###################            Tree Node Create            ####################
###############################################################################

Tree_Node_Create:

	la $a0, 12        # Allocate 12 bytes
	li $v0, 9
	syscall
	
	beqz $v0, Exit    # If no more memory left, Exit
	
	move $s1, $v0     # Save Pointer to memory address v0 in s1
	
	li $v0, 5         # Insert new Node
	syscall

	beqz $v0, Tree_Print    # If Node value equal to 0, Print and Exit
	
	sw $zero, 0($s1)  # Left Pointer to Null
	sw $v0,   4($s1)  # Save Node value
	sw $zero, 8($s1)  # Right Pointer to Null
	
	jr $ra


###############################################################################
###################               Tree Insert              ####################
###############################################################################
Tree_Insert:

	move $s2, $s0     # Move pointer s0 to s2 to Run the Tree
	
	la $a0, Eol       # New Line
	li $v0, 4
	syscall

	jal Tree_Node_Create

Search_Position:

	lw $t1, 4($s2)    # Load Root Node value
	lw $t2, 4($s1)    # Load New Node value

	bgt $t2, $t1, Right_Tree # If new node is greater than Root_Node, Right_Tree
	
Left_Tree:

	la $a0, Left      # Tracita para ver si toma el camino de la izquierda
	li $v0, 4
	syscall

	lw $t1, 0($s2)    # If left pointer points to null, save the new node 
	
	bne $t1, $zero, Next_Node_Left # If not, check next Node

	addi $s1, $s1, 4  # Get the address of the new Node Value

	sw $s1, 0($s2)    # And save it in the Left Pointer position
	
	b Tree_Insert

Right_Tree:

	la $a0, Right     # Tracita para ver si toma el camino de la derecha
	li $v0, 4
	syscall

	lw $t1, 8($s2)    # If right pointer points to null, save the new node 
	
	bne $t1, $zero, Next_Node_Right # If not, check next Node

	addi $s1, $s1, 4  # Get the address of the new Node Value

	sw $s1, 8($s2)    # And save it in the Right Pointer position
	
	b Tree_Insert

Next_Node_Left:

	lw $s2, 0($s2)    # Set Pointer s2 to Left Node
	
	subi $s2, $s2, 4  # First position of the 3 words allocated
	
	b Search_Position

Next_Node_Right:

	lw $s2, 8($s2)    # Set Pointer s2 to Right Node
	
	subi $s2, $s2, 4  # First position of the 3 words allocated

	b Search_Position

###############################################################################
###################               Tree Print               ####################
###############################################################################

Tree_Print:

	beqz $s0, Exit    # If first value inserted is 0, Exit (address pointed by s0 is not set yet)

	la $a0, Tree
	li $v0, 4
	syscall
	
	move $s2, $s0     # Move pointer s0, to s2 to Run the Tree

	lw $a0, 0($s0)    # To print the Left Tree
	
	jal Print_Recursive
	
	lw $a0, 4($s0)    # To print the Root Node
	li $v0, 1
	syscall
	
	la $a0, Space
	li $v0, 4
	syscall
	
	lw $a0, 8($s0)    # To print the Right Tree

	jal Print_Recursive
	
	b Exit
	
Print_Recursive:

	subu $sp, $sp, 32 # Set up the Stack
	sw $ra, 0($sp)
	sw $fp, 4($sp)
	addi $fp, $sp, 8

	sw $s2, 12($sp)   # Save the pointer to current position

	move $s2, $a0     # a0 contains the address pointed by Left/Right Pointer

	beq $s2, $zero, Return # If address equal to 0, the Pointer is set Null, Free Stack and load s2

	subi $s2, $s2, 4  # Address not equal to 0 so Pointer s2 takes the position of the Left Pointer
	
	lw $a0, 0($s2)    # And load the address pointed by it
	
	jal Print_Recursive
	
	lw $a0, 4($s2)    # Print the Value
	li $v0, 1
	syscall
	
	la $a0, Space
	li $v0, 4
	syscall
	
	lw $s2, 8($s2)    # Load the address pointed by Right Pointer
	
	move $a0, $s2     # And move it to a0, to check if it is Null
	
	jal Print_Recursive


Return:

	lw $ra, 0($sp)    # Free the Stack
	lw $fp, 4($sp)
	lw $s2, 12($sp)   # Load the previous position of s2
	addi $sp, $sp, 32

	jr $ra


Exit:

	li $v0, 10
	syscall
