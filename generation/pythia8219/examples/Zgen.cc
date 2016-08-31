//Headers and Namespaces
#include "Pythia8/Pythia.h"                // Include Pythia headers

#include "Pythia8Plugins/HepMC2.h"

using namespace Pythia8;                   // Let Pythia8:: be implicit

int main (int argc, char* argv[]) {                              // Begin main program

  //Read arguments

  if (argc != 3) {

    cerr << " Unexpected number of command-line arguments. \n You are"

    << " expected to provide one input and one output file name. \n"

    << " Program stopped! " << endl;

    return 1;

  }
  //HEPMC file name and path read from command line
  std::string hepOut = argv[2];

  // Set up generation

  //Interface for conversion from Pythia8::Event to HepMC event

  HepMC::Pythia8ToHepMC ToHepMC;

  // Specify file where HepMC events will be stored

  HepMC::IO_GenEvent ascii_io(hepOut, std::ios::out);

  Pythia pythia;                           // Declare Pythia object
  
  pythia.readFile(argv[1]);                //Read command card file (Zgen.cmnd)
  int nEvents = pythia.mode("Main:numberOfEvents"); //Pull the number of evetns to be generated from this

  pythia.readString("WeakSingleBoson:ffbar2ffbar(s:gmZ) = on");  // Switch on process

  pythia.readString("WeakZ0:gmZmode = 0");  // Full gamma^*/Z^0 structure, with interference

  pythia.readString("23:onMode = off");    //Turn off all decay modes for the Z boson

  pythia.readString("23:onIfAll = 11 11"); // Turn on any decay mode if it has two electrons

  pythia.readString("Beams:eCM = 8000");   // 8 TeV CM energy

  pythia.init();                           // Initialize; incoming pp beams is default

  
  // Generate event(s)

  for ( int iEvent = 0; iEvent < nEvents; ++iEvent) {

    pythia.next();                           // Generate an(other) event. Fill event record

    //Find Z
    std::cout << "Looking at first event" <<std::endl;
    int iZ = 0;

    for (int i = 0; i < pythia.event.size(); ++i)

      if (pythia.event[i].id() == 23) iZ = i;

    //Find an electron from the Z decay

    int iE = iZ;

    while(true) {

      int daughter = pythia.event[iE].daughter1();

      if  (daughter == 0) break;

      else                iE = daughter;
    
    }

    //Check that it worked

    if (pythia.event[iE].idAbs() != 11 || !pythia.event[iE].isFinal()) {

      std::cout << "Error: Found incorrect decay product of the W" << endl;

      continue;

    }
    std::cout << "Checking electron properties" << std::endl;
    //Make some cuts on the electron

    if (pythia.event[iE].pT() < 20.0)

      continue;

    if (abs(pythia.event[iE].eta()) > 1.1)

      continue;

    // Generate HepMC event to file with remaining events
    std::cout << "Event passes cuts" <<std::endl;
    HepMC::GenEvent* hepmcevt = new HepMC::GenEvent();
    ToHepMC.fill_next_event( pythia, hepmcevt );
    // Write the HepMC event to file. Done with it.

    ascii_io << hepmcevt;

    delete hepmcevt;

  }

  return 0;
}                                          // End main program with error-free returnn
