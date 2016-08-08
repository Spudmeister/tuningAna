# Install script for directory: /home/aevans/CMS/phistar/generation/HepMC-2.06.09/examples/pythia8

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
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/HepMC/examples/pythia8" TYPE FILE FILES
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/examples/pythia8/main31.cc"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/examples/pythia8/main32.cc"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/examples/pythia8/main32.cmnd"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09/examples/pythia8/README"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/examples/pythia8/GNUmakefile"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/examples/pythia8/config.csh"
    "/home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/examples/pythia8/config.sh"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

