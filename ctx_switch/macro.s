/* Copyright(C) 2019 Hex Five Security, Inc. */
/* 10-MAR-2019 Cesare Garlati                */

# -----------------------------------------------------------------------------
.macro CTX_LOAD
# -----------------------------------------------------------------------------

		csrr x31, mscratch

	    lw  x1,  0*4 (x31); csrw mepc, x1
	    lw  x1,  1*4 (x31)
	    lw  x2,  2*4 (x31)
		lw  x3,  3*4 (x31)
		lw  x4,  4*4 (x31)
		lw  x5,  5*4 (x31)
		lw  x6,  6*4 (x31)
		lw  x7,  7*4 (x31)
		lw  x8,  8*4 (x31)
		lw  x9,  9*4 (x31)
		lw x10, 10*4 (x31)
		lw x11, 11*4 (x31)
		lw x12, 12*4 (x31)
		lw x13, 13*4 (x31)
		lw x14, 14*4 (x31)
		lw x15, 15*4 (x31)
		lw x16, 16*4 (x31)
		lw x17, 17*4 (x31)
		lw x18, 18*4 (x31)
		lw x19, 19*4 (x31)
		lw x20, 20*4 (x31)
		lw x21, 21*4 (x31)
		lw x22, 22*4 (x31)
		lw x23, 23*4 (x31)
		lw x24, 24*4 (x31)
		lw x25, 25*4 (x31)
		lw x26, 26*4 (x31)
		lw x27, 27*4 (x31)
		lw x28, 28*4 (x31)
		lw x29, 29*4 (x31)
		lw x30, 30*4 (x31)
		lw x31, 31*4 (x31)

.endm


# -----------------------------------------------------------------------------
.macro CTX_STORE
# -----------------------------------------------------------------------------

		csrrw x31, mscratch, x31

	    sw  x1,  1*4 (x31)
	    sw  x2,  2*4 (x31)
		sw  x3,  3*4 (x31)
		sw  x4,  4*4 (x31)
		sw  x5,  5*4 (x31)
		sw  x6,  6*4 (x31)
		sw  x7,  7*4 (x31)
		sw  x8,  8*4 (x31)
		sw  x9,  9*4 (x31)
		sw x10, 10*4 (x31)
		sw x11, 11*4 (x31)
		sw x12, 12*4 (x31)
		sw x13, 13*4 (x31)
		sw x14, 14*4 (x31)
		sw x15, 15*4 (x31)
		sw x16, 16*4 (x31)
		sw x17, 17*4 (x31)
		sw x18, 18*4 (x31)
		sw x19, 19*4 (x31)
		sw x20, 20*4 (x31)
		sw x21, 21*4 (x31)
		sw x22, 22*4 (x31)
		sw x23, 23*4 (x31)
		sw x24, 24*4 (x31)
		sw x25, 25*4 (x31)
		sw x26, 26*4 (x31)
		sw x27, 27*4 (x31)
		sw x28, 28*4 (x31)
		sw x29, 29*4 (x31)
		sw x30, 30*4 (x31)

		csrrw x1, mscratch, x31
		sw  x1, 31*4 (x31)

		csrr x1, mepc
		sw  x1,  0*4 (x31)

.endm

# -----------------------------------------------------------------------------
.macro CTX_CLEAR
# -----------------------------------------------------------------------------

	    mv  x1, zero
	    mv  x2, zero
		mv  x3, zero
		mv  x4, zero
		mv  x5, zero
		mv  x6, zero
		mv  x7, zero
		mv  x8, zero
		mv  x9, zero
		mv x10, zero
		mv x11, zero
		mv x12, zero
		mv x13, zero
		mv x14, zero
		mv x15, zero
		mv x16, zero
		mv x17, zero
		mv x18, zero
		mv x19, zero
		mv x20, zero
		mv x21, zero
		mv x22, zero
		mv x23, zero
		mv x24, zero
		mv x25, zero
		mv x26, zero
		mv x27, zero
		mv x28, zero
		mv x29, zero
		mv x30, zero
		mv x31, zero

.endm

# -----------------------------------------------------------------------------
.macro	TMR_SET ms:req
# -----------------------------------------------------------------------------

		# read mtime
      	lui a0, %hi(MTIME)
 1:   	lw	a2, %lo(MTIME)+4(a0)
      	lw  a1, %lo(MTIME)+0(a0)
		lw	a3, %lo(MTIME)+4(a0)
  		bne a2, a3, 1b

		# add tick time
		addi a3, a1, (\ms)*RTC_FREQ/1000
		sltu a1, a3, a1
		add  a2, a1, a2

		# write mtimecmp
	   	lui a0, %hi(MTIMECMP)
		li  a1, -1
		sw  a1, %lo(MTIMECMP)+0(a0)
		sw  a2, %lo(MTIMECMP)+4(a0)
		sw  a3, %lo(MTIMECMP)+0(a0)

.endm


# -----------------------------------------------------------------------------
.macro THREAD id:req
# -----------------------------------------------------------------------------

		CTX_CLEAR

		li a0, \id

1:		addi a1, a1, \id+1
		nop
		nop
		nop
		j 1b

.endm
