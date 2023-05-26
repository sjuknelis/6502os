typedef struct {
  char size;
  char new_row;

  char text[16];
  char rerender;

  char is_button;
  char on;
  void (*action)();
  
  void* next;
} window_element_t;

window_element_t* create_new_element(
  char size,
  char new_row,
  char* text,
  char is_button,
  void* action
);
void mainloop();