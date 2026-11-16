; function to print a string to the screen

; *******************************************************************

section .data

; ----
; Define standard constants

LF            equ  10            ; line feed
NULL          equ  0             ; end of string
TRUE          equ  1
FALSE         equ  0

EXIT_SUCCESS  equ  0             ; success code

STDIN         equ  0             ; standard input
STDOUT        equ  1             ; standard output
STDERR        equ  2             ; standard error

SYS_read      equ  0             ; read
SYS_write     equ  1             ; write
SYS_open      equ  2             ; file open
SYS_close     equ  3             ; file close
SYS_exit      equ  60            ; terminate

; ----
; Define some strings

newLine       db   LF, NULL

; *******************************************************************
; Generic function to display a string to the screen
; String must be NULL terminated
; Algorithm:
;  Count characters in string (excluding NULL)
;  Use syscall to output characters

; Arguments:
; 1) address, string
; Returns: nothing

global printString
printString:
   push  rbx

; ----
; Count characters in string

   mov  rbx, rdi
   mov  rdx, 0
strCountLoop:
   cmp  byte [rbx], NULL
   je   strCountDone
   inc  rdx
   inc  rbx
   jmp  strCountLoop
strCountDone:

   cmp  rdx, 0
   je   prtDone

; ----
; Call OS to output string

   mov  rax, SYS_write
   mov  rsi, rdi                   ; addr of chars to write
   mov  rdi, STDOUT                ; RDX=count to write, set above
   syscall

; ----
; String printed, return to calling routine

prtDone:

   pop rbx
   ret
