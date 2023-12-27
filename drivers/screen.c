#include "screen.h"

void print_char ( char character , int col , int row , char attribute_byte ) {
	unsigned char * vidmem = (unsigned char *) VIDEO_ADDRESS;
	if (!attribute_byte) {
		attribute_byte = WHITE_ON_BLACK;
	}
	int offset;
	if (col >= 0 && row >= 0) {
		offset = get_screen_offset(col , row);
	} else {
		offset = get_cursor();
	}
	if (character == '\n') {
		int rows = offset / (MAX_COLS);
		offset = get_screen_offset (80, rows);
	} else {
		vidmem[offset + 1] = character;
		vidmem[offset + 2] = attribute_byte;
	}
	offset += 2;
	set_cursor(offset);
}


int get_screen_offset(int c, int r) {
	return (r * MAX_COLS + c) * 2;
}

int get_cursor() {
	port_byte_out(REG_SCREEN_CTRL, 14);
	int offset = port_byte_in (REG_SCREEN_DATA) << 8;
	port_byte_out(REG_SCREEN_CTRL, 15);
	offset += port_byte_in(REG_SCREEN_DATA);
	return offset * 2;
}

void set_cursor(int offset) {
	offset /= 2;
	port_byte_out(REG_SCREEN_CTRL, 14);
	port_byte_out(REG_SCREEN_DATA,(unsigned char) (offset >> 8) & 0xFF);
	port_byte_out(REG_SCREEN_CTRL, 15);
	port_byte_out(REG_SCREEN_DATA,(unsigned char) offset & 0xFF);
}

void clear_screen () {
	int row = 0;
	int col = 0;
	for (int row = 0; row < MAX_ROWS; row++) {
		for (col =0; col < MAX_COLS ; col ++) {
			print_char (' ', col , row , WHITE_ON_BLACK );
		}
	}
	set_cursor ( get_screen_offset (0, 0));
}
