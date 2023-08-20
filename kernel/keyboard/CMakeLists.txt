project(keyboard)

add_custom_command(
    OUTPUT ../include/ps2convert.inc
    COMMAND python3
    ARGS scancodes.py > "../include/ps2convert.inc"
    MAIN_DEPENDENCY scancodes.py)
# $(PYTHON) scancodes.py > ..$(S)include$(S)ps2convert.inc

file(COPY_FILE ps2.data ../../emulator/keyboard/ps2.data INPUT_MAY_BE_RECENT)
# $(CCOPY) ps2.data ..$(S)..$(S)emulator$(S)keyboard
