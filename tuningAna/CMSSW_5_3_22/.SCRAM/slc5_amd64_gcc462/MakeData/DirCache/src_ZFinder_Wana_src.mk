ifeq ($(strip $(ZFinder/Wana)),)
ALL_COMMONRULES += src_ZFinder_Wana_src
src_ZFinder_Wana_src_parent := ZFinder/Wana
src_ZFinder_Wana_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_ZFinder_Wana_src,src/ZFinder/Wana/src,LIBRARY))
ZFinderWana := self/ZFinder/Wana
ZFinder/Wana := ZFinderWana
ZFinderWana_files := $(patsubst src/ZFinder/Wana/src/%,%,$(wildcard $(foreach dir,src/ZFinder/Wana/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
ZFinderWana_BuildFile    := $(WORKINGDIR)/cache/bf/src/ZFinder/Wana/BuildFile
ZFinderWana_LOC_USE := self  FWCore/Framework CommonTools/UtilAlgos FWCore/ServiceRegistry FWCore/PluginManager FWCore/ParameterSet DataFormats/Candidate DataFormats/HepMCCandidate FWCore/Utilities PhysicsTools/Utilities
ZFinderWana_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,ZFinderWana,ZFinderWana,$(SCRAMSTORENAME_LIB),src/ZFinder/Wana/src))
ZFinderWana_PACKAGE := self/src/ZFinder/Wana/src
ALL_PRODS += ZFinderWana
ZFinderWana_CLASS := LIBRARY
ZFinder/Wana_forbigobj+=ZFinderWana
ZFinderWana_INIT_FUNC        += $$(eval $$(call Library,ZFinderWana,src/ZFinder/Wana/src,src_ZFinder_Wana_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS)))
endif
