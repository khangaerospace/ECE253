.global _start

_start:
	la s0, LIST # get the list values
	lw s1, 0(s0) # get the length of the list
	
	addi s0, s0, 4 # get the rest of the list and put in s2
	
	addi s3, zero, 1 # swpped variable in MATLAB

WHILE: beqz s3, END

	addi s3, zero, 0 # condition when swapped == 0
	
	# load value in
	addi s4, s0, 0 
	addi t1, s1, -1 
	
	
FOR: beqz t1, WHILE # compare the the for loop
	addi a0, s4, 0 
	jal SWAP
	
	or s3, s3, a0 # see if we finish the for loop
	
	addi s4, s4, 4 # move to the next number
	addi t1, t1, -1 # subtract 1 in the for loop
	
	j FOR
	

SWAP:
	lw t2, 0(a0)
	lw t3, 4(a0) 
	
	bgeu t3, t2, RETURN
	
	sw t3, 0(a0)
	sw t2, 4(a0)
	
	addi a0, zero, 1
	
	jr ra

RETURN:
	addi a0, zero, 0
	jr ra
	
	

END: j END



.global LIST
.data
LIST:
    .word 10, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33

	

	
	