;
; wait for vblank
;
.proc wait_for_vblank
wait:
    bit PPU0_STATUS
    bpl wait
    rts
.endproc
