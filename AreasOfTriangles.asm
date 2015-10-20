;Author information
;  Author name: Art Grichine
;  Author email: ArtGrichine@gmail.com
;Course information
;  Course number: CPSC240
;  Assignment number: 2
;  Due date: 2014-Feb-11
;Project information
;  Project title: Areas of Triangles (Assignment 2)
;  Purpose: Preform vector processing on four different triangles at once. User input sides of triangles; Output triangle area
;  Status: No known errors
;  Project files: AreasOfTriangles.cpp, AreasOfTriangles.asm, debug.inc, debug.asm
;Module information
;  This module's call name: AreasOfTriangles
;  Language: X86-64
;  Syntax: Intel
;  Date last modified: 2014-Feb-06
;  Purpose: Preform vector processing on four triangles at once. The calculation will find the area of each triangle
;  File name: AreasOfTriangles.asm
;  Status: In production.  No known errors.
;  Future enhancements: None planned
;Translator information
;  Assemble: nasm -f elf64 -l AreasOfTriangles.lis -o AreasOfTriangles.o AreasOfTriangles.asm
;References and credits
;  Professor Floyd Holliday/CSUF
;Print information
;  Page width: 132 columns
;  Begin comments: 65
;  Optimal print specification: Landscape, 9 points or smaller, monospace, 8Â1⁄2x11 paper
;
;===== Begin code area ============================================================================================================

%include "debug.inc" 					    ;This file contains the subprogram to be tested with this test program.

extern printf						    ;External C++ function for writing to standard output device

extern scanf						    ;External C++ function for obtaining user input

global AreasOfTriangles 				    ;This makes AreasOfTriangles callable by functions outside of this file.

segment .data						    ;Place initialized data here

;===== Message Declarations =======================================================================================================

welcome db 10, "Welcome to Triangles by Art Grichine!", 10,
        db     "This program was tested on a MacBook Pro (late 2013) running at 2.6GHz.", 10,
        db     "This program will compute the areas of four triangles using vector processing", 10, 0

enter_number_tri1 db 10, "Enter lengths of sides of the first triangle separated by white space: ", 0 
enter_number_tri2 db     "Enter lengths of sides of the second triangle separated by white space: ", 0 
enter_number_tri3 db     "Enter lengths of sides of the third triangle separated by white space: ", 0
enter_number_tri4 db     "Enter lengths of sides of the fourth triangle separated by white space: ", 0 

format_area_of_tri1 db 10, "The area of the first triangle is %5.20lf square units.", 10, 0
format_area_of_tri2 db     "The area of the second triangle is %5.20lf square units.", 10, 0
format_area_of_tri3 db     "The area of the third triangle is %5.20lf square units.", 10, 0
format_area_of_tri4 db     "The area of the fourth triangle is %5.20lf square units.", 10, 0
  
goodbye db 10, "Enjoy your triangles.", 10, 0 

stringformat db "%s", 0						;general string format

formatTwoFloats db "%lf %lf", 0					;lowercase l is for double (64-bit)

segment .bss							;Place un-initialized data here.

        ;This segment is empty

segment .text							;Place executable instructions in this segment.

AreasOfTriangles:						;Entry point.  Execution begins here.

;=========== Back up all the integer registers used in this program ===============================================================

push rbp 							;Backup the stack base pointer
push rdi 							;Backup the destination index
push rsi 							;Backup the source index
push rdx 
push rdx

;============  Preliminary ========================================================================================================

vzeroall							;zeros out all SSE registers
push qword 0							;create storage for an input number on int stack (8 total)
push qword 0							;create storage for an input number on int stack
push qword 0							;create storage for an input number on int stack
push qword 0							;create storage for an input number on int stack
push qword 0							;create storage for an input number on int stack
push qword 0							;create storage for an input number on int stack
push qword 0							;create storage for an input number on int stack
push qword 0							;create storage for an input number on int stack

;=========== Initialize divider register ==========================================================================================

mov rax, 0x4000000000000000 					;copy HEX 2.0 value onto rax
push rax							;push rax value onto the stack for broadcast operation
vbroadcastsd ymm9, [rsp]					;makes ymm all 2.0
pop rax								;push operand must be followed by a pop operation when complete

;=========== Show the initial message =============================================================================================

mov qword rax, 0
mov rdi, stringformat 						;simple format indicating string ' "%s",0 '
mov rsi, welcome 						;display: Welcome Message, Name, Machine, Purpose of Assignment 
call printf

;============ Input Triangle 1 ====================================================================================================

;==== Display message for Triangle 1 ====
mov qword rax, 0						;satisfies printf function, expects no float in upcoming printf
mov rdi, stringformat
mov rsi, enter_number_tri1 					;asks user to enter two numbers seperated by a space
call printf

;==== Grab data for Triangle 1 ====
xor rax, rax							;same as 'mov rax, 0'
mov rdi, formatTwoFloats 					;formats input of scanf to recieve two numbers "%lf %lf"
mov rsi, rsp							;assign register to copy stack pointer location to absorb tri 1 s1
mov rdx, rsp							;rdx also assigned to pointer to accomidate the second number
add rdx, 32							;rdx+32 puts it in the 5th position in the stack; side 1 for all
								;four triangles will go in stack rsp through rsp+28, rsp+32 through
								;rsp+56 will absorb the second side of all triangles
call scanf

;============ Input Triangle 2 ====================================================================================================

;==== Display message for Triangle 2 ====
mov qword rax, 0
mov rdi, stringformat
mov rsi, enter_number_tri2 
call printf

;==== Grab data for Triangle 2 ====
xor rax, rax							;same as 'mov rax, 0'
mov rdi, formatTwoFloats 					;format to absorb two numbers: "%lf %lf"
mov rsi, rsp							;set location of tri2 side1 to be at rsp+8 (next function)
add rsi, 8							;assign register to copy stack pointer location to absorb tri 2 s1
mov rdx, rsp							;set location of tri2 side2 to be at rsp+40 (next function)
add rdx, 40							;mov register to 5th position to absorb tri 2 side 2
call scanf

;============ Grab Triangle 3 =====================================================================================================

;==== Display message for Triangle 3 ====
mov qword rax, 0
mov rdi, stringformat
mov rsi, enter_number_tri3 
call printf

;==== Grab data for Triangle 3 ====
xor rax, rax							;same as 'mov rax, 0'
mov rdi, formatTwoFloats 					;format to absorb two numbers: "%lf %lf"
mov rsi, rsp							;set location of tri3 side1 to be at rsp+16 (next function)
add rsi, 16							;assign register to copy stack pointer location to absorb tri 3 s1
mov rdx, rsp							;set location of tri3 side2 to be at rsp+48 (next function)
add rdx, 48 							;mov register to 5th position to absorb tri 3 side 2
call scanf						

;============ Grab Triangle 4 =====================================================================================================

;==== Display message for Triangle 4 ====
mov qword rax, 0
mov rdi, stringformat
mov rsi, enter_number_tri4 
call printf

;==== Grab data for Triangle 4 ====
xor rax, rax							;same as 'mov rax, 0'
mov rdi, formatTwoFloats 					;format to absorb two numbers: "%lf %lf"
mov rsi, rsp							;set location of tri4 side1 to be at rsp+24 (next function)
add rsi, 24							;assign register to copy stack pointer location to absorb tri 4 s1
mov rdx, rsp							;set location of tri4 side2 to be at rsp+56 (next function)
add rdx, 56							;mov register to 5th position to absorb tri 4 side 2
call scanf

;============ Move int stack into ymm registers ===================================================================================

vmovupd ymm4, [rsp] 						;moves side 1 of triangles into ymm4 register, first 4 #'s in stack 
								;'p' lets us grab four locations starting at rsp
vmovupd ymm5, [rsp+32] 						;moves side 2 of triangles into ymm5 register, rsp+32 thru rsp+56 

;============ Calculate Area ======================================================================================================

vmovupd ymm6, ymm4 						;backup ymm4 register,upcoming calculation will override ymm4 value
vmulpd ymm4, ymm5 						;(ymm4 * ymm5) = result stores in ymm4
vdivpd ymm4, ymm9						;(ymm4 / ymm9 <- 2.0 constant) = result stores in ymm4

vmovupd ymm0, ymm4						;places calculated area from ymm4 into ymm0 for output (print)

;========== Output ================================================================================================================
;a note on output, the 'printf' function corrupts xmm 0 and xmm1 after being called. We must keep a back-up of our intended output
;so that we may bring it down before every new output. Also printf prints from the xmm0.0 registry, our triangle areas must find
;there way to xmm0.0 one by one:

;Output Triangle 1						;Tri 1 area located in xmm0 first position
mov rax, 1							
mov rdi, format_area_of_tri1 					;print area of tri1
push qword 0							;Allocate storage for output value
push qword 0							;memory failure without this extra push
call printf
pop rax								;undo previous memory allocation 
pop rax								;undo previous memory allocation 

;setup output for triangle 2					;we must swap the xmm0 registry to get Triangle 2
vmovupd ymm3, ymm4 						;printf is stupid and ruins xmm0/xmm1, we must use copy ymm4
vpermilpd ymm2, ymm3, 0x1B 					;swap, 0x1B gives us transformation 4321 --> 4322
vmovupd ymm0, ymm2						;copy our result after transformation into output location  ymm0

;Output Triangle 2
mov rax, 1
mov rdi, format_area_of_tri2 
push qword 0							;Allocate storage for output value
push qword 0							;memory failure without extra push
call printf
pop rax								;undo previous memory allocation
pop rax								;undo previous memory allocation

;setup output for triangle 3					;move from 4322 --> 2243
vextractf128 xmm1, ymm0, 1 					;shift of ymm into xmm, ABCC --> CCAB
vmovupd ymm0, ymm1						;copy values into output location 'ymm0'

;Output Triangle 3
mov rax, 1
mov rdi, format_area_of_tri3 
push qword 0							;Allocate storage for output value
push qword 0							;memory failure without extra push
call printf
pop rax								;undo previous memory allocation
pop rax								;undo previous memory allocation

;setup output for triangle 4/side1				;fresh copy used for triangle 4 from our back-up 'ymm4'
vextractf128 xmm3, ymm4, 1 					;4321 --> 0043
vpermilpd ymm2, ymm3, 0x1B 					;swap, 0x1B gives us transformation 0043 --> 0034, Tri4 is ready
vmovupd ymm0, ymm2						;copy the final triangle into the output location 'ymm0'

;Output Triangle 4
mov rax, 1
mov rdi, format_area_of_tri4 
;push qword 0							;Allocate storage for output value
;push qword 0							;memory failure without extra push
call printf
;pop rax								;undo previous memory allocation
;pop rax								;undo previous memory allocation

;========== Conclusion message ====================================================================================================

mov qword rax, 0
mov 	  rdi, stringformat
mov 	  rsi, goodbye 						;"Enjoy your triangles!" 
call 	  printf

;=========== Now cleanup and return to the caller =================================================================================

pop       rax							;Undo memory allocation form initial input of triangle sides
pop 	  rax	 						;Undo memory allocation form initial input of triangle sides
pop 	  rax							;Undo memory allocation form initial input of triangle sides
pop 	  rax  							;Undo memory allocation form initial input of triangle sides
pop 	  rax							;Undo memory allocation form initial input of triangle sides
pop 	  rax 							;Undo memory allocation form initial input of triangle sides
pop 	  rax							;Undo memory allocation form initial input of triangle sides
pop 	  rax 							;Undo memory allocation form initial input of triangle sides

pop 	  rdx 							;Restore original value
pop 	  rdx 							;Required or memory core dump
pop 	  rsi 							;Restore original value
pop 	  rdi 							;Restore original value
pop 	  rbp							;Restore original value

mov qword rax, 1						;Return value of 1 to the driver

ret
                                                               
;========== End of program AreasOfTriangles.asm====================================================================================
