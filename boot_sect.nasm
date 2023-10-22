[org 0x7c00]
    mov dx, 0x2ecd
    call print_hex
    jmp $

%include "print.nasm"   
;Data 

; Padding and magic number.
times 510 -($-$$) db 0
dw 0xaa55