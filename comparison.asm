section .data

section .text
global _start

_start:
        MOV eax,1
        MOV ebx,2
        CMP eax,ebx
        JL less
        JMP end

less:
      MOV ecx,1
      INT 80h

end:
    INT 80h
