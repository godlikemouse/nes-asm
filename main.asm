    ; setup the NES header
    .inesprg    1       ; the number of 16k prg banks
    .ineschr    1       ; the number of 8k chr banks
    .inesmir    1       ; the vram mirroring of the banks (vertical mirroring)
    .inesmap    0       ; the nes mapper to be used (no mapper)

    ; setup game code
    .org $8000          ; game code starts at either $8000 or $c000
    .bank 0             ; game code stored in bank 0

Start:
    ; setup the PPU (see docs/PPU.md)
    lda #%00001000      ; Sprite pattern table (D3:1)
    sta $2000           ; PPU register #1
    lda #%00011110      ; Background/Sprite clip (D1-D2:1), visibility (D3-D4:1)
    sta $2001           ; PPU register #2

    ; setup palette - write sequentially to $2006 (store address $3f00)
    lda #$3f
    sta $2006
    lda #$00
    sta $2006

    ldx #0
Load_Palette:
    lda Title_Palette,x
    sta $2007
    inx
    cpx #$20
    bne Load_Palette

Title_Palette:
    .incbin "test.pal"

Loop:
    jmp Loop

    ; setup NS routine handlers
    .bank 1             ; needed or NESASM gets cranky
    .org $fffa
    .dw	0               ; NMI_Routine($fffa)
    .dw	Start           ; Reset_Routine($fffc)
    .dw	0               ; IRQ_Routine($fffe)

    .bank 2
    .org $0000
    .incbin "test.chr"  ; must be 8192 bytes long
