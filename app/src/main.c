#include "../stdlib/window.h"
#include "../stdlib/mem.h"

window_element_t* screen;
char screen_index = 0;

void add_number(char number) {
  screen -> text[screen_index] = number;
  screen -> rerender = 1;
  screen_index++;
}

void button_0() {
  add_number('0');
}
void button_1() {
  add_number('1');
}
void button_2() {
  add_number('2');
}
void button_3() {
  add_number('3');
}
void button_4() {
  add_number('4');
}
void button_5() {
  add_number('5');
}
void button_6() {
  add_number('6');
}
void button_7() {
  add_number('7');
}
void button_8() {
  add_number('8');
}
void button_9() {
  add_number('9');
}
void button_plus() {
  add_number('+');
}
void button_minus() {
  add_number('-');
}
void button_times() {
  add_number('*');
}
void button_slash() {
  add_number('/');
}

void evaluate() {
  char* text = screen -> text;
  int a = 0;
  int b = 0;
  int result;
  char operation = 0;
  char i = 0;
  while ( text[i] != 0 ) {
    if ( text[i] == '+' || text[i] == '-' || text[i] == '*' || text[i]  == '/' ) operation = text[i];
    else if ( operation == 0 ) a = a * 10 + text[i] - '0';
    else b = b * 10 + text[i] - '0';
    i++;
  }
  switch ( operation ) {
    case '+':
      result = a + b;
      break;
    case '-':
      result = a - b;
      break;
    case '*':
      result = a * b;
      break;
    case '/':
      result = a / b;
      break;
  }
  //ksprint_hex(result);
  memset(screen -> text,0,16);
  screen_index = inttostr(result,screen -> text);
  screen -> rerender = 1;
}

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