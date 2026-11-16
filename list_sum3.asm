; program to find the minimum, middle value, maximum, sum
; and integer average of a list of numbers.

; Additionally, the program will find the minimum, middle value,
; maximum, sum and integer average for the negative numbers
; in the list

;Finally, the program will find the minimum, middle value, 
; maximum, sum, and integer average for numbers evenly divisible
; by 3

; the middle value for odd number of elements is the middle value
; the middle value for an even number of elements is the integer
; average between the two middle values

; *******************************************************************

; Data declarations
section .data
; ----
; Define constants

EXIT_SUCCESS equ 0                    ; successful operation
SYS_exit     equ 60                   ; call code for termination

; ----
; Define Data

section .data
   lst1      dd  234, 5643, 768, 905
   lst3      dd  0, 0, 0, 0
   len       dd  4
   middle    dd  0
   middle3   dd  0

; *******************************************************************
section .text
global _start
_start:
   mov eax, dword [len]
   mov edx, 0
   mov ebx, 2
   div ebx
   cmp edx, 0
   je evenLen
   mov r8d, dword [lst1+(rax-1)*4]
   mov dword [middle], r8d
   jmp middle3Calc

evenLen:
   mov rsi, rax
   mov eax, dword [lst1+(rsi-1)*4]
   add eax, dword [lst1+rsi*4]
   mov edx, 0
   div ebx
   mov dword [middle], eax

; so I can initialize a list to the same length as lst1
; then keep a counter to count the number of elements added to that list
middle3Calc:
   mov rsi, 0            ; counter to keep track of elements in lst3
   mov ecx, dword [len]  ; counter for Loop3
   mov ebx, 3                  ; divisor for divide in loop
  
Loop3:
   mov eax, dword [lst1+rsi*4] ; load element from lst1
   mov edx, 0
   div ebx
   cmp edx, 0
   jne Next 
   mov r8d, dword [lst1+rsi*4]
   mov dword [lst3+rsi*4], r8d
   inc rsi
Next:
   loop Loop3

middle3Mid:
   mov rax, rsi 
   mov edx, 0
   mov ebx, 2
   div ebx
   cmp edx, 0
   je middle3EvenLen
   mov r8d, dword [lst3+eax*4]
   mov dword [middle3], r8d
   jmp End

middle3EvenLen:
   mov rsi, rax
   mov eax, dword [lst3+rsi*4]
   add eax, dword [lst3+(rsi+1)*4]
   mov edx, 0
   div ebx
   mov dword [middle3], eax

; ----
; terminate

End:
   mov rax, SYS_exit
   mov rdi, EXIT_SUCCESS
   syscall  
