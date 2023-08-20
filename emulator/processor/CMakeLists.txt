project(processor)

list(APPEND Definitions
    __6502support
    __6502mnemonics
    __6502opcodes)

string(JOIN ".h " Output ${Definitions})

add_custom_command(
    OUTPUT ${Output}
    COMMAND python3
    ARGS process.py
    MAIN_DEPENDENCY process.py)
# 	$(PYTHON) process.py

foreach(header IN LISTS Definitions)
    file(COPY_FILE ${header}.h ../6502/${header}.h INPUT_MAY_BE_RECENT)
endforeach()
# 	$(CCOPY) *.h ..$(S)6502
