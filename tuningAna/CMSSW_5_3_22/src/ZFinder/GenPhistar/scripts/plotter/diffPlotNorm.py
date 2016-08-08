import ROOT

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
    raw_input()

file1 = ROOT.TFile.Open("/home/aevans/CMS/oral/CMSSW_5_3_22/src/ZFinder/GenPhistar/GenPhiStarPythia6_Z2Star_5_3_13v2.root")
file2 = ROOT.TFile.Open("/home/aevans/Downloads/Final_Hist_MC_Norm_PH_Born.root")

myPhi = file1.Get("demo/phistarBorn")
numEvents = file1.Get("demo/counter")
phi = file2.Get("h_mc")
#phistar = file2.Get("ZFinder/Combined Single Reco/7 60 < M_{ee} < 120/phistar")
phi.SetTitle("Official Phistar TuneZ2*")
myPhi.SetTitle("Phistar TuneZ2*")
myPhi.Scale(1966.7/(numEvents.Integral()))
truInt = 0.
for ibin in range(1, myPhi.GetNbinsX()+1):
    truInt = truInt + myPhi.GetBinContent(ibin)*myPhi.GetBinWidth(ibin)
myPhi.Scale(1./truInt)
#for ibin in range(1, phi_1.GetNbinsX()+1):
#    phi_1.SetBinError(ibin, phi_1.GetBinError(ibin)/phi_1.GetBinWidth(ibin))

plot_same_normalized([myPhi, phi]) 

