#!/usr/bin/python
# coding: UTF-8

import re
import sys
import os

read_file = None
write_file = None
temp_file = "temp_file"
try:
    read_file = open(sys.argv[1], 'r')
    write_file = open(temp_file, 'w')
    for line in read_file:
        if line.find(sys.argv[2]) != -1:
            line = re.sub(sys.argv[2], sys.argv[3], line)
        write_file.write(line)
finally:
    read_file.close()
    write_file.close()

if os.path.isfile(sys.argv[1]) and os.path.isfile(temp_file):
    os.remove(sys.argv[1])
    os.rename(temp_file, sys.argv[1])
sys.exit(0)
