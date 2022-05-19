# Memory Map

      | Address | Size  | Flags | Description           |
      |---------|-------|-------|-----------------------|
      | $0000   | $800  |       | RAM                   |
      | $0800   | $800  | M     | RAM                   |
      | $1000   | $800  | M     | RAM                   |
      | $1800   | $800  | M     | RAM                   |
      | $2000   | 8     |       | Registers             |
      | $2008   | $1FF8 |  R    | Registers             |
      | $4000   | $20   |       | Registers             |
      | $4020   | $1FDF |       | Expansion ROM         |
      | $6000   | $2000 |       | SRAM                  |
      | $8000   | $4000 |       | PRG-ROM               |
      | $C000   | $4000 |       | PRG-ROM               |

         Flag Legend: M = Mirror of $0000
                      R = Mirror of $2000-2008 every 8 bytes
                          (e.g. $2008=$2000, $2018=$2000, etc.)
