ifeq ($(strip $(GeneratorInterface/RivetInterface)),)
ALL_COMMONRULES += src_GeneratorInterface_RivetInterface_src
src_GeneratorInterface_RivetInterface_src_parent := GeneratorInterface/RivetInterface
src_GeneratorInterface_RivetInterface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_RivetInterface_src,src/GeneratorInterface/RivetInterface/src,LIBRARY))
GeneratorInterfaceRivetInterface := self/GeneratorInterface/RivetInterface
GeneratorInterface/RivetInterface := GeneratorInterfaceRivetInterface
GeneratorInterfaceRivetInterface_files := $(patsubst src/GeneratorInterface/RivetInterface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/RivetInterface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceRivetInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/RivetInterface/BuildFile
GeneratorInterfaceRivetInterface_LOC_USE := self  rivet yoda fastjet clhep boost gsl root GeneratorInterface/Core GeneratorInterface/Pythia6Interface
GeneratorInterfaceRivetInterface_PRE_INIT_FUNC += $$(eval $$(call rivetPlugin,GeneratorInterfaceRivetInterface,GeneratorInterfaceRivetInterface,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/RivetInterface/src))
GeneratorInterfaceRivetInterface_PACKAGE := self/src/GeneratorInterface/RivetInterface/src
ALL_PRODS += GeneratorInterfaceRivetInterface
GeneratorInterfaceRivetInterface_CLASS := LIBRARY
GeneratorInterface/RivetInterface_forbigobj+=GeneratorInterfaceRivetInterface
GeneratorInterfaceRivetInterface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceRivetInterface,src/GeneratorInterface/RivetInterface/src,src_GeneratorInterface_RivetInterface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS)))
endif
ifeq ($(strip $(GeneratorInterfaceRivetInterface_plugins)),)
GeneratorInterfaceRivetInterface_plugins := self/src/GeneratorInterface/RivetInterface/plugins
PLUGINS:=yes
GeneratorInterfaceRivetInterface_plugins_files := $(patsubst src/GeneratorInterface/RivetInterface/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/RivetInterface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/RivetInterface/plugins/$(file). Please fix src/GeneratorInterface/RivetInterface/plugins/BuildFile.))))
GeneratorInterfaceRivetInterface_plugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/RivetInterface/plugins/BuildFile
GeneratorInterfaceRivetInterface_plugins_LOC_USE := self  FWCore/Framework FWCore/ServiceRegistry SimDataFormats/GeneratorProducts GeneratorInterface/Core DataFormats/Common rivet yoda gsl DQMServices/Core SimGeneral/HepPDTRecord DataFormats/HepMCCandidate
GeneratorInterfaceRivetInterface_plugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceRivetInterface_plugins,GeneratorInterfaceRivetInterface_plugins,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/RivetInterface/plugins))
GeneratorInterfaceRivetInterface_plugins_PACKAGE := self/src/GeneratorInterface/RivetInterface/plugins
ALL_PRODS += GeneratorInterfaceRivetInterface_plugins
GeneratorInterface/RivetInterface_forbigobj+=GeneratorInterfaceRivetInterface_plugins
GeneratorInterfaceRivetInterface_plugins_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceRivetInterface_plugins,src/GeneratorInterface/RivetInterface/plugins,src_GeneratorInterface_RivetInterface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS)))
GeneratorInterfaceRivetInterface_plugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceRivetInterface_plugins,src/GeneratorInterface/RivetInterface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_RivetInterface_plugins
src_GeneratorInterface_RivetInterface_plugins_parent := GeneratorInterface/RivetInterface
src_GeneratorInterface_RivetInterface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_RivetInterface_plugins,src/GeneratorInterface/RivetInterface/plugins,PLUGINS))
