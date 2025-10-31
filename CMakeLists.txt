cmake_minimum_required(VERSION 3.31) # Specify minimum CMake version

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
file(REAL_PATH "toolchain-SDCC.cmake" CMAKE_TOOLCHAIN_FILE EXPAND_TILDE)

set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Compilation flags
set(CMAKE_C_FLAGS "-mmcs51 --model-small --std-c23 --debug")
set(CMAKE_ASM_FLAGS "-lso -a -y")

project(blink LANGUAGES ASM C) # Define project name and language

set(CMAKE_C_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED ON)

add_subdirectory("src")


