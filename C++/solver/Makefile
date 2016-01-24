GNU nano 2.2.6                       File: Makefile

SYSTEM     =  x86_sles10_4.1
LIBFORMAT  = static_pic

CPLEXDIR      = /home/da/M2/lib_/cplex
CONCERTDIR    = /home/da/M2/lib_/concert


CPLEXBINDIR   = $(CPLEXDIR)/bin/$(SYSTEM)
CPLEXLIBDIR   = $(CPLEXDIR)/lib/$(SYSTEM)/$(LIBFORMAT)
CONCERTLIBDIR = $(CONCERTDIR)/lib/$(SYSTEM)/$(LIBFORMAT)

CPLEXFLAGS = -std=c++11 -I$(CPLEXDIR)/include   -I$(CONCERTDIR)/include -L$(CPLEXLIBDIR) -lilocplex -lcplex -L$(CONCERTLIBDIR) -lconcert -lm -m32 -lpthread
CC = g++ -O0
CFLAGS = -std=c++11 -O2 -Wall -ansi -pedantic -DIL_STD
DEBUG = -pg -g -Wall -pedantic -DIL_STD
OBJECTS = first_prog.o second_prog.o third_prog.o


exec : $(OBJECTS)
			$(CC) $(CFLAGS) -o exe $(OBJECTS) $(CPLEXFLAGS)
first_prog.o : first_prog.cpp
			$(CC) $(CFLAGS) $(CPLEXFLAGS) -c first_prog.cpp

second_prog.o : second_prog.cpp
	$(CC) $(CFLAGS) $(CPLEXFLAGS) -c second_prog.cpp


third_prog.o : third_prog.cpp
	$(CC) $(CFLAGS) $(CPLEXFLAGS) -c third_prog.cpp




clean :
			rm -f $(OBJECTS) exe
