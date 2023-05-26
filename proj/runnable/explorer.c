#include "../stdlib/window.h"
#include "../drivers/fs.h"
#include "../drivers/serial.h"
#include "../tasks/tasks.h"

void action(char* name) {
  ksprint_hex(0x7890);
  *(char*) 0x800a = 0xff;
}

void emain() {
  dirent_t* entry;
  char first = 1;
  while ( (entry = readdir()) != 0 ) {
    create_new_element(8,1 - first,entry -> name,1,action);
    first = 0;
  }
  mainloop();
}