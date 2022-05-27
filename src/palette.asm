.proc populate_palettes

    ldy #0
loop:
    lda (PAL_PTR),y
    sta PPU0_DATA
    iny
    cpy #$20
    bne loop

    rts
.endproc
