# Pull in ROOT
ROOT_INCLUDES=`root-config --cflags`
ROOT_ALL=`root-config --cflags --libs`

#Compiler
CC=g++ -O2 -g -std=c++0x -Wall
CCC=${CC} -c

all: pileup_plots.exe

pileup_plots.exe: pileup_plots.cpp
	${CC} ${ROOT_ALL} -o pileup_plots.exe \
	pileup_plots.cpp

clean:
	rm -f pileup_plots.exe *.o
