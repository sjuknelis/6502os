#include "serial.h"

#define HDD_PAGE *(char*) 0x8008

typedef struct {
  char name[16];
  int ptrs[8];
} dirent_t;

char loaded_page = 0;
dirent_t* readdir_ptr = 0x6000;
int file_ptrs[8];
char file_index;

void memcpy(char* dest,char* src,int bytes) {
  int i = 0;
  while ( i < bytes ) {
    dest[i] = src[i];
    i++;
  }
}

dirent_t* readdir() {
  dirent_t* ret;
  if ( loaded_page != 0 ) {
    // load page 0
    readdir_ptr = 0x6000;
  }
  while ( ! readdir_ptr -> name[0] ) {
    readdir_ptr++;
    if ( readdir_ptr >= 0x7000 ) return 0;
  }
  ret = readdir_ptr;
  readdir_ptr++;
  return ret;
}

int flip_bytes(int value) {
  return ((value & 0x00ff) << 8) | ((value & 0xff00) >> 8);
}

void open(dirent_t* entry) {
  HDD_PAGE = flip_bytes(entry -> ptrs[0]);
  file_index = 0;
}

void read(char* dest,int bytes) {
  memcpy(dest,0x6000 + file_index,bytes);
}

void fstest() {
  dirent_t *e = readdir();
  open(e);
  read(0x3000,0x200);
  //while ( 1 ) {}
}