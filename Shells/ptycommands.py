import os
import pty

def inpty(argv):
  output = []
  def reader(fd):
    c = os.read(fd, 1024)
    while c:
      output.append(c)
      c = os.read(fd, 1024)

  pty.spawn(argv, master_read=reader)
  return ''.join(output)

print "Command output: " + inpty(["sudo whoami"])
