project(kernel)

#
#		Load Addresses
#
set(LMONITOR E000)
set(LLOCKOUT F000)
set(LTILEMAP 24000)
set(LTILEIMAGES 26000)
set(LSOURCE 28000)
set(LSPRITES 30000)
set(LBASIC 34000)
set(DOLLAR $$)
set(AADDRESSES "'-D MONITOR_ADDRESS=${DOLLAR}${LMONITOR}' '-D LOCKOUT_ADDRESS=${DOLLAR}${LLOCKOUT}' \
                '-D BASIC_ADDRESS=${DOLLAR}${LBASIC}' '-D SOURCE_ADDRESS=${DOLLAR}${LSOURCE}' \
                '-D SPRITE_ADDRESS=${DOLLAR}${LSPRITES}' '-D TILEMAP_ADDRESS=${DOLLAR}${LTILEMAP}' \
                '-D TILEIMAGES_ADDRESS=${DOLLAR}${LTILEIMAGES}'")
set(OUTDIR output/)

list(APPEND RomSources
    newmonitor
    lockout
)
list(APPEND RomBins
    monitor
    lockout)

add_subdirectory(keyboard)

foreach(src bin IN ZIP_LISTS RomSources RomBins)
    add_custom_command(
        OUTPUT ${bin}.rom
        COMMAND 64tass
        ARGS ${AADDRESSES} -q -c -b 
            -L ${OUTDIR}${src}.lst
            -o ${bin}.rom
        MAIN_DEPENDENCY ${src}.asm
        BYPRODUCTS ${OUTDIR}${src}.lst)
endforeach()
# 	64tass.exe  $(AADDRESSES) -q -c -b -o monitor.rom -L output$(S)newmonitor.lst newmonitor.asm
# 	64tass.exe  $(AADDRESSES) -q -c -b -o lockout.rom -L output$(S)lockout.lst src$(S)lockout.asm

foreach(bin IN LISTS RomBins)
    file(COPY_FILE ${bin}.rom ../bin/${bin}.rom INPUT_MAY_BE_RECENT)
endforeach()

# clean:
# 	$(CDEL) output$(S)*.lst
