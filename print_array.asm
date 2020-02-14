# print_array.asm program
# CS 64, Z.Matni, zmatni@ucsb.edu
#
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.data
	# TODO: Write your initializations here
	arr: .word 1 2 3 4 5 6 7 8 9 10
	len: .word 10
	newline: .asciiz "\n"
	content: .asciiz "The contents of the array are:\n"

.text
printA:
	bge $t0, $t1, exit # if !(x < array length) = if (x >= array length)

	sll $t3, $t0, 2
	add $t4, $t3, $t2
	lw $t5, 0($t4)

	# print element at current index
	li $v0, 1
	move $a0, $t5
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	addi $t0, $t0, 1 # increment index

	j printA # restart loop

main:
	li $t0, 0 # index
	la $t3, len
	lw $t1, 0($t3)
	la $t2, arr

	# print
	li $v0, 4
	la $a0, content
	syscall

	j printA

exit:
	li $v0, 10
	syscall