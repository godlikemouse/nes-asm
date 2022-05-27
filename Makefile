CC=ca65
LD=ld65
FILE=main
EMU=fceux

all: clean generate-pattern-tables generate-name-tables build run

clean:
	$(info --- Clean)
	rm -f bin/*

build:
	$(info --- Build)
	mkdir -p bin
	${CC} src/${FILE}.asm -o bin/${FILE}.o -t nes -l bin/${FILE}.lst
	${LD} bin/${FILE}.o -o bin/${FILE}.nes -t nes -m bin/${FILE}.map

run:
	${EMU} bin/${FILE}.nes

generate-pattern-tables:
	$(info --- Generate pattern tables)
	tools/pattern-table.py --img=art/test.png --asm=src/char/test.asm

generate-name-tables:
	$(info --- Generate name tables)
	tools/name-table.py	--csv=art/tiled/test_nametable.csv --asm=src/nametable/test.asm --label=Background_Nametable
	tools/name-table.py	--csv=art/tiled/test_nametable2.csv --asm=src/nametable/test2.asm --label=Background_Nametable2
