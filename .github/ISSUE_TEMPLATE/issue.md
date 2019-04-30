---
name: Issue
about: Please provide detailed information
title: ''
labels: ''
assignees: ''

---

## Checklist

1. Read [`README.md`](https://github.com/nanoant/CMakePCHCompiler/blob/master/README.md) file completely to understand intentions of this project. 
2. Understand that CMakePCHCompiler is neither official nor proper way to provide PCH support in CMake.
3. Request first proper precompiled headers support from CMake's maintainers, adding your comment in [dedicated issue at CMake's issue tracker](https://gitlab.kitware.com/cmake/cmake/issues/1260).
4. Understand that the CMakePCHCompiler authors are neither compensated for their efforts not affiliated with KitWare (CMake's authors).
5. If you know or think you know how to fix / extend CMakePCHCompiler, try to provide PR.

## Minimal example
Provide minimal example of `CMakeLists.txt` (applies for both bug and feature requests):
~~~CMakeLists
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
- CMake Version [e.g. 3.14.1]
- Compiler Type and Version [e.g. GCC 7.2]
