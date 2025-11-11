.global _start
.text

_start:
	la s2, LIST
	addi s10, zero, 0
	addi s11, zero, 0

LOOP: lw s3, 0(s2) # load current number to list
	addi s4, zero, -1
	beq s3, s4, END # end if we get to -1
	
	add s10, s10, s3 # add the sum
	addi s11, s11, 1 # add 1 to S11
	
	addi s2,s2, 4 # move to the next value in the list
	j LOOP # continue the loop
	
	
	

END: j END

.global LIST
.data
LIST:
.word 1, 2, 3, 5, 0xA, -1
	