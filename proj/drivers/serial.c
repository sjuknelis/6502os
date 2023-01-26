#define SERIAL_OUT *(char*) 0x8003

void ksprint(char* str) {
  char i = 0;
  while ( str[i] != 0 ) {
    SERIAL_OUT = str[i];
    i++;
  }
}

const char* hex = "0123456789abcdef";

void ksprint_hex(int value) {
  SERIAL_OUT = '0';
  SERIAL_OUT = 'x';
  SERIAL_OUT = hex[(value & 0xf000) >> 12];
  SERIAL_OUT = hex[(value & 0x0f00) >> 8];
  SERIAL_OUT = hex[(value & 0x00f0) >> 4];
  SERIAL_OUT = hex[value & 0x000f];
  SERIAL_OUT = '\n';
}