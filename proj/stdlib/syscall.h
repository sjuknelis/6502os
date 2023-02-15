#ifndef SYSCALL_H
#define SYSCALL_H

void yield();
void rectangle(char x,char w,char y,char h,char color);
void sprint_hex(int value);
void sleep(int periods);
void init_flash();
void kill_flash();

#endif