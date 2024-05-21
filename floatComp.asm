bits 32
section .bss
    align 4
    float_a: resd   1
    float_b: resd   1
    float_sum: resd 1

section .data
    format_cmp: db "%f is greater than %f", 10, 0
    format_cmp2: db "%f is less than %f", 10, 0
    format_eql: db "float numbers are equal", 10, 0
    format_sum: db "The sum of the two float numbers is %f", 10, 0
    format_a:   db "Enter first float number", 10, 0
    format_b:   db "Enter second float number", 10, 0
    format_read_float: db "%f", 0
    dummy: dd 1.34

section .text
extern printf  ; printf(char*fmt, ...) void
extern scanf   ; scanf(char*buff) void

global main
main:
    push ebp
    mov ebp, esp
    lea eax, format_a
    push eax
    call printf
    add esp, 4
    lea eax, float_a
    push eax
    lea eax, format_read_float
    push eax
    call scanf
    add esp, 8
    lea eax, format_b
    push eax
    call printf
    add esp, 4
    lea eax, float_b
    push eax
    lea eax, format_read_float
    push eax
    call scanf
    add esp, 8
    movss xmm0, [float_a]
    movss xmm1, [float_b]
    pxor xmm2, xmm2
    addss xmm2, xmm0
    addss xmm2, xmm1
    movss [float_sum], xmm2
    ucomiss xmm0, xmm1
    jb .less
    ja .greater
    lea eax, format_eql
    push eax
    call printf 
    add esp, 4
    jmp .endcmp
.less:
    fld dword [float_b]
    sub esp, 8
    fstp qword [esp]
    fld dword [float_a]
    sub esp, 8
    fstp qword [esp]
    lea eax, format_cmp2
    push eax
    call printf
    add esp, 20
    jmp .endcmp
.greater:
    fld dword [float_b]
    sub esp, 8
    fstp qword [esp]
    fld dword [float_a]
    sub esp, 8
    fstp qword [esp]
    lea eax, format_cmp
    push eax
    call printf
    add esp, 20
.endcmp:
    fld dword [float_sum]
    sub esp, 8
    fstp qword [esp]
    lea eax, format_sum
    push eax
    call printf
    add esp, 12
    mov esp, ebp
    pop ebp
    ret