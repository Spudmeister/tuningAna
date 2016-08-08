import ROOT
import sys
from array import array
pwhg_unfolded_norm_diff_xs_PS = [9.29,9.12,8.89,8.68,8.51,7.95,7.75,7.23,6.81,6.33,5.80,5.32,4.87,4.47,4.01,3.55,3.15,2.81,2.41,2.09,1.75,1.42,1.141,.874,.632,.428,.247,.130,.0663,.0347,.0177,.0082,.0041,.00205]
pwhg_unfolded_norm_diff_xs_bin = [0.000, 0.004, 0.008, 0.012, 0.016, 0.020, 0.024, 0.029, 0.034, 0.039, 0.045, 0.052, 0.057, 0.064, 0.072, 0.081, 0.091, 0.102, 0.114, 0.128, 0.145, 0.165, 0.189, 0.219, 0.258, 0.312, 0.391, 0.524, 0.695, 0.918, 1.153, 1.496, 1.947, 2.522, 3.277]
pwhg_unfolded_norm_diff_xs_PS_err = [.08,.08,.09,.09,.08,.08,.07,.06,.06,.05,.04,.05,.04,.04,.03,.03,.02,.02,.02,.02,.01,.01,.009,.007,.005,.003,.002,.001,.0008,.0006,.0003,.0002,.0001,.00007]
colors = [ROOT.kBlack, ROOT.kBlue, ROOT.kGreen-2, ROOT.kRed]

ROOT.gStyle.SetOptStat(0)
c = ROOT.TCanvas("c","c",900,900)
c.SetLogx()
bins = array("f", pwhg_unfolded_norm_diff_xs_bin)
data = ROOT.TH1D("phistarBorn","Born Phistar", 34, bins)
data.SetTitle("POWHEG unfolded normalized #phi* differential cross-section")
data.GetXaxis().SetTitle("#phi*")
data.GetYaxis().SetTitle("d#sigma\d#phi*")
for i in range(len(pwhg_unfolded_norm_diff_xs_PS)):
    data.SetBinContent(i+1,pwhg_unfolded_norm_diff_xs_PS[i])
    data.SetBinError(i+1,pwhg_unfolded_norm_diff_xs_PS_err[i])
data.Draw("e")
c.Update()
c.Print("unfoldedPhistarPlot.eps","eps")
raw_input()
