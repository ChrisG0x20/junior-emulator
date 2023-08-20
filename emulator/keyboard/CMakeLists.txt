project(keyboard)

add_custom_command(
    OUTPUT ../include/sdltops2.h
    COMMAND python3
    ARGS ps2codes.py > "../include/sdltops2.h"
    MAIN_DEPENDENCY ps2codes.py)
# 	$(PYTHON) ps2codes.py >..$(S)include$(S)sdltops2.h
