#include "tasks/tasks.h"
#include "drivers/fs.h"
#include "drivers/graphics.h"

void main() {
  krectangle(72,1,0,255,0);
  run_tasks();
  //fstest();
  //emain();
}