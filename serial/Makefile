#
# To compile everything just type make:
#
#    $ make
#
# To run the unit tests, just type:
#
#    $ make test
#
# To remove any intermediate files, just type:
#
#    $ make clean
#
# - Sarah Mount, September 2014
#

CC=gcc

RM=rm

# What to all these C flags mean?
#
# -g 		add debug information for GDB.
# -Wall 	means turn on all common warnings.
# -Wextra 	means add some extra warnings.
# -std=c99 	means issue a warning when code does not conform to the C99 standard
# -pedantic means issue warnings about pedantic matters(!)
# -O3 		means switch on all optimisations
# -m64		means generate code for a 64 bit arch (remove if on a 32bit arch)
#
CFLAGS = -g -Wall -Wextra -std=c99 -pedantic -m64

LDLIBS = -lcrypt -lm

.PHONY: clean test all

all: pwcrack encrypt pwcrack2016

encrypt: encrypt.c
	$(CC) $(CFLAGS) encrypt.c -o $@ $(LDLIBS)

pwcrack: pwcrack.c
	$(CC) $(CFLAGS) pwcrack.c -o $@ $(LDLIBS)

pwcrack2016: pwcrack2016.c
	$(CC) $(CFLAGS) pwcrack2016.c -o $@ $(LDLIBS)

test:
	@echo 'NOT IMPLEMENTED'

clean:
	@rm pwcrack encrypt
