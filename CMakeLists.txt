# Almost all CMake files should start with this
# You should always specify a range with the newest
# and oldest tested versions of CMake. This will ensure
# you pick up the best policies.
cmake_minimum_required(VERSION 3.1...3.21)
include(FetchContent)

# This is your project statement. You should always list languages;
project(
  Metagen
  VERSION 1.0
  LANGUAGES C)

include(xxHash.cmake)
add_subdirectory(src)
