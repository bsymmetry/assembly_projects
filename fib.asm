; program to compute the nth fibonnaci number
; *******************************************************************
; Data Declarations

section .data

; ----
; Define constants

SUCCESS     equ 0                   ; Successful operation
SYS_exit    equ 60                  ; call code for termination

; Define Data

n           dd  10
fib         dq  0

; *******************************************************************

section .text

global _start
_start:

; ----
; compute the nth fibonnaci number
; Approach:
; while i <= n:
;    temp = fib1 + fib2
;    fib1 = fib2
;    fib2 = temp
;    i += 1

    ;mov rbx, 2                      ; i starts at 2 since fib1 and fib2 already set
    mov r8,  0                      ; fib1
    mov r9,  1                      ; fib2
    xor r10, r10                    ; temp
    mov ecx, dword [n]
    sub ecx, 2                      ; since fib1 and fib2 already set

fibLoop:
    mov r10, r8                     ; temp = fib1
    add r10, r9                     ; fib1 + fib2
    mov r8,  r9                     ; fib1 = fib2
    mov r9,  r10                    ; fib2 = temp
    ;inc rbx                         ; i++
    loop fibLoop

; ----
; done, terminate program

last:
    mov rax, SYS_exit              ; call code for exit
    mov rdi, SUCCESS               ; exit with success
    syscall
    


