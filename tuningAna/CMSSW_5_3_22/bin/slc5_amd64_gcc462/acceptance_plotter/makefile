# Pull in ROOT
ROOT_INCLUDES=`root-config --cflags`
ROOT_ALL=`root-config --cflags --libs`
ROO_INCLUDES=${ROOT_ALL} -I${ROOFITSYS}/include -L${ROOFITSYS}/lib -lRooFit -lRooFitCore -lRooStats

#Compiler
CC=g++ -O2 -g -std=c++0x -Wall
CCC=${CC} -c

all: acceptance_plotter.exe

acceptance_plotter.exe: acceptance_plotter.cpp
	${CC} ${ROOT_ALL} ${ROO_INCLUDES} -o acceptance_plotter.exe \
	acceptance_plotter.cpp

clean:
	rm -f acceptance_plotter.exe *.o
