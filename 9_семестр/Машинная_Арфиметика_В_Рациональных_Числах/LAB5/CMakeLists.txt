cmake_minimum_required(VERSION 3.26)
project(LAB5)

set(CMAKE_CXX_STANDARD 20)

find_package(Boost REQUIRED)

add_executable(LAB5 main.cpp
        Fraction.cpp
        Fraction.h)

target_link_libraries(LAB5 PRIVATE Boost::boost)
