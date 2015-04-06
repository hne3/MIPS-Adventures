.data
getN:
.asciiz "\Please insert the number of integers in your list.\n"
getList:
.asciiz "\Please enter your sorted list one number at a time.\n"
getSearchInput:
.asciiz "\What value would you like to search for?\n"
noMatch:
.asciiz "\No match.\n"

.text
main:
la $a0, getN # Asks user for number of integers.
li $v0, 4
syscall

li $v0, 5
syscall # Receives number of integers

add $t0, $v0, $zero # Stores number of integers in t0.

sll $a0, $t0, 2
li $v0, 9
syscall # Allocates appropriate amount of heap space to store array.

move $t1, $v0 # Stores address of start of array in t1

la $a0, getList
li $v0, 4
syscall # Asks for elements in array.

addi $t2, $zero, 1 # Initializes counter for ArrayLoop in t2

ArrayLoop:
li $v0, 5
syscall # Reads an integer from console.

beq $t2, $zero, Left # Condition for leftmost number.
beq $t2, $t0, Right # Condition for rightmost number.

sw $v0, ($t1) # Adds input number to array.
addi $t1, $t1, 4 # Increments pointer

addi $t2, $t2, 1 # Increments counter
j ArrayLoop

Left: # Stores leftmost value in t6.
add $t6, $v0, $zero
addi $t2, $t2, 1
j ArrayLoop

Right: # Stores rightmost value in t7.
add $t7, $v0, $zero
j Exit

Exit:

la $a0, getSearchInput # Asks user for value to search for.
li $v0, 4
syscall

add $t4, $v0, $zero # Stores search value in t4.

BinarySearch:

bgt $t6, $t7, NoMatch # If left > right, no match.

addi $sp, $sp, -8 # Adjusts stack pointer.
sw $ra, 4($sp) # Saves $sp return address.

# mid = 1/2 (left + right):
add $t8, $t6, $t7 # t8 = left + right
addi $t9, $zero, 2 # t9 = 2
div $t8, $t8, $t9 # t8 = t8 / 2
# mid is now stored in t8

# if t4 equal to t1[mid], return mid:

# else:

Else:

# if t1[mid] > t4
# BinarySearch(t1, t4, t6, mid - 1)

# if t1[mid] < t4
# BinarySearch(t1, t4, mid + 1, t7)

NoMatch:

la $a0, noMatch # Tells user that there is no match.
li $v0, 4
syscall

Return:
# return mid
