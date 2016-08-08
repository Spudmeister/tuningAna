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
