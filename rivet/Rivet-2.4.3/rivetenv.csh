## These variables need to exist
set prefix=/home/aevans/CMS/phistar/rivet/local
set exec_prefix=${prefix}
set datarootdir=${prefix}/share

## Try to automatically work out the YODA Python path
set YODA_PYTHONPATH="/home/aevans/CMS/phistar/rivet/local/lib64/python2.6/site-packages"
test -n "$YODA_PYTHONPATH" || (which yoda-config > /dev/null) && set YODA_PYTHONPATH="`yoda-config --pythonpath`"
test -n "$YODA_PYTHONPATH" || echo "yoda-config could not be found: you may need to manually set paths to libYODA and the yoda Python package" 1>&2

setenv PATH "$exec_prefix/bin:/home/aevans/CMS/phistar/rivet/local/lib/../bin:$PATH"

if ($?LD_LIBRARY_PATH) then
setenv LD_LIBRARY_PATH "${exec_prefix}/lib:/home/aevans/CMS/phistar/rivet/local/lib:/home/aevans/CMS/phistar/rivet/local/lib:/home/aevans/CMS/phistar/rivet/local/lib:/home/aevans/CMS/phistar/rivet/local/lib:$LD_LIBRARY_PATH"
else
setenv LD_LIBRARY_PATH "${exec_prefix}/lib:/home/aevans/CMS/phistar/rivet/local/lib:/home/aevans/CMS/phistar/rivet/local/lib:/home/aevans/CMS/phistar/rivet/local/lib:/home/aevans/CMS/phistar/rivet/local/lib"
endif

if ($?PYTHONPATH) then
setenv PYTHONPATH "/home/aevans/CMS/phistar/rivet/local/lib64/python2.6/site-packages:${YODA_PYTHONPATH}:$PYTHONPATH"
else
setenv PYTHONPATH "/home/aevans/CMS/phistar/rivet/local/lib64/python2.6/site-packages:$YODA_PYTHONPATH"
endif

if ($?TEXMFHOME) then
setenv TEXMFHOME "${datarootdir}/Rivet/texmf:$TEXMFHOME"
else
setenv TEXMFHOME "${datarootdir}/Rivet/texmf"
endif

if ($?HOMETEXMF) then
setenv HOMETEXMF "${datarootdir}/Rivet/texmf:$HOMETEXMF"
else
setenv HOMETEXMF "${datarootdir}/Rivet/texmf"
endif

if ($?TEXMFCNF) then
setenv TEXMFCNF "${datarootdir}/Rivet/texmf/cnf:$TEXMFCNF"
else
setenv TEXMFCNF "${datarootdir}/Rivet/texmf/cnf:"
endif

if ($?TEXINPUTS) then
setenv TEXINPUTS "${datarootdir}/Rivet/texmf/tex//:$TEXINPUTS"
else
setenv TEXINPUTS "${datarootdir}/Rivet/texmf/tex//:"
endif

if ($?LATEXINPUTS) then
setenv LATEXINPUTS "${datarootdir}/Rivet/texmf/tex//:$LATEXINPUTS"
else
setenv LATEXINPUTS "${datarootdir}/Rivet/texmf/tex//:"
endif

unset YODA_PYTHONPATH
