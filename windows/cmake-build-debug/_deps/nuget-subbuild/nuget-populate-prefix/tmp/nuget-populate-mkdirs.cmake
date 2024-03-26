# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "D:/3b3znew/github/dogdog/windows/cmake-build-debug/_deps/nuget-src"
  "D:/3b3znew/github/dogdog/windows/cmake-build-debug/_deps/nuget-build"
  "D:/3b3znew/github/dogdog/windows/cmake-build-debug/_deps/nuget-subbuild/nuget-populate-prefix"
  "D:/3b3znew/github/dogdog/windows/cmake-build-debug/_deps/nuget-subbuild/nuget-populate-prefix/tmp"
  "D:/3b3znew/github/dogdog/windows/cmake-build-debug/_deps/nuget-subbuild/nuget-populate-prefix/src/nuget-populate-stamp"
  "D:/3b3znew/github/dogdog/windows/cmake-build-debug/_deps/nuget-subbuild/nuget-populate-prefix/src"
  "D:/3b3znew/github/dogdog/windows/cmake-build-debug/_deps/nuget-subbuild/nuget-populate-prefix/src/nuget-populate-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "D:/3b3znew/github/dogdog/windows/cmake-build-debug/_deps/nuget-subbuild/nuget-populate-prefix/src/nuget-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "D:/3b3znew/github/dogdog/windows/cmake-build-debug/_deps/nuget-subbuild/nuget-populate-prefix/src/nuget-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()
