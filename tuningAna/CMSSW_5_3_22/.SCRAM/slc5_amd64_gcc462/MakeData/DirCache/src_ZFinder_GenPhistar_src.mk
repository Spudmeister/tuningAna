ifeq ($(strip $(ZFinder/GenPhistar)),)
ALL_COMMONRULES += src_ZFinder_GenPhistar_src
src_ZFinder_GenPhistar_src_parent := ZFinder/GenPhistar
src_ZFinder_GenPhistar_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_ZFinder_GenPhistar_src,src/ZFinder/GenPhistar/src,LIBRARY))
ZFinderGenPhistar := self/ZFinder/GenPhistar
ZFinder/GenPhistar := ZFinderGenPhistar
ZFinderGenPhistar_files := $(patsubst src/ZFinder/GenPhistar/src/%,%,$(wildcard $(foreach dir,src/ZFinder/GenPhistar/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
ZFinderGenPhistar_BuildFile    := $(WORKINGDIR)/cache/bf/src/ZFinder/GenPhistar/BuildFile
ZFinderGenPhistar_LOC_FLAGS_CXXFLAGS   := -g
ZFinderGenPhistar_LOC_USE := self  FWCore/Framework CommonTools/UtilAlgos FWCore/ServiceRegistry FWCore/PluginManager FWCore/ParameterSet DataFormats/Candidate DataFormats/HepMCCandidate FWCore/Utilities PhysicsTools/Utilities
ZFinderGenPhistar_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,ZFinderGenPhistar,ZFinderGenPhistar,$(SCRAMSTORENAME_LIB),src/ZFinder/GenPhistar/src))
ZFinderGenPhistar_PACKAGE := self/src/ZFinder/GenPhistar/src
ALL_PRODS += ZFinderGenPhistar
ZFinderGenPhistar_CLASS := LIBRARY
ZFinder/GenPhistar_forbigobj+=ZFinderGenPhistar
ZFinderGenPhistar_INIT_FUNC        += $$(eval $$(call Library,ZFinderGenPhistar,src/ZFinder/GenPhistar/src,src_ZFinder_GenPhistar_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS)))
endif
