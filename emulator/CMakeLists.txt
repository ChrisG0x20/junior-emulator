project(emulator)

set(APPNAME jr256)
set(SDL_SRC $ENV{sdl_dir})

if (WIN32)
    set(APPEXT ".exe")
else()
    set(APPEXT "")
endif()

include_directories(./
                    ./include
                    ./6502
                    ${SDL_SRC}/include
                    ${SDL_SRC}/include/SDL3)

#add_subdirectory(${SDL_SRC} bin)

set(SOURCES
    src/sys_processor.cpp
    framework/main.cpp
    framework/gfx.cpp
    framework/debugger.cpp
    src/sys_debug_uk101.cpp
    src/hardware.cpp
    src/hw_fifo.cpp)

add_subdirectory(processor)
add_subdirectory(roms)
add_subdirectory(keyboard)

set(LMONITOR E000)
set(LLOCKOUT F000)
set(LTILEMAP 24000)
set(LTILEIMAGES 26000)
set(LSOURCE 28000)
set(LSPRITES 30000)
set(LBASIC 34000)
add_compile_definitions(
    MONITOR_ADDRESS=0x${LMONITOR}
    LOCKOUT_ADDRESS=0x${LLOCKOUT}
    BASIC_ADDRESS=0x${LBASIC}
    SOURCE_ADDRESS=0x${LSOURCE}
    SPRITE_ADDRESS=0x${LSPRITES}
    TILEMAP_ADDRESS=0x${LTILEMAP}
    TILEIMAGES_ADDRESS=0x${LTILEIMAGES})

add_compile_definitions(
    INCLUDE_DEBUGGING_SUPPORT
    SDL_MAIN_HANDLED)
include_directories(
    cpu
    framework
    include)

add_executable(${APPNAME} ${SOURCES})

target_link_libraries(${APPNAME} ${SDL_SRC}bin/Release/sdl3.lib)
#add_dependencies(${APPNAME} SDL) # TODO: don't know how this works.
target_compile_options(${APPNAME} PUBLIC
                        #-fno-stack-protector
                        #-w -Wl,-subsystem,windows 
                        -DSDL_MAIN_HANDLED)

add_custom_command(TARGET ${APPNAME} POST_BUILD
    COMMAND copy "$(OutDir)${APPNAME}${APPEXT}" "$(SolutionDir)..\\bin\\${APPNAME}${APPEXT}"
    # COMMAND $<IF:WIN32,copy,cp> ${APPNAME}${APPEXT} ../bin/${APPNAME}${APPEXT}
    VERBATIM
)

# clean:
# 	$(CDEL) $(APPNAME) 
# 	$(CDEL) src$(S)*.o 
# 	$(CDEL) framework$(S)*.o
