import ROOT
import sys
pwhg_unfolded_norm_diff_xs_PS = [9.29,9.12,8.89,8.68,8.51,7.95,7.75,7.23,6.81,6.33,5.80,5.32,4.87,4.47,4.01,3.55,3.15,2.81,2.41,2.09,1.75,1.42,1.141,.874,.632,.428,.247,.130,.0663,.0347,.0177,.0082,.0041,.00205]
pwhg_unfolded_norm_diff_xs_PS_err = [.08,.08,.09,.09,.08,.08,.07,.06,.06,.05,.04,.05,.04,.04,.03,.03,.02,.02,.02,.02,.01,.01,.009,.007,.005,.003,.002,.001,.0008,.0006,.0003,.0002,.0001,.00007]
colors = [ROOT.kBlack, ROOT.kBlue, ROOT.kGreen-2, ROOT.kRed]
maxBin = 28
def plot_same_normalized(histograms):
    ROOT.gStyle.SetOptStat(0)
    ROOT.gROOT.SetBatch(True)
    c = ROOT.TCanvas("c","c",900,900)
    c.Divide(1,3)
    p1 = c.cd(1)
    p1.SetPad(0,.35,1,1)
    p1.SetLogx()
    ROOT.gStyle.SetOptStat(0)
    for h in histograms:
        h.Scale(1./h.Integral(1,maxBin))
    max_h = max( [ h.GetMaximum() for h in histograms]) * 1.1
    ci = 0
    for h in histograms:
        h.SetMaximum(max_h)
        h.SetLineColor(colors[ci % len(colors)])
        h.Draw("same"*(ci>0)+"e")
        h.GetXaxis().SetRange(1,maxBin)
        ci += 1

    p1.BuildLegend()
    p2 = c.cd(2)
    p2.SetPad(0,.15,1,.35)
    p2.SetLogx()
    if len(histograms) == 2:
        difference = histograms[0].Clone("difference")
        difference.SetTitle("")
        difference.Sumw2()
        average = histograms[0].Clone("average")
        average.SetTitle("Average")
        average.Sumw2()
        average.Add(histograms[1], 1.)
        average.Scale(.5)
        difference.Add(histograms[1], -1.)
        difference.Divide(average)
        difference.Draw("e")
    difference.GetYaxis().SetLabelSize(.1)
    difference.GetYaxis().SetRangeUser(-.3,.3)
    difference.GetXaxis().SetRange(1,maxBin)
    chiSquared = 0.0
    for ibin in range(1, maxBin+1):
        chiSquared += ((histograms[1].GetBinContent(ibin) - histograms[0].GetBinContent(ibin))**2)/((histograms[1].GetBinError(ibin))**2)
    print chiSquared
    p3 = c.cd(3)
    p3.SetPad(0,0,1,.15)
    pt = ROOT.TPaveText(.05,.1,.95,.8)
    pt.AddText("#Chi^{2}="+str(chiSquared)+", \\frac{#Chi^{2}}{Nbins}="+str(chiSquared/28.0))
    pt.Draw()
    c.Update()
    c.Print(sys.argv[1][:-5]+".png","png")
    #f = ROOT.TFile("dist.root","new")
    #histograms[0].Write()
    #raw_input()

file1 = ROOT.TFile.Open(sys.argv[1])
file2 = ROOT.TFile.Open(sys.argv[2])
phi_1 = file1.Get("h_mc")
phi_2 = file2.Get("demo/phistarBorn")

official = phi_1.Clone("official")
phistar_born34.SetTitle("officilal")
for ibin in range(1, phistar_born34.GetNbinsX()+1):
    phistar_born34.SetBinContent(ibin, histograms[1].GetBinContent(ibin))
    phistar_born34.SetBinError(ibin, histograms[1].GetBinError(ibin))

plot_same_normalized([phi_1, phi_2]) 
