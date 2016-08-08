#!/usr/bin/env python

import ROOT
import array
import sys

DOUBLE = 'd'

BINS = array.array(
        DOUBLE,
        sorted([
            0.000, 0.004, 0.008, 0.012, 0.016, 0.020, 0.024, 0.029, 0.034, 0.039,
            0.045, 0.052, 0.057, 0.064, 0.072, 0.081, 0.091, 0.102, 0.114, 0.128,
            0.145, 0.165, 0.189, 0.219, 0.258, 0.312, 0.391, 0.524, 0.695, 0.918,
            1.153, 1.496, 1.947, 2.522, 3.277,
            ])
        )

output_file = ROOT.TFile("output.root", "RECREATE")

i = 0
for arg in sys.argv[1:]:
    i+=1

    output_file.cd()
    histo = ROOT.TH1D("phi_"+str(i), "phi_"+str(i), len(BINS)-1, BINS)

    input_file = ROOT.TFile.Open(arg, "READ")
    tree = ROOT.TTree()
    tdir = input_file.demo.GetObject("tree", tree)
    for event in tree:
        histo.Fill(event.phistar)

    output_file.cd()
    histo.Write()

output_file.Write()
output_file.Close()
