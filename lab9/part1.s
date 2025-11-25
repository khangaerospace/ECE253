.global _start
_start:
	.equ LEDs, 0xFF200000
	.equ TIMER, 0xFF202000
	.equ PUSH_BUTTON, 0xFF200050

	#Set up the stack pointer
	li sp, 0x20000

	# might switch this
	csrw mstatus, zero # turn off interupt while setting

	jal CONFIG_TIMER #configure the Timer
	jal CONFIG_KEYS #configure the KEYs port

	# Enable Timer IRQ16 (Timer) and IRQ18 (keys)
	li t0, 0x50000 # IRQ16 (0x10000) + IRQ18 (0x40000) = 0x50000
	csrw mie, t0

	la t0, interrupt_handler
	csrw mtvec, t0
	# turn interupt handler back on
	li t0, 0b1000
    csrw mstatus, t0



	la s0, LEDs
	la s1, COUNT
LOOP:
	lw s2, 0(s1) # get current count
	sw s2, 0(s0) # store count in LEDs
	j LOOP

interrupt_handler:
    addi sp, sp, -28
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    sw t2, 12(sp)
    sw t3, 16(sp)
    sw t4, 20(sp)
	sw t5, 24(sp)

	csrr t0, mcause # see who cause the interupt

	li t1, 0x80000010       # IRQ16 (timer)
    beq t0, t1, Timer_ISR

	li t1, 0x80000012       # IRQ18 (keys)
    beq t0, t1, KEYs_ISR


Timer_ISR:
	li t0, TIMER
	sw zero, 0(t0) # clear interupt by putting this in register


	la t1, RUN
	lw t2, 0(t1)

	la t3, COUNT
	lw t4, 0(t3)

	# now wrap when we get to 255
	add t4, t4, t2 # add until 255
	li t5, 255
	ble t4, t5, wrap # check for wrap
	li t4, 0

wrap: 
	sw t4, 0(t3)
	j return




KEYs_ISR:
	# configuration for keys
	la t0, RUN
	lw t1, 0(t0)

	xori t1, t1, 1
	sw t1, 0(t0)

	# Clear the button 
	li t2, PUSH_BUTTON
	lw t3, 12(t2)
	sw t3, 12(t2)
	j return

return:
	lw ra, 0(sp)
    lw t0, 4(sp)
    lw t1, 8(sp)
    lw t2, 12(sp)
    lw t3, 16(sp)
    lw t4, 20(sp)
	lw t5, 24(sp)
	addi sp, sp, 28
	mret


CONFIG_TIMER:
	li t0, TIMER
	sw zero, 0(t0)

	# period = 0.25s at 100MHz → 25,000,000 = 0x017D7840
	li t1, 0x7840
    sw t1, 8(t0) # low 16 bits
    li t1, 0x017D
    sw t1, 12(t0) # high 16 bits

	li t1, 0b111
	sw t1, 4(t0)
	jr ra
CONFIG_KEYS:
	li t0, PUSH_BUTTON
	li t1, 0b111
	sw t1, 8(t0)
	sw t1, 12(t0)
	jr ra
.data
.global COUNT
COUNT: .word 0x0 # used by timer
.global RUN # used by pushbutton KEYs
RUN: .word 0x1 # initial value to increment COUNT
.end