#########################################################################################
# This program converts the output of GenPhistar to something properly normalized       #
#########################################################################################

import ROOT
import sys

xs = 1966.7
truInt = 0.


if len(sys.argv) < 2:
    print "please give a file to convert as the second argument"
    sys.exit(1)
if len(sys.argv) < 3:
    print "please give a name for the new file.root as the third argument"
    sys.exit(1)

file = sys.argv[1]
newName = sys.argv[2]
file1 = ROOT.TFile.Open(file)

myPhi = file1.Get("phistar/phistarBorn")
numEvents = file1.Get("phistar/counter")

myPhi.Scale(xs/(numEvents.Integral()))

myPhiAbs = myPhi.Clone("phistar_abs")
myPhiNorm = myPhi.Clone("phistar_norm")

for ibin in range(1, myPhiNorm.GetNbinsX()+1):
    truInt = truInt + myPhiNorm.GetBinContent(ibin)*myPhiNorm.GetBinWidth(ibin)
    print truInt
myPhiNorm.Scale(1./truInt)

print "Mixing your salad"
newFile = ROOT.TFile(newName,"recreate")
myPhiAbs.Write()
myPhiNorm.Write()

