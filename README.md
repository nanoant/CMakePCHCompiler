CMake Precompiled Headers
=========================

This module defines extra CXXPCH compiler that compiles `.h` into `.pch/.gch`.

For convenience it defines

	target_precompiled_header(target header [SHARED other_target] [TYPE type])

Uses given header as precompiled header for given target.

Optionally it may share compiled header object with other target, so it is
precompiled just once.

Also header may be given different type that default `c++-header`.

Supported & tested platforms
----------------------------

1. *Windows* with `MSVC`, tested on *VS2015*
2. *OSX* with `Clang`, `GCC`, tested on *OSX 10.10* & *Xcode 6.1*
3. *Linux* with `GCC`, tested on *Ubuntu 14.04 LTS* & *GCC 4.8*

Example
-------

	cmake_minimum_required(VERSION 2.6)
	
	list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/CMakePCHCompiler)
	
	project(pchtest CXX CXXPCH)
	
	add_library(engine SHARED src/engine.cpp src/library.cpp src/prefix.h)
	target_precompiled_header(engine src/prefix.h)
	
	add_executable(demo src/demo.cpp)
	target_link_libraries(demo engine)
	target_precompiled_header(demo src/prefix.h SHARED engine)

License
-------

Copyright (c) 2014-2015 Adam Strzelecki. All rights reserved.

This code is licensed under the MIT License:

> The MIT License
>
> License for the specific language governing rights and limitations under
> Permission is hereby granted, free of charge, to any person obtaining a
> copy of this software and associated documentation files (the "Software"),
> to deal in the Software without restriction, including without limitation
> the rights to use, copy, modify, merge, publish, distribute, sublicense,
> and/or sell copies of the Software, and to permit persons to whom the
> Software is furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included
> in all copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
> OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> DEALINGS IN THE SOFTWARE.
