## These variables need to exist
prefix=/home/aevans/CMS/phistar/rivet/local
exec_prefix=${prefix}
datarootdir=${prefix}/share

export PATH="$exec_prefix/bin:$PATH"
export LD_LIBRARY_PATH="${exec_prefix}/lib:$LD_LIBRARY_PATH"
export PYTHONPATH="/home/aevans/CMS/phistar/rivet/local/lib64/python2.6/site-packages:$PYTHONPATH"

# TODO: unset these (and rm from Rivet) when YODA provides TeX-based plotting functionality
# export TEXMFHOME="${datarootdir}/Rivet/texmf:$TEXMFHOME"
# export HOMETEXMF="${datarootdir}/Rivet/texmf:$HOMETEXMF"
# export TEXMFCNF="${datarootdir}/Rivet/texmf/cnf:$TEXMFCNF"
# export TEXINPUTS="${datarootdir}/Rivet/texmf/tex:$TEXINPUTS"
# export LATEXINPUTS="${datarootdir}/Rivet/texmf/tex:$LATEXINPUTS"

if (complete &> /dev/null); then
    test -e "${datarootdir}/YODA/yoda-completion" && source "${datarootdir}/YODA/yoda-completion"
fi
