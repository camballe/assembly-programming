 section	.text
   global _start     ;must be declared for linker (ld)
	
_start:	            ;tells linker entry point
   mov	edx,1     ;message length
   add [num+1], byte '0' ;for ascii processing - second item in the array
   mov	ecx,num+1     ;address of second item in the array
   mov	ebx,1       ;file descriptor (stdout)
   mov	eax,4       ;system call number (sys_write)
   int	0x80        ;call kernel 
	sub [num+1], byte '0'
	;EOL
	mov	edx,1     ;message length
   mov	ecx,eol     ;message to write
   mov	ebx,1       ;file descriptor (stdout)
   mov	eax,4       ;system call number (sys_write)
   int	0x80        ;call kernel
   ;add some value to the number
   add [num+1], byte 3
    add [num+1], byte '0'
    mov	edx,1     ;message length
   mov	ecx,num+1     ;message to write
   mov	ebx,1       ;file descriptor (stdout)
   mov	eax,4       ;system call number (sys_write)
   int	0x80        ;call kernel
	sub [num+1], byte '0'
   ;exit the program    			
   mov	eax,1       ;system call number (sys_exit)
   int	0x80        ;call kernel

section	.data
num db 2,3,4,6
eol db 0xa

