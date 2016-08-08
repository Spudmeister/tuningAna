import FWCore.ParameterSet.Config as cms

process = cms.Process("phistar")

# Set up message output and logging
process.load("FWCore.MessageService.MessageLogger_cfi")
process.MessageLogger.cerr.FwkReport.reportEvery = 1  # Report status ever 100 events

process.maxEvents = cms.untracked.PSet( input = cms.untracked.int32(-1) )

process.source = cms.Source("PoolSource",
    # replace 'myfile.root' with the source file you want to use
    fileNames = cms.untracked.vstring('file:/home/aevans/CMS/oral/CMSSW_5_3_13/src/ZFinder/EventGen/MinBias_Tune4C_8TeV_pythia8_cff_py_GEN.root')

)

# Output file
process.TFileService = cms.Service("TFileService",
        fileName = cms.string("TESTGenPhiStarPythia8_4C_5_3_13.root")
        )

process.demo = cms.EDAnalyzer('GenPhistar'
)


process.p = cms.Path(process.phistar)
