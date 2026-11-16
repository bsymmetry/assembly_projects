; Command Line Arguments Example
; ---------------------------------------------------------

section .data

; ----
; Define standard constants

LF equ 10
NULL equ 0
TRUE equ 1
FALSE equ 0
EXIT_SUCCESS

STDIN equ 0
STDOUT equ 1
STDERR equ 2

SYS_read equ 0
SYS_write equ 1
SYS_open equ 2
SYS_close equ 3
SYS_fork equ 57
SYS_exit equ 60
SYS_creat equ 85
SYS_time equ 201

; ----
; Variables for main

newLine db LF, NULL

; ---------------------------------------------------------

section .text
global main
main:

; ----
; Get command line arguments and echo to screen
; Based on the standard calling convention.
; rdi = argc
; rsi = argv

  mov r12, rdi
  mov r13, rsi

; ----
; Simple loop to display each argument to the screen.
; Each argument is a NULL terminated string, so can just
; print directly

printArguments:
  mov rdi, newLine
  call printString

  mov rbx, 0
printLoop:
  mov rdi, qword[r13+rbx*8]
  call printString

  inc rbx
  cmp rbx, r12
  jl printLoop

; ----
; Example program done

exampleDone:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall

; printString is same as in other asm examples
