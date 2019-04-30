cmake_minimum_required(VERSION 3.0)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/../../..)

project(pchtest CXX CXXPCH)
# project(pchtest CXX)

add_executable(demo demo.cpp ../shared.cpp)
target_precompiled_header(demo ../prefix.h)
