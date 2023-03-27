/*
-------------------------------------------------------
l05_t03.s
A simple list demo program. Traverses all elements of an integer list.
R0: temp storage of value in list
R2: address of start of list
R3: address of end of list
-------------------------------------------------------
Author:  Aleksander Sienkiewicz
ID:      210222490
Email:   sien2490@mylaurier.ca
Date:    2023-03-04
-------------------------------------------------------
*/
.org	0x1000	// Start at memory location 1000
.text  // Code section
.global _start
_start:

LDR    R2, =Data    // Store address of start of list
LDR    R3, =_Data   // Store address of end of list

LDR R6, [R2]//ESTABLISH MIN

LDR R7, [R2]//MAX VALUE

Loop:
LDR    R0, [R2], #4	// Read address with post-increment (R0 = *R2, R2 += 4)
//ALGORITHM
//IF SMALLER
CMP R0,R6//COMPARE CURRENT VALUE IN REGISTER TO MIN
MOVLT R6,R0//IF < THEN MIN UPDATES TO NEW MIN
//IF BIGGER
CMP R0, R7//COMPARE TO R7
MOVGT R7, R0//IF >THEN CURRENT VAL IS NEW MAX

CMP    R3, R2       // Compare current address with end of list
BNE    Loop         // If not at end, continue

_stop:
B	_stop

.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12    // The list of data
_Data:	// End of list address

.end