
elmo : elmo.c
	gcc -o elmo -O2 elmo.c -lm

clean :
	rm -f elmo
	rm -f output.vcd
