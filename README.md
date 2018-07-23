CMake Precompiled Headers
=========================

This module defines extra CXXPCH compiler that compiles `.h` into `.pch/.gch`.

For convenience it defines

	target_precompiled_header(target [...] header
	                          [REUSE other_target]
	                          [TYPE type])

Uses given header as precompiled header for given target.

Optionally it may share compiled header object with other target, so it is
precompiled just once.

Also header may be given different type that default `c++-header`.

Supported & tested platforms
----------------------------

1. *CMake* version 3.0 or higher
2. *Windows* with `MSVC`, tested on *VS2015*
3. *OSX* with `Clang`, `GCC`, tested on *OSX 10.10* & *Xcode 6.1*
4. *Linux* with `GCC`, tested on *Ubuntu 14.04 LTS* & *GCC 4.8*

Note for MSVC users
-------------------

Due to the problem in MSVC 2010 Microsoft.Cpp.Win32.targets and higher deleting PCH this module enforces `/Z7` compiler flag, hence debug information is stored on `.obj` files instead of `.pdb` program database. This is certainly not a perfect solution, but only one that is known to work so far. If you know any better workaround please submit PR. Thanks!

Example
-------

	cmake_minimum_required(VERSION 3.0)

	list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/CMakePCHCompiler)

	project(pchtest CXX CXXPCH)

	add_library(engine SHARED src/engine.cpp src/library.cpp)
	target_precompiled_header(engine src/prefix.h)

	add_executable(demo src/demo.cpp)
	target_link_libraries(demo engine)
	target_precompiled_header(demo src/prefix.h REUSE engine)

What it is about?
-----------------

*CMake* does not support precompiled headers by default. There are several
modules providing precompiled header support, but all of them use custom
commands and complicated wrappers to achieve their goals.

This module is somehow different. It defines a *meta C++ compiler* that simply
just patches compiler command template for precompiled header case.

Next it treats precompiled header file as source file for `CXXPCH` that makes
*CMake* use `CXXPCH` patched instead origin `CXX` compiler template. This
ensures that all `CXX` language flags and specific settings such as these
populated by `add_definitions` are also applied to precompiled header.

Passing same flags during precompiled header and other source files compilation
is very important. It is simply impossible to catch all flags, such as these
defined after calling `target_precompiled_header` or these using *CMake*
internal variables such as `add_definitions`, using custom commands. This is
the reason for such implementation.

This module is also transparent to source code. There is absolutely no need to
change you source files. Only requirement is a precompiled header `.h` file
added to given target via `target_precompiled_header` function.

Nevertheless this is not an ideal solution. In perfect world it is *CMake* that
should handle precompiled headers generation internally, based on given
compiler command templates. However this may be good start to request native
support using simple API of:

	target_precompiled_header(<target> <path/to/precompiled_header.h>)
	target_precompiled_header(<target1> <target2>
	                          <path/to/precompiled_header.h>)
	target_precompiled_header(<target> <path/to/precompiled_header.h> REUSE
	                          <other_target_to_reuse_precompiled_header_from>)

How does it work?
-----------------

First, we define new compilers `CPCH` and `CXXPCH` using `CMAKE_<LANG>_*`
variables. These compilers copy run templates and options from existing `C` and
`CXX` compilers respectively.

Next we provide `target_precompiled_header` function that enabled precompiled
header on given target.

Pre-compiler header is build in new `target.pch` subtarget using:

	add_library(${target}.pch OBJECT ${header})

This is done on purpose because of few reasons:

1. *CMake* does not allow to insert source file to existing target once it has
   been defined.

2. Even if it was possible, we could not ensure precompiled header is built
   first in main target, but adding it as subtarget we can.

3. We cannot prevent `header.pch`, which is output of `CPCH/CXXPCH` compiler
   from being linked when it is in part of main target, but if we put it into
   OBJECT library, then by definition we skip linking process. Also we take the
   result object to be a recompiled header for main target.

License
-------

[authors]: https://github.com/nanoant/CMakePCHCompiler/graphs/contributors

Copyright (c) 2015-2018 [CMakePCHCompiler Authors][authors]

This code is licensed under the MIT License, see [LICENSE](LICENSE) for details.