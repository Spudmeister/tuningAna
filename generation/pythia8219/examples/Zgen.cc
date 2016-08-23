//-----------------Z Generation Program-------------------//

//Headers and Namespaces
#include "Pythia8/Pythia.h"                // Include Pythia headers
#include "Pythia8Plugins/HepMC2.h"

using namespace Pythia8;                   // Let Pythia8:: be implicit

int main (int argc, char* argv[]) {                              // Begin main program
  //Read arguments
/*  if (argc != 2) {
    cerr << " Unexpected number of command-line arguments. \n You are"
    << " expected to provide one input and one output file name. \n"
    << " Program stopped! " << endl;
    return 1;
  }
*/
  // Set up generation
  //Interface for conversion from Pythia8::Event to HepMC event.
  HepMC::Pythia8ToHepMC ToHepMC;
  
  // Specify file where HepMC events will be stored.
  HepMC::IO_GenEvent ascii_io("Zgen.hepmc", std::ios::out);
  
  Pythia pythia;                           // Declare Pythia object
  
  pythia.readString("WeakSingleBoson:ffbar2ffbar(s:gmZ) = on");  // Switch on process   
  pythia.readString("WeakZ0:gmZmode = 0");  // Full gamma^*/Z^0 structure, with interference   
  pythia.readString("23:onMode = off");
  pythia.readString("23:onIfAll = 11 11");
  pythia.readString("Beams:eCM = 8000");   // 8 TeV CM energy
  pythia.init();                           // Initialize; incoming pp beams is default
  
  // Generate event(s)
  for ( int iEvent = 0; iEvent < 100000; ++iEvent) { 
    pythia.next();                           // Generate an(other) event. Fill event record
    // Generate HepMC event to file
    HepMC::GenEvent* hepmcevt = new HepMC::GenEvent();
    ToHepMC.fill_next_event( pythia, hepmcevt );

    // Write the HepMC event to file. Done with it.
    ascii_io << hepmcevt;
    delete hepmcevt;
  }

  return 0;
}                                          // End main program with error-free return
