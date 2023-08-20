cmake_minimum_required(VERSION 3.26)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_CONFIGURATION_TYPES "Debug;Release")
set(APPNAME $ENV{application_name})

# Build SDL
set(SDL_SRC $ENV{sdl_dir})
add_subdirectory(${SDL_SRC} bin)

file(MAKE_DIRECTORY bin)

add_subdirectory(kernel)
add_subdirectory(emulator)

project(
    ${APPNAME}
    VERSION 1.0.0
    DESCRIPTION "Foenix 256jr Emulator"
)

configure_file(config.h.in config.h)

include_directories(
    ${SDL_SRC}/include
    emulator/include
    kernel/include
)

message(STATUS "PROJECT_BINARY_DIR=${PROJECT_BINARY_DIR}")
message(STATUS "SDL_SRC=${SDL_SRC}")

file(COPY_FILE "${SDL_SRC}bin\\Release\\SDL3.dll" "bin/SDL3.dll" INPUT_MAY_BE_RECENT)
# add_custom_command(TARGET "${SDL_SRC}SDL3" POST_BUILD
#     COMMAND copy "${SDL_SRC}\\bin\\Release\\SDL3.dll" "$(SolutionDir)..\\bin\\SDL3.dll"
#     VERBATIM
# )

# run:kernel_target emulator_target
# 	./bin/jr256$(APPSTEM) basic.rom@b

# clean:
# 	$(CDEL) $(BINDIR)jr256*
# 	$(CDEL) jr256* 
# 	$(CDEL) bin/jr256*
# 	make -C emulator clean
# 	make -C kernel clean
