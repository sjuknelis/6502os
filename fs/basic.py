import struct

start = [65,66,67,68,69,65,66,67,68,69,65,66,67,68,69,65,66,67,68,69]
data = bytearray(start + [0] * (0x1000 - len(start)))
with open("hdd.o","wb") as f:
  f.write(data)