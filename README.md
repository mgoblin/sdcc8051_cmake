# sdcc8051_cmake
SDCC 8051 C/ASM firmware build project template with cmake support.

It demostrates how to make firmware for 8051-architecture MCU using SDCC and cmake.

Template was tested on Debian 13 and Visual Studio Code Version: 1.105.1 OS: Linux x64 6.12.48+deb13-amd64.

# Why?
Intel 8051 architecure microcontrollers are stable and very cheap. This MCUs continue using for simple electronic devices. 

SDCC is free and opensource C/ASM toolkit for 8 and 16 bit microcontrollers firmware including 8051 architecure.

Cmake is a standard de facto to build C applications. 

On beggining STC15W408AS MCU programming I have desire to build firmware outside Platfromio. I'm having trouble building the firmware using cmake.

This repository contains my experiment results to compile STC MCU firmware using cmake and SDCC.

# Required software
Before using this template, you must install the following soft on your PC:
1. [SDCC toolkit](https://sdcc.sourceforge.net/). 
2. [stcgal](https://github.com/grigorig/stcgal) STC MCU ISP flash tool. For others 8051 MCU (not STC) flash target in src/CmakeLists.txt should be modified or target should be removed.
3. Build tools: make or ninjia or both
4. cmake version >= 3.31
5. git (only for clone template files from gihub). 

# How to use it

## First steps
Clone this template from github.
```bash
git clone https://github.com/mgoblin/sdcc8051_cmake

cd sdcc8051_cmake
```
Edit toolchain-SDCC.cmake. Check sdcc location path
```cmake
if("${SDCC_LOCATION}" STREQUAL "")
	set(SDCC_LOCATION "/usr/bin") # Change it
endif()	
```

Open terminal and go to &lt;template dir&gt;/build folder.

Run command: 
```bash
cd build
# For make build tool
cmake -G "Unix Makefiles" ..
# For ninja build tool, but dont use make and ninja at the same time
cmake -G "Ninja" ..
```
