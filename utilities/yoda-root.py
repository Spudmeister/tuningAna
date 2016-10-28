import ROOT
import sys
import os
import numpy

colors = [ROOT.kBlack, ROOT.kBlue, ROOT.kGreen-2, ROOT.kRed]
def plot_same_normalized(histograms):
    ROOT.gStyle.SetOptStat(0)
    c = ROOT.TCanvas("c","c",900,900)
    c.Divide(1,2)
    p1 = c.cd(1)
    p1.SetPad(0,.3,1,1)
    p1.SetLogx()
    for h in histograms:
        #h.Scale(1./h.Integral())
        h.GetXaxis().SetLabelSize(.03)
        h.GetXaxis().SetTitle("#phi*")
    max_h = max( [ h.GetMaximum() for h in histograms]) * 1.1
    ci = 0
    for h in histograms:
        h.SetMaximum(max_h)
        h.SetLineColor(colors[ci % len(colors)])
        h.Draw("same"*(ci>0)+"e")
        ci += 1
    p1.BuildLegend()
    p2 = c.cd(2)
    p2.SetPad(0,0,1,.3)
    p2.SetLogx()
    difference = histograms[0].Clone("difference")
    difference.SetTitle("")
    difference.Sumw2()
    average = histograms[0].Clone("average")
    average.SetTitle("Average")
    average.Sumw2()
    phistar_born34 = histograms[0].Clone("h_mc34")
    phistar_born34.SetTitle("h_mc")
    for ibin in range(1, phistar_born34.GetNbinsX()+1):
        phistar_born34.SetBinContent(ibin, histograms[1].GetBinContent(ibin))
        phistar_born34.SetBinError(ibin, histograms[1].GetBinError(ibin))
    average.Add(phistar_born34, 1.)
    average.Scale(.5)
    difference.Add(phistar_born34, -1.)
    difference.Divide(average)
    difference.Draw("e")
    difference.GetYaxis().SetLabelSize(.1)
    difference.GetXaxis().SetLabelSize(.07)
    difference.GetXaxis().SetTitle("#phi*")
    difference.GetXaxis().SetTitleSize(.08)
    difference.GetXaxis().SetTitleOffset(.5)
    difference.GetYaxis().SetTitle("% error")
    difference.GetYaxis().SetTitleSize(.07)
    difference.GetYaxis().SetTitleOffset(.75)
   # difference.SetTitleSize(.5)
    c.Update()
    c.SaveAs("output.ps")
    raw_input()

############################################################################################

def makeHisto(datFileName):
    datFile = open(datFileName)
    dataLines = datFile.readlines()
    notFound = True
    index = 0
    print len(dataLines)
    while notFound:
        if dataLines[0].find("xlow") == -1:
            dataLines.pop(0)
            continue
        dataLines.pop(0)
        notFound = False
    while (dataLines[-1].find("END") == -1):
        dataLines.pop()
    dataLines.pop()
       #     continue
       # print "HI"
       # print dataLines.pop(index)
       # print dataLines.pop()
       # break
    #Now the dataLines list has been trimmed down we can create and fill a TH1D
    #First we get the vector of bin lower edges
    binLowers = []
    binContent = []
    binErrorLow = []
    binErrorHigh = []
    print "Getting Data:"
    for line in dataLines:
        binLowers.append(float(line[:12]))
        binContent.append(float(line[26:38]))
        binErrorLow.append(float(line[39:51]))
        binErrorHigh.append(float(line[52:64]))

    histo = ROOT.TH1D("phistar","phistar",len(binLowers)-1,numpy.array(binLowers))
    for bin in range(len(binLowers)):
        histo.SetBinContent(bin, binContent[bin])
        histo.SetBinError(bin, (binErrorLow[bin]+binErrorHigh[bin])/2)

    file2 = ROOT.TFile.Open("/home/aevans/CMS/phistar/utilities/Final_Hist_MC_Norm_PH_Born.root")
    
    phi = file2.Get("h_mc")
    phi.SetTitle("Official Phistar TuneZ2*")
    histo.SetTitle("Phistar Pythia8 Tune4C Rivet")
    histo.Scale(1966.7/(6868))
    truInt = 0
    for ibin in range(1, histo.GetNbinsX()+1):
        truInt = truInt + histo.GetBinContent(ibin)*histo.GetBinWidth(ibin)
    histo.Scale(1./truInt)
    
    print binErrorHigh
    plot_same_normalized([histo, phi]) 

############################################################################################
try:
    sys.argv[1]
except IndexError:
    print "No file name given"
    sys.exit(1)
else:
   datFileName=sys.argv[1]
if not os.path.isfile(datFileName):
   print "File is not accesible or does not exist"
   sys.exit(1)

makeHisto(datFileName)
