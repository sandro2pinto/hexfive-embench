# 1 "ctx_switch.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "ctx_switch.S"
# Copyright(C) 2019 Hex Five Security, Inc.
# 10-MAR-2019 Cesare Garlati



# -----------------------------------------------------------------------------
.section .data
# -----------------------------------------------------------------------------
ctx_base: .space 32*4*8; # 32 regs x 4 bytes x 8 threads

# -----------------------------------------------------------------------------
.section .text
# -----------------------------------------------------------------------------