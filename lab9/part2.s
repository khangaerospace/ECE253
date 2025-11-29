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
	li t0, PUSH_BUTTON # load base address of the button
	lw t1, 12(t0) # see which key cause the IRQ
	sw t1, 12(t0) # achknowledge that we interupt just
	
	# check Key 0, if not press move to KEY1
	andi t2, t1, 0x1
	beq t2, zero, KEY1
	
	la t3, RUN
	lw t4, 0(t3)
	xori t4, t4, 1 # toggle on and off
	sw t4, 0(t3)
	j return
	

KEY1: # increase rate by 2 => divide frequency by 2
	# check Key 1, if not press move to KEY2
	andi t2, t1, 0x2
	beq t2, zero, KEY2
	
	li t3, TIMER
	
	# read the speed of the current clock
	lw t4, 8(t3) # low 16bits
	lw t5, 12(t3) # high 16 bits
	slli t5, t5, 16
	or t4, t4, t5
	
	srli t4, t4, 1
	
	srli t0, t4, 16 # load to high speed
	sw t2, 8(t3) # load into period1
	sw t0, 12(t3)
	
	# restart timer
	li t4, 0b111
	sw t4, 4(t3)
	
	
	j return
	

KEY2: # reduce rate by 2
	andi t2, t1, 0x4
	beq t2, zero, return
	
	li t3, TIMER
	
	# read the speed of the current clock
	lw t4, 8(t3) # low 16bits
	lw t5, 12(t3) # high 16 bits
	slli t5, t5, 16
	or t4, t4, t5
	
	slli t4, t4, 1
	
	srli t0, t4, 16 # load to high speed
	sw t2, 8(t3) # load into period1
	sw t0, 12(t3)
	
	# restart timer
	li t4, 0b111
	sw t4, 4(t3)
	
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