.segment "STARTUP"

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
    jsr wait_for_vblank
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
    jsr wait_for_vblank

Load_Palette:
    ; setup palette - write sequentially to $2006 (store address $3f00)
    lda PPU0_STATUS     ; read PPU status to reset the high/low latch
    lda #$3f
    sta PPU0_ADDR       ; write the high byte of $3F00 address
    lda #$00
    sta PPU0_ADDR       ; write the low byte of $3F00 address

    ; populate palettes
    mwx Test_Palette, PAL_PTR
    jsr populate_palettes

Load_Sprites:
    ; populate sprites
    mwx Spriteset1, SPRITE_PTR
    jsr populate_sprites

Load_Background:
    ; setup background - write sequencially to $2006 (store address $2000)
    lda PPU0_STATUS     ; read PPU status to reset the high/low latch
    lda #$20
    sta PPU0_ADDR       ; write the high byte of $2000 address
    lda #$00
    sta PPU0_ADDR       ; write the low byte of $2000 address

    ; populate background nametables 1 and 2
    mwx Background_Nametable1, NT_PTR
    jsr populate_nametable1
    mwx Background_Nametable2, NT_PTR
    jsr populate_nametable2

Load_Background_Attributes:
    ; setup attributes - write sequencially to $2006 (store address $23c0)
    lda PPU0_STATUS     ; read PPU status to reset the high/low latch
    lda #$23
    sta PPU0_ADDR       ; write the high byte of $23C0 address
    lda #$c0
    sta PPU0_ADDR       ; write the low byte of $23C0 address

    ; populate background attributes
    mwx Background_Nametable_Attribute1, NT_PTR
    jsr populate_nametable1_attributes
    mwx Background_Nametable_Attribute2, NT_PTR
    jsr populate_nametable2_attributes

    ; setup the PPU (see docs/PPU.md)
    lda #%10000000      ; Sprite pattern table (D7:1)
    sta PPU0_REGISTER1  ; PPU register #1
    lda #%00011110      ; Background/Sprite clip (D1-D2:1), visibility (D3-D4:1)
    sta PPU0_REGISTER2  ; PPU register #2
