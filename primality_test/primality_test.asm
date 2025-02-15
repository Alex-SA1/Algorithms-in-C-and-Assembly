bits 32 ; indicating to the processor that we are working with 32-bit instructions

; making the function tag available outside of the current file
global _is_prime

segment code use32 class=code:
    _is_prime:
        ; creating a stack frame for .asm program
        push ebp
        mov ebp, esp

        ; stack representation
        ; ebp, esp -> |caller ebp value|
        ; ebp + 4     |return address  |
        ; ebp + 8     |x               | <- first parameter of the function 
        ;             | C program data | 

        ; the returned value of the function should be found in eax
        ; I will use eax to store the number for which we have to check the primality
        ; and at the end of the function I'll update the eax with the value 1 or 0 (wheter x is prime or not)

        mov eax, [ebp + 8] ; the number for which we have to check the primality

        cmp eax, dword 2
        jl .not_prime ; if eax < 2 then the number is not prime

        cmp eax, dword 2
        je .prime ;  if eax == 2 then the number is prime

        cmp eax, dword 3
        je .prime ; if eax == 3 then the number is prime

        mov ebx, 2
        xor edx, edx ; edx = 0

        div ebx ; edx:eax / ebx = edx:eax / 2 => eax = edx:eax / 2, edx = edx:eax % 2
        cmp edx, 0
        je .not_prime ; if eax % 2 == 0 then the number is not prime (because is divisible by 2)

        mov eax, [ebp + 8] ; restoring the value of the parameter

        mov ebx, 3
        xor edx, edx ; edx = 0

        div ebx
        cmp edx, 0
        je .not_prime ; if eax % 3 == 0 then the number is not prime (because is divisible by 3)

        ; the current number to check if it is a divisor of the parameter number
        mov ebx, 5

    .check:
        ; checking if divisor * divisor <= number
        mov eax, ebx
        mul ebx ; edx:eax = eax * ebx <=> edx:eax = ebx * ebx <=> eax = ebx * ebx (the result will have enough space in eax)

        cmp eax, [ebp + 8]
        jg .prime ; if divisor * divisor > number then we didn't find any divisor for the number => number is prime

        mov eax, [ebp + 8] ; restoring the value of the paramter
        xor edx, edx ; edx = 0
        div ebx 
        cmp edx, 0
        je .not_prime

        mov eax, [ebp + 8]
        xor edx, edx
        add ebx, 2

        div ebx
        cmp edx, 0
        je .not_prime

        add ebx, 4

        jmp .check ; we try to find another divisor for the number

    .prime:
        mov eax, 1
        jmp .end_program

    .not_prime:
        mov eax, 0

    .end_program:
        ; restoring the stack frame
        mov esp, ebp
        pop ebp

        ; going to return address
        ret



        



        