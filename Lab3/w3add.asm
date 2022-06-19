# Lab 3 CS10 w3add.asm 
# Short program to demonstrate MIPS arithmetic
# 
	.text
main:
	li	$t0, 2000000000           # Load 45 into register $t0
	li	$t1, 2000000000           # Load 11 into register $t1
	addu	$a0, $t0, $t1	# Do $a0 = $t0 + $t1
				# Ask the system to print an integer
	li	$v0, 1            # 1 means the print_int syscall
	syscall
				# Now tell the system to stop
	li	$v0, 10           # 10 means the exit syscall
	syscall
