[bits 32]

print_string_pm:
    pusha; regs to stack
    mov edx, VIDEO_MEMORY

    print_string_pm_loop:
        mov al, [ebx]; get the char at the position of bx
        mov ah, WHITE_ON_BLACK; text attributes

        cmp al, 0; if the current char is 0, 
        je print_string_pm_done; the string ends
        mov [edx], ax; place char in video memory
        add ebx, 1; next char in string
        add edx, 2; next char cell in video memory
        jmp print_string_pm_loop; loop back round

    print_string_pm_done:
        popa; regs off stack
        ret; end

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f