cmake_minimum_required(VERSION 3.26)
project(Lab3 CUDA)

set(CMAKE_CUDA_STANDARD 17)
set(CMAKE_CXX_STANDARD 20)

add_executable(Lab3 main.cu)

set_target_properties(Lab3 PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)
