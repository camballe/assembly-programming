section .text
global _start

_start:
        MOV eax,0b1010
        MOV ebx,0b1100
        XOR eax,ebx
        AND eax,ebx
        MOV eax,0b1010
        MOV ebx,0b1100
        OR eax,ebx
        NOT eax
        AND eax,0xF
        INT 80h
