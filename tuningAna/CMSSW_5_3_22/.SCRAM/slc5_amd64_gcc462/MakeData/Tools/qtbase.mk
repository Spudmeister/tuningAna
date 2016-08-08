ALL_TOOLS      += qtbase
qtbase_EX_INCLUDE := /cvmfs/cms.cern.ch/slc5_amd64_gcc462/external/qt/4.6.3/include /cvmfs/cms.cern.ch/slc5_amd64_gcc462/external/qt/4.6.3/include/Qt /cvmfs/cms.cern.ch/slc5_amd64_gcc462/external/qt/4.6.3/include/QtCore /cvmfs/cms.cern.ch/slc5_amd64_gcc462/external/qt/4.6.3/include/QtXml
qtbase_EX_LIB := QtCore QtXml
qtbase_EX_USE := zlib
qtbase_EX_FLAGS_CPPDEFINES  := -DQT_ALTERNATE_QTSMANIP -DQT_CLEAN_NAMESPACE -DQT_THREAD_SUPPORT

