#!/bin/bash
g++ Zgen.cc ../lib/libpythia8.a -o Zgen -I/home/aevans/CMS/phistar/generation/HepMC-2.06.09_build//include -I../include -O2 -ansi -pedantic -W -Wall -Wshadow -fPIC -Wl,-rpath,../lib -ldl -L/home/aevans/CMS/phistar/generation/HepMC-2.06.09_build//lib -Wl,-rpath,/home/aevans/CMS/phistar/generation/HepMC-2.06.09_build//lib -lHepMC
