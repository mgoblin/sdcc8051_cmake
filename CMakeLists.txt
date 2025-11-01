cmake_minimum_required(VERSION 3.31) # Specify minimum CMake version

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
file(REAL_PATH "toolchain-SDCC.cmake" CMAKE_TOOLCHAIN_FILE EXPAND_TILDE)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

project(blink LANGUAGES ASM C) # Define project name and language

set(CMAKE_C_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED ON)

add_subdirectory("src")


