[ org 0x7c00 ]
    mov [ BOOT_DRIVE ], dl ; BIOS stores our boot drive in DL , so it 's
    ; best to remember this for later.
    mov bp , 0x8000 ; Here we set our stack safely out of the
    mov sp , bp ; way , at 0 x8000
    mov bx , 0x9000 ; Load 5 sectors to 0 x0000 (ES ):0 x9000 (BX)
    mov dh , 5 ; from the boot disk.
    mov dl , [ BOOT_DRIVE ]
    call disk_load
    mov dx , [0x9000] ; Print out the first loaded word , which
    call print_hex ; we expect to be 0xdada , stored
    ; at address 0 x9000
    mov dx , [0x9000 + 512] ; Also , print the first word from the
    call print_hex ; 2nd loaded sector : should be 0 xface
    jmp $

%include "print.nasm"   
%include "disk.nasm"

; Global variables
BOOT_DRIVE: db 0

; Padding and magic number.
times 510 -($-$$) db 0
dw 0xaa55

times 256 dw 0xdada; add a little data to read
times 256 dw 0xface

