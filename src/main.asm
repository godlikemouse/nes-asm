; References
;
; https://www.nesdev.org/wiki/Nesdev_Wiki

    .list

    ; setup the NES header
    .inesprg    1       ; the number of 16k prg banks (PRG-ROM)
    .ineschr    1       ; the number of 8k chr banks (CHR-ROM)
    .inesmir    1       ; the vram mirroring of the banks (vertical mirroring)
    .inesmap    0       ; the nes mapper to be used (no mapper)

    ; setup game code
    .org $8000          ; game code starts at either $8000 or $c000
    .bank 0             ; game code stored in bank 0

Wait_For_VBlank:
    bit $2002
    bpl Wait_For_VBlank
    rts

Reset:
    sei                 ; disable IRQs
    cld                 ; disable decimal mode
    ldx #$40
    stx $4017           ; disable APU frame IRQ
    ldx #$ff
    txs                 ; setup stack
    inx
    stx $2000           ; disable NIM
    stx $2001           ; disable rendering
    stx $4010           ; disable DMC IRQs

    jsr Wait_For_VBlank

    txa

Clear_Memory:
    sta $0000,x
    sta $0100,x
    sta $0200,x
    sta $0400,x
    sta $0500,x
    sta $0600,x
    sta $0700,x
    lda #$fe
    sta $0300,x
    inx
    bne Clear_Memory

Wait_For_VBlank2
    bit $2002
    bpl Wait_For_VBlank2


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


    ; setup palette
Test_Palette:
    .include "src/test.pal"

    ldx #0
Load_Palette:
    lda Test_Palette,x
    sta $2007
    inx
    cpx #$20
    bne Load_Palette

    ; main loop
Loop:
    jmp Loop

    ; setup NS routine handlers
    .bank 1             ; needed or NESASM gets cranky
    .org $fffa
    .word 0             ; NMI_Routine($fffa) VBlank
    .word Reset         ; Reset_Routine($fffc)
    .word 0             ; IRQ_Routine($fffe)

    .bank 2
    .org $0000
    .include "src/test.chr"  ; must be 8192 bytes long
