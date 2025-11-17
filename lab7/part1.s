# Program that counts consecutive 1’s.
.global _start
.text
_start:
	la s2, LIST # Load the memory address into s2
	addi s10, zero, 0 # Register s10 will hold the result
	
MAIN: lw a0, 0(s2) # load current word into a0 as we will pass this into sub routine
	
	
	addi s5, zero, -1
	beq a0, s5, END # end if we get to -1
	
	
	
	jal SUBROUTINE # go to sub routine
	
	mv s6, a0 # move a0 to s6 to perform computation
	blt s10, s6, UPDATE # branch is s10 is less than s6
	
	addi s2, s2, 4 # move to the next word
	j MAIN
	
UPDATE: mv s10, s6
	j MAIN
	
	
SUBROUTINE:
	addi t0, zero, 0 # Initiate t0 as a counter
	mv t1, a0 # load a0 t0 t1

COUNT:
	
	# we modified the provided code to run in sub routine
	beqz t1, RETURN # Loop until data contains no more 1s
	srli t2, t1, 1 # Perform SHIFT, followed by AND
	and t1, t1, t2
	addi t0, t0, 1 # Count the string lengths so far
	j COUNT

RETURN: 
	mv a0, t0
	jr ra
	
END: j END


.global LIST
.data
LIST:
.word 0x103fe00f, 0x0000ffff,0x80000001 , -1
	