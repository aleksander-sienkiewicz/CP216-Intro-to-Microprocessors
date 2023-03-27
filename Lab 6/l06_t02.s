/*
-------------------------------------------------------
sub_read.s
Uses a subroutine to read strings from the UART into memory.
-------------------------------------------------------
Author:  David Brown
ID:      999999999
Email:   dbrown@wlu.ca
Date:    2020-12-14
-------------------------------------------------------
*/
// Constants
.equ SIZE, 20    	// Size of string buffer storage (bytes)
.text  // Code section
.org	0x1000	// Start at memory location 1000
.global _start
_start:

MOV    R5, #SIZE
LDR    R4, =First
BL	   ReadString
LDR    R4, =Second
BL	   ReadString
LDR    R4, =Third
BL     ReadString
LDR    R4, =Last
BL     ReadString
    
_stop:
B	_stop

// Subroutine constants
.equ UART_BASE, 0xff201000     // UART base address
.equ VALID, 0x8000	// Valid data in UART mask
.equ DATA, 0x00FF	// Actual data in UART mask
.equ ENTER, 0x0A	// End of line character

ReadString:
/*
-------------------------------------------------------
Reads an ENTER terminated string from the UART.
-------------------------------------------------------
Parameters:
  R4 - address of string buffer
  R5 - size of string buffer
Uses:
  R0 - holds character to print
  R1 - address of UART
-------------------------------------------------------
*/

// your code here
LDR  R1, =UART_BASE
ADD  R5, R4, #SIZE // store address of end of buffer
STMFD  SP!, {R0-R1, R4,R5, LR}//read drom uart

LOOP:
LDR  R0, [R1]  // read the UART data register
TST  R0, #VALID    // check if there is new data
BEQ  _ReadString    // if no data, return 0
cmp r0, #ENTER//see if "enter"
BEQ  _ReadString 
STRB R0, [R4]      // store the character in memory
ADD  R4, R4, #1    // move to next byte in storage buffer
CMP  R4, R5        // end program if buffer full
BEQ _ReadString
_ReadString:
LDMFD  SP!, {R0-R1, R4,R5, PC} //reset the values
B    LOOP

	
.data
.align
// The list of strings
First:
.space  SIZE
Second:
.space	SIZE
Third:
.space	SIZE
Last:
.space	SIZE
_Last:    // End of list address

//.end file 2 starts here

