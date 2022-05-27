;
; populate nametable 1
;   requires indirect address of NT_PTR to be set prior to invocation
.proc populate_nametable1

    ldx #0
main:
    ldy #0
    cpx #4
    beq done
loop:
    lda (NT_PTR),y
    sta PPU0_DATA
    iny
    cpy #$ff
    bne loop

    lda (NT_PTR),y
    sta PPU0_DATA

    inc NT_PTR+1
    inx
    jmp main

done:
    rts
.endproc

;
; populate nametable 2
;   requires indirect address of NT_PTR to be set prior to invocation
.proc populate_nametable2

    ldx #0
main:
    ldy #0
    cpx #4
    beq done
loop:
    lda (NT_PTR),y
    sta PPU1_DATA
    iny
    cpy #$ff
    bne loop

    lda (NT_PTR),y
    sta PPU1_DATA

    inc NT_PTR+1
    inx
    jmp main

done:
    rts
.endproc

;
; populate nametable 1 attributes
;   requires indirect access of NT_PTR to be set prior to invocation
.proc populate_nametable1_attributes

    ldy #0
loop:
    lda (NT_PTR),y
    sta PPU0_DATA
    iny
    cpy #$3c
    bne loop

    rts
.endproc

;
; populate nametable 2 attributes
;   requires indirect access of NT_PTR to be set prior to invocation
.proc populate_nametable2_attributes

    ldy #0
loop:
    lda (NT_PTR),y
    sta PPU1_DATA
    iny
    cpy #$40
    bne loop

    rts
.endproc
