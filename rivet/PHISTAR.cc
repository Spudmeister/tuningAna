//====================================================================//=//
//     THIS RIVET CODE IS DESIGNED TO FOLLOW THE GENPHISTAR.CC CODE
//     WRITTEN BY A. GUDE IN HIS ZFINDER ANALYSISIN ORDER TO CALCULATE 
//     THE PHISTAR VARIABLE WITH ELECTRONS FROM A Z BOSON DECAY
//
//     AUTHOR: ANDREW.CHISTOPHER.EVANS@CERN.CH CREATED: 8-AUG-2016
//
//====================================================================//=//
// -*- C++ -*-
#include "Rivet/Analysis.hh"
#include "Rivet/Projections/FinalState.hh"
#include "Rivet/Projections/ChargedLeptons.hh"
#include "Rivet/Projections/NeutralFinalState.hh"
#include "Rivet/Projections/IdentifiedFinalState.hh"
#include <iostream>


namespace Rivet {

  class PHISTAR : public Analysis {
  public:
    // Constructor
    PHISTAR() : Analysis("PHISTAR") {
    }

  public:
    // Book histograms and initialise projections before the run
    void init() {
      IdentifiedFinalState electrons;
      electrons.acceptIdPair(PID::ELECTRON);
      addProjection(electrons, "Electrons");
      static const double bins[] = {0.000, 0.004, 0.008, 0.012, 0.016, 0.020, 0.024, 0.029, 0.034, 0.039,
                                     0.045, 0.052, 0.057, 0.064, 0.072, 0.081, 0.091, 0.102, 0.114, 0.128,
                                     0.145, 0.165, 0.189, 0.219, 0.258, 0.312, 0.391, 0.524, 0.695, 0.918,
                                     1.153, 1.496, 1.947, 2.522, 3.277,5.0,10.0};
      std::vector<double> bins_ (bins, bins + sizeof(bins) / sizeof(bins[0]) );

      _hist_phistar           = bookHisto1D("Phistar", bins_);  // phistar
    }


    //Phistar calculator
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

    // Perform the per-event analysis
    void analyze(const Event& event) {
      std::cout << "ANALYZING EVENT" << std::endl;
      const double weight = event.weight();


      Particles electrons = applyProjection<IdentifiedFinalState>(event, "Electrons").particlesByPt();
      //Now we make event cuts
      std::cout << "Checking size of electrons: "<< electrons.size() << std::endl;
      //std::cout << "Checking energy of first electron: " <<electrons[0].pT()/GeV << std::endl;
      if (electrons[0].pT()/GeV < 30) vetoEvent;
      for(int i = 0; i < electrons.size(); i++){ 
        std::cout << "Pt of electron "<<i<<": " <<electrons[i].pT()/GeV<< std::endl;
        std::cout << "Charge of electron "<<i<<": "<< electrons[i].charge() << std::endl;
        std::cout << "Pseudorapidity of electron "<<i<<": "<< electrons[i].momentum().abseta() << std::endl;
      }
      //std::cout << "And of the 2nd electron: " <<electrons[1].pT()/GeV<< std::endl;
      if (electrons[1].pT()/GeV < 20) vetoEvent;
      //std::cout << "Checking the multiple of the first two electron's charge"<< electrons[0].charge()*electrons[1].charge() << std::endl;
      if (electrons[0].charge()*electrons[1].charge()>0) vetoEvent;
      if (electrons.size()<2) vetoEvent;
      double M = (electrons[0].momentum() + electrons[1].momentum()).mass()/GeV;
      std::cout << "Checking the mass of the two combined: "<<M << std::endl;
      if (M<60 || M >120) vetoEvent;
      //std::cout << "Checking pseudorapidity of 1st electron: "<<electrons[0].momentum().abseta() << std::endl;
      if (electrons[0].momentum().abseta() > 2.1) vetoEvent;
      //std::cout << "Checking pseudorapidity of 2nd electron: "<<electrons[0].momentum().abseta() << std::endl;
      if (electrons[1].momentum().eta() > 2.4) vetoEvent;
      double phistar = ReturnPhistar(electrons[0].momentum().eta(), electrons[0].momentum().phi(), electrons[1].momentum().eta(), electrons[1].momentum().phi());
      std::cout << "PHISTAR CALCULATED FOR EVENT IS: " << phistar << std::endl;
      _hist_phistar->fill(phistar);
    } 


    /// Normalise histograms etc., after the run
    void finalize() {
      scale(_hist_phistar,       crossSection() / sumOfWeights());
    }

  private:
    Histo1DPtr  _hist_phistar;
  };

  DECLARE_RIVET_PLUGIN(PHISTAR);
}
