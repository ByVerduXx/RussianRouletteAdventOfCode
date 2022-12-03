program: program.o
	ld -o program program.o 
program.o: program.asm
	nasm -f elf64 -gdwarf -o program.o program.asm  

