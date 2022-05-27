#!/usr/bin/env python

import sys

def usage():
    print("name-table [options]");
    print()
    print("\toptions:")
    print("\t\t--help: displays this help message")
    print("\t\t--csv: path to tiled csv export file")
    print("\t\t--asm: path to output assembly file")
    print("\t\t--label: the label name to use in the output assembly file")
    print()
    print("\tGenerates an NES assembly based name table by reading in a tiled")
    print("\tcsv export file.")
    print()
    print("\texample:")
    print("\t\tname-table --csv=tiled-export.csv --asm=code/name-table.asm --label=MyLabel")
    exit(1)

# handle inputs
in_file = None
out_file = None
label = None

for i in range(len(sys.argv)):
    if i== 0:
        continue

    arg = sys.argv[i]

    if arg == "--help":
        usage()

    if arg.startswith("--csv"):
        in_file = arg.split("=")[1]
        continue

    if arg.startswith("--asm"):
        out_file = arg.split("=")[1]
        continue

    if arg.startswith("--label"):
        label = arg.split("=")[1]
        continue

if in_file == None or out_file == None:
    usage()

output_bytes = ""
if label != None:
    output_bytes = f"{label}:\n"

csv = open(in_file, "r")
for line in csv:
    tiles = line.split(",")
    output_bytes += "\t.byte "

    out_tiles = []
    for tile in tiles:
        out_tiles.append("${0:0{1}x}".format(int(tile), 2))

    output_bytes += ",".join(out_tiles) + "\n"
output_bytes += "\n"
csv.close()

# write asm file
output = ""
dest = open(out_file, "w")
dest.write(output_bytes)
dest.close()
