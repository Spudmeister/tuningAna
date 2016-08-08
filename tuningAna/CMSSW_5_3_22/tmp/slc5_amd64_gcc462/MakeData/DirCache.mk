ifeq ($(strip $(PyZFinderWana)),)
PyZFinderWana := self/src/ZFinder/Wana/python
src_ZFinder_Wana_python_parent := 
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/ZFinder/Wana/python)
PyZFinderWana_files := $(patsubst src/ZFinder/Wana/python/%,%,$(wildcard $(foreach dir,src/ZFinder/Wana/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyZFinderWana_LOC_USE := self  
PyZFinderWana_PACKAGE := self/src/ZFinder/Wana/python
ALL_PRODS += PyZFinderWana
PyZFinderWana_CLASS := PYTHON
PyZFinderWana_INIT_FUNC        += $$(eval $$(call PythonProduct,PyZFinderWana,src/ZFinder/Wana/python,src_ZFinder_Wana_python,1,1,$(SCRAMSTORENAME_PYTHON),$(SCRAMSTORENAME_LIB),,))
else
$(eval $(call MultipleWarningMsg,PyZFinderWana,src/ZFinder/Wana/python))
endif
ALL_COMMONRULES += src_ZFinder_Wana_python
src_ZFinder_Wana_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_ZFinder_Wana_python,src/ZFinder/Wana/python,PYTHON))
ALL_PACKAGES += ZFinder/EventGen
subdirs_src_ZFinder_EventGen := 
ALL_PACKAGES += ZFinder/GenPhistar
subdirs_src_ZFinder_GenPhistar := src_ZFinder_GenPhistar_scripts src_ZFinder_GenPhistar_python src_ZFinder_GenPhistar_src src_ZFinder_GenPhistar_test
ALL_PACKAGES += ZFinder/Wana
subdirs_src_ZFinder_Wana := src_ZFinder_Wana_python src_ZFinder_Wana_src src_ZFinder_Wana_test
ifeq ($(strip $(PyZFinderGenPhistar)),)
PyZFinderGenPhistar := self/src/ZFinder/GenPhistar/python
src_ZFinder_GenPhistar_python_parent := 
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/ZFinder/GenPhistar/python)
PyZFinderGenPhistar_files := $(patsubst src/ZFinder/GenPhistar/python/%,%,$(wildcard $(foreach dir,src/ZFinder/GenPhistar/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyZFinderGenPhistar_LOC_USE := self  
PyZFinderGenPhistar_PACKAGE := self/src/ZFinder/GenPhistar/python
ALL_PRODS += PyZFinderGenPhistar
PyZFinderGenPhistar_CLASS := PYTHON
PyZFinderGenPhistar_INIT_FUNC        += $$(eval $$(call PythonProduct,PyZFinderGenPhistar,src/ZFinder/GenPhistar/python,src_ZFinder_GenPhistar_python,1,1,$(SCRAMSTORENAME_PYTHON),$(SCRAMSTORENAME_LIB),,))
else
$(eval $(call MultipleWarningMsg,PyZFinderGenPhistar,src/ZFinder/GenPhistar/python))
endif
ALL_COMMONRULES += src_ZFinder_GenPhistar_python
src_ZFinder_GenPhistar_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_ZFinder_GenPhistar_python,src/ZFinder/GenPhistar/python,PYTHON))
ALL_COMMONRULES += src_ZFinder_Wana_test
src_ZFinder_Wana_test_parent := ZFinder/Wana
src_ZFinder_Wana_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_ZFinder_Wana_test,src/ZFinder/Wana/test,TEST))
ALL_SUBSYSTEMS+=ZFinder
subdirs_src_ZFinder = src_ZFinder_EventGen src_ZFinder_Wana src_ZFinder_GenPhistar
src_ZFinder_GenPhistar_scripts_files := $(filter-out \#% %\#,$(notdir $(wildcard $(foreach dir,$(LOCALTOP)/src/ZFinder/GenPhistar/scripts,$(dir)/*))))
$(eval $(call Src2StoreCopy,src_ZFinder_GenPhistar_scripts,src/ZFinder/GenPhistar/scripts,$(SCRAMSTORENAME_BIN),*))
ALL_COMMONRULES += src_ZFinder_GenPhistar_test
src_ZFinder_GenPhistar_test_parent := ZFinder/GenPhistar
src_ZFinder_GenPhistar_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_ZFinder_GenPhistar_test,src/ZFinder/GenPhistar/test,TEST))
