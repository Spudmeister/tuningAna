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
include test/CMakeFiles/testHepMCIteration.dir/depend.make

# Include the progress variables for this target.
include test/CMakeFiles/testHepMCIteration.dir/progress.make

# Include the compile flags for this target's objects.
include test/CMakeFiles/testHepMCIteration.dir/flags.make

test/CMakeFiles/testHepMCIteration.dir/testHepMCIteration.cc.o: test/CMakeFiles/testHepMCIteration.dir/flags.make
test/CMakeFiles/testHepMCIteration.dir/testHepMCIteration.cc.o: test/testHepMCIteration.cc
	$(CMAKE_COMMAND) -E cmake_progress_report /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object test/CMakeFiles/testHepMCIteration.dir/testHepMCIteration.cc.o"
	cd /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/test && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/testHepMCIteration.dir/testHepMCIteration.cc.o -c /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/test/testHepMCIteration.cc

test/CMakeFiles/testHepMCIteration.dir/testHepMCIteration.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/testHepMCIteration.dir/testHepMCIteration.cc.i"
	cd /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/test && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/test/testHepMCIteration.cc > CMakeFiles/testHepMCIteration.dir/testHepMCIteration.cc.i

test/CMakeFiles/testHepMCIteration.dir/testHepMCIteration.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/testHepMCIteration.dir/testHepMCIteration.cc.s"
	cd /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/test && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/test/testHepMCIteration.cc -o CMakeFiles/testHepMCIteration.dir/testHepMCIteration.cc.s

test/CMakeFiles/testHepMCIteration.dir/testHepMCIteration.cc.o.requires:
.PHONY : test/CMakeFiles/testHepMCIteration.dir/testHepMCIteration.cc.o.requires

test/CMakeFiles/testHepMCIteration.dir/testHepMCIteration.cc.o.provides: test/CMakeFiles/testHepMCIteration.dir/testHepMCIteration.cc.o.requires
	$(MAKE) -f test/CMakeFiles/testHepMCIteration.dir/build.make test/CMakeFiles/testHepMCIteration.dir/testHepMCIteration.cc.o.provides.build
.PHONY : test/CMakeFiles/testHepMCIteration.dir/testHepMCIteration.cc.o.provides

test/CMakeFiles/testHepMCIteration.dir/testHepMCIteration.cc.o.provides.build: test/CMakeFiles/testHepMCIteration.dir/testHepMCIteration.cc.o

# Object files for target testHepMCIteration
testHepMCIteration_OBJECTS = \
"CMakeFiles/testHepMCIteration.dir/testHepMCIteration.cc.o"

# External object files for target testHepMCIteration
testHepMCIteration_EXTERNAL_OBJECTS =

test/testHepMCIteration: test/CMakeFiles/testHepMCIteration.dir/testHepMCIteration.cc.o
test/testHepMCIteration: test/CMakeFiles/testHepMCIteration.dir/build.make
test/testHepMCIteration: lib/libHepMC.so.4.0.0
test/testHepMCIteration: test/CMakeFiles/testHepMCIteration.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable testHepMCIteration"
	cd /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/test && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/testHepMCIteration.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
test/CMakeFiles/testHepMCIteration.dir/build: test/testHepMCIteration
.PHONY : test/CMakeFiles/testHepMCIteration.dir/build

test/CMakeFiles/testHepMCIteration.dir/requires: test/CMakeFiles/testHepMCIteration.dir/testHepMCIteration.cc.o.requires
.PHONY : test/CMakeFiles/testHepMCIteration.dir/requires

test/CMakeFiles/testHepMCIteration.dir/clean:
	cd /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/test && $(CMAKE_COMMAND) -P CMakeFiles/testHepMCIteration.dir/cmake_clean.cmake
.PHONY : test/CMakeFiles/testHepMCIteration.dir/clean

test/CMakeFiles/testHepMCIteration.dir/depend:
	cd /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/aevans/CMS/phistar/generation/HepMC-2.06.09 /home/aevans/CMS/phistar/generation/HepMC-2.06.09/test /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/test /home/aevans/CMS/phistar/generation/HepMC-2.06.09_build/test/CMakeFiles/testHepMCIteration.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : test/CMakeFiles/testHepMCIteration.dir/depend
