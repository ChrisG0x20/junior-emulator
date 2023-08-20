@echo off
setlocal enableextensions

:: Copyright (c) 2022 Christopher Gassib
:: Distributed under the Boost Software License, Version 1.0.
:: (See accompanying file LICENSE or copy at http://www.boost.org/LICENSE_1_0.txt)

set application_name=JuniorEmulator
set sdl_dir=E:\OtherProjects\SDL\

rem rm -rf build

:: make the simulator build directory
if not exist "build\" (
  mkdir "build"
)

:: build the simulator executable
pushd "build"
cmake -G "Visual Studio 17 2022" -A x64 -DCMAKE_BUILD_TYPE=Release ..
popd

:: build the application
msbuild build\JuniorEmulator.sln -p:Configuration=Release
