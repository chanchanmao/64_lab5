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
	content: .asciiz "The contents of the array are: \n"

.text
printA:
    # TODO: Write your function code here
	la $t1, len # get address of array length
	lw $t2, 0($t1) # store value of array length

	bge $t0, $t2, exit # if !(x < array length) = if (x >= array length)

	la $t4, arr # else...
	sll $t5, $t0, 2
	add $t6, $t5, $t4
	lw $t7, 0($t6)

	# print element at current index
	li $v0, 1
	move $a0, $t7
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	addi $t0, $t0, 1 # increment index

	j printA # restart loop

main:
	# TODO: Write your main function code here
	li $t0, 0

	li $v0, 4
	la $a0, content
	syscall

	j printA

exit:
	li $v0, 10
	syscall