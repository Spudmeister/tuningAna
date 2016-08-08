#!/bin/csh
if( ! $?LD_LIBRARY_PATH ) then
  setenv LD_LIBRARY_PATH /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/lib
else
  setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/lib
endif
setenv PYTHIA8DATA ${PYTHIA8_HOME}/xmldoc
