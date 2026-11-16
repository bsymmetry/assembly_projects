     1                                 %line 1+1 int_selection_sort.asm
     2                                 
     3                                 
     4                                 
     5                                 
     6                                 
     7                                 
     8                                 
     9                                 [section .data]
    10                                 
    11                                 
    12                                 
    13                                 LF equ 10
    14                                 NULL equ 0
    15                                 TRUE equ 1
    16                                 FALSE equ 0
    17                                 EXIT_SUCCESS equ 0
    18                                 
    19                                 STDIN equ 0
    20                                 STDOUT equ 1
    21                                 STDERR equ 2
    22                                 
    23                                 SYS_read equ 0
    24                                 SYS_write equ 1
    25                                 SYS_open equ 2
    26                                 SYS_close equ 3
    27                                 SYS_fork equ 57
    28                                 SYS_exit equ 60
    29                                 SYS_creat equ 85
    30                                 SYS_time equ 201
    31                                 
    32                                 
    33                                 
    34                                 
    35 00000000 0A00                   newLine db LF, NULL
    36                                 
    37                                 
    38                                 
    39                                 [section .text]
    40                                 [global main]
    41                                 [extern printString]
    42                                 [extern signed_str_to_int]
    43                                 [extern selection_sort]
    44                                 main:
    45                                 
    46                                 
    47                                 
    48                                 
    49                                 
    50                                 
    51                                 
    52 00000000 4989FC                  mov r12, rdi
    53 00000003 4989F5                  mov r13, rsi
    54 00000006 4C29E4                  sub rsp, r12
    55                                 
    56                                 
    57                                 
    58                                 
    59                                 
    60                                 
    61                                 str_to_intArgs:
    62                                 
    63 00000009 48C7C300000000          mov rbx, 0
    64                                 intLoop:
    65 00000010 498B7CDD00              mov rdi, qword[r13+rbx*8]
    66 00000015 E8(F6FFFFFF)            call signed_str_to_int
    67 0000001A 488904DC                mov qword[rsp+rbx*8], rax
    68                                 
    69 0000001E 48FFC3                  inc rbx
    70 00000021 4C39E3                  cmp rbx, r12
    71 00000024 7CE8                    jl intLoop
    72                                 
    73                                 sortInts:
    74                                 
    75 00000026 4889E7                  mov rdi, rsp
    76 00000029 4C89E6                  mov rsi, r12
    77 0000002C E8(F6FFFFFF)            call selection_sort
    78                                 
    79                                 printInts:
    80 00000031 48C7C7[00000000]        mov rdi, newLine
    81 00000038 E8(F6FFFFFF)            call printString
    82                                 
    83 0000003D 48C7C300000000          mov rbx, 0
    84                                 printLoop:
    85 00000044 488B3CDC                mov rdi, qword[rsp+rbx*8]
    86 00000048 E8(F6FFFFFF)            call printString
    87                                 
    88 0000004D 48FFC3                  inc rbx
    89 00000050 4C39E3                  cmp rbx, r12
    90 00000053 7CED                    jl printLoop
    91                                 
    92                                 
    93                                 
    94                                 
    95                                 end:
    96 00000055 48C7C03C000000          mov rax, SYS_exit
    97 0000005C 48C7C700000000          mov rdi, EXIT_SUCCESS
    98 00000063 0F05                    syscall
    99                                 
   100                                 
   101                                 
