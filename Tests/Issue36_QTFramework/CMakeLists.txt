# git sc -xdf && cmake . -DCMAKE_PREFIX_PATH=/Applications/Qt/5.9.7/clang_64/lib/cmake && make VERBOSE=1

cmake_minimum_required(VERSION 2.8.11)

# Enabling C++11 via this does not work with CMakePCHCompiler,
# use set_target_properties CXX_STANDARD instead.
# set(CMAKE_CXX_STANDARD 11)
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/../..)

project(demo CXX CXXPCH)
set(CMAKE_VERBOSE_MAKEFILE ON)

# set(CMAKE_DEBUG_TARGET_PROPERTIES INCLUDE_DIRECTORIES)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt5Core REQUIRED)

add_executable(${PROJECT_NAME} src/main.cpp)

target_link_libraries(${PROJECT_NAME} Qt5::Core)
target_precompiled_header(${PROJECT_NAME} src/prefix.h)
set_target_properties(${PROJECT_NAME} PROPERTIES
	CXX_STANDARD 11
	CXX_STANDARD_REQUIRED YES
	CXX_EXTENSIONS NO
	)
