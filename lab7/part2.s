.global _start
_start:
    la s1, LIST
    lw s2, 0(s1)      # number of items
    addi s1, s1, 4    # point to first element
    addi s2, s2, -1   # s2 = number of comparisons on first pass

OUTER:
    addi s3, zero, 0  # s3 = index
    la s1, LIST
    addi s1, s1, 4

INNER:
    jal ra, SWAP
    addi s1, s1, 4
    addi s3, s3, 1
    bne s3, s2, INNER

    addi s2, s2, -1   # one fewer compare on next pass
    bgt s2, zero, OUTER

END: j END


SWAP:
    lw t4, 0(s1)
    lw t5, 4(s1)
    bgt t4, t5, IF
    li a0, 0
    ret

IF:
    lw t6, 0(s1)
    lw t5, 4(s1)
    sw t5, 0(s1)
    sw t6, 4(s1)
    li a0, 1
    ret


.global LIST
.data
LIST:
    .word 10, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33
