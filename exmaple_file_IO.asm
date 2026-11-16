; Example program to demonstrate file I/O.  This example will open/create
; a file, write some information to the file, and close the file.  Note, the file name and write message are hard-coded for this example

section .data

; ----
; Define standard constants

LF   equ 10
NULL equ 0
TRUE equ 1
FALSE equ 0
EXIT_SUCCESS equ 0
STDIN equ 0
STDOUT equ 1
STDERR equ 2

SYS_read equ 0
SYS_write equ 1
SYS_open equ  2
SYS_close equ 3
SYS_fork equ 57
SYS_exit equ 60
SYS_creat equ 85
SYS_time equ 201

O_CREAT  equ 0x40
O_TRUNC equ 0x200
O_APPEND equ 0x400

O_RDONLY equ 000000q
O_WRONLY equ 000001q
O_RDWR   equ 000002q

S_IRUSR  equ 00400q
S_IWUSR  equ 00200q
S_IXUSR  equ 00100q

; ----
; Variables for main

newLine   db LF, NULL
header    db LF, "File Write Example."
          db LF, LF, NULL
fileName  db "url.txt", NULL
url       db "http://www.google.com"
          db LF, NULL
len       db $-url-1

writeDone db "Write Completed.", LF, NULL
fileDesc  dq 0
errMsgOpen db "Error Opening file.", LF, NULL
errMsgWrite db "Error Writing to file.", LF, NULL

; *******************************************************************

section .text
global _start
_start:

; ----
; Display header line
  mov rdi, header
  call printString

; ----
; Attempt to open file
; Use system service to open file

; System Service - Open/Create
;  rax = SYS_create (file open/create)
;  rdi = address of file name string
;  rsi = attributes (i.e., read only etc.)

; Returns:
;  if error -> eax < 0
;  if success -> eax = file descriptor number

; The file descriptor points to the File Control Block (FCB)
; The FCB is maintained by the OS.  The file descriptor is used for all 
; subsequent file operations
openInputFile:
  mov rax, SYS_creat
  mov rdi, fileName
  mov rsi, S_IRUSR | S_IWUSR  ; allow read write
  syscall

  cmp rax, 0
  jl  errorOnOpen

  mov qword [fileDesc], rax     ; save descriptor
; ----
; Write to file
; In this example, the characters to write are in a predefined
; string containing an URL

; System service - write
;  rax  SYS_write
;  rdi = file descriptor
;  rsi = address of characters to write
;  rdx = count of characters to write
; Returns;
; if error -> rax < 0
; if success -> rax = count of characters actually read

  mov rax, SYS_write
  mov rdi, qword [fileDesc]
  mov rsi, url
  mov rdx, qword [len]
  syscall

  cmp rax, 0
  jl  errorOnWrite

  mov rdi, writeDone
  call printString

; ----
;Close the file
; System Service - close
;  rax = SYS_close
;  rdi = file descriptor

  mov rax, SYS_close
  mov rdi, qword [fileDesc]
  syscall

  jmp exampleDone

; ---
; Error on open
; note, rax contains an error code which is not used
;  for this example 

errorOnOpen:
  mov  rdi, errMsgOpen
  call print String

  jmp  exampleDone

; ----
; Error on write
; note, rax contains an error code which, not used here

errorOnWrite:
  mov rdi, errMsgWrite
  call printString

  jmp exampleDone

; ----
; Example program done

exampleDone:
  mov, rax, SYS_exit
  mov, rdi, EXIT_SUCCESS
  syscall

; same printString function code below as in hello_world.asm
