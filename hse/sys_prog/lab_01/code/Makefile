all: gas, nasm

gas.o: task.gas.s
	as -g task.gas.s -o task.gas.o

gas: gas.o
	ld task.gas.o -e _entrypoint -o gas

nasm.o:
	nasm task.nasm.s -f elf64 -o task.nasm.o

nasm: nasm.o
	ld task.nasm.o -e _entrypoint -o nasm

clean:
	rm -rf gas.o gas
