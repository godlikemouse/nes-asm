# Name Table

NES graphics are displayed using a matrix of tiles, this is known as a
Name Table. Each tile is 8x8 pixels. The Name Table is made up of 32x30 tiles
(256x240 pixels). Resolution differs between NTSC and PAL. The Name Table
holds the tile number which relates to the Pattern Table.

    | Address | Size  | Flags | Description        |
    |---------|-------|-------|--------------------|
    | $2000   | $3C0  |       | Name Table #0      |
    | $23C0   | $40   |  M    | Attribute Table #0 |
    | $2400   | $3C0  |  M    | Name Table #1      |
    | $27C0   | $40   |  M    | Attribute Table #1 |
    | $2800   | $3C0  |  M    | Name Table #2      |
    | $2BC0   | $40   |  M    | Attribute Table #2 |
    | $2C00   | $3C0  |  M    | Name Table #3      |
    | $2FC0   | $40   |  M    | Attribute Table #3 |

M = Mirrored

# Attribute Table

Each byte in an Attribute Table represents a 4x4 group of tiles on the screen.

    |  Square 0  |  Square 1  |  #0-F represents an 8x8 tile
    |------------|------------|
    |   #0  #1   |   #4  #5   |
    |   #2  #3   |   #6  #7   |  Square [x] represents four (4) 8x8 tiles
    |------------|------------|   (i.e. a 16x16 pixel grid)
    |  Square 2  |  Square 3  |
    |   #8  #9   |   #C  #D   |
    |   #A  #B   |   #E  #F   |

Each attribute byte (`%dddddddd`) for a given square breaks down in the following way:

| D7  | D6  | D5  | D4  | D3  | D2  | D1  | D0  |                               |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------------------------- |
| 3   | 3   | 2   | 2   | 1   | 1   | 0   | 0   | Upper color bits for square # |

Each square # contains 4 tiles (ie. Square 0, contains tiles #0,#1,#2,#3). Every 2 bits of an attribute byte corresponds to a given Square # (ie. `%11000000` corresponds to Square 3).
