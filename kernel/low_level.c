unsigned char port_byte_in(unsigned short port) { // gets a byte from an io port
	unsigned char result;
	// "=a" (result) means load reg a into result once finished
	// "d" (port) means load port into reg d at the start
	__asm__("in %%dx, %%al" : "=a" (result) : "d" (port));
	return result;
}

void port_byte_out(unsigned short port, unsigned char data) { // outputs a byte
							      // to an io port
	__asm__("out %%al, %%dx" : : "a" (data), "d" (port));
}

unsigned short port_word_in(unsigned short port) { // gets two bytes from an io port
	unsigned short result;
	__asm__("in %%dx, %%ax" : "=a" (result) : "d" (port));
	return result;
}

void port_word_out(unsigned short port, unsigned short data) { // outputs two bytes 
							       // to an io port
	__asm__("out %%ax, %%dx" : : "a" (data), "d" (port));
}
