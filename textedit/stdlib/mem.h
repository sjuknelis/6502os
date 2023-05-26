#ifndef MEM_H
#define MEM_H

int strcmp(char* stra,char* strb);
void memcpy(char* dest,char* src,int bytes);
void memset(char* mem,char value,char size);
int strlen(char* str);
int inttostr(int value,char* str);

#endif