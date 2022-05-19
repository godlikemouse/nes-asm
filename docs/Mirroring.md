# Mirroring

Mirroring specify the scrolling and mirror system to use.  For example, vertical mirroring (`#$01`) which generates a  64x30 tilemap, would allow for horizontal scrolling by combining $2000 and $2400 and mirroring those address locations to $2800 and $2c00 respectively.

    |-------------------------------------------|
    |  $2000               $2400                |        
    |                                           |
    |                                           |
    |-------------------------------------------|
    |  $2800               $2c00                |        
    |                                           |
    |                                           |
    |-------------------------------------------|

Inversely, horizontal mirroring (`#$00`) which generates a 32x60 tilemap would be a good use for vertical scrolling.  In this mode $2000 and $2800 are combined and mirrored to addresses $2400 and $2c00 respectively.

    |-------------------------------------------|
    |  $2000              | $2400               |        
    |                     |                     |
    |                     |                     |
    |                     |                     |
    |  $2800              | $2c00               |        
    |                     |                     |
    |                     |                     |
    |-------------------------------------------|
