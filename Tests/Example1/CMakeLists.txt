cmake_minimum_required(VERSION 3.0)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/../..)

project(pchtest CXX CXXPCH)

add_library(engine SHARED src/engine.cpp src/library.cpp)
target_precompiled_header(engine src/prefix.h)

add_executable(demo src/demo.cpp)
target_link_libraries(demo engine)
target_precompiled_header(demo src/prefix.h REUSE engine)
set_target_properties(demo PROPERTIES
	CXX_STANDARD 11
	CXX_STANDARD_REQUIRED YES
	CXX_EXTENSIONS NO
	)
