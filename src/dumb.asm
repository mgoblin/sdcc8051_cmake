; Delay execution module

.module delay
.optsdcc -mmcs51 --model-small

.area CSEG	(CODE)

;=====================================================================
; Delay subroutine
; Wait for ~1 second
; Change R5, R6, R7 registrers
; Subroutine caller should save/restore used register if needed
;=====================================================================
_delay::
	mov R7, #0x1f
d1:	mov R6, #0xff
d2:	mov R5, #0xff
	
d3:	djnz R5, d3
	djnz R6, d2
	djnz R7, d1
	
	ret
