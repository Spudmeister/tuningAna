# Auto generated configuration file
# using: 
# Revision: 1.381.2.28 
# Source: /local/reps/CMSSW/CMSSW/Configuration/PyReleaseValidation/python/ConfigBuilder.py,v 
# with command line options: Configuration/GenProduction/python/MinBias_Tune4C_8TeV_pythia8_cff.py --mc --datatier GEN --conditions auto:mc --step GEN --filein file:/home/aevans/CMS/oral/POWHEG-BOX/VBF_Z/testrun5/pwgevents-0012.lhe -n -1 --no_exec
import FWCore.ParameterSet.Config as cms

process = cms.Process('GEN')

# import of standard configurations
process.load('Configuration.StandardSequences.Services_cff')
#process.load('SimGeneral.HepPDTESSource.pythiapdt_cfi')
process.load('FWCore.MessageService.MessageLogger_cfi')
process.load('Configuration.EventContent.EventContent_cff')
#process.load('SimGeneral.MixingModule.mixNoPU_cfi')
#process.load('Configuration.StandardSequences.GeometryRecoDB_cff')
#process.load('Configuration.StandardSequences.MagneticField_38T_cff')
#process.load('Configuration.StandardSequences.Generator_cff')
process.load('PhysicsTools.HepMCCandAlgos.genParticles_cfi')
#process.load('IOMC.EventVertexGenerators.VtxSmearedRealistic8TeVCollision_cfi')
#process.load('GeneratorInterface.Core.genFilterSummary_cff')
#process.load('Configuration.StandardSequences.EndOfProcess_cff')
#process.load('Configuration.StandardSequences.FrontierConditions_GlobalTag_cff')

process.maxEvents = cms.untracked.PSet(
    input = cms.untracked.int32(-1)
)

# Input source
process.source = cms.Source("PoolSource",
    fileNames = cms.untracked.vstring('file:/data/whybee0a/user/lesko_2/fermi/Output/LHEStuff/res/step1_115_1_13m.root')
)

process.options = cms.untracked.PSet(
    wantSummary = cms.untracked.bool(True)
)

# Production Info
process.configurationMetadata = cms.untracked.PSet(
    version = cms.untracked.string('$Revision: 1.1 $'),
    annotation = cms.untracked.string('PYTHIA8-MinBias Tune 4C at 8TeV'),
    name = cms.untracked.string('$Source: /afs/cern.ch/project/cvs/reps/CMSSW/CMSSW/Configuration/GenProduction/python/EightTeV/MinBias_Tune4C_8TeV_pythia8_cff.py,v $')
)

# Output definition

process.TFileService = cms.Service("TFileService",
        fileName = cms.string("GenPhiStarPythia8_4C_5_3_13.root")
        )

# Additional output definition

# Other statements
#process.genstepfilter.triggerConditions=cms.vstring("generation_step")
#from Configuration.AlCa.GlobalTag import GlobalTag
#process.GlobalTag = GlobalTag(process.GlobalTag, 'auto:mc', '')

process.generator = cms.EDFilter("Pythia8HadronizerFilter",
    pythiaPylistVerbosity = cms.untracked.int32(1),
    filterEfficiency = cms.untracked.double(1.0),
    pythiaHepMCVerbosity = cms.untracked.bool(False),
    comEnergy = cms.double(8000.0),
    crossSection = cms.untracked.double(72850000000),
    maxEventsToPrint = cms.untracked.int32(0),
    PythiaParameters = cms.PSet(
        processParameters = cms.vstring('Main:timesAllowErrors    = 10000', 
            'ParticleDecays:limitTau0 = on',
            'ParticleDecays:tauMax = 10',
            'Tune:pp 5', 
            'Tune:ee 3',
            'BeamRemnants:primordialKTsoft = 0.5',
            'BeamRemnants:primordialKThard = 2',
            'BeamRemnants:halfScaleForKT = 1',
            'BeamRemnants:halfMassForKT = 0.5'            ),

        parameterSets = cms.vstring('processParameters')
    )
)


process.ProductionFilterSequence = cms.Sequence(process.generator)

# Path and EndPath definitions
process.generation_step = cms.Path(process.ProductionFilterSequence*process.genParticles)
#process.genfiltersummary_step = cms.EndPath(process.genFilterSummary)
#process.endjob_step = cms.EndPath(process.endOfProcess)
process.phistar = cms.EDAnalyzer('GenPhistar')
process.p = cms.Path(process.phistar)

# Schedule definition
process.schedule = cms.Schedule(process.generation_step,process.p)
# filter all path with the production filter sequence
#for path in process.paths:
#	getattr(process,path)._seq = process.ProductionFilterSequence * getattr(process,path)._seq 

