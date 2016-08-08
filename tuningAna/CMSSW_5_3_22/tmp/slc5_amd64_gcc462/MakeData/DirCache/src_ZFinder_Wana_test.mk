ALL_COMMONRULES += src_ZFinder_Wana_test
src_ZFinder_Wana_test_parent := ZFinder/Wana
src_ZFinder_Wana_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_ZFinder_Wana_test,src/ZFinder/Wana/test,TEST))
