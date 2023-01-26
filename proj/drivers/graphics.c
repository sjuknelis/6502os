#define SCREEN_LO     *(char*) 0x8000
#define SCREEN_HI     *(char*) 0x8001
#define SCREEN_DATA   *(char*) 0x8002

void hline(char x,char w,char y,char color) {
  const char color_byte = (color << 4) | color;
  char lo = x / 2;
  char i = 0;

  SCREEN_HI = y / 2;
  if ( y % 2 == 1 ) lo += 128;
  if ( x % 2 == 1 ) {
    SCREEN_LO = lo;
    SCREEN_DATA = (SCREEN_DATA & 0xf0) | color;
    lo++;
    i = 1;
  }
  for ( ; i < w - 1; i += 2 ) {
    SCREEN_LO = lo;
    SCREEN_DATA = color_byte;
    lo++;
  }
  if ( (x % 2 == 1) ^ (w % 2 == 1) ) {
    SCREEN_LO = lo;
    SCREEN_DATA = (SCREEN_DATA & 0x0f) | (color << 4);
  }
}

void krectangle(char x,char w,char y,char h,char color) {
  char i;
  for ( i = y; i < y + h; i++ ) {
    hline(x,w,i,color);
  }
}