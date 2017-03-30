# prime.asm by Bijan Razavi

.globl main
main:
	# Initial user stuff.
	li $t0, 0 # $t0 is user input.
	li $t1, 2 # $t1 is i.
	li $t2, 2 # $t2 is the number $t1 is added by.
	li $t3, 0 # $t3 used to check for remainder.
	li $t4, 3 # $t4 is j.
	li $t5, 0 # $t5 stores the number of j loops.
	li $t6, 0 # Used as a check.
	li $t7, 0 # Used to track the number of prime numbers.
	
	# New stuff for more efficient divison.
	li $t8, 0 # Used to iterate through array during loop.
	li $s2, 0 # Used to track array size + address (mostly to add
		  # new primes.
	li $s3, 0 # Stores just the initial address of the array.

	# Loads array primeNumbers into $s1.
	la $s1, primeNumbers
	
	addu $s2, $s2, $s1
	addu $s3, $s3, $s1
	addu $t8, $t8, $s1
	
	# Loads 3 into $s1.
	li $t8, 3
		sw $t8, 0($s2)
		addiu $s2, $s2, 4

	# Display prompt1.
	li $v0, 4
	la $a0, prompt1
	syscall

	# Take in user input.
	li $v0, 5
	syscall
	
	# Move $v0 to $t0.
	move $t0, $v0
	
	# Check if $t0 is valid.
	blez $t0, notValid
	
	# Check if $t0 is 1.
	beq $t0, 1, notPrimeByDefinition
	
	# Display prompt2.
	li $v0, 4
	la $a0, prompt2
	syscall
	
	# Take user input.
	li $v0, 5
	syscall
	
	# Move $v0 to $t6
	move $t6, $v0
	
	# Check for user response and complete their task.
	bgtz $t6, s2
	
	addiu $t0, $t0, 1 # Add user input by 1 to make looping easier.
	
	# 2 is automatically prime, go ahead and print it.
	addiu $t7, $t7, 1
	
	li $v0, 1
	move $a0, $t7
	syscall
	
	li $v0, 4
	la $a0, period
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, isprime
	syscall
	
	addiu $t1, $t1, 1 # Add 1 to i to set it to 3 since 2 has already been displayed.
	
	# 3 is automatically prime, go ahead and print it.
	addiu $t7, $t7, 1
	
	li $v0, 1
	move $a0, $t7
	syscall
	
	li $v0, 4
	la $a0, period
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, isprime
	syscall
	
	addiu $t1, $t1, 2 # Add 2 to i to set it to 5 since 3 has already been displayed.
	
	# Loops through all numbers in #t0 to check for prime.
	l1: 	bge $t1, $t0, exit
		
		# During the checking process you want to only check the first half
		# of the numbers (no point checking for the remainder of 53 for 55
		# only need to check from 3 - 28).
		subiu $t5, $t1, 1
		
		divu $t5, $t5, 2
		
		addiu $t5, $t5, 1
		
		# Checks to see if the potential prime number is actually prime.
		l2: 	bge $t4, $t5, moveon
			
			lw $t4, 0($t8)
			
			addiu $t8, $t8, 4
			
			remu $t3, $t1, $t4
			
			beqz $t3, s1
			
			j l2
		moveon:
			# Print out prime number.
			addiu $t7, $t7, 1
			li $v0, 1
			move $a0, $t7
			syscall
			
			li $v0, 4
			la $a0, period
			syscall
			
			li $v0, 1
			move $a0, $t1
			syscall
		
			li $v0, 4
			la $a0, isprime
			syscall
		
			sw $t1, 0($s2)
				addiu $s2, $s2, 4
		
		s1:	addu $t1, $t1, $t2
			li $t4, 3
			li $t8, 0
			addu $t8, $t8, $s3
			
			beq $t2, 2, e
			
			li $t2, 2
			
			j l1
			
		e: 	li $t2, 4
		
			j l1

	j exit

	s2:	
		# Check to see if the number is 2.
		beq $t0, 2, print
	
		# Check to see if the number is even.
		remu $t3, $t0, 2
		
		beqz $t3, notPrime
		
		# Determine which numbers to divide by.
		subiu $t5, $t0, 1
		
		divu $t5, $t5, 2
		
		addiu $t5, $t5, 1
		
		# Loop through all divisible numbers to check to see if prime.
		l3: bge $t4, $t5, print
			
			remu $t3, $t0, $t4
			
			beqz $t3, notPrime
			
			addiu $t4, $t4, 2
			
			j l3
	
	print:
		# Print out prime number.
		addiu $t7, $t7, 1
		
		li $v0, 1
		move $a0, $t0
		syscall
		
		li $v0, 4
		la $a0, isprime
		syscall
		
		j exit
		
	notPrime:
		li $v0, 1
		move $a0, $t0
		syscall
		
		li $v0, 4
		la $a0, notprime
		syscall
		
		j exit
		
	notPrimeByDefinition:
		li $v0, 1
		move $a0, $t0
		syscall
		
		li $v0, 4
		la $a0, notprimebydefinition
		syscall
		
		j exit
		
	notValid:
		li $v0, 1
		move $a0, $t0
		syscall
		
		li $v0, 4
		la $a0, notvalid
		syscall

	# Exit.
	exit:
		# Print out the total number of primes.
		li $v0, 4
		la $a0, numberofprimes
		syscall
		
		li $v0, 1
		move $a0, $t7
		syscall
		
		li $v0, 4
		la $a0, newline
		syscall
		
		# Restart?
		li $v0, 4
		la $a0, prompt3
		syscall
		
		li $v0, 5
		syscall
		
		# Moves $v0 into $t7.
		move $t6, $v0
		
		bgtz $t6, main
		
		li $v0, 10
		syscall

.data
	prompt1: .asciiz "Enter a number please: "
	prompt2: .asciiz "Enter 0 to check for all primes between 1 and your number, enter 1 to check only your number: "
	prompt3: .asciiz "Enter 0 to exit, enter 1 to restart: "
	isprime: .asciiz " is a prime!\n"
	notprime: .asciiz " is not a prime!\n"
	notvalid: .asciiz " is not a valid number!\n"
	notprimebydefinition: .asciiz " is not prime by definition!\n"
	numberofprimes: .asciiz "Number of primes: "
	newline: .asciiz "\n"
	period: .asciiz ". "
	comma: .asciiz ", "
	testing: .asciiz "TESTING, TESTING: "
	primeNumbers: .word 4	# Array of prime numbers.
