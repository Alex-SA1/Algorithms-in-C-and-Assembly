bits 32 ; indicating to the processor that we are working with 32-bit instructions

; making the function tag available outside of the current file
global _binary_search

segment code use32 class=code: 
    _binary_search:
        ; creating a stack frame for .asm program
        push ebp
        mov ebp, esp

        ; stack representation
        ; ebp, esp -> |caller ebp value|
        ; ebp + 4     |return address  |
        ; ebp + 8     |length          | <- first parameter of the function 
        ; ebp + 12    |array           | <- second parameter of the function
        ; ebp + 16    | x              | <- third parameter of the function
        ;             | C program data | 

        mov ecx, [ebp + 8]
        mov esi, [ebp + 12]
        mov edx, [ebp + 16]

        ; the return value of the function should be found in eax (cdecl convention)
        xor eax, eax ; eax = 0

        ; if length of the array is equal with zero we jump to the end of the function
        jecxz .end_program

        cmp edx, [esi]
        jl .end_program ; if edx < [esi] (x < array[0]): x is not in the array

        je .found_in_array ; if edx == [esi] (x == array[0]): x is in the array

        mov edi, ecx ; edi = length of the array
        dec edi ; edi = length - 1

        cmp edx, [esi + edi * 4] 
        jg .end_program ; if edx > [esi + edi * 4] (x > array[length - 1]): x is not in the array

        ; ebx = left position of the current sequence
        mov ebx, 0

        ; ecx = right position of the current sequence

    .search:
        ; edi register will store mid position of the current sequence
        cmp ebx, ecx
        jg .end_program ; ebx > ecx (st > dr)

        mov edi, 0

        add edi, ebx
        add edi, ecx
        shr edi, 1 ; edi >> 1 = edi / 2

        cmp edx, [esi + edi*4]
        je .found_in_array

        jl .search_in_left ; edx < [esi + edi * 4] (x < array[mid])

    .search_in_right:
        mov ebx, edi
        jmp .search

    .search_in_left:
        mov ecx, edi
        jmp .search

    .found_in_array:
        mov eax, 1

    .end_program:

        ; restoration of stack frame
        mov esp, ebp
        pop ebp

        ; going to return address
        ret