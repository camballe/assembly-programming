section .data
    array       dd 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 ; Array of 10 integers
    arraySize   dd 10                                      ; Number of elements in the array
    promptInput db "Enter a number: ", 0                   ; Input prompt
    formatIn    db "%d", 0                                 ; Format for scanning integers
    formatOut   db "Hi There are %d values <= to %d in this array: [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]", 10, 0   ; Output format

section .bss
    count       resb 4                                     ; Space for counting number of values 
    userNumber  resb 4                                     ; Space for storing the user input number
    

section .text
    global main
    extern printf
    extern scanf

main:
    push ebp                                               ; Start of function
    mov ebp, esp

    ; Prompt user for input
    push promptInput
    call printf
    add esp, 4                                             ; Clean up the stack (the pushed address)

    ; Read user input
    push userNumber                                        ; Push the address of userNumber
    push formatIn                                          ; Push the format
    call scanf
    add esp, 8                                             ; Clean the stack from pushed addresses

    xor eax, eax                                           ; Set EAX register to 0
    mov [count], eax                                       ; Initialize count with 0

    mov esi, array                                         ; Point ESI to the start of the array
    mov ecx, [arraySize]                                   ; Number of elements in the array

loop_start:
    cmp ecx, 0                                             ; Check if the loop is done
    je loop_end
    dec ecx

    mov eax, [esi + ecx * 4]                               ; Get current array element
    cmp eax, [userNumber]                                  ; Compare array element with user input
    jg skip_increment                                      ; If element > user input, skip increment

    inc dword [count]                                      ; Increment the counter

skip_increment:
    jmp loop_start

loop_end:
    push dword [userNumber]                                ; Push userNumber for output
    push dword [count]                                     ; Push count for output
    push formatOut                                         ; Push output format
    call printf
    add esp, 12                                            ; Adjust the stack

    mov esp, ebp                                           ; Clean up function prologue
    pop ebp
    ret                                                    ; End of function
