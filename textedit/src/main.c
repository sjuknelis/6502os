#include "../stdlib/window.h"
#include "../stdlib/mem.h"

void main() {
  screen = create_new_element(12,0,"",0,0);

  create_new_element(5,1,"  9  ",1,button_9);
  create_new_element(5,0,"  8  ",1,button_8);
  create_new_element(5,0,"  7  ",1,button_7);
  create_new_element(5,0,"  =  ",1,evaluate);

  create_new_element(5,1,"  6  ",1,button_6);
  create_new_element(5,0,"  5  ",1,button_5);
  create_new_element(5,0,"  4  ",1,button_4);
  create_new_element(5,0,"  /  ",1,button_slash);

  create_new_element(5,1,"  3  ",1,button_3);
  create_new_element(5,0,"  2  ",1,button_2);
  create_new_element(5,0,"  1  ",1,button_1);
  create_new_element(5,0,"  *  ",1,button_times);

  create_new_element(10,1,"    0     ",1,button_0);
  create_new_element(5,0,"  +  ",1,button_plus);
  create_new_element(5,0,"  -  ",1,button_minus);

  mainloop();
}