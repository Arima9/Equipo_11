# Author: Luis Pizano
# Date: Aug 17, 2020

.text
Main:
	lw $a0, 0x3FFFBC #				DONE
	jal Factorial # Calling procedure			DONE
	sw $v0, 0x3FFFC0
	j Exit	# Jump to Main label				DONE
	
Factorial:
	slti $t0, $a0, 1 # if n = 1				DONE
	beq $t0, $zero, Loop # Branch to Loop			DONE
	addi $v0, $zero, 1 # Loading 1  #Check			DONE
	jr $ra # Return to the caller				DONE
Loop:	
	addi $sp, $sp,-8 # Decreasing the stack pointer		DONE
	sw $ra, 4($sp) # Storing n				DONE
	sw $a0, 0($sp) #  Storing the resturn address		DONE
	addi $a0, $a0, -1 # Decreasing n			DONE
	jal Factorial # recursive function			DONE
	lw $a0, 0($sp) # Loading values from stak		DONE
	lw $ra, 4($sp) # Loading values from stak		DONE
	addi $sp, $sp, 8 # Increasing stack pointer		DONE
	mul $v0, $a0, $v0 # Multiplying n*Factorial(n-1)
	jr $ra  # Return to the caller				DONE
Exit:
nop
nop
nop
	
