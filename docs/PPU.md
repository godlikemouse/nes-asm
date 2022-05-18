### PPU Control Register #1 `$2000`

    |  $2000  | PPU Control Register #1 (W)                              |
    |---------|----------------------------------------------------------|
    |         |    D7: Execute NMI on VBlank                             |
    |         |           0 = Disabled                                   |
    |         |           1 = Enabled                                    |
    |         |    D6: PPU Master/Slave Selection --+                    |
    |         |           0 = Master                +-- UNUSED           |
    |         |           1 = Slave               --+                    |
    |         |    D5: Sprite Size                                       |
    |         |           0 = 8x8                                        |
    |         |           1 = 8x16                                       |
    |         |    D4: Background Pattern Table Address                  |
    |         |           0 = $0000 (VRAM)                               |
    |         |           1 = $1000 (VRAM)                               |
    |         |    D3: Sprite Pattern Table Address                      |
    |         |           0 = $0000 (VRAM)                               |
    |         |           1 = $1000 (VRAM)                               |
    |         |    D2: PPU Address Increment                             |
    |         |           0 = Increment by 1                             |
    |         |           1 = Increment by 32                            |
    |         | D1-D0: Name Table Address                                |
    |         |         00 = $2000 (VRAM)                                |
    |         |         01 = $2400 (VRAM)                                |
    |         |         10 = $2800 (VRAM)                                |
    |         |         11 = $2C00 (VRAM)                                |

### PPU Control Register #2 `$2001`

    |  $2001  | PPU Control Register #2 (W)                              |
    |---------|----------------------------------------------------------|
    |         |                                                          |
    |         | D7-D5: Full Background Color (when D0 == 1)              |
    |         |         000 = None  +------------+                       |
    |         |         001 = Green              | NOTE: Do not use more |
    |         |         010 = Blue               |       than one type   |
    |         |         100 = Red   +------------+                       |
    |         | D7-D5: Colour Intensity (when D0 == 0)                   |
    |         |         000 = None            +--+                       |
    |         |         001 = Intensify green    | NOTE: Do not use more |
    |         |         010 = Intensify blue     |       than one type   |
    |         |         100 = Intensify red   +--+                       |
    |         |    D4: Sprite Visibility                                 |
    |         |           0 = Sprites not displayed                      |
    |         |           1 = Sprites visible                            |
    |         |    D3: Background Visibility                             |
    |         |           0 = Background not displayed                   |
    |         |           1 = Background visible                         |
    |         |    D2: Sprite Clipping                                   |
    |         |           0 = Sprites invisible in left 8-pixel column   |
    |         |           1 = No clipping                                |
    |         |    D1: Background Clipping                               |
    |         |           0 = BG invisible in left 8-pixel column        |
    |         |           1 = No clipping                                |
    |         |    D0: Display Type                                      |
    |         |           0 = Color display                              |
    |         |           1 = Monochrome display                         |
    +---------+----------------------------------------------------------+
