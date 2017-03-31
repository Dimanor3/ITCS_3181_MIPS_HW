# BySix.asm by Bijan Razavi
# Outputs the first N (user inputted integer)
# numbers that are divisible by 6.

.globl main
main:
	li $t0, 0	# Stores user input.
	li $t1, 1	# i.
	li $t2, 0	# Loops through all numbers divisible by 6.
				# between 0 and $t0.
	
	# Asks user for N.
	li $v0, 4
	la $a0, userInputRequest
	syscall
	
	li $v0, 5
	syscall
	
	# Moves $v0 into $t0.
	move $t0, $v0
	
	# Increments user input by 1 because $t1
	# starts at 1 for better text output.
	# (Don't want to output 0-9, want 1-10)
	addiu $t0, $t0, 1
	
	# Loops through N times and outputs each number
	# that's divisible by 6.
	loop: bge $t1, $t0, exit
	# Determines the next integer that's divisible by 6.
	addiu $t2, $t2, 6
	
	# Prints each number that's divisible by 6.
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, period
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	# Increments $t1 and goes back to the beginning of the loop
	addiu $t1, $t1, 1	
	j loop

	exit:
		# Exits the program
		li $v0, 10
		syscall
	
.data
	userInputRequest: .asciiz "How many numbers do you want to look into?\n"
	period: .asciiz ". "
	newLine: .asciiz "\n"