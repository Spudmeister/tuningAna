// -*- C++ -*-
#include "Rivet/Analysis.hh"
#include "Rivet/Projections/FinalState.hh"
#include "Rivet/Projections/ChargedLeptons.hh"
#include "Rivet/Projections/NeutralFinalState.hh"
#include "Rivet/Projections/IdentifiedFinalState.hh"


namespace Rivet {

  class phistar : public Analysis {
  public:
    // Constructor
    phistar() : Analysis("PHISTAR") {
    }

  public:
    // Book histograms and initialise projections before the run
    void init() {
      
      Cut c_electrons = (Cuts::pT >= 20.0*GeV) & (Cuts::etaIn(-2.4, 0.0) || Cuts::etaIn(0.0, 2.4));
      
      IdentifiedFinalState electrons(c_electrons);
      electrons.acceptId(PID::ELECTRON);
      addProjection(electrons, "ELECFS");
      
      _hist_elec_phistar       = bookHisto1D(1, 1, 1);  // phistar
    }


    // Perform the per-event analysis
    void analyze(const Event& event) {
    
      static const double PI = 3.14159265358979323846;

      if (electrons.size()<2) vetoEvent;
      if (electrons[0].pT()/GeV < 30) vetoEvent;
      if (electrons[1].pT()/GeV < 20) vetoEvent;
      if (electrons[0].charge()*electrons[1].charge()>0) vetoEvent;
      double M = (electrons[0].momentum() + electrons[1].momentum()).mass()/GeV;
      if (M<=60 || M >=130) vetoEvent;

      const double weight = event.weight();
      
      double dphi = electrons[0].phi() - electrons[0].phi();
      if (dphi < 0) {
        if (dphi > -PI){
          dphi = fabs(dphi);
        }
        if (dphi < -PI) {
          dphi += 2*PI;
        }
      }
      const double DETA = fabs(eta0 - eta1);
      double phistar = ( 1 / cosh( DETA / 2 ) ) * ( 1 / tan( dphi /2 ) );
      Particles electrons = applyProjection<IdentifiedFinalState>(event, "PHOTFS").particlesByPt();

      _hist_elec_phistar->fill(phistar, weight);
    } 


    /// Normalise histograms etc., after the run
    void finalize() {
      scale(_hist_elec_phistar,   crossSection() / sumOfWeights());
    }

  private:
    Histo1DPtr  _hist_elec_phistar;
  };

  DECLARE_RIVET_PLUGIN(PHISTAR);
}
