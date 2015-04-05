.data
getN:
.asciiz "\Please insert the number of integers in your list.\n"
getList:
.asciiz "\Please enter your sorted list one number at a time.\n"
getSearchInput:
.asciiz "What value would you like to search for?\n"
confirmation:
.asciiz "Okay, searching.\n"

.text
main:
la $a0, getN # Asks user for number of integers.
li $v0, 4
syscall
li $v0, 5
syscall # Receives number of integers
add $t0, $v0, $zero
la $a0, getList
li $v0, 4
syscall # Asks for elements in array, one at a time.
add $s0, $zero, $zero # Initializes counter for ArrayLoop.
ArrayLoop:
li $v0, 5
syscall
add $t1, $v0, $zero # Adds input number to array. TO EDIT: needs to store each integer in a different location.
addi $s0, $s0, 1 # Increments counter
bne $s0, $t0, ArrayLoop # Loops until finished