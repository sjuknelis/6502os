#define SERIAL_OUT *(char*) 0x8003

void ksprint(char* str) {
  char i = 0;
  while ( str[i] != 0 ) {
    SERIAL_OUT = str[i];
    i++;
  }
}

void main() {
  ksprint("hello world\n");
  while ( 1 ) {}
}