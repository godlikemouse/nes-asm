CC=nesasm
FILE=main
EMU=fceux

all: clean generate-pattern-tables build run

clean:
	$(info --- Clean)
	rm -f bin/*

build:
	$(info --- Build)
	${CC} -l 3 src/${FILE}.asm
	mv src/${FILE}.fns bin/
	mv src/${FILE}.nes bin/
	mv src/${FILE}.lst bin/

run:
	${EMU} bin/${FILE}.nes

generate-pattern-tables:
	$(info --- Generate pattern tables)
	tools/pattern-table.py --img=art/test.png --asm=src/test.chr
