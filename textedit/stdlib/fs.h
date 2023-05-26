typedef struct {
  char name[16];
  int ptrs[8];
} dirent_t;

dirent_t* readdir();
dirent_t* find(char* name);
void open(dirent_t* entry);
void read(char* dest,int bytes);
void exec(char* name);