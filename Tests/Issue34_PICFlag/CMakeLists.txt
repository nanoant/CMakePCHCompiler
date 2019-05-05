cmake_minimum_required(VERSION 3.0)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/../..)

project(pchtest CXX CXXPCH)

add_executable(demo src/demo.cpp)
target_precompiled_header(demo src/prefix.h)
set_target_properties(demo PROPERTIES
	POSITION_INDEPENDENT_CODE YES
	)
