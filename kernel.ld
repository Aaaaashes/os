SECTIONS
{
    . = 0xE00; /* When joined with the boot sector is 0x1000 */
    .text :
    {
        *(.text)
    }

    /* Other sections like .data, .rodata, .bss, etc. */

    /* Remove or comment out the .init section */
    /*
    .init :
    {
        *(.init)
    }
    */

    /* Add other sections as needed */
}
