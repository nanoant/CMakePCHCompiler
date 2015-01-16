# Precompiled Header creation for C++
#
# Author: Adam Strzelecki <ono@java.pl>
# Copyright (c) 2014-2015 Adam Strzelecki. All rights reserved.
# This code is licensed under the MIT License, see README.md.
#
# Main entry point for new compiler. Here it just proxies to C++ compiler.

set(CMAKE_CXXPCH_COMPILER_ENV_VAR "CXXPCH")
set(CMAKE_CXXPCH_COMPILER ${CMAKE_CXX_COMPILER})

configure_file(
	${CMAKE_CURRENT_LIST_DIR}/CMakeCXXPCHCompiler.cmake.in
	${CMAKE_PLATFORM_INFO_DIR}/CMakeCXXPCHCompiler.cmake
	)
