#!/usr/bin/python
from datetime import date
from subprocess import call, Popen, PIPE
import sys
import ROOT
from array import array

wMassLine =  "            '24:m0 = 80.385',\n"

#massW = [80.355,80.360,80.365,80.370,80.375,80.380,80.385,80.390,80.395,80.400,80.405,80.410,80.415]
#massW = [80.305,80.310,80.315,80.320,80.325,80.330,80.335,80.340,80.345,80.350]
massW = [80.305,80.310,80.315,80.320,80.325,80.330,80.335,80.340,80.345,80.350,80.355,80.360,80.365,80.370,80.375,80.380,80.385,80.390,80.395,80.400,80.405,80.410,80.415]
#massW = [80.355,80.360,80.365,80.370,80.375,80.380,80.385,80.390,80.395,80.400,80.405,80.410,80.415,72.1]
#massW = [80.385,80.390]
#massW = [80.395,80.400,80.405,80.410,80.415]
numberOfJobs =  100#number of events in template cfg is 1000000

template = "W2enu_Pythia8_Tune4C_cfi_GEN_ana.py"

fNames = []
newMass = ""
chis = []

runJob = False
runAhadd = False
runChi = False
if(len(sys.argv) == 2):
    if sys.argv[1] == "runAhadd":
        runAhadd = True
    elif sys.argv[1] == "runJob":
        runJob = True
    elif sys.argv[1] == "runChi":
        runChi = True
else:
    print "Must Specify Task"
    sys.exit(1)


original_lines = [line for line in open(template)]

lines = list(original_lines)
loc = lines.index(wMassLine)
for var in massW:
    newMass = lines[loc].replace("80.385",str(var))
    lines.insert(loc, newMass)
    lines.pop(loc+1)
    fNames.append(template[:-3]+"massW"+str(var)+".py")
    if runJob:
        newFile = open(fNames[-1], 'w')
        newFile.writelines(lines)
        newFile.close()
    lines = list(original_lines)
if runJob:
    for cfg in fNames:
        call(["condor_prod.perl", cfg, str(numberOfJobs)])
if runAhadd:
    for cfg in fNames:
        #print "/data/whybee0b/user/aevans/"+"Pythia8_Tune4C_5_3_13_"+cfg[:-3]+"/*.root"
        call("ahadd.py ahadd_"+cfg[:-3]+".root"+" /data/whybee0b/user/aevans/"+cfg[:-3]+"/*.root", shell=True)


if runChi:
    for cfg in fNames:
        output,error = Popen(["python","./chi-squared2Hist.py","ahadd_W2enu_Pythia8_Tune4CMODCORRECTED_cfi_GEN_ana.root","ahadd_"+cfg[:-3]+".root"],stdout=PIPE, stderr=PIPE).communicate()

        chis.append(float(output))

    graph = ROOT.TGraph(len(chis),array("f", massW),array("f", chis))
    graph.SetTitle(" ")
    graph.GetXaxis().SetTitle("M_{W} [GeV]")
    graph.GetYaxis().SetTitleOffset(1.4)
    graph.GetYaxis().SetTitle("#chi^{2}")
    poly = ROOT.TF1("poly", "[2]*(x-[0])**2+[1]")
    poly.SetParameters(80.385,1700)
    graph.Fit("poly")
    o0 = poly.GetParameter(0)
    o0e = poly.GetParError(0)
    o1 = poly.GetParameter(1)
    o1e = poly.GetParError(1)
    o2 = poly.GetParameter(2)
    o2e = poly.GetParError(2)
    minChi = o1
    minM = o0
    minMerr = o0e
    minChierr = o1e
   # minM = -.5*o1/o2
   # minMerr = minM*(((o1e/o1)**2)+((o2e/o2)**2))**.5
   # minChi = (-1.*(o1**2)/(4*o2)) + o0
    print minChi
    print minM
    print minMerr
    text = ROOT.TPaveText(.25,.6,.75,.8,"NDC")
    text.AddText("Minimum Mass: %.3f"%minM)
    text.AddText("Minimum #chi^{2}: %.3f"%minChi)
    #ROOT.gStyle.SetOptFit(0001)
    graph.Draw("A*")
    text.Draw()
raw_input()

