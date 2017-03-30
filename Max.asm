# Max.asm by Bijan Razavi
# Checks an array of integers and selects the largest number
# to display.

.globl main
main:
	li $t0, 0	# Stores randomly generated number.
	li $t1, 0	# Stores intArray address.
	li $t2, 0	# Stores array size.
	li $t3, 0	# Stores next number to check.
	li $s1, 0	# Stores biggest number.

	# Loads array intArray into $s0.
	la $s0, intArray
	
	# Set $t1 to intArray's address
	addu $t1, $t1, $s0
	
	# Sets $t2 to intArray's max size
	addu $t2, $t2, $s0
	addiu $t2, $t2, 40
	
	li $v0, 4
	la $a0, intsInArray
	syscall
	
	loop: bge $t1, $t2, loopEnd
		li $v0, 42	# Picks a random number to later be loaded into
				# intArray.
		li $a1, 100	# Sets upper bound.
		syscall
	
		sw $a0, 0($t1)
		
		# Prints out a list of ints in the array
		li $v0, 1
		syscall
		
		li $v0, 4
		la $a0, comma
		syscall
	
		addiu $t1, $t1, 4
		j loop
		
	loopEnd:
		# Resets $t1
		li $t1, 0
		addu $t1, $t1, $s0
		
		li $v0, 4
		la $a0, newLine
		syscall
	
		# Loads the first int into $s1
		lw $s1, 0($t1)
		addiu $t1, $t1, 4
	
	loop2: bge $t1, $t2, print
		# Loads the next int into $t3
		lw $t3, 0($t1)
		
		# Checks to see if $t3 is greater than or
		# equal to $s1 and if it is it branches
		# out to greater, otherwise it moves on.
		bge $t3, $s1, greater
		
		addiu $t1, $t1, 4
		j loop2
		
		greater:
			# Stores $t3 into $s1
			move $s1, $t3
		
			addiu $t1, $t1, 4
			j loop2
	
	print:
		# Prints the max int.
		li $v0, 4
		la $a0, greatestInt
		syscall
		
		li $v0, 1
		move $a0, $s1
		syscall
		
	exit:
		li $v0, 10
		syscall
		
.data
	intArray: .word 40
	intsInArray: .asciiz "The ints in the array are: "
	greatestInt: .asciiz "Max int in array: "
	comma: .asciiz ", "
	newLine: .asciiz "\n"
