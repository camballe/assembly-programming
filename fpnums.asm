section .data
        x DD 3.14
        y DD 2.1
section .text
global _start

_start:
    MOVSS xmm0, [x]
    MOVSS xmm1, [y]
    ADDSS xmm0, xmm1
   UCOMISS xmm0, xmm1