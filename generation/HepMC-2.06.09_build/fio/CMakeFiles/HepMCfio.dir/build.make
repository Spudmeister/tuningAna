# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The program to use to edit the cache.
CMAKE_EDIT_COMMAND = /usr/bin/ccmake

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/aevans/CMS/phistar/generation/HepMC-2.06.09

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build

# Include any dependencies generated for this target.
include fio/CMakeFiles/HepMCfio.dir/depend.make

# Include the progress variables for this target.
include fio/CMakeFiles/HepMCfio.dir/progress.make

# Include the compile flags for this target's objects.
include fio/CMakeFiles/HepMCfio.dir/flags.make

fio/CMakeFiles/HepMCfio.dir/HEPEVT_Wrapper.cc.o: fio/CMakeFiles/HepMCfio.dir/flags.make
fio/CMakeFiles/HepMCfio.dir/HEPEVT_Wrapper.cc.o: /home/aevans/CMS/phistar/generation/HepMC-2.06.09/fio/HEPEVT_Wrapper.cc
	$(CMAKE_COMMAND) -E cmake_progress_report /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object fio/CMakeFiles/HepMCfio.dir/HEPEVT_Wrapper.cc.o"
	cd /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/fio && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/HepMCfio.dir/HEPEVT_Wrapper.cc.o -c /home/aevans/CMS/phistar/generation/HepMC-2.06.09/fio/HEPEVT_Wrapper.cc

fio/CMakeFiles/HepMCfio.dir/HEPEVT_Wrapper.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HepMCfio.dir/HEPEVT_Wrapper.cc.i"
	cd /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/fio && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/aevans/CMS/phistar/generation/HepMC-2.06.09/fio/HEPEVT_Wrapper.cc > CMakeFiles/HepMCfio.dir/HEPEVT_Wrapper.cc.i

fio/CMakeFiles/HepMCfio.dir/HEPEVT_Wrapper.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HepMCfio.dir/HEPEVT_Wrapper.cc.s"
	cd /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/fio && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/aevans/CMS/phistar/generation/HepMC-2.06.09/fio/HEPEVT_Wrapper.cc -o CMakeFiles/HepMCfio.dir/HEPEVT_Wrapper.cc.s

fio/CMakeFiles/HepMCfio.dir/HEPEVT_Wrapper.cc.o.requires:
.PHONY : fio/CMakeFiles/HepMCfio.dir/HEPEVT_Wrapper.cc.o.requires

fio/CMakeFiles/HepMCfio.dir/HEPEVT_Wrapper.cc.o.provides: fio/CMakeFiles/HepMCfio.dir/HEPEVT_Wrapper.cc.o.requires
	$(MAKE) -f fio/CMakeFiles/HepMCfio.dir/build.make fio/CMakeFiles/HepMCfio.dir/HEPEVT_Wrapper.cc.o.provides.build
.PHONY : fio/CMakeFiles/HepMCfio.dir/HEPEVT_Wrapper.cc.o.provides

fio/CMakeFiles/HepMCfio.dir/HEPEVT_Wrapper.cc.o.provides.build: fio/CMakeFiles/HepMCfio.dir/HEPEVT_Wrapper.cc.o

fio/CMakeFiles/HepMCfio.dir/HerwigWrapper.cc.o: fio/CMakeFiles/HepMCfio.dir/flags.make
fio/CMakeFiles/HepMCfio.dir/HerwigWrapper.cc.o: /home/aevans/CMS/phistar/generation/HepMC-2.06.09/fio/HerwigWrapper.cc
	$(CMAKE_COMMAND) -E cmake_progress_report /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/CMakeFiles $(CMAKE_PROGRESS_2)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object fio/CMakeFiles/HepMCfio.dir/HerwigWrapper.cc.o"
	cd /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/fio && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/HepMCfio.dir/HerwigWrapper.cc.o -c /home/aevans/CMS/phistar/generation/HepMC-2.06.09/fio/HerwigWrapper.cc

fio/CMakeFiles/HepMCfio.dir/HerwigWrapper.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HepMCfio.dir/HerwigWrapper.cc.i"
	cd /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/fio && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/aevans/CMS/phistar/generation/HepMC-2.06.09/fio/HerwigWrapper.cc > CMakeFiles/HepMCfio.dir/HerwigWrapper.cc.i

fio/CMakeFiles/HepMCfio.dir/HerwigWrapper.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HepMCfio.dir/HerwigWrapper.cc.s"
	cd /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/fio && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/aevans/CMS/phistar/generation/HepMC-2.06.09/fio/HerwigWrapper.cc -o CMakeFiles/HepMCfio.dir/HerwigWrapper.cc.s

fio/CMakeFiles/HepMCfio.dir/HerwigWrapper.cc.o.requires:
.PHONY : fio/CMakeFiles/HepMCfio.dir/HerwigWrapper.cc.o.requires

fio/CMakeFiles/HepMCfio.dir/HerwigWrapper.cc.o.provides: fio/CMakeFiles/HepMCfio.dir/HerwigWrapper.cc.o.requires
	$(MAKE) -f fio/CMakeFiles/HepMCfio.dir/build.make fio/CMakeFiles/HepMCfio.dir/HerwigWrapper.cc.o.provides.build
.PHONY : fio/CMakeFiles/HepMCfio.dir/HerwigWrapper.cc.o.provides

fio/CMakeFiles/HepMCfio.dir/HerwigWrapper.cc.o.provides.build: fio/CMakeFiles/HepMCfio.dir/HerwigWrapper.cc.o

fio/CMakeFiles/HepMCfio.dir/IO_HEPEVT.cc.o: fio/CMakeFiles/HepMCfio.dir/flags.make
fio/CMakeFiles/HepMCfio.dir/IO_HEPEVT.cc.o: /home/aevans/CMS/phistar/generation/HepMC-2.06.09/fio/IO_HEPEVT.cc
	$(CMAKE_COMMAND) -E cmake_progress_report /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/CMakeFiles $(CMAKE_PROGRESS_3)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object fio/CMakeFiles/HepMCfio.dir/IO_HEPEVT.cc.o"
	cd /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/fio && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/HepMCfio.dir/IO_HEPEVT.cc.o -c /home/aevans/CMS/phistar/generation/HepMC-2.06.09/fio/IO_HEPEVT.cc

fio/CMakeFiles/HepMCfio.dir/IO_HEPEVT.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HepMCfio.dir/IO_HEPEVT.cc.i"
	cd /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/fio && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/aevans/CMS/phistar/generation/HepMC-2.06.09/fio/IO_HEPEVT.cc > CMakeFiles/HepMCfio.dir/IO_HEPEVT.cc.i

fio/CMakeFiles/HepMCfio.dir/IO_HEPEVT.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HepMCfio.dir/IO_HEPEVT.cc.s"
	cd /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/fio && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/aevans/CMS/phistar/generation/HepMC-2.06.09/fio/IO_HEPEVT.cc -o CMakeFiles/HepMCfio.dir/IO_HEPEVT.cc.s

fio/CMakeFiles/HepMCfio.dir/IO_HEPEVT.cc.o.requires:
.PHONY : fio/CMakeFiles/HepMCfio.dir/IO_HEPEVT.cc.o.requires

fio/CMakeFiles/HepMCfio.dir/IO_HEPEVT.cc.o.provides: fio/CMakeFiles/HepMCfio.dir/IO_HEPEVT.cc.o.requires
	$(MAKE) -f fio/CMakeFiles/HepMCfio.dir/build.make fio/CMakeFiles/HepMCfio.dir/IO_HEPEVT.cc.o.provides.build
.PHONY : fio/CMakeFiles/HepMCfio.dir/IO_HEPEVT.cc.o.provides

fio/CMakeFiles/HepMCfio.dir/IO_HEPEVT.cc.o.provides.build: fio/CMakeFiles/HepMCfio.dir/IO_HEPEVT.cc.o

fio/CMakeFiles/HepMCfio.dir/IO_HERWIG.cc.o: fio/CMakeFiles/HepMCfio.dir/flags.make
fio/CMakeFiles/HepMCfio.dir/IO_HERWIG.cc.o: /home/aevans/CMS/phistar/generation/HepMC-2.06.09/fio/IO_HERWIG.cc
	$(CMAKE_COMMAND) -E cmake_progress_report /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/CMakeFiles $(CMAKE_PROGRESS_4)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object fio/CMakeFiles/HepMCfio.dir/IO_HERWIG.cc.o"
	cd /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/fio && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/HepMCfio.dir/IO_HERWIG.cc.o -c /home/aevans/CMS/phistar/generation/HepMC-2.06.09/fio/IO_HERWIG.cc

fio/CMakeFiles/HepMCfio.dir/IO_HERWIG.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HepMCfio.dir/IO_HERWIG.cc.i"
	cd /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/fio && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/aevans/CMS/phistar/generation/HepMC-2.06.09/fio/IO_HERWIG.cc > CMakeFiles/HepMCfio.dir/IO_HERWIG.cc.i

fio/CMakeFiles/HepMCfio.dir/IO_HERWIG.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HepMCfio.dir/IO_HERWIG.cc.s"
	cd /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/fio && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/aevans/CMS/phistar/generation/HepMC-2.06.09/fio/IO_HERWIG.cc -o CMakeFiles/HepMCfio.dir/IO_HERWIG.cc.s

fio/CMakeFiles/HepMCfio.dir/IO_HERWIG.cc.o.requires:
.PHONY : fio/CMakeFiles/HepMCfio.dir/IO_HERWIG.cc.o.requires

fio/CMakeFiles/HepMCfio.dir/IO_HERWIG.cc.o.provides: fio/CMakeFiles/HepMCfio.dir/IO_HERWIG.cc.o.requires
	$(MAKE) -f fio/CMakeFiles/HepMCfio.dir/build.make fio/CMakeFiles/HepMCfio.dir/IO_HERWIG.cc.o.provides.build
.PHONY : fio/CMakeFiles/HepMCfio.dir/IO_HERWIG.cc.o.provides

fio/CMakeFiles/HepMCfio.dir/IO_HERWIG.cc.o.provides.build: fio/CMakeFiles/HepMCfio.dir/IO_HERWIG.cc.o

# Object files for target HepMCfio
HepMCfio_OBJECTS = \
"CMakeFiles/HepMCfio.dir/HEPEVT_Wrapper.cc.o" \
"CMakeFiles/HepMCfio.dir/HerwigWrapper.cc.o" \
"CMakeFiles/HepMCfio.dir/IO_HEPEVT.cc.o" \
"CMakeFiles/HepMCfio.dir/IO_HERWIG.cc.o"

# External object files for target HepMCfio
HepMCfio_EXTERNAL_OBJECTS =

lib/libHepMCfio.so.4.0.0: fio/CMakeFiles/HepMCfio.dir/HEPEVT_Wrapper.cc.o
lib/libHepMCfio.so.4.0.0: fio/CMakeFiles/HepMCfio.dir/HerwigWrapper.cc.o
lib/libHepMCfio.so.4.0.0: fio/CMakeFiles/HepMCfio.dir/IO_HEPEVT.cc.o
lib/libHepMCfio.so.4.0.0: fio/CMakeFiles/HepMCfio.dir/IO_HERWIG.cc.o
lib/libHepMCfio.so.4.0.0: fio/CMakeFiles/HepMCfio.dir/build.make
lib/libHepMCfio.so.4.0.0: fio/CMakeFiles/HepMCfio.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX shared library ../lib/libHepMCfio.so"
	cd /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/fio && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/HepMCfio.dir/link.txt --verbose=$(VERBOSE)
	cd /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/fio && $(CMAKE_COMMAND) -E cmake_symlink_library ../lib/libHepMCfio.so.4.0.0 ../lib/libHepMCfio.so.4 ../lib/libHepMCfio.so

lib/libHepMCfio.so.4: lib/libHepMCfio.so.4.0.0

lib/libHepMCfio.so: lib/libHepMCfio.so.4.0.0

# Rule to build all files generated by this target.
fio/CMakeFiles/HepMCfio.dir/build: lib/libHepMCfio.so
.PHONY : fio/CMakeFiles/HepMCfio.dir/build

fio/CMakeFiles/HepMCfio.dir/requires: fio/CMakeFiles/HepMCfio.dir/HEPEVT_Wrapper.cc.o.requires
fio/CMakeFiles/HepMCfio.dir/requires: fio/CMakeFiles/HepMCfio.dir/HerwigWrapper.cc.o.requires
fio/CMakeFiles/HepMCfio.dir/requires: fio/CMakeFiles/HepMCfio.dir/IO_HEPEVT.cc.o.requires
fio/CMakeFiles/HepMCfio.dir/requires: fio/CMakeFiles/HepMCfio.dir/IO_HERWIG.cc.o.requires
.PHONY : fio/CMakeFiles/HepMCfio.dir/requires

fio/CMakeFiles/HepMCfio.dir/clean:
	cd /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/fio && $(CMAKE_COMMAND) -P CMakeFiles/HepMCfio.dir/cmake_clean.cmake
.PHONY : fio/CMakeFiles/HepMCfio.dir/clean

fio/CMakeFiles/HepMCfio.dir/depend:
	cd /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/aevans/CMS/phistar/generation/HepMC-2.06.09 /home/aevans/CMS/phistar/generation/HepMC-2.06.09/fio /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/fio /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/fio/CMakeFiles/HepMCfio.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : fio/CMakeFiles/HepMCfio.dir/depend
