[org 0x7c00]
    mov dx, TEST_NUM
    call print_binary
    jmp $

%include "print.nasm"   

TEST_NUM:
    db 0x1001

; Padding and magic number.
times 510 -($-$$) db 0
dw 0xaa55