[bits 16]
switch_to_pm:
    cli; Clear interrupts
    lgdt [gdt_descriptor]; Modify gdt.nasm to change the global
                         ; descriptor table.
    mov eax, cr0; Indirectly set the first bit of cr0 to 1.
    or eax, 0x1
    mov cr0, eax

    jmp CODE_SEG:init_pm; Do a far jump to the code segment
                        ; to force flush the pipeline

[bits 32]
init_pm:
    mov ax, DATA_SEG; In PM, all our segment regs are useless,
    mov ds, ax      ; so we point them all to the data 
    mov ss, ax      ; in our GDT.
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000; Update our stack position so it is at
    mov esp, ebp    ; the top of out free space

    call BEGIN_PM