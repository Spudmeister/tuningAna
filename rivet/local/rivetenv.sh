## These variables need to exist
prefix=/home/aevans/CMS/phistar/rivet/local
exec_prefix=${prefix}
datarootdir=${prefix}/share

## Try to automatically work out the YODA Python path
YODA_PYTHONPATH="/home/aevans/CMS/phistar/rivet/local/lib64/python2.6/site-packages"
test -n "$YODA_PYTHONPATH" || { (which yoda-config > /dev/null) && YODA_PYTHONPATH=`yoda-config --pythonpath`; }
test -n "$YODA_PYTHONPATH" || echo "yoda-config could not be found: you may need to manually set paths to libYODA and the yoda Python package" 1>&2

export PATH="$exec_prefix/bin:/home/aevans/CMS/phistar/rivet/local/lib/../bin:$PATH"
export LD_LIBRARY_PATH="${exec_prefix}/lib:/home/aevans/CMS/phistar/rivet/local/lib:/home/aevans/CMS/phistar/rivet/local/lib:/home/aevans/CMS/phistar/rivet/local/lib:/home/aevans/CMS/phistar/rivet/local/lib:$LD_LIBRARY_PATH"
export PYTHONPATH="/home/aevans/CMS/phistar/rivet/local/lib64/python2.6/site-packages:$YODA_PYTHONPATH:$PYTHONPATH"

export TEXMFHOME="${datarootdir}/Rivet/texmf:$TEXMFHOME"
export HOMETEXMF="${datarootdir}/Rivet/texmf:$HOMETEXMF"
export TEXMFCNF="${datarootdir}/Rivet/texmf/cnf:$TEXMFCNF"
export TEXINPUTS="${datarootdir}/Rivet/texmf/tex//:$TEXINPUTS"
export LATEXINPUTS="${datarootdir}/Rivet/texmf/tex//:$LATEXINPUTS"

if (complete &> /dev/null); then
    test -e "${datarootdir}/Rivet/rivet-completion" && source "${datarootdir}/Rivet/rivet-completion"
fi

unset YODA_PYTHONPATH
