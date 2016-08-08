#!/bin/sh
if [ ! $?LD_LIBRARY_PATH ]; then
  export LD_LIBRARY_PATH=/home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/lib
fi
if [ $?LD_LIBRARY_PATH ]; then
  export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/lib
fi
export PYTHIA8DATA=${PYTHIA8_HOME}/xmldoc
