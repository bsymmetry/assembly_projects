; Simple example demonstarting basic stack operations

; Reverse a list of numbers - in place.
; Method; Put each number on stack, then pop each number
; back off, andthen put back into memory.

;********************************************************************
; Data declarations

section .data

; ----
; Define constants

EXIT_SUCCESS equ 0
SYS_exit     equ 60

; ----
; Define data

numbers      dq  121, 122, 123, 124, 125
len          dq  5

;********************************************************************
section .text
global _start
_start:

; Loop to put numbers on the stack

  mov rcx, qword [len]
  mov rbx, numbers
  mov r12, 0
  mov rax, 0

pushLoop:
  push qword [rbx+r12*8]
  inc r12
  loop pushLoop

; ----
; All the numbers are on the stack (in reverse order)
; Loop to get them back off and put them back into original list

  mov rcx, qword [le]
  mov rbx, numbers
  mov r12, 0

popLoop:
  pop rax
  mov qword [rbx+12*8], rax
  inc r12
  loop popLoop

; ----
; Done, terminate

last:
   mov rax, SYS_exit
   mov rdi, EXIT_SUCCESS
   syscall
