import ROOT
import sys
colors = [ROOT.kBlack, ROOT.kBlue, ROOT.kGreen-2, ROOT.kRed]
maxPt = 50  #GeV
minPt = 20  #GeV
rebin = 100
def plot_same_normalized(histograms):
    ROOT.gStyle.SetOptStat(0)
    ROOT.gROOT.SetBatch(True)
    c = ROOT.TCanvas("c","c",900,900)
    c.Divide(1,3)
    p1 = c.cd(1)
    p1.SetPad(0,.35,1,1)
    for h in histograms:
        h.Sumw2()
        h.Rebin(rebin)
        h.Scale(1./h.Integral(minPt*100/rebin,maxPt*100/rebin))
    max_h = max( [ h.GetMaximum() for h in histograms]) * 1.1
    ci = 0
    for h in histograms:
        h.SetMaximum(max_h)
        h.SetLineColor(colors[ci % len(colors)])
        h.Draw("same"*(ci>0)+"e")
        ci += 1

    p1.BuildLegend()
    p2 = c.cd(2)
    p2.SetPad(0,.15,1,.35)
    if len(histograms) == 2:
        difference = histograms[1].Clone("difference")
        difference.SetTitle("")
        difference.Sumw2()
        average = histograms[1].Clone("average")
        average.SetTitle("Average")
        average.Sumw2()
        average.Add(histograms[0], 1.)
        average.Scale(.5)
        difference.Add(histograms[0], -1.)
        difference.Divide(average)
        difference.Draw("e")
    difference.GetYaxis().SetLabelSize(.1)
    difference.GetXaxis().SetLabelSize(.1)
    difference.GetXaxis().SetRange(minPt*100/rebin,maxPt*100/rebin)
    chiSquared = 0.0
    for ibin in range(minPt*100/rebin, maxPt*100/rebin+1): #bin width in Wana is 10MeV
        chiSquared += ((histograms[0].GetBinContent(ibin) - histograms[1].GetBinContent(ibin))**2)/((histograms[1].GetBinError(ibin))**2)
    print chiSquared
    p3 = c.cd(3)
    p3.SetPad(0,0,1,.15)
    pt = ROOT.TPaveText(.05,.1,.95,.8)
    pt.AddText("#Chi^{2}="+str(chiSquared)+", \\frac{#Chi^{2}}{Nbins}="+str(chiSquared/((maxPt-minPt)*100)))
    pt.Draw()
    c.Update()
    c.Print(sys.argv[2][38:-5]+"vs"+sys.argv[1][38:-5]+".png","png")
    #raw_input()
file1 = ROOT.TFile.Open(sys.argv[1]) #"data"
file2 = ROOT.TFile.Open(sys.argv[2]) 
pt_1 = file1.Get("wana/pte")
pt_2 = file2.Get("wana/pte")
#phistar = file2.Get("ZFinder/Combined Single Reco/7 60 < M_{ee} < 120/phistar")


#for ibin in range(1, phi_1.GetNbinsX()+1):
#    phi_1.SetBinError(ibin, phi_1.GetBinError(ibin)/phi_1.GetBinWidth(ibin))

plot_same_normalized([pt_1, pt_2]) 
