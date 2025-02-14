bits 32 ; indicating to the processor that we are working with 32-bit instuctions

; making the function tag available outside of the current file
global _gcd

segment code use32 class=code:
    _gcd:
        ; creating a stack frame for .asm program
        push ebp
        mov ebp, esp

        ; stack representation
        ; ebp, esp -> |caller ebp value|
        ; ebp + 4     |return address  |
        ; ebp + 8     |a               | <- first parameter of the function 
        ; ebp + 12    |b               | <- second parameter of the function
        ;             | C program data |

        mov eax, [ebp + 8]
        mov ebx, [ebp + 12]

        ; the returned value of the function should be in eax
    
    .divide:
        mov edx, 0
        div ebx ; edx:eax / ebx => eax = edx:eax / ebx, edx = edx:eax % ebx

        mov eax, ebx ; a <- b
        mov ebx, edx ; b <- remainder

        cmp ebx, 0
        jne .divide ; if b != 0 the algorithm should continue
        
    .end_program:

        ; restoring the stack frame
        mov esp, ebp
        pop ebp

        ; going to return address
        ret