cmake_minimum_required(VERSION 3.24)
project(Lab1_W)
#
#include_directories("/usr/local/include" "/usr/local/Cellar/libomp/15.0.7/include")
#link_directories("/usr/local/lib" "/usr/local/Cellar/libomp/15.0.7/lib")

# added -fopenmp
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Xclang -fopenmp")
find_library(OPENMP_LIB libomp.dylib /usr/local/Cellar/libomp/15.0.7/lib)

set(CMAKE_CXX_STANDARD 23)

add_executable(Lab1_W main.cpp)

target_link_libraries(Lab1_W LINK_PUBLIC ${OPENMP_LIB})
