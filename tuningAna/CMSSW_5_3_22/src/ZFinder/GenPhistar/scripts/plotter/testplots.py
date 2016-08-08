import ROOT

colors = [ROOT.kBlack, ROOT.kBlue, ROOT.kGreen-2, ROOT.kRed]
def plot_same_normalized(histograms):
    ROOT.gStyle.SetOptStat(0)
    c = ROOT.TCanvas("c","c",900,900)
    c.SetLogx()
    for h in histograms:
        h.Scale(1./h.Integral())
    max_h = max( [ h.GetMaximum() for h in histograms]) * 1.1
    ci = 0
    for h in histograms:
        h.SetMaximum(max_h)
        h.SetLineColor(colors[ci % len(colors)])
        h.Draw("same"*(ci>0))
        ci += 1
    c.BuildLegend()
    raw_input()


file1 = ROOT.TFile.Open("scripts/plotter/output.root")
file2 = ROOT.TFile.Open("/data/whybee0a/user/lesko_2/fermi/Output/ZfinderPOW15-9-8/PowhegDressed15-9-8.root")

phi_1 = file1.Get("phi_1")
phistar_born = file2.Get("ZFinder/Combined Single Reco/7 60 < M_{ee} < 120/phistar_born")
phistar = file2.Get("ZFinder/Combined Single Reco/7 60 < M_{ee} < 120/phistar")

print phistar_born, phi_1

plot_same_normalized([phi_1, phistar_born]) 

