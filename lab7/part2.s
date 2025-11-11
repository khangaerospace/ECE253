.global _start
_start:
	
	la s1, LIST
	
	lw s2, 0(s1) # get number of list
	addi s1, s1, 4 # take the rest of the list
	
	addi s3, zero, 1 # swpped variable in MATLAB
	
	
WHILE: beqz s3, END # initiate the while loop and condition when end
	addi s3, zero, 0 # condition when swapped = 0
	
	addi t1, s2, -1 # this is for the inner for loop
	
	
FOR: beqz t1, WHILE # compare the the for loop
	slli a0, s2, 4
	mv s2, a0 # load the list into t2 so I can go over the linner loop
	jal SWAP
	addi t7, zero, 1
	beq a1, t7, FLAG
	
	
FLAG:
	addi s3, zero 1
	

SWAP:
	addi t2, zero, 0
	mv t3, a0
	
	addi t4, 0(t3) # A(i)
	addi t5, 4(t3) # A(i + 1)
	
	blt t4, t5, IF
	j RETURN

IF: 
	mv t6, 0(t3)
	mv 0(t3), 4(t3)
	mv 4(t3), t6
	
	addi t2, zero, 1
	j RETURN
	

RETURN:
	mv a0, t3
	mv a1, t2
	jr ra
	
	
	

END: j END
	


.global LIST
.data
LIST:
    .word 10, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33