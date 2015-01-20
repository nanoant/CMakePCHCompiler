#.rst:
# CMakeCXXPCHInformation
# ----------------------
#
# Defines CXX precompiled-header compiler and following functions:
#
# target_precompiled_header(target header [SHARED other_target] [TYPE type])
#
# Uses given header as precompiled header for given target.
#
# Optionally it may share compiled header object with other target, so it is 
# precompiled just once.
#
# Also header may be given different type that default "c++-header".

# Author: Adam Strzelecki <ono@java.pl>
# Copyright (c) 2014-2015 Adam Strzelecki. All rights reserved.
# This code is licensed under the MIT License, see README.md.

set(CMAKE_CXXPCH_COMPILE_OBJECT ${CMAKE_CXX_COMPILE_OBJECT})
if(CMAKE_COMPILER_IS_GNUCXX)
	set(CMAKE_CXXPCH_OUTPUT_EXTENSION .gch)
else()
	set(CMAKE_CXXPCH_OUTPUT_EXTENSION .pch)
endif()

if(CMAKE_CXX_COMPILER_ID)
	include(Platform/${CMAKE_SYSTEM_NAME}-${CMAKE_CXX_COMPILER_ID}-CXXPCH
		OPTIONAL
		)
endif()

if(NOT CMAKE_NOT_USING_CONFIG_FLAGS)
	set(CMAKE_CXXPCH_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG_INIT}"
		CACHE STRING
		"Flags used by the compiler during debug builds."
		)
	set(CMAKE_CXXPCH_FLAGS_MINSIZEREL "${CMAKE_CXX_FLAGS_MINSIZEREL_INIT}"
		CACHE STRING
		"Flags used by the compiler during release builds for minimum size."
		)
	set(CMAKE_CXXPCH_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE_INIT}"
		CACHE STRING
		"Flags used by the compiler during release builds."
		)
	set(CMAKE_CXXPCH_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO_INIT}"
		CACHE STRING
		"Flags used by the compiler during release builds with debug info."
		)
endif()

include(CMakeParseArguments)

function(target_precompiled_header target header) # [SHARED shared] [TYPE type]
	if(NOT MSVC AND
		NOT CMAKE_COMPILER_IS_GNUCXX AND
		NOT CMAKE_CXX_COMPILER_ID STREQUAL "Clang"
		)
		message(WARNING
			"Precompiled headers not supported for ${CMAKE_CXX_COMPILER_ID}"
			)
		return()
	endif()
	cmake_parse_arguments(ARGS "" "SHARED;TYPE" "" ${ARGN})
	if(ARGS_SHARED)
		set(pch_target ${ARGS_SHARED}.pch)
	else()
		if(ARGS_TYPE)
			set(header_type ${ARGS_TYPE})
		else()
			set(header_type "c++-header")
		endif()
		if(MSVC)
			set_source_files_properties(
				${header}
				PROPERTIES
				LANGUAGE CXXPCH
				COMPILE_FLAGS "/Yc${header}"
				)
		else()
			set_source_files_properties(
				${header}
				PROPERTIES
				LANGUAGE CXXPCH
				COMPILE_FLAGS "-x ${header_type}"
				)
		endif()
		add_library(${target}.pch OBJECT ${header})
		set(pch_target ${target}.pch)
	endif()
	add_dependencies(${target} ${pch_target})
	set(target_dir 
		${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/${pch_target}.dir
		)
	if(CMAKE_COMPILER_IS_GNUCXX OR MSVC)
		target_include_directories(${target} PRIVATE ${target_dir})
	elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
		set_target_properties(${target} PROPERTIES
			COMPILE_FLAGS "-include ${target_dir}/${header}"
			)
	endif()
endfunction()
