import math

class Page:
  def __init__(self):
    self.content = bytearray([0] * 0x1000)
    self.in_use = True

class DirectoryEntry:
  def __init__(self,name,page_pointers):
    self.name = name
    self.page_pointers = page_pointers
  
  def to_content(self):
    name_array = bytearray(self.name,encoding="ascii") + bytearray([0] * (16 - len(self.name)))
    page_int_array = []
    for pointer in self.page_pointers:
      page_int_array.append(math.floor(pointer / 256))
      page_int_array.append(pointer % 256)
    page_array = bytearray(page_int_array) + bytearray([0] * (16 - len(page_int_array)))
    return name_array + page_array

class Directory:
  entries = []

  def __init__(self,content):
    for i in range(0,0x1000,32):
      if content[i] != 0:
        name_array = bytearray(content[i:i + 16])
        if 0 in name_array:
          name = name_array[:name_array.index(0)].decode()
        else:
          name = name_array.decode()
        page_array = bytearray(content[i + 16:i + 32])
        page_pointers = []
        for j in range(0,16,2):
          if page_array[j] == 0 and page_array[j + 1] == 0:
            continue
          page_pointers.append(page_array[j] * 256 + page_array[j + 1])
        self.entries.append(DirectoryEntry(name,page_pointers))

  def to_content(self):
    content = bytearray()
    for entry in self.entries:
      content += entry.to_content()
    return content + bytearray([0] * (0x1000 - len(content)))

class HDD:
  def __init__(self):
    self.pages = [Page()]
    self.directory = Directory(self.pages[0].content)

  def import_hdd(self):
    self.pages = []

    hdd_file = open("hdd.o","rb")
    hdd_file.seek(0,2)
    size = hdd_file.tell()
    hdd_file.seek(0)
    page_count = math.ceil(size / 0x1000)

    for _ in range(page_count):
      page = Page()
      page.content = bytearray(hdd_file.read(0x1000))
      self.pages.append(page)

    if page_count == 0:
      self.pages.append(Page())

    self.directory = Directory(self.pages[0].content)

  def export_hdd(self):
    self.pages[0].content = self.directory.to_content()

    hdd_file = open("hdd.o","wb")
    for page in self.pages:
      hdd_file.write(page.content)
    hdd_file.close()

  def add_file(self,fname,internal_name):
    added_file = open(fname,"rb")
    added_file.seek(0,2)
    size = added_file.tell()
    added_file.seek(0)
    page_count = math.ceil(size / 0x1000)

    entry = DirectoryEntry(internal_name,[])
    for _ in range(page_count):
      open_page = None
      for page in self.pages:
        if not page.in_use:
          open_page = page
          break
      if open_page is None:
        open_page = Page()
        self.pages.append(open_page)
      else:
        open_page.in_use = True
      array = bytearray(added_file.read(0x1000))
      array += bytearray([0] * (0x1000 - len(array)))
      open_page.content = array
      entry.page_pointers.append(self.pages.index(open_page))

    self.directory.entries.append(entry)
    added_file.close()

  def remove_file(self,name):
    selected_entry = None
    for entry in self.directory.entries:
      if entry.name == name:
        selected_entry = entry
        break
    
hdd = HDD()
while True:
  command_text = input("> ").split(" ")
  command = command_text[0]
  params = command_text[1:]
  if command == "import":
    hdd.import_hdd()
    print("Imported")
  elif command == "export":
    hdd.export_hdd()
    print("Exported")
  elif command == "add":
    hdd.add_file(params[0],params[1])
    print(f"Added {params[0]} as {params[1]}")
  elif command == "exit":
    break
