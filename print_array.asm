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
	li $t0, 0 # index
	la $s0, arr # get base of array

for:
	bge $t0, $a1, end # if !(x < array length) = if (x >= array length)

	# print element at current index
	li $v0, 1
	lw $a0, 0($s0)
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	addiu $s0, $s0, 4
	addiu $t0, $t0, 1 # increment index

	j for # restart for loop

end:
	jr $ra

main:
	la $s1, len # address of array length
	lw $a1, 0($s1) # value array length

	# print
	li $v0, 4
	la $a0, content
	syscall

	addiu $sp, $sp, -4
	sw $ra, 0($sp)

	jal printA

exit:
	li $v0, 10
	syscall