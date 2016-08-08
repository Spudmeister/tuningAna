// -*- C++ -*-
//
// Package:    Wana
// Class:      Wana
// 
/**\class Wana Wana.cc ZFinder/Wana/src/Wana.cc

Description: [one line class summary]

Implementation:
[Notes on implementation]
*/
//
// Original Author:  Andrew Evans
//         Created:  Tue Oct 27 11:24:07 CDT 2015
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

// CMSSW
#include "FWCore/ServiceRegistry/interface/Service.h" // edm::Service
#include "CommonTools/UtilAlgos/interface/TFileService.h" // TFileService
#include "DataFormats/HepMCCandidate/interface/GenParticle.h"  // reco::GenParticle

// ROOT
//#include <TTree.h>
#include <TH1D.h>
#include "FWCore/ParameterSet/interface/ParameterSet.h"



class Wana : public edm::EDAnalyzer {
    public:
        explicit Wana(const edm::ParameterSet&);
        ~Wana();

        static void fillDescriptions(edm::ConfigurationDescriptions& descriptions);


    private:
        virtual void beginJob() ;
        virtual void analyze(const edm::Event&, const edm::EventSetup&);
        virtual void endJob() ;

        virtual void beginRun(edm::Run const&, edm::EventSetup const&);
        virtual void endRun(edm::Run const&, edm::EventSetup const&);
        virtual void beginLuminosityBlock(edm::LuminosityBlock const&, edm::EventSetup const&);
        virtual void endLuminosityBlock(edm::LuminosityBlock const&, edm::EventSetup const&);

        // ----------member data ---------------------------
};

//
// constants, enums and typedefs
//
    TH1D* pt;
    TH1D* mW;
//
// static data member definitions
//

//
// constructors and destructor
//
Wana::Wana(const edm::ParameterSet& iConfig)

{
    //now do what ever initialization is needed
    edm::Service<TFileService> fs;
    pt = fs->make<TH1D>("pte","pt of W decay electron", 8000, 0., 80.);
    mW = fs->make<TH1D>("massW","mass of W boson",8000,40.,120.);
}


Wana::~Wana()
{

    // do anything here that needs to be done at desctruction time
    // (e.g. close files, deallocate resources etc.)

}


//
// member functions
//

// ------------ method called for each event  ------------
    void
Wana::analyze(const edm::Event& iEvent, const edm::EventSetup& iSetup)
{
//    std::cout << "NEW EVENT" << std::endl;
    using namespace edm;
  //  const int ELECTRON = 11;
    edm::Handle<reco::GenParticleCollection> mc_particles;
    iEvent.getByLabel("genParticles", mc_particles);
    for (unsigned int i = 0; i < mc_particles->size(); ++i)
    {
      //  if(abs(mc_particles->at(i).pdgId()) != 21 && abs(mc_particles->at(i).pdgId()) != 22/* && mc_particles->at(i).status() == 23*/)
      //  {
      //      std::cout << "I got a: "<< mc_particles->at(i).pdgId() <<" status: " << mc_particles->at(i).status() << std::endl;
      //  }

        const reco::GenParticle* genParticle = &mc_particles->at(i);

        if(abs(genParticle->pdgId()) == 24)
        {
        //    std::cout << "Found a W with " << genParticle->numberOfDaughters() << " daughters\n";

            for(size_t i=0; i < genParticle->numberOfDaughters(); ++i)
            {
                const reco::GenParticle * daughter = dynamic_cast<const reco::GenParticle *>(genParticle->daughter(i));
           //     std::cout << "Daughter " << i << " has ID " << daughter->pdgId() << std::endl;
           //     std::cout << "Daughter " << i << " has status " << daughter->status() << std::endl;
           //     std::cout << "Daughter has " << daughter->numberOfDaughters() << " daughters\n";
                if (abs(daughter->pdgId()) == 11){  
                    mW->Fill(genParticle->mass());
                    pt->Fill(daughter->pt());
                }

        //        for(size_t j=0; j < daughter->numberOfDaughters(); ++j)
        //        {
        //            const reco::GenParticle * sub_daughter = dynamic_cast<const reco::GenParticle *>(daughter->daughter(j));
        //            std::cout << "sub Daughter " << j << " has ID " << sub_daughter->pdgId() << std::endl;
        //            std::cout << "sub Daughter " << j << " has status " << sub_daughter->status() << std::endl;
              //  }
            }
        }
    }
}


// ------------ method called once each job just before starting event loop  ------------
    void 
Wana::beginJob()
{
}

// ------------ method called once each job just after ending the event loop  ------------
    void 
Wana::endJob() 
{
}

// ------------ method called when starting to processes a run  ------------
    void 
Wana::beginRun(edm::Run const&, edm::EventSetup const&)
{
}

// ------------ method called when ending the processing of a run  ------------
    void 
Wana::endRun(edm::Run const&, edm::EventSetup const&)
{
}

// ------------ method called when starting to processes a luminosity block  ------------
    void 
Wana::beginLuminosityBlock(edm::LuminosityBlock const&, edm::EventSetup const&)
{
}

// ------------ method called when ending the processing of a luminosity block  ------------
    void 
Wana::endLuminosityBlock(edm::LuminosityBlock const&, edm::EventSetup const&)
{
}

// ------------ method fills 'descriptions' with the allowed parameters for the module  ------------
void
Wana::fillDescriptions(edm::ConfigurationDescriptions& descriptions) {
    //The following says we do not know what parameters are allowed so do no validation
    // Please change this to state exactly what you do use, even if it is no parameters
    edm::ParameterSetDescription desc;
    desc.setUnknown();
    descriptions.addDefault(desc);
}

//define this as a plug-in
DEFINE_FWK_MODULE(Wana);
