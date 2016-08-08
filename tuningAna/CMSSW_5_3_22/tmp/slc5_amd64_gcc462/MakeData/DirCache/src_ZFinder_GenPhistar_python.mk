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
