# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.13

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


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
CMAKE_COMMAND = /usr/local/lib/python3.6/dist-packages/cmake/data/bin/cmake

# The command to remove a file.
RM = /usr/local/lib/python3.6/dist-packages/cmake/data/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ubuntu/Projeto1_Supercomp

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ubuntu/Projeto1_Supercomp/build

# Include any dependencies generated for this target.
include CMakeFiles/busca_local_seq.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/busca_local_seq.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/busca_local_seq.dir/flags.make

CMakeFiles/busca_local_seq.dir/busca_local_seq.cpp.o: CMakeFiles/busca_local_seq.dir/flags.make
CMakeFiles/busca_local_seq.dir/busca_local_seq.cpp.o: ../busca_local_seq.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ubuntu/Projeto1_Supercomp/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/busca_local_seq.dir/busca_local_seq.cpp.o"
	/usr/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/busca_local_seq.dir/busca_local_seq.cpp.o -c /home/ubuntu/Projeto1_Supercomp/busca_local_seq.cpp

CMakeFiles/busca_local_seq.dir/busca_local_seq.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/busca_local_seq.dir/busca_local_seq.cpp.i"
	/usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ubuntu/Projeto1_Supercomp/busca_local_seq.cpp > CMakeFiles/busca_local_seq.dir/busca_local_seq.cpp.i

CMakeFiles/busca_local_seq.dir/busca_local_seq.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/busca_local_seq.dir/busca_local_seq.cpp.s"
	/usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ubuntu/Projeto1_Supercomp/busca_local_seq.cpp -o CMakeFiles/busca_local_seq.dir/busca_local_seq.cpp.s

# Object files for target busca_local_seq
busca_local_seq_OBJECTS = \
"CMakeFiles/busca_local_seq.dir/busca_local_seq.cpp.o"

# External object files for target busca_local_seq
busca_local_seq_EXTERNAL_OBJECTS =

busca_local_seq: CMakeFiles/busca_local_seq.dir/busca_local_seq.cpp.o
busca_local_seq: CMakeFiles/busca_local_seq.dir/build.make
busca_local_seq: CMakeFiles/busca_local_seq.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ubuntu/Projeto1_Supercomp/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable busca_local_seq"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/busca_local_seq.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/busca_local_seq.dir/build: busca_local_seq

.PHONY : CMakeFiles/busca_local_seq.dir/build

CMakeFiles/busca_local_seq.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/busca_local_seq.dir/cmake_clean.cmake
.PHONY : CMakeFiles/busca_local_seq.dir/clean

CMakeFiles/busca_local_seq.dir/depend:
	cd /home/ubuntu/Projeto1_Supercomp/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ubuntu/Projeto1_Supercomp /home/ubuntu/Projeto1_Supercomp /home/ubuntu/Projeto1_Supercomp/build /home/ubuntu/Projeto1_Supercomp/build /home/ubuntu/Projeto1_Supercomp/build/CMakeFiles/busca_local_seq.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/busca_local_seq.dir/depend

