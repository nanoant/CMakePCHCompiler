## Acknowledgement

I have read README.md and I have already requested support for precompiled headers at official CMake issue tracker. Nevertheless, I want to continue using CMakePCHCompiler for my project understanding that CMakePCHCompiler is neither official nor proper way to provide PCH support for CMake.

## Minimal example

Minimal `CMakeLists.txt` example reproducing bug or showing requested feature:

~~~cmake
cmake_minimum_required(VERSION 3.0)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/CMakePCHCompiler)

project(pchtest CXX CXXPCH)

add_library(engine src/engine.cpp src/library.cpp)
target_precompiled_header(engine src/prefix.h)

add_executable(demo src/demo.cpp)
target_link_libraries(demo engine)
target_precompiled_header(demo src/prefix.h REUSE engine)
~~~

**NOTE:** Individual source files are not necessary, unless their content affects CMake's behavior.

## Additional information

- OS [e.g. macOS]
- CMake version [e.g. 3.14.1]
- Compiler type and version [e.g. GCC 7.2]
- Additional Libraries used [e.g. Qt 5.12]
