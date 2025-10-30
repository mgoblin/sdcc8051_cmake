# the name of the target operating system
set(CMAKE_SYSTEM_NAME Generic)

set(CMAKE_CROSSCOMPILING TRUE)

if("${SDCC_LOCATION}" STREQUAL "")
	set(SDCC_LOCATION "/usr/bin") # Change it
endif()	

set(CMAKE_ASM_COMPILER_ID "SDAS8051")

# which compilers to use for C
set(CMAKE_C_COMPILER sdcc CACHE INTERNAL "SDCC C compiler")
set(CMAKE_ASM_COMPILER sdas8051 CACHE INTERNAL "asm compiler")
set(CMAKE_ASM_COMPILER_LINKER sdld CACHE INTERNAL "asm linker tool")
set(CMAKE_C_COMPILER_LINKER sdld CACHE INTERNAL "c linker tool")
set(CMAKE_OBJCOPY sdobjcopy CACHE INTERNAL "objcopy tool")
set(CMAKE_PACKIHX packihx CACHE INTERNAL "packihx tool")
set(CMAKE_MAKEBIN makebin CACHE INTERNAL "makebin tool")
set(CMAKE_SDAR sdar CACHE INTERNAL "library tool")

find_program(CMAKE_C_COMPILER sdcc PATHS "${SDCC_LOCATION}" NO_DEFAULT_PATH)
find_program(CMAKE_ASM_COMPILER sdas8051 PATHS "${SDCC_LOCATION}" NO_DEFAULT_PATH)
find_program(CMAKE_ASM_COMPILER_LINKER sdld PATHS "${SDCC_LOCATION}" NO_DEFAULT_PATH)
find_program(CMAKE_OBJCOPY sdobjcopy PATHS "${SDCC_LOCATION}" NO_DEFAULT_PATH)
find_program(CMAKE_PACKIHX packihx PATHS "${SDCC_LOCATION}" NO_DEFAULT_PATH)
find_program(CMAKE_MAKEBIN makebin PATHS "${SDCC_LOCATION}" NO_DEFAULT_PATH)
find_program(CMAKE_SDAR sdar PATHS "${SDCC_LOCATION}" NO_DEFAULT_PATH)

set(CMAKE_AR "${CMAKE_SDAR}" CACHE FILEPATH "The sdcc librarian" FORCE)

option(BUILD_SHARED_LIBS "build shared libraries" OFF)

# here is the target environment is located
set(CMAKE_FIND_ROOT_PATH  /usr/share/sdcc)

# adjust the default behaviour of the FIND_XXX() commands:
# search headers and libraries in the target environment, search 
# programs in the host environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

if(WIN32)
	# !! Firmware size output not tested !!
	function(ihx_to_hex bin)
	    add_custom_command( 
		TARGET ${bin} POST_BUILD COMMAND  ${CMAKE_PACKIHX} ${bin}.ihx > ${bin}.hex
		TARGET ${bin} POST_BUILD COMMAND  ${CMAKE_MAKEBIN} -p ${bin}.hex ${bin}.bin
		TARGET ${bin} POST_BUILD COMMAND  echo | set /p=\"Firmware bytes size: \"
		TARGET ${bin} POST_BUILD COMMAND  for %I in "\"${bin}.bin\"" do @echo %~zI
	    )
	endfunction(ihx_to_hex)

else()	
	function(ihx_to_hex bin)
	    add_custom_command( 
		TARGET ${bin} POST_BUILD COMMAND  ${CMAKE_PACKIHX} ${bin}.ihx > ${bin}.hex
		TARGET ${bin} POST_BUILD COMMAND  ${CMAKE_MAKEBIN} -p ${bin}.hex ${bin}.bin
		TARGET ${bin} POST_BUILD COMMAND  echo -n "Firmware bytes size: "
		TARGET ${bin} POST_BUILD COMMAND  stat --format '%s' ${bin}.bin
	    )
	endfunction(ihx_to_hex)
	
endif()
