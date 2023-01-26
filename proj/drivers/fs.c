#define HDD_LO      *(char*) 0x8005
#define HDD_HI      *(char*) 0x8006
#define HDD_RAM     *(char*) 0x8007
#define HDD_GO      *(char*) 0x8008

#define HDD_READ    0x01
#define HDD_WRITE   0x02

#define ALLOC_BLOCK 0x00
#define DIR_BLOCK   0x01

typedef struct {
  int magic;
  char is_full[512];
} fs_alloc_table_t;

typedef struct {
  char fname[16];   // 15
  char is_empty;    // 1
  int ptrs[6];      // 12
  int next_block;   // 2
  char next_index;  // 1
} fs_dirent_t;      // 32

typedef struct {
  fs_dirent_t entries[119]; // 3808
  char empty[28];           // 28
  int magic;                // 2
  int next_block;           // 2
} fs_directory_t;           // 3840

int strcmp(const char* stra,const char* strb) {
  char i = 0;
  while ( stra[i] != 0 && strb[i] != 0 ) {
    if ( stra[i] > strb[i] ) return 1;
    else if ( stra[i] < strb[i] ) return -1;
  }
  if ( stra[i] == 0 && strb[i] == 0 ) return 0;
}

int ram_block_hdd_ptrs[8];

void read_block(int hdd_block_ptr,char ram_block) {
  HDD_LO = hdd_block_ptr & 0x00ff;
  HDD_HI = (hdd_block_ptr & 0xff00) >> 8;
  HDD_RAM = ram_block << 4;
  HDD_GO = HDD_READ;
  ram_block_hdd_ptrs[ram_block] = hdd_block_ptr;
}

void write_block(int hdd_block_ptr,char ram_block) {
  HDD_LO = hdd_block_ptr & 0x00ff;
  HDD_HI = (hdd_block_ptr & 0xff00) >> 8;
  HDD_RAM = ram_block << 4;
  HDD_GO = HDD_WRITE;
}

void save_block(char ram_block) {
  write_block(ram_block_hdd_ptrs[ram_block],ram_block);
}

fs_alloc_table_t* alloc_table = (fs_alloc_table_t*) 0x7000;
fs_directory_t* directory = (fs_directory_t*) 0x7000;

void readdir_start() {
  read_block(DIR_BLOCK,0x7);
}

void readdir_next() {
  read_block(directory -> next_block,0x7);
}

/*int alloc_new_block() {
  char full_byte;
  int i,j;
  read_block(ALLOC_BLOCK,0x7);
  for ( i = 0; i < 512; i++ ) {
    full_byte = alloc_table -> is_full[i];
    if ( full_byte != 0xff ) {
      j = 0;
      while ( full_byte & 0x01 == 0x01 ) {
        j++;
        full_byte >>= 1;
      }
      alloc_table -> is_full[i] |= (0x01 << j);
      save_block(0x7);
      return (i << 3) | j;
    }
  }
  // EFULL
  return 0;
}*/

// Block of entry will be in ram_block_hdd_prts[7]
fs_dirent_t get_dir_entry(char* fname) {
  char entry_found = 0;
  fs_dirent_t entry;
  char i;

  readdir_start();
  while ( ! entry_found ) {
    for ( i = 0; i < 119; i++ ) {
      entry = directory -> entries[i];
      if ( ! entry.is_empty && strcmp(fname,entry.fname) == 0 ) {
        entry_found = 1;
        break;
      }
    }
    if ( ! entry_found && directory -> next_block != 0xffff ) {
      readdir_next();
    } else {
      // ENOENT
    }
  }
  return entry;
}

/*void create_new_entry(char* fname) {
  char empty_entry_found = 0;
  char last_directory_block = 0xff;
  char new_directory_block;
  fs_dirent_t entry;
  char i;

  readdir_start();
  while ( ! empty_entry_found ) {
    for ( i = 0; i < 119; i++ ) {
      entry = directory -> entries[i];
      if ( entry.is_empty ) {
        empty_entry_found = 1;
        break;
      }
    }
    if ( ! empty_entry_found && directory -> next_block != 0xffff ) {
      readdir_next();
    } else {
      // Create new directory block
      last_directory_block = ram_block_hdd_ptrs[7];
      read_block(alloc_new_block(),0x7);
      for ( i = 0; i < 119; i++ ) {
        directory -> entries[i].is_empty = 1;
      }
      directory -> next_block = 0xffff;
      entry = directory -> entries[0];
      empty_entry_found = 1;
    }
  }

  i = 0;
  while ( fname[i] != 0 ) {
    entry.fname[i] = fname[i];
  }
  for ( ; i < 16; i++ ) {
    entry.fname[i] = 0;
  }
  entry.is_empty = 0;
  for ( i = 0; i < 6; i++ ) {
    entry.ptrs[i] = 0xffff;
  }
  entry.next_block = 0xffff;
  entry.next_index = 0xff;

  if ( last_directory_block != 0xff ) {
    new_directory_block = ram_block_hdd_ptrs[7];
    read_block(last_directory_block,0x7);
    directory -> next_block = new_directory_block;
  }
}*/

void fread(char* fname,char seek_to_block,char length_block,char ram_block) {
  char first_ptr_entry = seek_to_block / 6;
  char first_ptr_index = seek_to_block % 6;
  int ptrs[6];
  char next_entry_index;
  char i,pi;

  fs_dirent_t entry = get_dir_entry(fname);

  for ( i = 0; i < first_ptr_entry; i++ ) {
    if ( entry.next_index != 0xff ) {
      next_entry_index = entry.next_index;
      if ( entry.next_block != ram_block_hdd_ptrs[7] ) {
        read_block(entry.next_block,0x7);
      }
      entry = directory -> entries[next_entry_index];
    } else {
      // ESIZE
    }
  }

  for ( i = first_ptr_index,pi = 0; i < first_ptr_index + length_block && i < 6; i++,pi++ ) {
    if ( entry.ptrs[i] == 0xffff ) {
      // ESIZE
    }
    ptrs[pi] = entry.ptrs[i];
  }
  if ( first_ptr_index + length_block > 6 ) {
    if ( entry.next_index != 0xff ) {
      next_entry_index = entry.next_index;
      if ( entry.next_block != ram_block_hdd_ptrs[7] ) {
        read_block(entry.next_block,0x7);
      }
      entry = directory -> entries[next_entry_index];
    } else {
      // ESIZE
    }
    for ( i = 0; i < length_block - (6 - first_ptr_index); i++,pi++ ) {
      if ( entry.ptrs[i] == 0xffff ) {
        // ESIZE
      }
      ptrs[pi] = entry.ptrs[i];
    }
  }

  for ( i = 0; i < pi; i++ ) {
    read_block(ptrs[i],ram_block);
  }
}

/*void fappend(char* fname,char ram_block) {
  char i;

  fs_dirent_t entry = get_dir_entry(fname);

  for ( i = 0; i < 6; i++ ) {
    if ( entry.ptrs[i] == 0xff ) break;
  } 
  if ( i == 6 ) {

  }
}*/