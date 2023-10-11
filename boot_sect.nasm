[org 0x7c00]
    mov bx, HELLO_MSG
    call print_string

    jmp $

%include "print.nasm"   

HELLO_MSG:
    db 'Hello, World!', 0

; Padding and magic number.
times 510 -($-$$) db 0
dw 0xaa55