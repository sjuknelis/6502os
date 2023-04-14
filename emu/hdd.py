import array

hdd = open("../fs/hdd.o","rb")

def read_hdd_page(mmu,page):
  hdd.seek(page * 0x1000)
  for addr in range(0x6000,0x7000):
    mmu.write(addr,ord(hdd.read(1)))