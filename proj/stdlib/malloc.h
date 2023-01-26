#ifndef MALLOC_H
#define MALLOC_H

void init_malloc();
char *malloc(int size);
void free(char *ptr);

#endif