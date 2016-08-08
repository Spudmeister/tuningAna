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


namespace Rivet {

  class PHISTAR : public Analysis {
  public:
    // Constructor
    PHISTAR() : Analysis("PHISTAR") {
    }

  public:
    // Book histograms and initialise projections before the run
    void init() {
      Cut c_electrons   = (Cuts::pT>9*GeV) & (Cuts::abseta<3.0); 
      IdentifiedFinalState electrons(c_electrons);
      electrons.acceptId(PID::ELECTRON);
      addProjection(electrons, "ELECFS");
      


      _hist_phistar           = bookHisto1D(1, 1, 1);  // photon transverse energy
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

      const double weight = event.weight();


      Particles electrons = applyProjection<IdentifiedFinalState>(event, "ELECFS").particlesByPt();
      //Now we make event cuts
      if (electrons.size()<2) vetoEvent;
      if (electrons[0].pT()/GeV < 30) vetoEvent;
      if (electrons[1].pT()/GeV < 20) vetoEvent;
      if (electrons[0].charge()*electrons[1].charge()>0) vetoEvent;
      double M = (electrons[0].momentum() + electrons[1].momentum()).mass()/GeV;
      if (M<60 || M >120) vetoEvent;
      if (electrons[0].momentum().abseta() > 2.1) vetoEvent;
      if (electrons[1].momentum().eta() > 2.4) vetoEvent;

      _hist_phistar->fill(ReturnPhistar(electrons[0].momentum().eta(), electrons[0].momentum().phi(), electrons[1].momentum().eta(), electrons[1].momentum().phi()));
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
