# ---- Remove if you dont need firmware build
# Firmware build description
add_executable(main 
  # <item1> <item2> ... - assembler source files *.s *.asm
  main.c 
  # dumb.asm
)
# ---- remove end

target_include_directories(main 
    PRIVATE "${CMAKE_SOURCE_DIR}/include"
)

# Transform firmware ihx to hex
ihx_to_hex(main)

# upload firmware to STC MCU
add_custom_target(flash
    COMMAND stcgal ${CMAKE_BINARY_DIR}/src/main.hex
    DEPENDS main
    JOB_POOL console # for ninja build tool output stgal command input to console
)
