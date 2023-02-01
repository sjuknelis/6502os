typedef struct {
  char is_full;
  int size;
  char *prev;
  char *next;
} malloc_header_t;

malloc_header_t *first = (malloc_header_t*) 0x1000;

void init_malloc() {
  first -> is_full = 0;
  first -> size = 0x1000;
  first -> prev = 0;
  first -> next = 0;
}

char *malloc(int size) {
  malloc_header_t *current = first;
  malloc_header_t *created;

  while ( current != 0 ) {
    if ( ! current -> is_full && current -> size >= size ) break;
    current = (malloc_header_t*) current -> next;
  }

  if ( current != 0 ) {
    // Empty area found; current to be used
    current -> is_full = 1;
    if ( current -> size - size > sizeof(malloc_header_t) ) {
      // Excess space; create new and resize current
      created = (malloc_header_t*) ((char*) current + sizeof(malloc_header_t) + size);
      created -> is_full = 0;
      created -> size = current -> size - size - sizeof(malloc_header_t);
      created -> prev = (char*) current;
      created -> next = current -> next;
      ((malloc_header_t*) created -> next) -> prev = (char*) created;
      current -> next = (char*) created;
      current -> size = size;
    }
    return (char*) current + 1;
  }
  return 0;
}

void merge_empties(malloc_header_t *first) {
  malloc_header_t *second = (malloc_header_t*) first -> next;
  malloc_header_t *third = (malloc_header_t*) second -> next;

  first -> size += sizeof(malloc_header_t) + second -> size;
  first -> next = (char*) third;
  third -> prev = (char*) first;
}

void free(char *ptr) {
  malloc_header_t *current = (malloc_header_t*) ptr - sizeof(malloc_header_t);
  current -> is_full = 0;

  if ( current -> prev && ! ((malloc_header_t*) current -> prev) -> is_full ) {
    current = (malloc_header_t*) current -> prev;
    merge_empties(current);
  }
  
  if ( current -> next && ! ((malloc_header_t*) current -> next) -> is_full ) merge_empties(current);
}