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
	addiu $sp, $sp, -4
	sw $ra, 0($sp)

	li $s0, 0 # index

	j print

print:
	bge $s0, $a1, end # if !(x < array length) = if (x >= array length)

	sll $s1, $s0, 2
	add $t4, $s1, $a2
	lw $t5, 0($t4)

	# print element at current index
	li $v0, 1
	move $a0, $t5
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	addi $s0, $s0, 1 # increment index

	j print # restart loop

end:
	sw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra

main:
	la $s1, len
	lw $a1, 0($s1)
	la $a2, arr

	# print
	li $v0, 4
	la $a0, content
	syscall

	jal printA

exit:
	li $v0, 10
	syscall