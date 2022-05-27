; References
;
; CA65 Assembler:
; https://cc65.github.io/doc/ca65.html

    .include "hardware.asm"
    .include "nametable.asm"
    .include "sprite.asm"
    .include "palette.asm"
    .include "util/macro.asm"
    .include "util/vblank.asm"

; *** header ***
    .include "header.asm"

; *** zeropage ***
    .include "zeropage.asm"

; *** startup ***
    .include "startup.asm"

    ; main loop
    jmp *

    .include "interrupt.asm"
    .include "sprite/spriteset1.asm"
    .include "nametable/test1.asm"
    .include "nametable/test1-attr.asm"
    .include "nametable/test2.asm"
    .include "nametable/test2-attr.asm"
    .include "palette/test.asm"

; *** vectors ***
    .include "vector.asm"

; *** chars ***
    .include "char.asm"
