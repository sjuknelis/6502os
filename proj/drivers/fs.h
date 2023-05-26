typedef struct {
  char name[16];
  int ptrs[8];
} dirent_t;

dirent_t* readdir();
void exec(char* name);