Testing CMakePCHCompiler
========================

Testing on macOS
----------------

Each test case should be completed with:

~~~bash
git clean -xdf . && cmake . && make VERBOSE=1
~~~

Alternatively we may want to test it with Ninja too:

~~~bash
git clean -xdf . && cmake -GNinja . && ninja
~~~

Or older CMake (such as 3.0 - oldest supported):

~~~bash
git clean -xdf . && /Applications/CMake/CMake-3.0.1.app/Contents/bin/cmake . && make VERBOSE=1
~~~

Testing on Windows
------------------

Using PowerShell, each test case should be compiled with:

~~~powershell
git clean -xdf .; cmake .; cmake --build .
~~~
