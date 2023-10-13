print_string:
    pusha; regs to stack
    mov ah, 0x0e; scrolling teletype BIOS routine
    loop:
        mov al, [bx]; get the char at the position of bx
        cmp al, 0; if the current char is 0, 
        je end; the string ends
        int 0x10; video services interrupt
        add bx, 1; increment b by one
        jmp loop; loop back round
    end:
        popa; regs off stack
        ret; end

print_binary:
    pusha
    popa
    ret