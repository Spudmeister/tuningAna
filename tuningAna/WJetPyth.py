# Auto generated configuration file
# using: 
# Revision: 1.381.2.13 
# Source: /local/reps/CMSSW/CMSSW/Configuration/PyReleaseValidation/python/ConfigBuilder.py,v 
# with command line options: WJet/Test/python/WJet2LNu_cfi.py --python_filename test.py --conditions auto:mc -n 10000 -s GEN --datatier GEN --fileout file:WJetBG.root --no_exec
import FWCore.ParameterSet.Config as cms
import sys
from os import listdir
from os.path import isfile, join
import random


process = cms.Process('GEN')

# import of standard configurations
process.load('Configuration.StandardSequences.Services_cff')
process.load('SimGeneral.HepPDTESSource.pythiapdt_cfi')
process.load('FWCore.MessageService.MessageLogger_cfi')
process.load('Configuration.EventContent.EventContent_cff')
process.load('SimGeneral.MixingModule.mixNoPU_cfi')
process.load('Configuration.StandardSequences.GeometryRecoDB_cff')
process.load('Configuration.StandardSequences.MagneticField_38T_cff')
process.load('Configuration.StandardSequences.Generator_cff')
process.load('IOMC.EventVertexGenerators.VtxSmearedRealistic8TeVCollision_cfi')
process.load('GeneratorInterface.Core.genFilterSummary_cff')
process.load('Configuration.StandardSequences.EndOfProcess_cff')
process.load('Configuration.StandardSequences.FrontierConditions_GlobalTag_cff')

process.maxEvents = cms.untracked.PSet(
    output = cms.untracked.int32(5000)
)

# Input source
process.source = cms.Source("EmptySource")

process.options = cms.untracked.PSet(

)
#x = random.randrange(1,100000000)
#process.RandomNumberGeneratorService.generator.initialSeed = cms.untracked.uint32(x)
# Production Info
process.configurationMetadata = cms.untracked.PSet(
    version = cms.untracked.string('$Revision: 1.381.2.13 $'),
    annotation = cms.untracked.string('WJet/Test/python/WJet2LNu_cfi.py nevts:10000'),
    name = cms.untracked.string('PyReleaseValidation')
)

# Output definition

#print 'file:/data/whybee0a/user/lesko_2/WJetBG/WJetSample_%d.root' % int(sys.argv[2])
process.RECOSIMoutput = cms.OutputModule("PoolOutputModule",
    splitLevel = cms.untracked.int32(0),
    eventAutoFlushCompressedSize = cms.untracked.int32(5242880),
    outputCommands = process.RECOSIMEventContent.outputCommands,
    fileName = cms.untracked.string('file:/data/whybee0a/user/lesko_2/WJetBG/WJetSample_%d.root' % int(sys.argv[2])),
    dataset = cms.untracked.PSet(
        filterName = cms.untracked.string(''),
        dataTier = cms.untracked.string('GEN')
    ),
    SelectEvents = cms.untracked.PSet(
        SelectEvents = cms.vstring('generation_step')
    )
)

# Additional output definition

# Other statements
process.genstepfilter.triggerConditions=cms.vstring("generation_step")
from Configuration.AlCa.GlobalTag import GlobalTag
process.GlobalTag = GlobalTag(process.GlobalTag, 'auto:mc', '')

process.generator = cms.EDFilter("Pythia8GeneratorFilter",
    pythiaPylistVerbosity = cms.untracked.int32(1),
    filterEfficiency = cms.untracked.double(1.0),
    pythiaHepMCVerbosity = cms.untracked.bool(False),
    comEnergy = cms.double(14000.0),
    crossSection = cms.untracked.double(1),
    maxEventsToPrint = cms.untracked.int32(0),
    PythiaParameters = cms.PSet(
        processParameters = cms.vstring(
            'Main:timesAllowErrors = 10000',
	     'ParticleDecays:limitTau0 = on',
				'ParticleDecays:tauMax = 10',
				'Tune:ee 3',
				'Tune:pp 5',
				'WeakBosonAndParton:qqbar2Wg = on',
				'WeakBosonAndParton:qg2Wq = on',
				'24:onMode = off', # turn OFF all W decays
				'24:onIfMatch = 13 14'),
        parameterSets = cms.vstring('processParameters')
    )
)

process.muonfilter = cms.EDFilter("MuonEta")
# Path and EndPath definitions
#process.filterstep = cms.Path(process.muonfilter)
process.generation_step = cms.Path(process.pgen*process.muonfilter)
process.genfiltersummary_step = cms.EndPath(process.genFilterSummary)
process.endjob_step = cms.EndPath(process.endOfProcess)
process.RECOSIMoutput_step = cms.EndPath(process.RECOSIMoutput)

# Schedule definition
process.schedule = cms.Schedule(process.generation_step,process.genfiltersummary_step,process.endjob_step,process.RECOSIMoutput_step)

# filter all path with the production filter sequence
for path in process.paths:
	getattr(process,path)._seq = process.generator* getattr(process,path)._seq 
