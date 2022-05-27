.proc on_vblank
    lda #$00
    sta $2003
    lda #$02
    sta $4014

    ; setup the PPU (see docs/PPU.md)
    lda #%10000000      ; Sprite pattern table (D3:1)
    sta PPU0_REGISTER1  ; PPU register #1
    lda #%00011110      ; Background/Sprite clip (D1-D2:1), visibility (D3-D4:1)
    sta PPU0_REGISTER2  ; PPU register #2

    LDA #$00
    STA $2005
    STA $2005

    rti
.endproc
