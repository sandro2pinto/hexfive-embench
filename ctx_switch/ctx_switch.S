# Copyright(C) 2019 Hex Five Security, Inc.
# 10-MAR-2019 Cesare Garlati

#include "platform.h"
#include "macro.s"

.section .data
.equ ctx_size, 32*4 # 32 regs x 4 bytes
 ctx_base: .space ctx_size*8; # 32 regs x 4 bytes x 4 threads = 256 bytes

.section .text
.global _start

# -----------------------------------------------------------------------------
_start:
# -----------------------------------------------------------------------------

		# perf counters
		# mhpm3: ctx switch counter
		# mhpm4: ctx switch tot cycles
		li a0, 1000; csrw mhpmcounter3, a0
		csrw mhpmcounter4, zero

		# set trap vector
		la a0, mtvec; csrw mtvec, a0

		# set timer (10 ms)
		TMR_SET 10

		# enable timer interrupt
		li a0, 1 << 7; csrw mie, a0
		li a0, 1 << 3; csrw mstatus, a0

		# initialize threads
        la a0, ctx_base;
		la a1, thread0; sw a1, 0*ctx_size(a0)
		la a1, thread1; sw a1, 1*ctx_size(a0)
		la a1, thread2; sw a1, 2*ctx_size(a0)
		la a1, thread3; sw a1, 3*ctx_size(a0)
		la a0, ctx_base; csrw mscratch, a0
		CTX_CLEAR

		# threads
		thread0: THREAD 0
		thread1: THREAD 1
		thread2: THREAD 2
		thread3: THREAD 3


		.align 8;
# -----------------------------------------------------------------------------
mtvec:
# -----------------------------------------------------------------------------

		csrw mcycle, zero

		CTX_STORE

		TMR_SET 10

		# next thread ptr
		csrr a0, mscratch
		la a1, ctx_base + 4*ctx_size
		addi a0, a0, ctx_size
		bltu a0, a1, 1f
		la a0, ctx_base
1:		csrw mscratch, a0

		CTX_LOAD

		# stats
		csrrw t1, mcycle, t1;
		csrrw t0, mhpmcounter4, t0;
		add t0, t1, t0;
		csrrw t0, mhpmcounter4, t0
		csrrw t1, mcycle, t1;

		csrrw t0, mhpmcounter3, t0
		addi t0, t0, -1; beqz t0, exit
		csrrw t0, mhpmcounter3, t0

		mret

exit:	ebreak
