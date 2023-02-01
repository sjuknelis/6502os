#include "tasks/tasks.h"
#include "drivers/graphics.h"
#include "drivers/serial.h"

char* input_buf = (char*) 0x7e00;
char* input_buf_write_ptr = (char*) 0x7dff;
char input_buf_read_ptr = 0;

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

void shell() {
  char input_byte;
  char command_str[24];
  char command_str_ptr = 0;
  char print_str[2] = {0x00,0x00};
  memset(command_str,0,24);
  kclear();
  while ( 1 ) {
    while ( input_buf_read_ptr != *input_buf_write_ptr ) {
      input_byte = *(input_buf + input_buf_read_ptr);
      print_str[0] = input_byte;
      kprint(print_str);
      input_buf_read_ptr++;

      switch ( input_byte ) {
        case NEWLINE:
          if ( strcmp(command_str,"hello") == 0 ) kprint("world\n");
          else if ( strcmp(command_str,"clear") == 0 ) kclear();
          memset(command_str,0,24);
          command_str_ptr = 0;
          break;

        case BACKSPACE:
          command_str[command_str_ptr] = 0;
          command_str_ptr--;
          break;

        default:
          command_str[command_str_ptr++] = input_byte;
      }
    }
  }
}

void main() {
  shell();
}