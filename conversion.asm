# conversion.asm program
# CS 64, Z.Matni, zmatni@ucsb.edu
#
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.text
conv:
	addiu $sp, $sp, -4 # save return address
	sw $ra, 0($sp)

	move $s2, $a0 # x
	move $s3, $a1 # y

	li $s4, 0 # z
	li $t0, 0 # counter
	li $t1, 5 # compare
	j loop
	
loop:
	beq $t0, $t1, return # if !(i < 5), exit for loop

	# for loop body
	addi $t0, $t0, 1 # increment counter
	
	sll $t2, $s2, 1 # 2*x
	add $s4, $s4, $t2 # z + 2*x
	sub $s4, $s4, $s3 # z - 2*x - y

	j if # go to if loop

return:
	move $v0, $s4 # return value

	sw $ra, 0($sp)
	addiu $sp, $sp, 4

	jr $ra # return to main

if:
	li $t3, 3 # compare
	blt $s2, $t3, end_if # if !(x >= 3), exit if loop
	addi $s3, $s3, -1 # y -= 1

	j end_if # exit if loop

end_if:
	addi $s2, $s2, 1 # x += 1
	j loop # restart loop

main:
	li $a0, 5 # a
	li $a1, 7 # b
	jal conv

	# print
	move $a0, $v0 # c
	li $v0, 1
	syscall

exit:
	li $v0, 10
	syscall
