; References
;
; CA65 Assembler:
; https://cc65.github.io/doc/ca65.html

    ; setup the NES header
.segment "HEADER"

    .byte "NES"         ; NES constant
    .byte $1a           ; MS-DOS EOL
    .byte $02           ; the number of 16k prg banks (PRG-ROM)
    .byte $01           ; the number of 8k chr banks (CHR-ROM)
    .byte $01           ; the vram mirroring (vert mirroring/horz scroll)
    .byte $00           ; the nes mapper to be used (no mapper)
    .byte $00           ; PRG-RAM size (rarely used extension)
    .byte $00           ; NTSC
    .byte $00           ; TV system, PRG-RAM presence (rarely used extension)
    .byte $00           ; Unused padding
    .byte $00           ; Unused padding
    .byte $00           ; Unused padding
    .byte $00           ; Unused padding
    .byte $00           ; Unused padding

.segment "ZEROPAGE"

NT_ADDR: .res 2, $00    ; Nametable address used for loading into nametables

.segment "STARTUP"

    .include "memory.asm"
    .include "util/macro.asm"

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

    ; wait for vblank sync
    jsr Wait_For_VBlank
    txa

Clear_Memory:
    sta $0000,x
    sta $0100,x
    sta $0300,x
    sta $0400,x
    sta $0500,x
    sta $0600,x
    sta $0700,x
    lda #$ff
    sta $0200,x
    lda #0
    inx
    bne Clear_Memory

    ; wait for vblank sync
    jsr Wait_For_VBlank

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

    ; populate background nametables 1 and 2 with the same source
    mwx Background_Nametable, NT_ADDR
    jsr populate_nametable1
    mwx Background_Nametable2, NT_ADDR
    jsr populate_nametable2


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
    jmp *

;
; populate nametable 1
;   requires indirect address of NT_ADDR to be set prior to invocation
.proc populate_nametable1

    ldx #0
main:
    ldy #0
    cpx #4
    beq done
loop:
    lda (NT_ADDR),y
    sta NTADDR1
    iny
    cpy #$ff
    bne loop

    lda (NT_ADDR),y
    sta NTADDR1

    inc NT_ADDR+1
    inx
    jmp main

done:
    rts
.endproc

;
; populate nametable 2
;   requires indirect address of NT_ADDR to be set prior to invocation
.proc populate_nametable2

    ldx #0
main:
    ldy #0
    cpx #4
    beq done
loop:
    lda (NT_ADDR),y
    sta NTADDR2
    iny
    cpy #$ff
    bne loop

    lda (NT_ADDR),y
    sta NTADDR2

    inc NT_ADDR+1
    inx
    jmp main

done:
    rts
.endproc



.proc Wait_For_VBlank
wait:
    bit $2002
    bpl wait
    rts
.endproc

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


    .include "palette/test.asm"

Sprites:
     ;vert tile attr horiz
    .byte $80, $32, $00, $80   ;sprite 0
    .byte $80, $33, $00, $88   ;sprite 1
    .byte $88, $34, $00, $80   ;sprite 2
    .byte $88, $35, $00, $88   ;sprite 3

    .include "nametable/test.asm"
    .include "nametable/test-attr.asm"
    .include "nametable/test2.asm"

.segment "VECTORS"
    ; setup NS routine handlers
    .word NMI_Routine   ; NMI_Routine($fffa) VBlank
    .word Reset         ; Reset_Routine($fffc)
    .word 0             ; IRQ_Routine($fffe)

.segment "CHARS"
    .include "char/test.asm"  ; must be 8192 bytes long
