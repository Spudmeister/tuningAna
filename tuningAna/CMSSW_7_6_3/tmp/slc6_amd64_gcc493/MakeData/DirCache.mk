ifeq ($(strip $(PyConfigurationGenProduction)),)
PyConfigurationGenProduction := self/src/Configuration/GenProduction/python
src_Configuration_GenProduction_python_parent := 
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/Configuration/GenProduction/python)
PyConfigurationGenProduction_files := $(patsubst src/Configuration/GenProduction/python/%,%,$(wildcard $(foreach dir,src/Configuration/GenProduction/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyConfigurationGenProduction_LOC_USE := self  
PyConfigurationGenProduction_PACKAGE := self/src/Configuration/GenProduction/python
ALL_PRODS += PyConfigurationGenProduction
PyConfigurationGenProduction_INIT_FUNC        += $$(eval $$(call PythonProduct,PyConfigurationGenProduction,src/Configuration/GenProduction/python,src_Configuration_GenProduction_python,1,1,$(SCRAMSTORENAME_PYTHON),$(SCRAMSTORENAME_LIB),,))
else
$(eval $(call MultipleWarningMsg,PyConfigurationGenProduction,src/Configuration/GenProduction/python))
endif
ALL_COMMONRULES += src_Configuration_GenProduction_python
src_Configuration_GenProduction_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_Configuration_GenProduction_python,src/Configuration/GenProduction/python,PYTHON))
ALL_PACKAGES += Configuration/GenProduction
subdirs_src_Configuration_GenProduction := src_Configuration_GenProduction_python
ALL_COMMONRULES += src_GeneratorInterface_RivetInterface_test
src_GeneratorInterface_RivetInterface_test_parent := GeneratorInterface/RivetInterface
src_GeneratorInterface_RivetInterface_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_RivetInterface_test,src/GeneratorInterface/RivetInterface/test,TEST))
ALL_SUBSYSTEMS+=GeneratorInterface
subdirs_src_GeneratorInterface = src_GeneratorInterface_RivetInterface
ALL_PACKAGES += GeneratorInterface/RivetInterface
subdirs_src_GeneratorInterface_RivetInterface := src_GeneratorInterface_RivetInterface_python src_GeneratorInterface_RivetInterface_src src_GeneratorInterface_RivetInterface_plugins src_GeneratorInterface_RivetInterface_test
ALL_SUBSYSTEMS+=Configuration
subdirs_src_Configuration = src_Configuration_GenProduction
ifeq ($(strip $(PyGeneratorInterfaceRivetInterface)),)
PyGeneratorInterfaceRivetInterface := self/src/GeneratorInterface/RivetInterface/python
src_GeneratorInterface_RivetInterface_python_parent := 
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/RivetInterface/python)
PyGeneratorInterfaceRivetInterface_files := $(patsubst src/GeneratorInterface/RivetInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/RivetInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceRivetInterface_LOC_USE := self  
PyGeneratorInterfaceRivetInterface_PACKAGE := self/src/GeneratorInterface/RivetInterface/python
ALL_PRODS += PyGeneratorInterfaceRivetInterface
PyGeneratorInterfaceRivetInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceRivetInterface,src/GeneratorInterface/RivetInterface/python,src_GeneratorInterface_RivetInterface_python,1,1,$(SCRAMSTORENAME_PYTHON),$(SCRAMSTORENAME_LIB),,))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceRivetInterface,src/GeneratorInterface/RivetInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_RivetInterface_python
src_GeneratorInterface_RivetInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_RivetInterface_python,src/GeneratorInterface/RivetInterface/python,PYTHON))
