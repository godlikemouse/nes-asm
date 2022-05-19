# iNES Header

The iNES header format occurs within the first 16 bytes of memory.  The following describes what each byte represents.

    | Byte          | Description                               |
    |---------------|-------------------------------------------|
    | 0-3           | Constant "NES" followed by MS-DOS EOL     |
    | 4             | Size of PRG-ROM in 16k units              |
    | 5             | Size of CHR-ROM in 8k units               |
    | 6             | Mapper mirroring (76543210)               |
    |               |   0: Mirroring:   0 - horizontal          |
    |               |                   1 - vertical            |
    |               |   1: Battery backed cartridge             |
    |               |   2: 512-byte trainer at $7000-$71ff      |
    |               |                (stored before PRG-ROM)    |
    |               |   3: Ignore mirroring control             |
    |               |   4 - 7: Lower nibble of mapper number    |
    | 7             | Mapper, VS/Playchoice, NES 2.0 (76543210) |
    |               |   0: VS Unisystem                         |
    |               |   1: PlayChoice-10                        |
    |               |   2-3: NES 2.0 (if 2-3 == 2)              |
    |               |   4-7: Upper nibble of mapper number      |
    | 8             | PRG-RAM size (rarely used extension)      |
    | 9             | TV-System (rarely used extension) 0 NTSC  |
    | 10            | TV system, PRG-RAM presence (unofficial)  |
    | 11-15         | Unused padding (should be #$00)           |
