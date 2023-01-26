char* table = (char*) 0x7f00;
char head_index = 0;

void reset_head() {
  if ( table[0] == 0 ) head_index = 0;
}

void yield() {
  while ( table[0] != 0 ) {}
}

void rectangle(char x,char w,char y,char h,char color) {
  reset_head();
  table[head_index + 1] = x;
  table[head_index + 2] = w;
  table[head_index + 3] = y;
  table[head_index + 4] = h;
  table[head_index + 5] = color;
  table[head_index + 6] = 0;
  table[head_index] = 0x01;
  head_index += 6;
}

void sprint_hex(int value) {
  reset_head();
  table[head_index + 1] = value & 0x00ff;
  table[head_index + 2] = (value & 0xff00) >> 8;
  table[head_index + 3] = 0;
  table[head_index] = 0x02;
  head_index += 3;
}

void sleep(int periods) {
  reset_head();
  table[head_index + 1] = periods & 0x00ff;
  table[head_index + 2] = (periods & 0xff00) >> 8;
  table[head_index + 3] = 0;
  table[head_index] = 0x03;
  head_index += 3;
}