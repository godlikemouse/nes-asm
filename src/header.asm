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
