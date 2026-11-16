; Example program to demonstrate console input
; This example will send some messages to the screen
; *******************************************************************

section .data

; ----
; Define standard constants

LF           equ     10
NULL         equ     0

TRUE         equ     1
FALSE        equ     0

EXIT_SUCCESS equ     0

STDIN        equ     0
STDOUT       equ     1
STDERR       equ     2

SYS_read     equ     0
SYS_write    equ     1
SYS_open     equ     2
SYS_close    equ     3
SYS_fork     equ     57
SYS_exit     equ     60
SYS_creat    equ     85
SYS_time     equ     201

; ----
; Define some strings

STRLEN       equ     50

prmpt        db      "Enter Text: ", NULL
newLine      db      LF, NULL

section .bss
chr          resb    1
inLine       resb    STRLEN+2

; *******************************************************************

section .text
global _start
_start:

; ----
; Display prompt

   mov  rdi, prmpt
   call printString

; ----
; Read characters from user (one at a time)

   mov  rbx, inLine
   mov  r12, 0                                   ; char count
readCharacters:
   mov  rax, SYS_read
   mov  rdi, STDIN
   lea  rsi, byte [chr]
   mov  rdx, 1                                   ; count (how many to read)
   syscall

   mov  al, byte [chr]                           ; get char just read
   cmp  al, LF                                   ; if linefeed, input done
   je   readDone

   inc  r12                                      ; count++
   cmp  r12, STRLEN                              ; if # of char >= STRLEN
   jae  readCharacters                           ;  stop placing in buffer

   mov  byte [rbx], al                           ; inLine[i] = chr
   inc  rbx                                      ; update tmpStr addr

   jmp  readCharacters
readDone:
   mov  byte [rbx], NULL                         ; add NULL termination

; ----
; Output the line to verify successful read

   mov   rdi, inLine
   call  printString

; ----
; Example done

exampleDone:
    mov  rax, SYS_exit
    mov  rdi, EXIT_SUCCESS
    syscall

; *******************************************************************
; Generic procedure to display a string to the screen
; String must be NULL terminated
; Algorithm:
;  Count characters in string (excluding NULL)
;  Use syscall to output characters

; Arguments: 1) address, string
; Returns: nothing

global printString
printSTring:
   push  rbx

; ----
; Count characters in string

   mov   rbx, rdi
   mov   rdx, 0

strCountLoop:
   cmp  byte [rbx], NULL
   je   strCountDone
   inc  rdx
   inc  rbx
   jmp  strCountLopp
StrCountDone:

   cmp  rdx, 0
   je   prtDone

; ----
; Call OS to output string

   mov  rax, SYS_write
   mov  rsi, rdi
   mov  rdi, STDOUT
   syscall

; ----
; String printed, return to calling routine

prtDone:
   pop   rbx
   ret

