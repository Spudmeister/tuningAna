// Standard Library
#include <stdexcept>
#include <iostream>
#include <sstream>

// ROOT
#include <TFile.h>
#include <TBranch.h>
#include <TCanvas.h>
#include <TTree.h>
#include <TLeaf.h>
#include <TLegend.h>
#include <TLatex.h>
#include <TH1D.h>

// Style
//#include "PlotStyle.h"

// ZFinder
#include "../../interface/ATLASBins.h"  // ATLAS_PHISTAR_BINNING

TTree* GetTTree(const std::string TFILE, const std::string TTREE) {
    // Open the TFiles
    TFile* mc_tfile = new TFile(TFILE.c_str(), "READ");
    if (!mc_tfile || mc_tfile->IsZombie()) {
        const std::string ERR = "Could not open the file " + TFILE;
        throw std::runtime_error(ERR);
    }

    // Load the tree
    TTree* tree = new TTree();
    mc_tfile->GetObject(TTREE.c_str(), tree);
    if (!tree || tree->IsZombie()) {
        const std::string ERR = "Could not open the TTree " + TTREE;
        throw std::runtime_error(ERR);
    }

    return tree;
}

int main() {
    const std::string MC_FILE = "/data/whybee0a/user/gude_2/MC/20150409_mc/MadGraph_hadded.root";
    const std::string ACC_NAME = "ZFinder/Combined Gen Cuts Reco/Combined Gen Cuts Reco";
    const std::string ALL_CUTS_NAME = "ZFinder/Combined Single Reco/Combined Single Reco";
    TTree* acc_tree = GetTTree(MC_FILE, ACC_NAME);
    TTree* all_cuts_tree = GetTTree(MC_FILE, ALL_CUTS_NAME);

    // Histos to fill
    TH1D* phistar_histo_acc = new TH1D("phistar_acc", "QCD Phistar;#phi*;Acceptance Rate", zf::ATLAS_PHISTAR_BINNING.size() - 1, &zf::ATLAS_PHISTAR_BINNING[0]);
    TH1D* phistar_histo_all = new TH1D("phistar_all", "QCD Phistar;#phi*;Acceptance Rate", zf::ATLAS_PHISTAR_BINNING.size() - 1, &zf::ATLAS_PHISTAR_BINNING[0]);
    phistar_histo_acc->Sumw2();
    phistar_histo_all->Sumw2();

    // Read the trees
    TBranch* reco_branch_acc = acc_tree->GetBranch("reco");
    TLeaf* phistar_acc = reco_branch_acc->GetLeaf("z_phistar_dressed");
    for (int i = 0; i < acc_tree->GetEntries(); i++) {
        acc_tree->GetEntry(i);
        phistar_histo_acc->Fill(phistar_acc->GetValue());
    }

    TBranch* reco_branch_all = all_cuts_tree->GetBranch("reco");
    TLeaf* phistar_all = reco_branch_all->GetLeaf("z_phistar_dressed");
    for (int i = 0; i < all_cuts_tree->GetEntries(); i++) {
        all_cuts_tree->GetEntry(i);
        phistar_histo_all->Fill(phistar_all->GetValue());
    }

    // Divide
    phistar_histo_all->Divide(phistar_histo_acc);

    // Open a tfile to save our histos
    TFile output_file("output.root", "RECREATE");
    output_file.cd();

    phistar_histo_all->Write();

    output_file.Write();
    output_file.Close();

    return EXIT_SUCCESS;
}
