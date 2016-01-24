
SYSTEM     =  x86_sles10_4.1
LIBFORMAT  = static_pic

CPLEXDIR      = /net/i/rboudjeltia/Documents/lib_/cplex
CONCERTDIR    = /net/i/rboudjeltia/Documents/lib_/concert


CPLEXBINDIR   = $(CPLEXDIR)/bin/$(SYSTEM)
CPLEXLIBDIR   = $(CPLEXDIR)/lib/$(SYSTEM)/$(LIBFORMAT)
CONCERTLIBDIR = $(CONCERTDIR)/lib/$(SYSTEM)/$(LIBFORMAT)

CPLEXFLAGS = -std=c++11 -I$(CPLEXDIR)/include   -I$(CONCERTDIR)/include -L$(CPLEXLIBDIR) -lilocplex -lcplex -L$(CONCERTLIBDIR) -lconcert -lm -m32 -lpthread
CC = g++ -O0
CFLAGS = -std=c++11 -O2 -Wall -ansi -pedantic -DIL_STD
DEBUG = -pg -g -Wall -pedantic -DIL_STD
OBJECTS = third_prog.o


exec : $(OBJECTS)
	$(CC) $(CFLAGS) $(DEBUG) -o exe $(OBJECTS) $(CPLEXFLAGS)


third_prog.o : third_prog.cpp
	$(CC) $(CFLAGS) $(DEBUG)  $(CPLEXFLAGS) -c third_prog.cpp


clean :
	rm -f $(OBJECTS) exe
