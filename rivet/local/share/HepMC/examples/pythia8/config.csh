#!/bin/csh
if( ! $?LD_LIBRARY_PATH ) then
  setenv LD_LIBRARY_PATH /home/aevans/CMS/phistar/rivet/local/lib
else
  setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/home/aevans/CMS/phistar/rivet/local/lib
endif
setenv PYTHIA8DATA ${PYTHIA8_HOME}/xmldoc
