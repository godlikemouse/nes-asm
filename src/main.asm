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
    .bank 0             ; game code stored in bank 0
    .org $c000          ; game code starts at either $8000 or $c000

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

Wait_For_VBlank:
    bit $2002
    bpl Wait_For_VBlank

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

Wait_For_VBlank2:
    bit $2002
    bpl Wait_For_VBlank2

Load_Palette:
    ; setup palette - write sequentially to $2006 (store address $3f00)
    lda $2002           ; read PPU status to reset the high/low latch
    lda #$3f
    sta $2006           ; write the high byte of $3F00 address
    lda #$00
    sta $2006           ; write the low byte of $3F00 address

    ldx #0
Load_Palette_Loop:
    lda Test_Palette,x
    sta $2007
    inx
    cpx #$20
    bne Load_Palette_Loop

Load_Sprites:
    ldx #0
Load_Sprites_Loop:
    lda Sprites,x
    sta $0200,x
    inx
    cpx #$10
    bne Load_Sprites_Loop

Load_Background:
    lda $2002           ; read PPU status to reset the high/low latch
    lda #$20
    sta $2006           ; write the high byte of $2000 address
    lda #$00
    sta $2006           ; write the low byte of $2000 address


    ldx #0
Load_Background_Loop:
    lda Background_Nametable,x
    sta $2007
    inx
    cpx #$ff
    bne Load_Background_Loop
    lda Background_Nametable,x
    sta $2007

    ldx #0
Load_Background_Loop2:
    lda Background_Nametable+$100,x
    sta $2007
    inx
    cpx #$ff
    bne Load_Background_Loop2
    lda Background_Nametable,x
    sta $2007

    ldx #0
Load_Background_Loop3:
    lda Background_Nametable+$200,x
    sta $2007
    inx
    cpx #$ff
    bne Load_Background_Loop3
    lda Background_Nametable,x
    sta $2007

    ldx #0
Load_Background_Loop4:
    lda Background_Nametable+$300,x
    sta $2007
    inx
    cpx #$c0
    bne Load_Background_Loop4
    lda Background_Nametable,x
    sta $2007


Load_Background_Attribute:
    lda $2002           ; read PPU status to reset the high/low latch
    lda #$23
    sta $2006           ; write the high byte of $23C0 address
    lda #$c0
    sta $2006           ; write the low byte of $23C0 address

    ldx #0
Load_Background_Attribute_Loop:
    lda Background_Nametable_Attribute,x
    sta $2007
    inx
    cpx #$3c
    bne Load_Background_Attribute_Loop

    ; setup the PPU (see docs/PPU.md)
    lda #%10000000      ; Sprite pattern table (D3:1)
    sta $2000           ; PPU register #1
    lda #%00011110      ; Background/Sprite clip (D1-D2:1), visibility (D3-D4:1)
    sta $2001           ; PPU register #2



    ; main loop
Loop:
    jmp Loop

NMI_Routine:
    lda #$00
    sta $2003
    lda #$02
    sta $4014

    ; setup the PPU (see docs/PPU.md)
    lda #%10000000      ; Sprite pattern table (D3:1)
    sta $2000           ; PPU register #1
    lda #%00011110      ; Background/Sprite clip (D1-D2:1), visibility (D3-D4:1)
    sta $2001           ; PPU register #2

    LDA #$00
    STA $2005
    STA $2005

    rti




    .bank 1
    .org $e000

    .include "src/test.pal"

Sprites:
     ;vert tile attr horiz
  .db $80, $32, $00, $80   ;sprite 0
  .db $80, $33, $00, $88   ;sprite 1
  .db $88, $34, $00, $80   ;sprite 2
  .db $88, $35, $00, $88   ;sprite 3

    .include "src/background.asm"

    ; setup NS routine handlers
    .org $fffa
    .word NMI_Routine   ; NMI_Routine($fffa) VBlank
    .word Reset         ; Reset_Routine($fffc)
    .word 0             ; IRQ_Routine($fffe)


    .bank 2
    .org $0000
    .include "src/test.chr"  ; must be 8192 bytes long
