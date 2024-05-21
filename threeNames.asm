section .data
    fmt_in db "%s", 0                        ; Input format string for scanf
    fmt_out db "Your full name is %s %s %s", 10, 0  ; Output format string for printf with newline
    prompt_fname db "Enter your first name: ", 0
    prompt_mname db "Enter your middle name: ", 0
    prompt_lname db "Enter your surname: ", 0

section .bss
    fname resb 50                            ; Reserve 50 bytes for the first name
    mname resb 50                            ; Reserve 50 bytes for the middle name
    lname resb 50                            ; Reserve 50 bytes for the surname

section .text
    extern printf, scanf                     ; Extern declarations for C standard library functions
    global main                              ; Entry point for the linker

main:
    ; Prompt for first name
    push dword prompt_fname
    call printf
    add esp, 4                               ; Clean up the stack

    push dword fname
    push dword fmt_in
    call scanf
    add esp, 8                               ; Clean up the stack

    ; Prompt for middle name
    push dword prompt_mname
    call printf
    add esp, 4                               ; Clean up the stack

    push dword mname
    push dword fmt_in
    call scanf
    add esp, 8                               ; Clean up the stack

    ; Prompt for surname
    push dword prompt_lname
    call printf
    add esp, 4                               ; Clean up the stack

    push dword lname
    push dword fmt_in
    call scanf
    add esp, 8                               ; Clean up the stack

    ; Print the full name
    push dword lname
    push dword mname
    push dword fname
    push dword fmt_out
    call printf
    add esp, 16                              ; Clean up the stack

    ; Return 0 from main
    mov eax, 1                               ; syscall number for sys_exit
    xor ebx, ebx                             ; return code 0
    int 0x80                                 ; make syscall
