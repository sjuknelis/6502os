import array

hdd = open("../fs/hdd.o","r+b")

def read_hdd_page(mmu,page):
  hdd.seek(page * 0x1000)
  for addr in range(0x6000,0x7000):
    mmu.write(addr,ord(hdd.read(1)))

def write_hdd_page(mmu,page):
  hdd.seek(page * 0x1000)
  print(page)
  for addr in range(0x6000,0x7000):
    hdd.write(bytes([mmu.read(addr)]))