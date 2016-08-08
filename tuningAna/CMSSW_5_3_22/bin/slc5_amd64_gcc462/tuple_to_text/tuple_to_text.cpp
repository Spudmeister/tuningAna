// Standard Library
#include <iostream>
#include <string>

// ROOT
#include <TTree.h>
#include <TFile.h>
#include <TBranch.h>
#include <TLeaf.h>


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
    // Input Files
    const std::string MC_FILE =
        "/data/whybee0a/user/gude_2/MC/20150306_MC_CTEQ6LL_muons_status_1/MadGraph/hadded.root";

    // Tree
    const std::string TREE_NAME =
        "ZFinder/Combined Gen Cuts Reco/Combined Gen Cuts Reco";

    // Load the tree
    TTree* tree = GetTTree(MC_FILE, TREE_NAME);

    // Get the branch
    TBranch* reco_branch = tree->GetBranch("reco");
    TLeaf* Event

    // Text file
    std::cout << "#event_number" << ", ";
    std::cout << "e_pt[0]" << ", ";
    std::cout << "e_eta[0]" << ", ";
    std::cout << "e_phi[0]" << ", ";
    std::cout << "e_charge[0]" << ", ";
    std::cout << "e_pt[1]" << ", ";
    std::cout << "e_eta[1]" << ", ";
    std::cout << "e_phi[1]" << ", ";
    std::cout << "e_charge[1]" << ", ";
    std::cout << "z_m" << ", ";
    std::cout << "z_y" << ", ";
    std::cout << "z_phistar_dressed";
    std::cout << std::endl;
    std::cout << tree->GetEntries() << std::endl;
    for (int i = 0; i < tree->GetEntries(); i++) {
        tree->GetEntry(i);
        // Make the text file
        std::cout << event_branch.event_number << ", ";
        std::cout << truth_branch.e_pt[0] << ", ";
        std::cout << truth_branch.e_eta[0] << ", ";
        std::cout << truth_branch.e_phi[0] << ", ";
        std::cout << truth_branch.e_charge[0] << ", ";
        std::cout << truth_branch.e_pt[1] << ", ";
        std::cout << truth_branch.e_eta[1] << ", ";
        std::cout << truth_branch.e_phi[1] << ", ";
        std::cout << truth_branch.e_charge[1] << ", ";
        std::cout << truth_branch.z_m << ", ";
        std::cout << truth_branch.z_y << ", ";
        std::cout << truth_branch.z_phistar_dressed;
        std::cout << std::endl;
    }

    return EXIT_SUCCESS;
}
