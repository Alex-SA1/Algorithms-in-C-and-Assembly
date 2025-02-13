bits 32 ; indicatin to the processor that we are working with 32-bit instructions

; making the function tag available outside of the current file
global _fast_exponentiation

segment code use32 class=code:
    _fast_exponentiation:
        ; creating a stack frame for .asm program
        push ebp
        mov ebp, esp

        ; stack representation
        ; ebp, esp -> |caller ebp value|
        ; ebp + 4     |return address  |
        ; ebp + 8     |number          | <- first parameter of the function 
        ; ebp + 12    |power           | <- second parameter of the function
        ;             | C program data | 

        mov ebx, [ebp + 8]
        mov edi, [ebp + 12]

        ; the return value of the function should be found in eax (cdecl convention)
        xor eax, eax ; eax = 0
        ; if the result is too big (> 2 ^ 31 - 1, signed interpretation), we have to store it on edx:eax


        ; eax represents the result of the function (number ^ power, "^" - exponentiation )
        mov eax, 1

        cmp edi, 0 ;
        je .end_program ; if edi == 0 (power == 0) : result = 1, and we jump to end of the program because we have the result computed

    .divide:    
        test edi, 1b ; edi & 1 (if edi & 1 == 0: edi even else edi odd)
        jz .continue ; if power is even we continue dividing without updating the final result

        ; edi & 1 = 1 => edi odd
        ; we have to update the final result with eax * ebx

        mul ebx ; edx:eax = eax * ebx

    .continue:
        push eax
        push edx
        ; we save the values from edx and eax to use these registers for another multiplication

        ; ebx = ebx * ebx
        mov eax, ebx
        mov edx, 0
        mul ebx ; edx:eax = eax * ebx = ebx * ebx

        mov ebx, eax

        ; restoring the values of registers
        pop edx
        pop eax

        shr edi, 1 ; edi >> 1 = edi / 2

        cmp edi, dword 0
        jne .divide


    .end_program:

        ; restoration of the stack frame
        mov esp, ebp
        pop ebp

        ; going to the return address
        ret

