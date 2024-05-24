cmake_minimum_required(VERSION 3.24)
project(Lab2_MPI)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Xclang -fopenmp")
find_library(OPENMP_LIB libomp.dylib /usr/local/Cellar/libomp/15.0.7/lib)
find_library(OPENMPI_LIB libmpi.dylib /opt/homebrew/Cellar/open-mpi/4.1.4_2/lib)

set(CMAKE_CXX_STANDARD 23)

add_executable(Lab2_MPI main.cpp)
target_link_libraries(Lab2_MPI LINK_PUBLIC ${OPENMP_LIB} ${OPENMPI_LIB})



