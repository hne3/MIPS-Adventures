.data
getN:
.asciiz "\Please insert the number of integers in your list.\n"
getList:
.asciiz "\Please enter your sorted list one number at a time.\n"
getSearchInput:
.asciiz "\What value would you like to search for?\n"

.text
main:

# s0 : number of integers n
# s1 : address of array
# t2 : counter of array loop
# t1 : temporary for loop

la $a0, getN # Asks user for number of integers.
li $v0, 4
syscall

li $v0, 5
syscall # Receives number of integers

add $s0, $v0, $zero # Stores number of integers in t0.

sll $a0, $t0, 2
li $v0, 9
syscall # Allocates appropriate amount of heap space to store array.

move $s1, $v0 # Stores address of start of array in t1

la $a0, getList
li $v0, 4
syscall # Asks for elements in array.

addi $t2, $zero, 0 # Initializes counter for ArrayLoop in t2
move $t1, $s1  # So that we can index at zero.

ArrayLoop:
# Counter is t2, array[i] in t1.
bge $t2, $s0, SearchConditions # Branches if array is complete.

li $v0, 5
syscall # Reads an integer from console.

sw $v0, ($t1) # Adds input number to array.
addi $t1, $t1, 4 # Increments pointer

addi $t2, $t2, 1 # Increments counter
j ArrayLoop

SearchConditions:
la $a0, getSearchInput # Asks user for integer to search for.
li $v0, 4
syscall

li $v0, 5
syscall # Receives search value
add $a1, $v0, $zero # Stores search value in a1

move $a0, $s1 # Moves start address of array to a0.
move $a2, $zero
add $a3, $s0, $zero # Moves counter to right

jal BinarySearch
#sll $v0, $v0, 2 # divides v0 by 2
move $a0, $v0 # prints value of v0
li $v0, 1
syscall
# print value in $v0
j SuperExit

# a0 : array
# a1 : value
# a2 : left
# a3 : right
# t0 : mid
# t1 : a[mid]

BinarySearch:

addi $sp, $sp, -4 # Makes room for 3 items on the stack.
sw $ra, 0($sp) # Stores return address.

blt $a3, $a2, NoMatch # if right < left, return -1

# mid = (left + right) / 2
add $t0, $a2, $a3
sra $t0, $t0, 1 # Divides by 2.

sll $t0, $t0, 2 # multiplies mid by 4
add $t1, $a0, $t0 # address of a[mid]
lw $t1, 0($t1) # loads value of a[mid]


beq $t1, $a1, Exit # if a[mid] = value, return mid
blt $a1, $t1, LessThan
j GreaterThan

NoMatch:
addi $v0, $zero, -1
lw $ra, 0($sp) # Pops return address from the stack
addi $sp, $sp, 4 # Move stack pointer back up
jr $ra # Returns

Exit:
move $v0, $t1
lw $ra, 0($sp) # Pops return address from the stack
addi $sp, $sp, 4 # Move stack pointer back up
jr $ra # Returns

LessThan:
addi $a3, $t0, -1 # Stores mid - 1 in right.
jal BinarySearch

GreaterThan:

addi $a2, $t0, 1 # Stores mid - 1 in right.
jal BinarySearch

SuperExit:
j SuperExit