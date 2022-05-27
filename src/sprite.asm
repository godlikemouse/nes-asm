;
; populate sprites
.proc populate_sprites

    ldy #0
loop:
    lda (SPRITE_PTR),y
    sta $0200,y
    iny
    cpy #$10
    bne loop

    rts
.endproc
