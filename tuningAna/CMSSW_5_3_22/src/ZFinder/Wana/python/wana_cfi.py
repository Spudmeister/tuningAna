import FWCore.ParameterSet.Config as cms

process = cms.Process("Demo")

# Set up message output and logging
process.load("FWCore.MessageService.MessageLogger_cfi")
process.MessageLogger.cerr.FwkReport.reportEvery = 1  # Report status ever 100 events

process.maxEvents = cms.untracked.PSet( input = cms.untracked.int32(-1) )

process.source = cms.Source("PoolSource",
    # replace 'myfile.root' with the source file you want to use
    fileNames = cms.untracked.vstring( #'file:/data/whybee0b/user/aevans/Pythia6_Z2Star_5_3_13_GEN/Pythia6_Z2Star_5_3_13_GEN_000.root')
                                        'file:/home/aevans/CMS/oral/CMSSW_5_3_22/src/ZFinder/EventGen/WprodTest.root')
)
# Output file
process.TFileService = cms.Service("TFileService",
        fileName = cms.string("testAna")
        )

process.demo = cms.EDAnalyzer('Wana'
)


process.p = cms.Path(process.demo)

