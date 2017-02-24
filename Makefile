
elmo : elmo.c
	gcc -o elmo -O2 elmo.c

clean :
	rm -f elmo
	rm -f output.vcd
