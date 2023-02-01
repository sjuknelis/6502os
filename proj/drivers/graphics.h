#ifndef GRAPHICS_H
#define GRAPHICS_H

#define BACKSPACE 0x08
#define NEWLINE 0x0d

void krectangle(char x,char w,char y,char h,char color);
void kbitmap(char* bitmap,char x,char y,char w,char h,char color0,char color1);
void kprint(char* str);
void kclear();

#endif