.macro mwa src, dst
    lda #<src
    sta dst
    lda #>src
    sta dst+1
.endmacro

.macro mwx src, dst
    ldx #<src
    stx dst
    ldx #>src
    stx dst+1
.endmacro
