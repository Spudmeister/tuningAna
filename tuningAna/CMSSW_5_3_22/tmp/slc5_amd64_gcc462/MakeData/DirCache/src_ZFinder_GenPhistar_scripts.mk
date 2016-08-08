src_ZFinder_GenPhistar_scripts_files := $(filter-out \#% %\#,$(notdir $(wildcard $(foreach dir,$(LOCALTOP)/src/ZFinder/GenPhistar/scripts,$(dir)/*))))
$(eval $(call Src2StoreCopy,src_ZFinder_GenPhistar_scripts,src/ZFinder/GenPhistar/scripts,$(SCRAMSTORENAME_BIN),*))
