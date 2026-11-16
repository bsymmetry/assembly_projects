bubbleSort(int*):
        push    rbp
        mov     rbp, rsp
        mov     QWORD PTR [rbp-40], rdi
        mov     DWORD PTR [rbp-16], 8
        mov     eax, DWORD PTR [rbp-16]
        sub     eax, 1
        mov     DWORD PTR [rbp-4], eax
        jmp     .L2
.L8:
        mov     BYTE PTR [rbp-5], 0
        mov     DWORD PTR [rbp-12], 0
        jmp     .L3
.L5:
        mov     eax, DWORD PTR [rbp-12]
        cdqe
        lea     rdx, [0+rax*4]
        mov     rax, QWORD PTR [rbp-40]
        add     rax, rdx
        mov     edx, DWORD PTR [rax]
        mov     eax, DWORD PTR [rbp-12]
        cdqe
        add     rax, 1
        lea     rcx, [0+rax*4]
        mov     rax, QWORD PTR [rbp-40]
        add     rax, rcx
        mov     eax, DWORD PTR [rax]
        cmp     edx, eax
        jle     .L4
        mov     eax, DWORD PTR [rbp-12]
        cdqe
        lea     rdx, [0+rax*4]
        mov     rax, QWORD PTR [rbp-40]
        add     rax, rdx
        mov     eax, DWORD PTR [rax]
        mov     DWORD PTR [rbp-20], eax
        mov     eax, DWORD PTR [rbp-12]
        cdqe
        add     rax, 1
        lea     rdx, [0+rax*4]
        mov     rax, QWORD PTR [rbp-40]
        add     rax, rdx
        mov     edx, DWORD PTR [rbp-12]
        movsx   rdx, edx
        lea     rcx, [0+rdx*4]
        mov     rdx, QWORD PTR [rbp-40]
        add     rdx, rcx
        mov     eax, DWORD PTR [rax]
        mov     DWORD PTR [rdx], eax
        mov     eax, DWORD PTR [rbp-12]
        cdqe
        add     rax, 1
        lea     rdx, [0+rax*4]
        mov     rax, QWORD PTR [rbp-40]
        add     rdx, rax
        mov     eax, DWORD PTR [rbp-20]
        mov     DWORD PTR [rdx], eax
        mov     BYTE PTR [rbp-5], 1
.L4:
        add     DWORD PTR [rbp-12], 1
.L3:
        mov     eax, DWORD PTR [rbp-12]
        cmp     eax, DWORD PTR [rbp-4]
        jl      .L5
        movzx   eax, BYTE PTR [rbp-5]
        test    eax, eax
        je      .L9
        sub     DWORD PTR [rbp-4], 1
.L2:
        cmp     DWORD PTR [rbp-4], 0
        jg      .L8
        jmp     .L1
.L9:
        nop
.L1:
        pop     rbp
        ret
