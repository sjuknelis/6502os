#include "window.h"
#include "../drivers/graphics.h"
#include "../drivers/serial.h"

#define MOUSE_X *(char*) 0x8005
#define MOUSE_Y *(char*) 0x8006
#define KEYBOARD *(char*) 0x8007

window_element_t* first_window_element;
window_element_t* last_window_element;
char window_x = 50;
char window_y = 50;
char mouse_triggered = 0;

char input_box_index = 0;

void* kmalloc_ptr = 0x1000;
void* kmalloc(int size) {
  void* original = kmalloc_ptr;
  kmalloc_ptr = (void*) ((int) kmalloc_ptr + size);
  return original;
}

char moving_window = 0;

void render() {
  window_element_t* element = first_window_element;
  char x = window_x;
  char y = window_y;
  if ( moving_window ) krectangle(x,10,y - 10,10,3);
  else krectangle(x,10,y - 10,10,1);
  while ( element != 0 ) {
    if ( element -> new_row ) {
      x = window_x;
      y += 14;
    }
    if ( element -> rerender ) {
      krectangle(x,element -> size * 9,y,14,7);
      ktext(element -> text,x,y + 1,0,7);
      element -> rerender = 0;
    }
    x += element -> size * 9;
    element = element -> next;
  }
}

char* cinput_buf = (char*) 0x7e00;
char* cinput_buf_write_ptr = (char*) 0x7dff;
char cinput_buf_read_ptr = 0;

void update_buttons() {
  window_element_t* element = first_window_element;
  char x = window_x;
  char y = window_y;
  char new_window_x,new_window_y;
  char input_byte = 0;

  while ( cinput_buf_read_ptr != *cinput_buf_write_ptr ) {
    input_byte = *(cinput_buf + cinput_buf_read_ptr);
    cinput_buf_read_ptr++;
  }

  if (
    moving_window &&
    input_byte & 0x80
  ) {
    moving_window = 0;
    new_window_x = MOUSE_X;
    new_window_y = MOUSE_Y;
    while ( element != 0 ) {
      if ( element -> new_row ) {
        x = window_x;
        y += 14;
      }
      krectangle(x,element -> size * 9,y,14,0);
      element -> rerender = 1;
      x += element -> size * 9;
      element = element -> next;
    }
    krectangle(window_x,10,window_y - 10,10,0);
    window_x = new_window_x;
    window_y = new_window_y;
    return;
  }

  if (
    MOUSE_X >= x &&
    MOUSE_X <= x + 10 &&
    MOUSE_Y >= y - 10 &&
    MOUSE_Y <= y &&
    input_byte & 0x80
  ) {
    moving_window = 1;
    return;
  }

  while ( element != 0 ) {
    if ( element -> new_row ) {
      x = window_x;
      y += 14;
    }
    if ( element -> is_button ) {
      if (
        MOUSE_X >= x &&
        MOUSE_X < x + element -> size * 9 &&
        MOUSE_Y >= y &&
        MOUSE_Y < y + 14
      ) {
        if ( ! element -> on ) kreplace(x,element -> size * 9,y,14,4,7);
        element -> on = 1;
        if ( input_byte & 0x80 ) {
          if ( ! mouse_triggered ) {
            (element -> action)();
            render();
          }
          mouse_triggered = 1;
        } else {
          mouse_triggered = 0;
        }
      } else {
        if ( element -> on ) kreplace(x,element -> size * 9,y,14,7,4);
        element -> on = 0;
      }
    }
    x += element -> size * 9;
    element = element -> next;
  }
}

window_element_t* create_new_element(
  char size,
  char new_row,
  char* text,
  char is_button,
  void* action
) {
  char i = 0;
  window_element_t* element = kmalloc(sizeof(window_element_t));
  element -> size = size;
  element -> new_row = new_row;
  while ( text[i] != 0 ) {
    element -> text[i] = text[i];
    i++;
  }
  element -> rerender = 1;
  element -> is_button = is_button;
  element -> action = action;
  element -> next = 0;
  if ( ! last_window_element ) {
    first_window_element = element;
    last_window_element = element;
  } else {
    last_window_element -> next = element;
    last_window_element = element;
  }
  return element;
}

void mainloop() {
  while ( 1 ) {
    render();
    update_buttons();
  }
}