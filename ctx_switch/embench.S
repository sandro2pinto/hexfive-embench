# Copyright(C) 2019 Hex Five Security, Inc.
# 10-MAR-2019 Cesare Garlati 

		.global _start

		.align 2;
# -----------------------------------------------------------------------------
_start:
# -----------------------------------------------------------------------------

		# setup trap vector
		la a0, _mtvec; csrw mtvec, a0

		# disable interrupts - do not assume zero
		csrw mie, zero

        # do something
        nop

        ebreak


		.align 8;
# -----------------------------------------------------------------------------
_mtvec:
# -----------------------------------------------------------------------------
		csrrw a0, mcause, a0
		csrrw a0, mcause, a0
		mret

