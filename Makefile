# Get the list of sources using wildcards
C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

# TODO: Make sources dep on all header files.

OBJ = ${C_SOURCES:.c=.o} 
# Convert *.c filenames to *.o to get object filenames

all: os-image # Default build target

run: all # Run bochs with options file to emulate our code
	bochs -f bochsrc.bxrc -q

# Generate the disk image that the computer loads
os-image: boot/boot_sect.bin kernel.bin
	cat $^ > os-image

# Builds the binary out of our compiled c kernel
# and our kernel_entry script
kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld -o $@ -T kernel.ld $^ --oformat binary
	# Use an external linker script
	# as the Ttext argument throws an error

# Generic rule for building somefile.o out of somefile.c
%.o : %.c ${HEADERS}
	gcc -ffreestanding -c $< -o $@

%.o : %.nasm
	nasm $< -f elf64 -o $@

%.bin : %.nasm
	nasm $< -f bin -I 'NASMRoutines/' -o $@

clean:
	rm -rf *.bin *.dis *.o os-image
	rm -rf kernel/*.o boot/*.bin drivers/*.o
