# CS10 Lab 2
# Program to demonstrate a basic hello world program with additional
# information print out in MIPS.
# Development Environment:  MARS MIPS Simulator
# Name:  Yinan Qiao Foothill
# Solution File: yinanQiaoLab2.asm
# Date:  10/05/20
# Registers Used:
# $a0 : holds address of hello_msg，my_name，my_fhID，
# syllabus_detail1,syllabus_detail2,syllabus_detail3
# $v0 : holds addr sycalls

	.data
hello_msg:	        .asciiz	"Hello World!\n"
my_name:		.asciiz "Qiao\n"
my_fhID:		.asciiz "20383477\n"
syllabus_detail1:	.asciiz "Weekly topic material is released on Mondays at 8:00 AM\n"
syllabus_detail2:	.asciiz "There will be a one hour midterm exam on Tuesday of the 6th week\n"
syllabus_detail3:	.asciiz "The final is a two hour timed exam\n"

	.text
main:

         la $a0, hello_msg # load the addr of hello_msg into $a0.
   	 li $v0, 4         # 4 is the print_string syscall.
         syscall           # do the syscall.

	 la $a0, my_name # load the addr of my_name into $a0.
	 li $v0, 4         # 4 is the print_string syscall.
	 syscall           # do the syscall.

	 la $a0, my_fhID # load the addr of my_fhID into $a0.
	 li $v0, 4         # 4 is the print_string syscall.
	 syscall           # do the syscall.

	 la $a0, syllabus_detail1 # load the addr of syllabus_detail1 into $a0.
	 li $v0, 4         # 4 is the print_string syscall.
	 syscall           # do the syscall.

	 la $a0, syllabus_detail2 # load the addr of syllabus_detail2 into $a0.
	 li $v0, 4         # 4 is the print_string syscall.
	 syscall           # do the syscall.

	 la $a0, syllabus_detail3 # load the addr of syllabus_detail3 into $a0.
	 li $v0, 4         # 4 is the print_string syscall.
	 syscall           # do the syscall.

   li $v0, 10        # 10 is the exit syscall.
   syscall           # do the syscall
