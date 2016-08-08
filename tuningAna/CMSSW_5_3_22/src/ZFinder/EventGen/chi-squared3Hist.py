import ROOT
import sys
colors = [ROOT.kBlue, ROOT.kGreen-2, ROOT.kRed]
titles = ["Standard Tune4C with M_{W}=80.385 GeV", "Standard Tune4C with M_{W}=79 GeV", "Modified Tune4C with double #sigma_{k_{t},hard}"]
differences = []
maxPt = 50  #GeV
minPt = 20  #GeV
rebin = 100
def plot_same_normalized(histograms):
    ROOT.gStyle.SetOptStat(0)
    #ROOT.gROOT.SetBatch(True)
    c = ROOT.TCanvas("c","c",900,900)
    c.Divide(1,2)
    p1 = c.cd(1)
    p1.SetPad(0,.25,1,1)
    for h in histograms:
        h.Sumw2()
        h.Rebin(rebin)
        h.Scale(1./h.Integral())
    
    maxh = max( [ h.GetMaximum() for h in histograms]) * 1.1
    ci = 0
    leg = ROOT.TLegend(.15,.15,.65,.34)
    for h in histograms:
        c.cd(1)
        h.SetMaximum(maxh)
        h.SetTitle(" ")
        h.SetLineColor(colors[ci % len(colors)])
        h.SetLineWidth(2)
        leg.AddEntry(h, titles[ci], "l")
        h.GetXaxis().SetRange(20, 50)
        h.GetXaxis().SetTitle(" ")
        h.GetYaxis().SetTitle("% events/GeV")
        h.GetYaxis().SetTitleOffset(1.5)
        h.GetYaxis().SetTitleSize(.03)
        h.GetYaxis().SetLabelSize(.03)
        h.GetXaxis().SetLabelSize(.0000001)
        #h.Draw("hist"+"C"+"same"*(ci>0))
        ci += 1
    p1.cd()
    leg.SetFillColor(ROOT.kWhite)
    i = 0
    for hist in histograms:
        p1.cd()
        hist.Draw("hist"+"C"+"same"*(i>0))
        print "hist"+"C"+"same"*(i>0)
        i += 1
    p1.SetTitle(" ")
    leg.Draw()
    p2 = c.cd(2)
    p2.SetPad(0,0,1,.32)
    p2.SetBottomMargin(.24)
    c.SetTitle(" ") 
    for i in range(1, 3):
        difference = histograms[0].Clone("difference")
        difference.SetTitle(" ")
        difference.Sumw2()
        average = histograms[0].Clone("average")
        average.SetTitle("Average")
        average.Sumw2()
        average.Add(histograms[i], 1.)
        average.Scale(.5)
        difference.Add(histograms[i], -1.)
        difference.Divide(average)
        difference.Draw("e"+"same"*(i>1))
        difference.GetYaxis().SetLabelSize(.07)
        difference.GetXaxis().SetLabelSize(.1)
        difference.GetXaxis().SetRange(20, 50)
        difference.GetXaxis().SetTitle("Decay electron p_{t} [GeV]")
        difference.GetYaxis().SetTitle("% difference from standard")
        difference.GetXaxis().SetTitleSize(.1)
        difference.GetYaxis().SetTitleSize(.07)
        difference.GetYaxis().SetTitleOffset(.65)
        difference.SetMinimum(-0.08)
        difference.SetLineColor(colors[i % len(colors)])
        differences.append(difference)
   # pt.Draw()
    i = 0
    for diff in differences:
        p2.cd()
        diff.Draw("hist"+"C"+"same"*(i>0))
        print "hist"+"C"+"same"*(i>0)
        i += 1
    c.Update()
  #  chiSquared = 0.0
  #  for ibin in range(minPt*100/rebin, maxPt*100/rebin+1): #bin width in Wana is 10MeV
  #      chiSquared += ((histograms[0].GetBinContent(ibin) - histograms[1].GetBinContent(ibin))**2)/((histograms[1].GetBinError(ibin))**2)
  #  print chiSquared
  #  p3 = c.cd(3)
  #  p3.SetPad(0,0,1,.15)
  #  pt = ROOT.TPaveText(.05,.1,.95,.8)
  #  pt.AddText("#Chi^{2}="+str(chiSquared)+", \\frac{#Chi^{2}}{Nbins}="+str(chiSquared/((maxPt-minPt)*100)))
  #  pt.Draw()
  #  c.Update()
    c.SaveAs("TripleLine.eps")
    raw_input()
file1 = ROOT.TFile.Open(sys.argv[1]) 
file2 = ROOT.TFile.Open(sys.argv[2]) 
file3 = ROOT.TFile.Open(sys.argv[3]) 
pt_1 = file1.Get("wana/pte")
pt_2 = file2.Get("wana/pte")
pt_3 = file3.Get("wana/pte")

plot_same_normalized([pt_1, pt_2, pt_3]) 
