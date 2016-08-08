# Install script for directory: /home/aevans/CMS/phistar/generation/HepMC-2.06.09/examples

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
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/HepMC/examples" TYPE FILE FILES
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/examples/example_BuildEventFromScratch.cc"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/examples/example_EventSelection.cc"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/examples/example_UsingIterators.cc"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/examples/example_UsingIterators.txt"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/examples/example_VectorConversion.cc"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/examples/VectorConversion.h"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/examples/GNUmakefile"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  INCLUDE("/home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/examples/fio/cmake_install.cmake")
  INCLUDE("/home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/examples/pythia8/cmake_install.cmake")

ENDIF(NOT CMAKE_INSTALL_LOCAL_ONLY)

