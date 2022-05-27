.segment "VECTORS"
    ; setup NS routine handlers
    .word on_vblank   ; NMI_Routine($fffa) VBlank
    .word Reset       ; Reset_Routine($fffc)
    .word 0           ; IRQ_Routine($fffe)
