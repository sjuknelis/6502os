#include "context.h"
#include "../drivers/fs.h"
#include "../drivers/graphics.h"
#include "../drivers/serial.h"
#include "../stdlib/syscall.h"
#include "../runnable/shell.h"
#include "../runnable/calculator.h"
#include "../runnable/explorer.h"

#define TASK_JUMP_LO  *(char*) 0x7ff0
#define TASK_JUMP_HI  *(char*) 0x7ff1
#define NMI_DETECT    *(char*) 0x7ff3

#define TASK_COUNT    3

typedef struct {
  char running;
  int sleeping;
} task_t;

task_t tasks[TASK_COUNT];

void init_task(char mb,void* func) {
  tasks[mb].running = 1;
  tasks[mb].sleeping = 0;

  TASK_JUMP_LO = (int) func & 0x00ff;
  TASK_JUMP_HI = ((int) func & 0xff00) >> 8;
  init_task_internal(mb);
}

char flash_index = 1;
char flash_triggered = 0;

void process_syscalls(char task) {
  char* table = (char*) 0x7f00;
  char i = 0;
  while ( table[i] != 0 ) {
    if ( table[i] == 0x01 ) {
      // Rectangle
      krectangle(table[i + 1],table[i + 2],table[i + 3],table[i + 4],table[i + 5]);
      i += 6;
    } else if ( table[i] == 0x02 ) {
      // Serial print hex
      ksprint_hex(table[i + 1] | (table[i + 2] << 8));
      i += 3;
    } else if ( table[i] == 0x03 ) {
      // Sleep
      tasks[task].sleeping = table[i + 1] | (table[i + 2] << 8);
      i += 3;
    }
  }
}

#define MOUSE_X *(char*) 0x8005
#define MOUSE_Y *(char*) 0x8006

void run_tasks() {
  char i,j;
  char task_run = 0;
  init_task(1,emain);
  while ( 1 ) {
    task_run = 0;
    for ( i = 1; i < TASK_COUNT; i++ ) {
      if ( (*(char*) 0x800a) == 0xff ) {
        (*(char*) 0x800a) = 0;
        init_task(2,exec);
      }
      if ( tasks[i].running && tasks[i].sleeping == 0 ) {
        continue_task(i);
        process_syscalls(i);
        for ( j = 1; j < TASK_COUNT; j++ ) {
          if ( tasks[j].sleeping != 0 ) tasks[j].sleeping--;
        }
        task_run = 1;
      }
    }
    if ( ! task_run ) {
      NMI_DETECT = 1;
      while ( NMI_DETECT != 0 ) {}
      for ( i = 1; i < TASK_COUNT; i++ ) {
        if ( tasks[i].sleeping != 0 ) tasks[i].sleeping--;
      }
    }
  }
}