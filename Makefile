build:
	nasm -f elf32 -F stabs -o caesar.o caesar_cipher.asm
	ld -o caesar caesar.o -m elf_i386

clear:
	rm *.o && rm caesar