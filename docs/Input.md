# Input

To read input from the controllers, access memory location `$4016` for player 1
and `$4017` for player 2. Before reading from a controller, you must strobe them, by sending a #1 then a #0 to the desired controller address. Afterward, you can read from the input address.  Note, values are retrieved 1 bit at a time, not a byte at a time.  For example, to read values for all buttons requires 8 reads to either `$4016` or `$4017` respectively.

| Value | Button | Description       |
| ----- | ------ | ----------------- |
| 1     | A      | A button          |
| 2     | B      | B button          |
| 3     | Select | Select button     |
| 4     | Start  | Start button      |
| 5     | Up     | Up control pad    |
| 6     | Down   | Down control pad  |
| 7     | Left   | Left control pad  |
| 8     | Right  | Right control pad |
| 9     | Ignore | Not used          |
| 10    | Ignore | Not used          |
| 11    | Ignore | Not used          |
| 12    | Ignore | Not used          |
| 13    | Ignore | Not used          |
| 14    | Ignore | Not used          |
| 15    | Ignore | Not used          |
| 16    | Ignore | Not used          |
| 17    | Sig    | Signature data    |
| 18    | Sig    | Signature data    |
| 19    | Sig    | Signature data    |
| 20    | Sig    | Signature data    |
| 21    | 0      |                   |
| 22    | 0      |                   |
| 23    | 0      |                   |
| 24    | 0      |                   |
