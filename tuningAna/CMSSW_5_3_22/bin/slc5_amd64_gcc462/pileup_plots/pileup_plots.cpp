// Standard Library
#include <iostream>
#include <string>

// ROOT
#include <TTree.h>
#include <TFile.h>
#include <TBranch.h>
#include <TH1D.h>
//#include <TIter.h>


int main() {
    //Structure outlining the branch
    struct branch_struct {
        double z_m;
        double z_y;
        double z_phistar_born;
        double z_phistar_dressed;
        double z_phistar_naked;
        double z_phistar_sc;
        double z_pt;
        double z_eta;
        double e_pt[2];
        double e_eta[2];
        double e_phi[2];
        double n_true_pileup;
        int e_charge[2];
        int n_verts;
    } mc_truth_branch, mc_reco_branch, data_reco_branch;

    // Input Files
    const std::string MC_FILE =
        "/data/whybee0a/user/gude_2/MC/20150305_MC_CTEQ6LL/MadGraph_hadded.root";
    const std::string DATA_FILE =
        "/data/whybee0a/user/gude_2/Data/20150304_SingleElectron_2012ALL/20150304_SingleElectron_2012ALL_hadded.root";

    // Tree
    const std::string TREE_NAME =
        "ZFinder/Combined Single Reco/Combined Single Reco";

    // Open the TFiles
    TFile* mc_tfile = new TFile(MC_FILE.c_str(), "READ");
    if (!mc_tfile) {
        std::cout << "Failed to read TFile: " << MC_FILE << std::endl;
        return EXIT_FAILURE;
    }
    TFile* data_tfile = new TFile(DATA_FILE.c_str(), "READ");
    if (!data_tfile) {
        std::cout << "Failed to read TFile: " << DATA_FILE << std::endl;
        return EXIT_FAILURE;
    }

    // Load the tree
    TTree* mc_tree;
    mc_tfile->GetObject(TREE_NAME.c_str(), mc_tree);
    if (!mc_tree) {
        std::cout << "Failed to load the tree: " << TREE_NAME << std::endl;
        return EXIT_FAILURE;
    }
    TTree* data_tree;
    mc_tfile->GetObject(TREE_NAME.c_str(), data_tree);
    if (!data_tree) {
        std::cout << "Failed to load the tree: " << TREE_NAME << std::endl;
        return EXIT_FAILURE;
    }

    // Open a new file and histogram
    TFile outfile("outfile.root", "RECREATE");
    outfile.cd();

    // Get the branch
    mc_tree->SetBranchAddress("truth", &mc_truth_branch);
    mc_tree->SetBranchAddress("reco", &mc_reco_branch);
    data_tree->SetBranchAddress("reco", &data_reco_branch);

    //std::cout << "Branch list:\n";
    //TIter next(mc_tree->GetListOfBranches());
    //TBranch *branch;
    //while((branch = (TBranch *)next())){
    //    std::cout<< "\t"<<branch->GetName()<<std::endl;
    //}

    //TIter next2(data_tree->GetListOfBranches());
    //while((branch = (TBranch *)next2())){
    //    std::cout<< "\t"<<branch->GetName()<<std::endl;
    //}

    std::cout << "MC Truth: " << mc_tree->GetBranchStatus("truth");
    std::cout << " MC Reco: " << mc_tree->GetBranchStatus("reco");
    std::cout << " Data Reco: " << data_tree->GetBranchStatus("reco");
    std::cout << " BULLSHIT: " << data_tree->GetBranchStatus("BS");

    // Make the histrograms
    TH1D* mc_num_histo = new TH1D("mc_num", "mc_num", 100, 0, 100);
    TH1D* mc_true_num_histo = new TH1D("mc_true_num", "mc_true_num", 100, 0, 100);
    TH1D* mc_reco_histo = new TH1D("mc_reco", "mc_reco", 100, 0, 100);
    TH1D* data_reco_histo = new TH1D("data_reco", "data_reco", 100, 0, 100);
    for (int i = 0; i < mc_tree->GetEntries(); i++) {
        mc_tree->GetEntry(i);
        mc_num_histo->Fill(mc_truth_branch.n_verts);
        mc_true_num_histo->Fill(mc_truth_branch.n_true_pileup);
        mc_reco_histo->Fill(mc_reco_branch.n_verts);
        //std::cout << std::endl;
        //std::cout << "z_m " << mc_reco_branch.z_m << std::endl;
        //std::cout << "z_m " << mc_truth_branch.z_m << std::endl;
        //std::cout << "z_y " << mc_reco_branch.z_y << std::endl;
        //std::cout << "z_phistar_born " << mc_reco_branch.z_phistar_born << std::endl;
        //std::cout << "z_phistar_dressed " << mc_reco_branch.z_phistar_dressed << std::endl;
        //std::cout << "z_phistar_naked " << mc_reco_branch.z_phistar_naked << std::endl;
        //std::cout << "z_phistar_sc " << mc_reco_branch.z_phistar_sc << std::endl;
        //std::cout << "z_pt " << mc_reco_branch.z_pt << std::endl;
        //std::cout << "z_eta " << mc_reco_branch.z_eta << std::endl;
        //std::cout << "e_pt[0] " << mc_reco_branch.e_pt[0] << std::endl;
        //std::cout << "e_pt[1] " << mc_reco_branch.e_pt[1] << std::endl;
        //std::cout << "e_eta[0] " << mc_reco_branch.e_eta[0] << std::endl;
        //std::cout << "e_eta[1] " << mc_reco_branch.e_eta[1] << std::endl;
        //std::cout << "e_phi[0] " << mc_reco_branch.e_phi[0] << std::endl;
        //std::cout << "e_phi[1] " << mc_reco_branch.e_phi[1] << std::endl;
        //std::cout << "n_true_pileup " << mc_reco_branch.n_true_pileup << std::endl;
        //std::cout << "e_charge[0] " << mc_reco_branch.e_charge[0] << std::endl;
        //std::cout << "e_charge[1] " << mc_reco_branch.e_charge[1] << std::endl;
        //std::cout << "n_verts " << mc_reco_branch.n_verts << std::endl;
    }
    for (int i = 0; i < data_tree->GetEntries(); i++) {
        data_tree->GetEntry(i);
        data_reco_histo->Fill(data_reco_branch.n_verts);
        //std::cout << "z_m " << data_reco_branch.z_m << std::endl;
    }

    outfile.Write();
    outfile.Close();

    return EXIT_SUCCESS;
}
