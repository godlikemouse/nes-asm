CC=ca65
LD=ld65
FILE=main
EMU=fceux

all: clean generate-pattern-tables build run

clean:
	$(info --- Clean)
	rm -f bin/*

build:
	$(info --- Build)
	mkdir -p bin
	${CC} src/${FILE}.asm -o bin/${FILE}.o -t nes
	${LD} bin/${FILE}.o -o bin/${FILE}.nes -t nes

run:
	${EMU} bin/${FILE}.nes

generate-pattern-tables:
	$(info --- Generate pattern tables)
	tools/pattern-table.py --img=art/test.png --asm=src/test.chr
