cmake_minimum_required(VERSION 3.0)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/../..)

project(pchtest C CXX CXXPCH)

set(CMAKE_VERBOSE_MAKEFILE TRUE)

add_executable(demo src/demo.cpp src/engine.cpp src/library.c)
set_target_properties(demo PROPERTIES
	CXX_STANDARD 11
	CXX_STANDARD_REQUIRED YES
	CXX_EXTENSIONS NO
	)

target_precompiled_header(demo src/prefix.h)
