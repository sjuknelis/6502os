#include "../stdlib/window.h"
#include "../stdlib/serial.h"
#include "../stdlib/fs.h"
#include "../stdlib/mem.h"

#define BACKSPACE 0x08
#define NEWLINE 0x0d

window_element_t* first_line;
window_element_t* last_line;
char last_line_index;

void keypress(char s) {
  window_element_t* line = first_line;
  window_element_t* prev_line;
  if ( s == BACKSPACE ) {
    if ( last_line_index > 0 ) {
      last_line -> text[--last_line_index] = 0;
      last_line -> rerender = 1;
    } else {
      while ( line != last_line ) {
        prev_line = line;
        line = line -> next;
      }
      last_line = prev_line;
      last_line_index = strlen(last_line -> text);
    }
  } else if ( s == NEWLINE ) {
    if ( last_line -> next ) last_line = last_line -> next;
    else last_line = create_new_element(20,1,"",0,0);
    last_line_index = 0;
  } else {
    if ( last_line_index < 20 ) {
      last_line -> text[last_line_index++] = s;
      last_line -> rerender = 1;
    }
  }
}

void save() {
  char text[256];
  window_element_t* line = first_line;
  char i = 0;
  char li = 0;
  while ( 1 ) {
    while ( li < 20 && line -> text[li] != 0 ) {
      text[i++] = line -> text[li++];
    }
    text[i++] = '\n';
    li = 0;
    if ( line == last_line ) break;
    line = line -> next;
  }
  text[i] = 0;
  ksprint(text);
  memcpy((char*) 0x6000,text,256);
  *((char*) 0x800a) = 3;
}

void main() {
  char text[256];
  char line[21];
  int i = 0;
  char li = 0;
  window_element_t* line_element;

  create_new_element(10,0,"test",0,0);
  create_new_element(10,0,"Save",1,save);

  open(find("test"));
  read(text,256);

  ksprint("---\n");
  while ( text[i] != 0 ) {
    ksprint_hex(text[i]);
    if ( text[i] == '\n' ) {
      line[li] = 0;
      line_element = create_new_element(20,1,line,0,0);
      if ( ! first_line ) first_line = line_element;
      li = 0;
    } else {
      if ( li < 20 ) line[li++] = text[i];
    }
    i++;
  }
  line[li] = 0;
  last_line = create_new_element(20,1,line,0,0);
  last_line_index = li;

  set_keyboard_handler(keypress);
  mainloop();
}