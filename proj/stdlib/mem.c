int strcmp(char* stra,char* strb) {
  char i = 0;
  while ( stra[i] != 0 || strb[i] != 0 ) {
    if ( stra[i] != strb[i] ) return stra[i] - strb[i];
    i++;
  }
  return 0;
}

void memset(char* mem,char value,char size) {
  char i = 0;
  for ( ; i < size; i++ ) {
    mem[size] = value;
  }
}

int inttostr(int value,char* str) {
  char buf[16];
  char i = 15;
  char start_i;
  if ( value == 0 ) {
    str[0] = '0';
    str[1] = 0;
    return 1;
  }
  while ( value > 0 ) {
    buf[i] = value % 10 + '0';
    value /= 10;
    i--;
  }
  i++;
  start_i = i;
  for ( ; i < 16; i++ ) {
    str[i - start_i] = buf[i];
  }
  str[i - start_i] = 0;
  return i - start_i;
}