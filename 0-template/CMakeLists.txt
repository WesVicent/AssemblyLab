cmake_minimum_required(VERSION 3.15)

file(READ "${CMAKE_SOURCE_DIR}/.env" ENV_FILE_CONTENT)

string(REGEX MATCH "PROJECT_NAME=([^\n\r]+)" _ ${ENV_FILE_CONTENT})
set(PROJECT_NAME ${CMAKE_MATCH_1})

if(NOT PROJECT_NAME)
    message(FATAL_ERROR "PROJECT_NAME not found in .env")
endif()

project(${PROJECT_NAME} C ASM_NASM)

enable_language(ASM_NASM)

set(CMAKE_ASM_NASM_OBJECT_FORMAT elf64)

# Debug symbols
set(CMAKE_ASM_NASM_FLAGS "${CMAKE_ASM_NASM_FLAGS} -g -F dwarf")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(SOURCES src/main.asm)

add_executable(${PROJECT_NAME} ${SOURCES})

# Use _start instead of main
set_target_properties(${PROJECT_NAME} PROPERTIES LINKER_LANGUAGE C)

target_link_options(${PROJECT_NAME} PRIVATE
    -nostdlib
    -no-pie
)