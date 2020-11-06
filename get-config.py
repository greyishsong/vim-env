#!/usr/bin/python3
import sys
import configparser

if (len(sys.argv) < 3):
    print("")
    exit(0)

section = sys.argv[1]
key = sys.argv[2]
conf = configparser.ConfigParser()

conf.read("local.conf")
value = conf.get(section, key)
print(value)
