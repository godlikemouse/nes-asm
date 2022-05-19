# Sprites

Sprites are composed of 4 bytes. Each byte determines attributes related to how the sprite is displayed. The following table describes the bytes and their meaning.

    | Byte | Bits     | Description                          |
    |------|----------|--------------------------------------|
    |  0   | YYYYYYYY | Y Coordinate - 1. Consider the coor- |
    |      |          | dinate the upper-left corner of the  |
    |      |          | sprite itself.                       |
    |  1   | IIIIIIII | Tile Index # from Pattern Table      |
    |  2   | vhp000cc | Attributes                           |
    |      |          |   v = Vertical Flip   (1=Flip)       |
    |      |          |   h = Horizontal Flip (1=Flip)       |
    |      |          |   p = Background Priority            |
    |      |          |         0 = In front                 |
    |      |          |         1 = Behind                   |
    |      |          |   c = Upper two (2) bits of colour   |
    |  3   | XXXXXXXX | X Coordinate (upper-left corner)     |
