[org 0x7c00]
[bits 16]
    mov bp, 0x9000  ; Set the stack.
    mov sp, bp
    mov bx, MSG_REAL_MODE ; Load the address of MSG_REAL_MODE into BX
    call print_string
    call switch_to_pm ; Note that we never return from here.
    jmp $

%include "print.nasm"   
%include "print_pm.nasm"
%include "switch_to_pm.nasm"
%include "gdt.nasm"

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm

    jmp $

; Global variables
MSG_REAL_MODE  db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE  db "Successfully landed in 32-bit Protected Mode", 0

; Padding and magic number.
times 510 -($-$$) db 0
dw 0xaa55
