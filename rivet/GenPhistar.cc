// -*- C++ -*-
//
// Package:    GenPhistar
// Class:      GenPhistar
//
/**\class GenPhistar GenPhistar.cc ZFinder/GenPhistar/src/GenPhistar.cc

Description: [one line class summary]

Implementation:
[Notes on implementation]
*/
//
// Original Author:  Alexander Gude
//         Created:  Mon May 11 12:01:16 CDT 2015
// $Id$
//
//


// system include files
#include <memory>

// user include files
#include "FWCore/Framework/interface/Frameworkfwd.h"
#include "FWCore/Framework/interface/EDAnalyzer.h"

#include "FWCore/Framework/interface/Event.h"
#include "FWCore/Framework/interface/MakerMacros.h"

#include "FWCore/ParameterSet/interface/ParameterSet.h"

// CMSSW
#include "FWCore/ServiceRegistry/interface/Service.h" // edm::Service
#include "CommonTools/UtilAlgos/interface/TFileService.h" // TFileService
#include "DataFormats/HepMCCandidate/interface/GenParticle.h"  // reco::GenParticle

// ROOT
#include <TTree.h>
#include <TH1D.h>
#include <TH2D.h>
//
// class declaration
//
//
double ReturnPhistar(const double& eta0, const double& phi0, const double& eta1, const double& phi1) {
    /* Calculate phi star */
    static const double PI = 3.14159265358979323846;
    double dphi = phi0 - phi1;

    // Properly account for the fact that 2pi == 0.
    if (dphi < 0){
        if (dphi > -PI){
            dphi = fabs(dphi);
        }
        if (dphi < -PI) {
            dphi += 2*PI;
        }
    }
    if (dphi > PI){
        dphi = 2*PI - dphi;
    }

    const double DETA = fabs(eta0 - eta1);

    /* PhiStar */
    return ( 1 / cosh( DETA / 2 ) ) * (1 / tan( dphi / 2 ) );
}

bool PassAcceptance(const double& eta0, const double& pt0, const double& eta1, const double& pt1) {
    if (fabs(eta0) < 2.1 && fabs(eta1) < 2.4 && pt0 > 30 && pt1 > 20 ) {
        return true;
    }
    else if (fabs(eta1) < 2.1 && fabs(eta0) < 2.4 && pt1 > 30 && pt0 > 20) {
        return true;
    }
    return false;
    //mass cut in main code body
}

class GenPhistar : public edm::EDAnalyzer {
    public:
        explicit GenPhistar(const edm::ParameterSet&);
        ~GenPhistar();

        static void fillDescriptions(edm::ConfigurationDescriptions& descriptions);


    private:
        virtual void beginJob() ;
        virtual void analyze(const edm::Event&, const edm::EventSetup&);
        virtual void endJob() ;

        virtual void beginRun(edm::Run const&, edm::EventSetup const&);
        virtual void endRun(edm::Run const&, edm::EventSetup const&);
        virtual void beginLuminosityBlock(edm::LuminosityBlock const&,
                                          edm::EventSetup const&);
        virtual void endLuminosityBlock(edm::LuminosityBlock const&,
                                        edm::EventSetup const&);

        // ----------member data ---------------------------
        TTree* ttree_;
        double phistarBorn_;
        double phistarBare_;
        double mz_;
        double Yz_;
        TH1D* counter_;
        int zCounter_;
        TH1D* phistarBornHist_;
        TH1D* phistarBareHist_;
        TH1D* mzBorn_;
        TH1D* mzBare_;
        TH2D* phistarYzBorn_;
        TH2D* phistarYzBare_;
        static double bins_ [37];
};

//
// constants, enums and typedefs
//

//
// static data member definitions
//

    double GenPhistar::bins_ [37] = {0.000, 0.004, 0.008, 0.012, 0.016, 0.020, 0.024, 0.029, 0.034, 0.039,
                                     0.045, 0.052, 0.057, 0.064, 0.072, 0.081, 0.091, 0.102, 0.114, 0.128,
                                     0.145, 0.165, 0.189, 0.219, 0.258, 0.312, 0.391, 0.524, 0.695, 0.918,
                                     1.153, 1.496, 1.947, 2.522, 3.277,5.0,10.0};
//
// constructors and destructor
//
GenPhistar::GenPhistar(const edm::ParameterSet& iConfig) {
    //now do what ever initialization is needed
}


GenPhistar::~GenPhistar() {
    // do anything here that needs to be done at destruction time
    // (e.g. close files, deallocate resources etc.)
}


//
// member functions
//

// ------------ method called for each event  ------------
void GenPhistar::analyze(const edm::Event& iEvent, const edm::EventSetup& iSetup) {
    using namespace edm;

    // Count every event so we can normalize by the cross section later
    counter_->Fill(1);

    // Only check for a truth Z in MC
    if (!iEvent.isRealData()){
        // Must be Z->ee
        const int ZBOSON = 23;
        const int ELECTRON = 11;
        bool has_z = false;
        edm::Handle<reco::GenParticleCollection> mc_particles;
        iEvent.getByLabel("genParticles", mc_particles);
        const reco::GenParticle *e01(0), *e11(0), *e03(0), *e13(0);
        for (unsigned int i = 0; i < mc_particles->size(); ++i) {
            const reco::GenParticle* gen_particle = &mc_particles->at(i);
            //std::cout << gen_particle->pdgId() << ' ' << gen_particle->numberOfDaughters() << std::endl;
            // Is a Z
            if (abs(gen_particle->pdgId()) == ELECTRON) {
//                std::cout << "An electron of status " <<gen_particle->status()  <</* " is part of the hard process "<< gen_particle->isHardProcess()<<*/ " pt " <<gen_particle->pt()<< " type "<< gen_particle->pdgId()<<std::endl;
            }
            if (gen_particle->pdgId() == ZBOSON) {
                has_z = true;
//                std::cout << "I got one!" << std::endl;
                zCounter_++;
//                std::cout << "With status: "<< gen_particle->status() << std::endl;
            }
            else if (gen_particle->pdgId() == ELECTRON && gen_particle->status() == 23) {
                //born
//                std::cout << "Born electron" << std::endl;
                e03 = gen_particle;
            }
            else if (gen_particle->pdgId() == -ELECTRON && gen_particle->status() == 23) {
//                std::cout << "Born positron" << std::endl;
                e13 = gen_particle;
            }
            else if (gen_particle->pdgId() == ELECTRON && gen_particle->status() == 1) {
//                std::cout << "Bare electron" << std::endl;
                //bare
                e01 = gen_particle;
            }
            else if (gen_particle->pdgId() == -ELECTRON && gen_particle->status() == 1) {
//                std::cout << "Bare positron" << std::endl;
                e11 = gen_particle;
            }
        }
        if (!has_z) return;
        if (e13 != 0 && e03 != 0) { //born
            if (PassAcceptance(e13->eta(), e13->pt(), e03->eta(), e03->pt())) {
                const double ELECTRON_MASS = 5.109989e-4;
                math::PtEtaPhiMLorentzVector e13lv(e13->pt(), e13->eta(), e13->phi(), ELECTRON_MASS);
                math::PtEtaPhiMLorentzVector e03lv(e03->pt(), e03->eta(), e03->phi(), ELECTRON_MASS);
                math::PtEtaPhiMLorentzVector zlv;
                zlv = e13lv + e03lv;

                double m = zlv.mass();
                if(m <= 60 || m >= 120) return;
                double y = zlv.Rapidity();
                double pt = zlv.pt();
                double phistar = ReturnPhistar(e03->eta(), e03->phi(), e13->eta(), e13->phi());
                double eta = zlv.eta();

                //std::cout<<"aaand our phistar is "<<phistar<<std::endl;
                // Add to tree
                Yz_=y;
                mz_ = m;
                phistarBorn_ = phistar;
                if(phistar<10.0)ttree_->Fill();
                if(phistar<10.0){ 
                    phistarBornHist_->Fill(phistar);
                    mzBorn_->Fill(m);
                    phistarYzBorn_->Fill(phistar,y);
                }
            }
        }
        if (e11 != 0 && e01 != 0) { //bare
            if (PassAcceptance(e11->eta(), e11->pt(), e01->eta(), e01->pt())) {
                const double ELECTRON_MASS = 5.109989e-4;
                math::PtEtaPhiMLorentzVector e01lv(e01->pt(), e01->eta(), e01->phi(), ELECTRON_MASS);
                math::PtEtaPhiMLorentzVector e11lv(e11->pt(), e11->eta(), e11->phi(), ELECTRON_MASS);
                math::PtEtaPhiMLorentzVector zlv;
                zlv = e01lv + e11lv;

                double m = zlv.mass();
                if(m <= 60 || m >= 120) return;
                double y = zlv.Rapidity();
                double pt = zlv.pt();
                double phistar = ReturnPhistar(e01->eta(), e01->phi(), e11->eta(), e11->phi());
                double eta = zlv.eta();

                //std::cout<<"aaand our phistar is "<<phistar<<std::endl;
                // Add to tree
                Yz_=y;
                mz_ = m;
                phistarBare_ = phistar;
                //if(phistar<3.277)ttree_->Fill();
                if(phistar<3.277){
                    phistarBareHist_->Fill(phistar);
                    mzBare_->Fill(m);
                    phistarYzBare_->Fill(phistar,y);
                }
            }
        }
    }
    // Only works on MC
    else {
        return;
    }
}


// ------------ method called once each job just before starting event loop  ------------
void GenPhistar::beginJob() {
    edm::Service<TFileService> fs;
    ttree_ = fs->make<TTree>("tree", "tree");
    ttree_->Branch("phistar_born", &phistarBorn_);
    ttree_->Branch("phistar_bare", &phistarBare_);
    ttree_->Branch("mz", &mz_);
    ttree_->Branch("Yz", &Yz_);
    phistarBornHist_ = fs->make<TH1D>("phistarBorn","Born Phistar", 34, bins_);
    phistarBareHist_ = fs->make<TH1D>("phistarBare","Bare Phistar", 34, bins_);
    mzBorn_ = fs->make<TH1D>("mzBorn","Z boson mass born", 120, 60., 120.);
    mzBare_ = fs->make<TH1D>("mzBare","Z boson mass bare", 120, 60., 120.);
    phistarYzBorn_ = fs->make<TH2D>("phistarYzBorn","Phistar and Z rapidity Born", 34, bins_, 60, -3., 3.);
    phistarYzBare_ = fs->make<TH2D>("phistarYzBare","Phistar and Z rapidity Bare", 34, bins_, 60, -3., 3.);
    counter_ = fs->make<TH1D>("counter", "counter", 3, 0, 3);
    zCounter_ = 0;
}

// ------------ method called once each job just after ending the event loop  ------------
void GenPhistar::endJob() {
    std::cout << "Number of Zs wrangled: " << zCounter_ << std::endl;
    double error = 0.;
    for(int ibin = 1; ibin <= phistarBareHist_->GetNbinsX(); ibin++)
    {
        error = phistarBareHist_->GetBinError(ibin);
        phistarBareHist_->SetBinContent(ibin, phistarBareHist_->GetBinContent(ibin)/phistarBareHist_->GetBinWidth(ibin));
        phistarBareHist_->SetBinError(ibin, error/phistarBareHist_->GetBinWidth(ibin));
        error = phistarBornHist_->GetBinError(ibin);
        phistarBornHist_->SetBinContent(ibin, phistarBornHist_->GetBinContent(ibin)/phistarBornHist_->GetBinWidth(ibin));
        phistarBornHist_->SetBinError(ibin, error/phistarBornHist_->GetBinWidth(ibin));
    }
}

// ------------ method called when starting to processes a run  ------------
void GenPhistar::beginRun(edm::Run const&, edm::EventSetup const&) {
}

// ------------ method called when ending the processing of a run  ------------
void GenPhistar::endRun(edm::Run const&, edm::EventSetup const&) {
}

// ------------ method called when starting to processes a luminosity block  ------------
void GenPhistar::beginLuminosityBlock(edm::LuminosityBlock const&, edm::EventSetup const&) {
}

// ------------ method called when ending the processing of a luminosity block  ------------
void GenPhistar::endLuminosityBlock(edm::LuminosityBlock const&,
                               edm::EventSetup const&) {
}

// ------------ method fills 'descriptions' with the allowed parameters for the module  ------------
void GenPhistar::fillDescriptions(edm::ConfigurationDescriptions& descriptions) {
    //The following says we do not know what parameters are allowed so do no validation
    // Please change this to state exactly what you do use, even if it is no parameters
    edm::ParameterSetDescription desc;
    desc.setUnknown();
    descriptions.addDefault(desc);
}

//define this as a plug-in
DEFINE_FWK_MODULE(GenPhistar);
