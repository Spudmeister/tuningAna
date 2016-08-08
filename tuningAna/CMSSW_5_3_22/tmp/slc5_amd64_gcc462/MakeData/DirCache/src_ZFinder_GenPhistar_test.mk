ALL_COMMONRULES += src_ZFinder_GenPhistar_test
src_ZFinder_GenPhistar_test_parent := ZFinder/GenPhistar
src_ZFinder_GenPhistar_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_ZFinder_GenPhistar_test,src/ZFinder/GenPhistar/test,TEST))
