project(roms)

file(COPY_FILE ../../bin/monitor.rom monitor.rom INPUT_MAY_BE_RECENT)
# 	$(CCOPY) ..$(S)..$(S)bin$(S)monitor.rom .

add_custom_command(
    OUTPUT monitor_rom.h foenix_charset.h
    COMMAND python3
    ARGS export.py
    MAIN_DEPENDENCY export.py)
# 	$(PYTHON) export.py
