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