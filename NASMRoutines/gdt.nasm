gdt_start:

gdt_null:; mandatory null descriptor
    dd 0x0; double word ie 4 bytes
    dd 0x0; two double words = 8 bytes

gdt_code:; code segment descriptor
    ; base=0x0, limit=0xfffff,
    ; 1st flags: present=1 privilege=00 descriptor type=1 => 1001
    ; type flags: code=1 conforming=0 readable=1 accessed=0 => 1010b#
    ; 2nd flags: AVL=0 64-bit=0 opsize=1(32-bit) granularity=1(*0x10000)
    dw 0xffff; limit (bits 0-15)
    dw 0x0; base (bits 0-15)
    db 0x0; base (bits 16-23)
    db 10011010b; 1st flags, type flags
    db 11001111b; 2nd flags, limit (bits 16-19)
    db 0x0; base (bits 24-31)
    ; complete: 1111111111111111000000000000000000000000100110101100111100000000
gdt_data:; identical to code, except for:
    ; type flags: code=0 expand down=0 writable=1 accessed=0 => 0010b
    dw 0xffff; limit (bits 0-15)
    dw 0x0; base (bits 0-15)
    db 0x0; base (bits 16-23)
    db 10010010b; 1st flags, type flags
    db 11001111b; 2nd flags, limit (bits 16-19)
    db 0x0; base (bits 24-31)
    ; complete: 1111111111111111000000000000000000000000100100101100111100000000

gdt_end:; add this so the assembler can calculate
        ; the size of the gdt for the gdt descriptor

gdt_descriptor:
    dw gdt_end - gdt_start - 1; size of the gdt, one less than true size
    dd gdt_start; gdt base address

; some handy constants for the GDT segment descriptor offsets
; 0x0 => NULL, 0x8 => CODE, 0x10 => DATA
; so the cpu knows to use the 'write' segment (womp womp)
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start