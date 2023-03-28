#include "../stdlib/mem.h"
#include "../drivers/graphics.h"
#include "../tasks/tasks.h"
#include "../stdlib/syscall.h"
#include "../drivers/serial.h"

#define MOUSE_X *(char*) 0x8005
#define MOUSE_Y *(char*) 0x8006

void flashing() {
  char color = 2;
  char start_x,start_y;
  char y,z;
  start_x = MOUSE_X;
  start_y = MOUSE_Y;
  while ( 1 ) {
    color = (color + 1) & 0x07;
    krectangle(start_x,32,start_y,32,color);
    y = 0xc0;
    z = 1;
    while ( y != 0 ) {
      while ( z != 0 ) {
        z++;
      }
      y++;
      z = 1;
    }
  }
}

char* input_buf = (char*) 0x7e00;
char* input_buf_write_ptr = (char*) 0x7dff;
char input_buf_read_ptr = 0;

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
      ksprint_hex(input_byte);
      input_buf_read_ptr++;

      switch ( input_byte ) {
        case NEWLINE:
          if ( strcmp(command_str,"hello") == 0 ) kprint("world\n");
          else if ( strcmp(command_str,"clear") == 0 ) kclear();
          else if ( strcmp(command_str,"flash") == 0 ) init_flash();
          else if ( strcmp(command_str,"kill") == 0 ) kill_flash();
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