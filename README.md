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

This command generate files to build project using make utility (or ninja). Command output is:

```
-- The ASM compiler identification is SDAS8051
-- Found assembler: /usr/bin/sdas8051
-- The C compiler identification is SDCC
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/bin/sdcc - skipped
-- Configuring done (0.3s)
-- Generating done (0.0s)
-- Build files have been written to: <absoule path to template_dir/build folder> 
```

Now you are ready to build firmware and static library. Run command:
```bash
make
# or ninja 
```
Command output is:
```
[ 33%] Building C object src/CMakeFiles/main.dir/main.rel
[ 66%] Building ASM object src/CMakeFiles/main.dir/dumb.rel
[100%] Linking C executable main.ihx
packihx: read 15 lines, wrote 20: OK.
Firmware bytes size: 193
[100%] Built target main
```

Yap. Success. You can find firmware hex file &lt;template dir&gt;/build/src/main.hex

f you have STC MCU (dev board) connected to PC with something like [STC programmator](https://github.com/mgoblin/STC-programmator) firmware could be uploaded.

Assume terminal in &lt;template dir&gt;/build folder.
To upload firmware run:
```bash
make flash
```
This command run stcgal flash tool.

Once the download is complete, the LED on the microcontroller pin P10 will start blinking.

## Change C and ASM source files
Source code files placed in &lt;template dir&gt;/src subfolder. 
For demo purposes template contains one assembler source code file **dumb.s** and C file **main.c**. main.c call delay function from assembler dumb.s.

Assembler source files must have s or asm extension.

For change builded source files place it to src folder and edit src/CmakeLists.txt.

```cmake
# Firmware build description
add_executable(blink 
  # <item1> <item2> ... - source files *.s *.asm *.c
  main.c
  dumb.s 
)
```

# Change compiler and linker flags (optional)
See SDCC documentation and edit src folder CMakeLists.txt

For compile flags change:
```cmake
target_compile_options(main PRIVATE
  $<IF:$<COMPILE_LANGUAGE:C>, -mmcs51 --model-small -std-c23 --debug,>
  $<IF:$<COMPILE_LANGUAGE:ASM>, -lso -a -y,>
)
```

For link flags change
```cmake
target_link_options(main PRIVATE
  -mmcs51 --debug
)
```

# Use Cmake with Visual Studio code
This is optional step. 

With cmake you are free to use your favorite IDE/code editor.

But if you like to develop embedded software using VS code, do following steps: 
 - Install VS code. 
 - Install C/C++ and cmake plugins.
 - Go to command palette (Ctrl+Shift+P) and select "Edit User-Local Cmake Kits" command. File cmake-tools-kits.json will be opened.

At the end of json add SDCC Cmake Kit description 
```json
  [
  {
    "name": "GCC 14.2.0 x86_64-linux-gnu",
    "compilers": {
      "C": "/usr/bin/gcc",
      "CXX": "/usr/bin/g++"
    },
    "isTrusted": true
  },
  {
    "name": "GCC 14.2.1 arm-none-eabi",
    "compilers": {
      "C": "/usr/bin/arm-none-eabi-gcc",
      "CXX": "/usr/bin/arm-none-eabi-g++"
    },
    "isTrusted": true
  },
  {
    "name": "SDCC",
    "compilers": {
      "C": "/usr/bin/sdcc",
      "ASM": "/usr/bin/sdas8051"
    },
    "isTrusted": true
  }
]
```
Save cmake-tools-kits.json.

After that, you can open the project folder (File/Open Folder menu item) and VS Code will "pick up" the project with cmake support. When VS code importing project select SDCC Kit in drop-down list.   

Using command palette you can build running "CMake:Build" and other cmake commands now.