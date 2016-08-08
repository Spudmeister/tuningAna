#!/usr/bin/python
from datetime import date
from subprocess import call, Popen, PIPE
import sys
import ROOT
from array import array

ktSoft =  "            'BeamRemnants:primordialKTsoft = 0.5',\n"
ktHard =  "            'BeamRemnants:primordialKThard = 2',\n"
ktScale = "            'BeamRemnants:halfScaleForKT = 1',\n"
ktMass =  "            'BeamRemnants:halfMassForKT = 1'            ),\n"

template = "GENandPhistar.py"
softVars = [.05,.1,.15,.2,.25,.3,.35,.4,.45,.5,.6,.7,.8,.9,1.]
soft = False
if soft:
    parm = "\sigma_{k_{t},soft}"
    usedVars = softVars
    template = "GENandPhistarktHard1.6.py"
hardVars = [1.0,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2.0,2.1,2.2,2.3,2.4,2.5]
hard = True
if hard:
    parm = "\sigma_{k_{t},hard}"
    usedVars = hardVars
scaleVars = [0.1,0.5,2.0,10.]
scale = False
if scale:
    parm = "kt scale middle"
    usedVars = scaleVars
massVars = [0.1,0.5,2.0,10.]
mass = False
if mass:
    parm = "mass scale middle"
    usedVars = massVars



fNames = []
chis = []

original_lines = [line for line in open(template)]

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

print [ line for line in original_lines if "KTsoft" in line]
lines = list(original_lines)
loc = lines.index(ktSoft)
if(soft):
    for var in softVars:
        ktSoftNew = lines[loc].replace("0.5",str(var))
        lines.insert(loc, ktSoftNew)
        lines.pop(loc+1)
        fNames.append(template[:-3]+"ktSoft"+str(var)+".py")
        if runJob:
            newFile = open(fNames[-1], 'w')
            newFile.writelines(lines)
            newFile.close()
        lines = list(original_lines)
if(hard):    
    loc = lines.index(ktHard)
    for var in hardVars:
        ktHardNew = lines[loc].replace("2",str(var))
        lines.insert(loc, ktHardNew)
        lines.pop(loc+1)
        fNames.append(template[:-3]+"ktHard"+str(var)+".py")
        if runJob:
            newFile = open(fNames[-1], 'w')
            newFile.writelines(lines)
            newFile.close()
        lines = list(original_lines)
if(scale):    
    loc = lines.index(ktScale)
    for var in scaleVars:
        ktScaleNew = lines[loc].replace("1",str(var))
        lines.insert(loc, ktScaleNew)
        lines.pop(loc+1)
        fNames.append(template[:-3]+"ktScale"+str(var)+".py")
        if runJob:
            newFile = open(fNames[-1], 'w')
            newFile.writelines(lines)
            newFile.close()
        lines = list(original_lines)
if(mass):    
    loc = lines.index(ktMass)
    for var in massVars:
        ktMassNew = lines[loc].replace("1",str(var))
        lines.insert(loc, ktMassNew)
        lines.pop(loc+1)
        fNames.append(template[:-3]+"ktMass"+str(var)+".py")
        if runJob:
            newFile = open(fNames[-1], 'w')
            newFile.writelines(lines)
            newFile.close()
        lines = list(original_lines)
if (mass or scale or hard or soft) and runJob:        
    for cfg in fNames:
        call(["condor_filelist.perl", "--jobname", "Pythia8_Tune4C_5_3_13_"+cfg[:-3], cfg, "../EventGen/fileList.txt", "--batch", "11"])
      #  condor_filelist.perl --jobname GenPhistar_Pythia8_Tune4C_5_3_13 GENandPhistar.py ../EventGen/fileList.txt --batch 1
if runAhadd:
    for cfg in fNames:
        #print "/data/whybee0b/user/aevans/"+"Pythia8_Tune4C_5_3_13_"+cfg[:-3]+"/*.root"
        call("ahadd.py ahadd_"+"Pythia8_Tune4C_5_3_13_"+cfg[:-3]+".root"+" /data/whybee0b/user/aevans/"+"Pythia8_Tune4C_5_3_13_"+cfg[:-3]+"/*.root", shell=True)
if runChi:
    for cfg in fNames:
        print "python","./scripts/plotter/chi-squared.py","ahadd_"+"Pythia8_Tune4C_5_3_13_"+cfg[:-3]+".root"
        output,error = Popen(["python","./scripts/plotter/chi-squared.py","ahadd_"+"Pythia8_Tune4C_5_3_13_"+cfg[:-3]+".root"],stdout=PIPE, stderr=PIPE).communicate()
        chis.append(float(output))
       
    graph = ROOT.TGraph(len(chis),array("f", usedVars),array("f", chis))
    graph.SetTitle(" ")
    graph.GetXaxis().SetTitle(parm+" [GeV]")
    graph.GetYaxis().SetTitleOffset(1.4)
    graph.GetYaxis().SetTitle("#chi^{2}")
    poly = ROOT.TF1("poly", "[2]*(x-[0])**2+[1]")
   # poly.SetParameters(80.385,1700) used if fit is in wrong local minimum
    graph.Fit("poly")
    o0 = poly.GetParameter(0)
    o0e = poly.GetParError(0)
    o1 = poly.GetParameter(1)
    o1e = poly.GetParError(1)
    o2 = poly.GetParameter(2)
    o2e = poly.GetParError(2)
    minChi = o1
    minParm = o0
    minParmerr = o0e
    minChierr = o1e
    text = ROOT.TPaveText(.25,.6,.75,.8,"NDC")
    text.AddText("Minimum "+parm+": %.3f"%minParm)
    text.AddText("Minimum #chi^{2}: %.3f"%minChi)
    #ROOT.gStyle.SetOptFit(0001)
    graph.Draw("A*")
    text.Draw()

raw_input()
     # print error
   
