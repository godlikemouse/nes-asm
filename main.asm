    .inesprg    1
    .ineschr    1
    .inesmir    1
    .inesmap    0

    .org $8000
    .bank 0

Start:
    ; setup the PPU
    lda #%00001000
    sta $2000
    lda #%00011110
    sta $2001

Loop:
    jmp Loop

    .bank 1            ;needed or NESASM gets cranky
    .org $fffa         ;ditto
    .dw	0	           ;NMI_Routine($FFFA)
    .dw	Start          ;Reset_Routine($FFFC)
    .dw	0	           ;IRQ_Routine($FFFE)
