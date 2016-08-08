# Install script for directory: /home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC

# Set the install prefix
IF(NOT DEFINED CMAKE_INSTALL_PREFIX)
  SET(CMAKE_INSTALL_PREFIX "/home/aevans/CMS/phistar/generation/HepMC-2.06.09_build")
ENDIF(NOT DEFINED CMAKE_INSTALL_PREFIX)
STRING(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
IF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  IF(BUILD_TYPE)
    STRING(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  ELSE(BUILD_TYPE)
    SET(CMAKE_INSTALL_CONFIG_NAME "RelWithDebInfo")
  ENDIF(BUILD_TYPE)
  MESSAGE(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
ENDIF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)

# Set the component getting installed.
IF(NOT CMAKE_INSTALL_COMPONENT)
  IF(COMPONENT)
    MESSAGE(STATUS "Install component: \"${COMPONENT}\"")
    SET(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  ELSE(COMPONENT)
    SET(CMAKE_INSTALL_COMPONENT)
  ENDIF(COMPONENT)
ENDIF(NOT CMAKE_INSTALL_COMPONENT)

# Install shared libraries without execute permission?
IF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  SET(CMAKE_INSTALL_SO_NO_EXE "0")
ENDIF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/HepMC" TYPE FILE FILES
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/CompareGenEvent.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/Flow.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/GenEvent.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/GenParticle.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/GenVertex.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/GenCrossSection.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/GenRanges.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/HeavyIon.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/HEPEVT_Wrapper.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/HerwigWrapper.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/IO_AsciiParticles.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/IO_BaseClass.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/IO_Exception.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/IO_GenEvent.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/IO_HEPEVT.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/IO_HERWIG.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/IteratorRange.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/PdfInfo.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/Polarization.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/PythiaWrapper6_4.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/PythiaWrapper6_4_WIN32.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/PythiaWrapper.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/WeightContainer.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/SearchVector.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/SimpleVector.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/SimpleVector.icc"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/StreamHelpers.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/StreamInfo.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/enable_if.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/is_arithmetic.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/TempParticleMap.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/Units.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/Version.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/HepMC/HepMCDefs.h"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

