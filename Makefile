CC=nesasm
FILE=main
EMU=fceux

all: clean build run

clean:
	rm -f ${FILE}.fns ${FILE}.nes

build:
	${CC} ${FILE}.asm

run:
	${EMU} ${FILE}.nes
