#include "fs.h"
#include "serial.h"
#include "../stdlib/mem.h"

#define HDD_PAGE *(char*) 0x8008

char loaded_page = 0xff;
dirent_t* readdir_ptr = (dirent_t*) 0x6000;
int file_ptrs[8];
char file_ptr_index;
int file_index;

void load_hdd_page(int page) {
  if ( loaded_page != page ) {
    HDD_PAGE = page;
    loaded_page = page;
  }
}

dirent_t* readdir() {
  dirent_t* ret;
  if ( loaded_page != 0 ) {
    load_hdd_page(0);
    readdir_ptr = (dirent_t*) 0x6000;
  }
  while ( ! readdir_ptr -> name[0] ) {
    readdir_ptr++;
    if ( readdir_ptr >= (dirent_t*) 0x7000 ) return 0;
  }
  ret = readdir_ptr;
  readdir_ptr++;
  return ret;
}

dirent_t* find(char* name) {
  dirent_t* entry;
  readdir_ptr = (dirent_t*) 0x6000;
  entry = readdir();
  while ( entry != 0 ) {
    if ( strcmp(entry -> name,name) == 0 ) return entry;
    entry = readdir();
  }
  ksprint_hex(0xa1b2);
  return 0;
}

/*int flip_bytes(int value) {
  return ((value & 0x00ff) << 8) | ((value & 0xff00) >> 8);
}*/

#define flip_bytes(value) ((((value) & 0x00ff) << 8) | (((value) & 0xff00) >> 8))

void open(dirent_t* entry) {
  memcpy(file_ptrs,entry -> ptrs,sizeof(int) * 8);
  file_ptr_index = 0;
  file_index = 0;
}

void read(char* dest,int bytes) {
  if ( file_index + bytes > 0x1000 ) {
    load_hdd_page(flip_bytes(file_ptrs[file_ptr_index]));
    memcpy(dest,(char*) (0x6000 + file_index),0x1000 - file_index);
    file_ptr_index++;
    file_index = 0;
    dest += 0x1000 - file_index;
    bytes -= 0x1000 - file_index;
  }

  while ( bytes > 0x1000 ) {
    load_hdd_page(flip_bytes(file_ptrs[file_ptr_index]));
    memcpy(dest,(char*) (0x6000 + file_index),0x1000);
    file_ptr_index++;
    file_index = 0;
    dest += 0x1000;
    bytes -= 0x1000;
  }

  ksprint_hex(flip_bytes(file_ptrs[file_ptr_index]));
  load_hdd_page(flip_bytes(file_ptrs[file_ptr_index]));
  memcpy(dest,(char*) (0x6000 + file_index),bytes);
  file_index += bytes;
  if ( file_index == 0x1000 ) {
    file_ptr_index++;
    file_index = 0;
  }
}

int stat() {
  char i = 0;
  for ( ; i < 8; i++ ) {
    if ( file_ptrs[i] == 0 ) break;
  }
  return i << 12;
}
