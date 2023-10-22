print_string:
    pusha; regs to stack
    mov ah, 0x0e; scrolling teletype BIOS routine
    loop:
        mov al, [bx]; get the char at the position of bx
        cmp al, 0; if the current char is 0, 
        je end; the string ends
        int 0x10; video services interrupt
        inc bx ; increment b by one
        jmp loop; loop back round
    end:
        popa; regs off stack
        ret; end

print_hex:
    pusha
    mov bx, HEX_PREFIX
    call print_string

    mov bx, HEX_TABLE
    mov ax, dx

    mov al, ah; makes al and ah both the high byte to get each nibble
    call byte_to_string
    call print_string

    mov bx, HEX_TABLE
    mov ax, dx

    mov ah, al; makes al and ah both the low byte to get each nibble
    call byte_to_string
    call print_string

    popa
    ret

byte_to_string:
    shr ah, 4; gets the high nibble
    and al, 0x0F; gets the low nibble
    xlat ; lookup
    xchg ah, al ; switch
    xlat ; lookup

    mov bx, HEX_STRING; moves the address of the data to bx
    mov [bx], ax
    ret

;data
HEX_TABLE:
    db "0123456789abcdef", 0

HEX_STRING:
    resb 50

HEX_PREFIX:
    db "0x", 0