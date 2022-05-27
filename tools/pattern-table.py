#!/usr/bin/env python

import sys
import png

tile_width = 8
tile_height = 8

def usage():
    print("pattern-table [options]");
    print()
    print("\toptions:")
    print("\t\t--help: displays this help message")
    print("\t\t--img: path to PNG image file")
    print("\t\t--asm: path to output assembly file")
    print()
    print("\tGenerates an NES assembly based pattern table (PRG-CHR) by reading")
    print("\tin a 4 color indexed PNG image file.")
    print()
    print("\texample:")
    print("\t\tpattern-table --img=myfile.png --asm=code/pattern-table.asm")
    exit(1)

# handle inputs
in_file = None
out_file = None

for i in range(len(sys.argv)):
    if i== 0:
        continue

    arg = sys.argv[i]

    if arg == "--help":
        usage()

    if arg.startswith("--img"):
        in_file = arg.split("=")[1]
        continue

    if arg.startswith("--asm"):
        out_file = arg.split("=")[1]
        continue

if in_file == None or out_file == None:
    usage()

# read img file
img_file = png.Reader(filename=in_file)
(width, height, rows, info) = img_file.read()
colors = ["00", "01", "10", "11"]
row_list = list(rows)

# validate size
if width * height != 16384:
    print("Error: invalid PNG size, pattern table must contain 256 tiles")
    exit(1)

# prepare asm file
asm_file = open(out_file, "w")

# populate pixels list
pixels = list()
for row in row_list:
    pixels.append(list(row))

# interate pixels and write out asm
index = 0
for row in range(int(height / tile_height)):
    for col in range(int(width / tile_width)):
        asm_file.write(f"\t; pattern {index}\n")

        # byte data for NES pattern tables are separated across 2 bytes
        # associated second byte is written 8 bytes after first half
        # second half contains left bit, first half contains second bit
        # example: 01 - selects palette color 1, but is stored as:
        #     first half bit: 1
        #     second half bit: 0
        #     first: %11111111
        #     second: %00000000
        #       draws 8 bit line using palette color 1
        second_half = list()

        for y in range(row * tile_height, row * tile_height + tile_height):

            # write first half of image date directly out to asm file
            asm_file.write("\t.byte %")

            # store second half of image data temporarity until first 8x8
            # has been written
            second_half.append("\t.byte %")

            for x in range(col * tile_width, col * tile_width + tile_width):
                color = colors[ pixels[y][x] ]
                second_half.append(color[0])
                asm_file.write(color[1])

            asm_file.write("\n")
            second_half.append("\n")

        # write second half of image data
        asm_file.write(f"\t; pattern {index}:1\n")
        for i in second_half:
            asm_file.write(i)
        asm_file.write("\n")

        index += 1
