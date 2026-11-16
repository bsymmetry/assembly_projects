; Simple example to get the sum and average for a list of numbers
; *******************************************************************
; Data declarations
section .data
; ----
; Define constants

EXIT_SUCCESS equ 0         ; successful operatoin
SYS_exit     equ 60        ; call code for termination

; ----
; Define Data

section .data
    lst      dd  1002, 1004, 1006, 1008, 10010
    len      dd  5
    sum      dd  0

; *******************************************************************
section .text
global _start
_start:

; ----
; Summation loop

    mov  ecx, dword [len]        ; get length value
    mov  rsi, 0                  ; index=0

sumLoop:
    mov  eax, dword [lst+rsi*4]  ; get lst[rsi]
    add  dword [sum], eax        ; update sum value
    inc  rsi                     ; next item in lst
    loop sumLoop

; ----
; Done, terminate

last:
    mov rax, SYS_exit           ; call code for exit
    mov rdi, EXIT_SUCCESS       ; exit with sucess
    syscall
