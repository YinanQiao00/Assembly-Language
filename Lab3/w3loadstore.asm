# Lab 3 CS10 w3loadstore.asm 
# Short program to demonstrate MIPS load/store instructions
#
	.data
num1:	.word	7		# Store 7 as a word into num1 location
num2:	.word	6		# num2 = 6
num3:	.half	-10		# Store -10 into 16-bit location num3
num4:	.half	3		# num4 = 3
num5:	.byte	64		# num5 is only 1 byte long
num6:	.byte	1

#
# Perform the command num1 = num1 * num2 + num3
#

	.text
main:
	lw	 $t0, num1        # $t0 = num1
	lw	 $t1, num2        # $t0 = num2
	lh	 $t2, num3        # $t2 = num3
	mulo $t3, $t0, $t1	  # $t3 = $t0 + $t1, i.e. 7 * 6 = 42
	add	 $t3, $t3, $t2	  # $t3 = $t3 + $t2, i.e. 42 + -10 = 32
	sw	 $t3, num1        # num1 = $t3

                          # Now print out the result
	move $a0, $t3
	li	$v0, 1            # 1 means the print_int syscall
	syscall
                          # Now tell the system to stop
	li	$v0, 10           # 10 means the exit syscall
	syscall
