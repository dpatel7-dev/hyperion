// ─────────────────────────────────────────
// HYPERION 32×32 SYSTOLIC ARRAY
// 1,024 MAC units running in parallel
// 4× the compute of the 16×16
// ─────────────────────────────────────────

module systolic_array_32x32 (
    input clk,
    input reset,
    input signed [7:0] a0,
    input signed [7:0] a1,
    input signed [7:0] a2,
    input signed [7:0] a3,
    input signed [7:0] a4,
    input signed [7:0] a5,
    input signed [7:0] a6,
    input signed [7:0] a7,
    input signed [7:0] a8,
    input signed [7:0] a9,
    input signed [7:0] a10,
    input signed [7:0] a11,
    input signed [7:0] a12,
    input signed [7:0] a13,
    input signed [7:0] a14,
    input signed [7:0] a15,
    input signed [7:0] a16,
    input signed [7:0] a17,
    input signed [7:0] a18,
    input signed [7:0] a19,
    input signed [7:0] a20,
    input signed [7:0] a21,
    input signed [7:0] a22,
    input signed [7:0] a23,
    input signed [7:0] a24,
    input signed [7:0] a25,
    input signed [7:0] a26,
    input signed [7:0] a27,
    input signed [7:0] a28,
    input signed [7:0] a29,
    input signed [7:0] a30,
    input signed [7:0] a31,
    input signed [7:0] b0,
    input signed [7:0] b1,
    input signed [7:0] b2,
    input signed [7:0] b3,
    input signed [7:0] b4,
    input signed [7:0] b5,
    input signed [7:0] b6,
    input signed [7:0] b7,
    input signed [7:0] b8,
    input signed [7:0] b9,
    input signed [7:0] b10,
    input signed [7:0] b11,
    input signed [7:0] b12,
    input signed [7:0] b13,
    input signed [7:0] b14,
    input signed [7:0] b15,
    input signed [7:0] b16,
    input signed [7:0] b17,
    input signed [7:0] b18,
    input signed [7:0] b19,
    input signed [7:0] b20,
    input signed [7:0] b21,
    input signed [7:0] b22,
    input signed [7:0] b23,
    input signed [7:0] b24,
    input signed [7:0] b25,
    input signed [7:0] b26,
    input signed [7:0] b27,
    input signed [7:0] b28,
    input signed [7:0] b29,
    input signed [7:0] b30,
    input signed [7:0] b31,
    output signed [15:0] r0c0,
    output signed [15:0] r0c1,
    output signed [15:0] r0c2,
    output signed [15:0] r0c3,
    output signed [15:0] r0c4,
    output signed [15:0] r0c5,
    output signed [15:0] r0c6,
    output signed [15:0] r0c7,
    output signed [15:0] r0c8,
    output signed [15:0] r0c9,
    output signed [15:0] r0c10,
    output signed [15:0] r0c11,
    output signed [15:0] r0c12,
    output signed [15:0] r0c13,
    output signed [15:0] r0c14,
    output signed [15:0] r0c15,
    output signed [15:0] r0c16,
    output signed [15:0] r0c17,
    output signed [15:0] r0c18,
    output signed [15:0] r0c19,
    output signed [15:0] r0c20,
    output signed [15:0] r0c21,
    output signed [15:0] r0c22,
    output signed [15:0] r0c23,
    output signed [15:0] r0c24,
    output signed [15:0] r0c25,
    output signed [15:0] r0c26,
    output signed [15:0] r0c27,
    output signed [15:0] r0c28,
    output signed [15:0] r0c29,
    output signed [15:0] r0c30,
    output signed [15:0] r0c31,
    output signed [15:0] r1c0,
    output signed [15:0] r1c1,
    output signed [15:0] r1c2,
    output signed [15:0] r1c3,
    output signed [15:0] r1c4,
    output signed [15:0] r1c5,
    output signed [15:0] r1c6,
    output signed [15:0] r1c7,
    output signed [15:0] r1c8,
    output signed [15:0] r1c9,
    output signed [15:0] r1c10,
    output signed [15:0] r1c11,
    output signed [15:0] r1c12,
    output signed [15:0] r1c13,
    output signed [15:0] r1c14,
    output signed [15:0] r1c15,
    output signed [15:0] r1c16,
    output signed [15:0] r1c17,
    output signed [15:0] r1c18,
    output signed [15:0] r1c19,
    output signed [15:0] r1c20,
    output signed [15:0] r1c21,
    output signed [15:0] r1c22,
    output signed [15:0] r1c23,
    output signed [15:0] r1c24,
    output signed [15:0] r1c25,
    output signed [15:0] r1c26,
    output signed [15:0] r1c27,
    output signed [15:0] r1c28,
    output signed [15:0] r1c29,
    output signed [15:0] r1c30,
    output signed [15:0] r1c31,
    output signed [15:0] r2c0,
    output signed [15:0] r2c1,
    output signed [15:0] r2c2,
    output signed [15:0] r2c3,
    output signed [15:0] r2c4,
    output signed [15:0] r2c5,
    output signed [15:0] r2c6,
    output signed [15:0] r2c7,
    output signed [15:0] r2c8,
    output signed [15:0] r2c9,
    output signed [15:0] r2c10,
    output signed [15:0] r2c11,
    output signed [15:0] r2c12,
    output signed [15:0] r2c13,
    output signed [15:0] r2c14,
    output signed [15:0] r2c15,
    output signed [15:0] r2c16,
    output signed [15:0] r2c17,
    output signed [15:0] r2c18,
    output signed [15:0] r2c19,
    output signed [15:0] r2c20,
    output signed [15:0] r2c21,
    output signed [15:0] r2c22,
    output signed [15:0] r2c23,
    output signed [15:0] r2c24,
    output signed [15:0] r2c25,
    output signed [15:0] r2c26,
    output signed [15:0] r2c27,
    output signed [15:0] r2c28,
    output signed [15:0] r2c29,
    output signed [15:0] r2c30,
    output signed [15:0] r2c31,
    output signed [15:0] r3c0,
    output signed [15:0] r3c1,
    output signed [15:0] r3c2,
    output signed [15:0] r3c3,
    output signed [15:0] r3c4,
    output signed [15:0] r3c5,
    output signed [15:0] r3c6,
    output signed [15:0] r3c7,
    output signed [15:0] r3c8,
    output signed [15:0] r3c9,
    output signed [15:0] r3c10,
    output signed [15:0] r3c11,
    output signed [15:0] r3c12,
    output signed [15:0] r3c13,
    output signed [15:0] r3c14,
    output signed [15:0] r3c15,
    output signed [15:0] r3c16,
    output signed [15:0] r3c17,
    output signed [15:0] r3c18,
    output signed [15:0] r3c19,
    output signed [15:0] r3c20,
    output signed [15:0] r3c21,
    output signed [15:0] r3c22,
    output signed [15:0] r3c23,
    output signed [15:0] r3c24,
    output signed [15:0] r3c25,
    output signed [15:0] r3c26,
    output signed [15:0] r3c27,
    output signed [15:0] r3c28,
    output signed [15:0] r3c29,
    output signed [15:0] r3c30,
    output signed [15:0] r3c31,
    output signed [15:0] r4c0,
    output signed [15:0] r4c1,
    output signed [15:0] r4c2,
    output signed [15:0] r4c3,
    output signed [15:0] r4c4,
    output signed [15:0] r4c5,
    output signed [15:0] r4c6,
    output signed [15:0] r4c7,
    output signed [15:0] r4c8,
    output signed [15:0] r4c9,
    output signed [15:0] r4c10,
    output signed [15:0] r4c11,
    output signed [15:0] r4c12,
    output signed [15:0] r4c13,
    output signed [15:0] r4c14,
    output signed [15:0] r4c15,
    output signed [15:0] r4c16,
    output signed [15:0] r4c17,
    output signed [15:0] r4c18,
    output signed [15:0] r4c19,
    output signed [15:0] r4c20,
    output signed [15:0] r4c21,
    output signed [15:0] r4c22,
    output signed [15:0] r4c23,
    output signed [15:0] r4c24,
    output signed [15:0] r4c25,
    output signed [15:0] r4c26,
    output signed [15:0] r4c27,
    output signed [15:0] r4c28,
    output signed [15:0] r4c29,
    output signed [15:0] r4c30,
    output signed [15:0] r4c31,
    output signed [15:0] r5c0,
    output signed [15:0] r5c1,
    output signed [15:0] r5c2,
    output signed [15:0] r5c3,
    output signed [15:0] r5c4,
    output signed [15:0] r5c5,
    output signed [15:0] r5c6,
    output signed [15:0] r5c7,
    output signed [15:0] r5c8,
    output signed [15:0] r5c9,
    output signed [15:0] r5c10,
    output signed [15:0] r5c11,
    output signed [15:0] r5c12,
    output signed [15:0] r5c13,
    output signed [15:0] r5c14,
    output signed [15:0] r5c15,
    output signed [15:0] r5c16,
    output signed [15:0] r5c17,
    output signed [15:0] r5c18,
    output signed [15:0] r5c19,
    output signed [15:0] r5c20,
    output signed [15:0] r5c21,
    output signed [15:0] r5c22,
    output signed [15:0] r5c23,
    output signed [15:0] r5c24,
    output signed [15:0] r5c25,
    output signed [15:0] r5c26,
    output signed [15:0] r5c27,
    output signed [15:0] r5c28,
    output signed [15:0] r5c29,
    output signed [15:0] r5c30,
    output signed [15:0] r5c31,
    output signed [15:0] r6c0,
    output signed [15:0] r6c1,
    output signed [15:0] r6c2,
    output signed [15:0] r6c3,
    output signed [15:0] r6c4,
    output signed [15:0] r6c5,
    output signed [15:0] r6c6,
    output signed [15:0] r6c7,
    output signed [15:0] r6c8,
    output signed [15:0] r6c9,
    output signed [15:0] r6c10,
    output signed [15:0] r6c11,
    output signed [15:0] r6c12,
    output signed [15:0] r6c13,
    output signed [15:0] r6c14,
    output signed [15:0] r6c15,
    output signed [15:0] r6c16,
    output signed [15:0] r6c17,
    output signed [15:0] r6c18,
    output signed [15:0] r6c19,
    output signed [15:0] r6c20,
    output signed [15:0] r6c21,
    output signed [15:0] r6c22,
    output signed [15:0] r6c23,
    output signed [15:0] r6c24,
    output signed [15:0] r6c25,
    output signed [15:0] r6c26,
    output signed [15:0] r6c27,
    output signed [15:0] r6c28,
    output signed [15:0] r6c29,
    output signed [15:0] r6c30,
    output signed [15:0] r6c31,
    output signed [15:0] r7c0,
    output signed [15:0] r7c1,
    output signed [15:0] r7c2,
    output signed [15:0] r7c3,
    output signed [15:0] r7c4,
    output signed [15:0] r7c5,
    output signed [15:0] r7c6,
    output signed [15:0] r7c7,
    output signed [15:0] r7c8,
    output signed [15:0] r7c9,
    output signed [15:0] r7c10,
    output signed [15:0] r7c11,
    output signed [15:0] r7c12,
    output signed [15:0] r7c13,
    output signed [15:0] r7c14,
    output signed [15:0] r7c15,
    output signed [15:0] r7c16,
    output signed [15:0] r7c17,
    output signed [15:0] r7c18,
    output signed [15:0] r7c19,
    output signed [15:0] r7c20,
    output signed [15:0] r7c21,
    output signed [15:0] r7c22,
    output signed [15:0] r7c23,
    output signed [15:0] r7c24,
    output signed [15:0] r7c25,
    output signed [15:0] r7c26,
    output signed [15:0] r7c27,
    output signed [15:0] r7c28,
    output signed [15:0] r7c29,
    output signed [15:0] r7c30,
    output signed [15:0] r7c31,
    output signed [15:0] r8c0,
    output signed [15:0] r8c1,
    output signed [15:0] r8c2,
    output signed [15:0] r8c3,
    output signed [15:0] r8c4,
    output signed [15:0] r8c5,
    output signed [15:0] r8c6,
    output signed [15:0] r8c7,
    output signed [15:0] r8c8,
    output signed [15:0] r8c9,
    output signed [15:0] r8c10,
    output signed [15:0] r8c11,
    output signed [15:0] r8c12,
    output signed [15:0] r8c13,
    output signed [15:0] r8c14,
    output signed [15:0] r8c15,
    output signed [15:0] r8c16,
    output signed [15:0] r8c17,
    output signed [15:0] r8c18,
    output signed [15:0] r8c19,
    output signed [15:0] r8c20,
    output signed [15:0] r8c21,
    output signed [15:0] r8c22,
    output signed [15:0] r8c23,
    output signed [15:0] r8c24,
    output signed [15:0] r8c25,
    output signed [15:0] r8c26,
    output signed [15:0] r8c27,
    output signed [15:0] r8c28,
    output signed [15:0] r8c29,
    output signed [15:0] r8c30,
    output signed [15:0] r8c31,
    output signed [15:0] r9c0,
    output signed [15:0] r9c1,
    output signed [15:0] r9c2,
    output signed [15:0] r9c3,
    output signed [15:0] r9c4,
    output signed [15:0] r9c5,
    output signed [15:0] r9c6,
    output signed [15:0] r9c7,
    output signed [15:0] r9c8,
    output signed [15:0] r9c9,
    output signed [15:0] r9c10,
    output signed [15:0] r9c11,
    output signed [15:0] r9c12,
    output signed [15:0] r9c13,
    output signed [15:0] r9c14,
    output signed [15:0] r9c15,
    output signed [15:0] r9c16,
    output signed [15:0] r9c17,
    output signed [15:0] r9c18,
    output signed [15:0] r9c19,
    output signed [15:0] r9c20,
    output signed [15:0] r9c21,
    output signed [15:0] r9c22,
    output signed [15:0] r9c23,
    output signed [15:0] r9c24,
    output signed [15:0] r9c25,
    output signed [15:0] r9c26,
    output signed [15:0] r9c27,
    output signed [15:0] r9c28,
    output signed [15:0] r9c29,
    output signed [15:0] r9c30,
    output signed [15:0] r9c31,
    output signed [15:0] r10c0,
    output signed [15:0] r10c1,
    output signed [15:0] r10c2,
    output signed [15:0] r10c3,
    output signed [15:0] r10c4,
    output signed [15:0] r10c5,
    output signed [15:0] r10c6,
    output signed [15:0] r10c7,
    output signed [15:0] r10c8,
    output signed [15:0] r10c9,
    output signed [15:0] r10c10,
    output signed [15:0] r10c11,
    output signed [15:0] r10c12,
    output signed [15:0] r10c13,
    output signed [15:0] r10c14,
    output signed [15:0] r10c15,
    output signed [15:0] r10c16,
    output signed [15:0] r10c17,
    output signed [15:0] r10c18,
    output signed [15:0] r10c19,
    output signed [15:0] r10c20,
    output signed [15:0] r10c21,
    output signed [15:0] r10c22,
    output signed [15:0] r10c23,
    output signed [15:0] r10c24,
    output signed [15:0] r10c25,
    output signed [15:0] r10c26,
    output signed [15:0] r10c27,
    output signed [15:0] r10c28,
    output signed [15:0] r10c29,
    output signed [15:0] r10c30,
    output signed [15:0] r10c31,
    output signed [15:0] r11c0,
    output signed [15:0] r11c1,
    output signed [15:0] r11c2,
    output signed [15:0] r11c3,
    output signed [15:0] r11c4,
    output signed [15:0] r11c5,
    output signed [15:0] r11c6,
    output signed [15:0] r11c7,
    output signed [15:0] r11c8,
    output signed [15:0] r11c9,
    output signed [15:0] r11c10,
    output signed [15:0] r11c11,
    output signed [15:0] r11c12,
    output signed [15:0] r11c13,
    output signed [15:0] r11c14,
    output signed [15:0] r11c15,
    output signed [15:0] r11c16,
    output signed [15:0] r11c17,
    output signed [15:0] r11c18,
    output signed [15:0] r11c19,
    output signed [15:0] r11c20,
    output signed [15:0] r11c21,
    output signed [15:0] r11c22,
    output signed [15:0] r11c23,
    output signed [15:0] r11c24,
    output signed [15:0] r11c25,
    output signed [15:0] r11c26,
    output signed [15:0] r11c27,
    output signed [15:0] r11c28,
    output signed [15:0] r11c29,
    output signed [15:0] r11c30,
    output signed [15:0] r11c31,
    output signed [15:0] r12c0,
    output signed [15:0] r12c1,
    output signed [15:0] r12c2,
    output signed [15:0] r12c3,
    output signed [15:0] r12c4,
    output signed [15:0] r12c5,
    output signed [15:0] r12c6,
    output signed [15:0] r12c7,
    output signed [15:0] r12c8,
    output signed [15:0] r12c9,
    output signed [15:0] r12c10,
    output signed [15:0] r12c11,
    output signed [15:0] r12c12,
    output signed [15:0] r12c13,
    output signed [15:0] r12c14,
    output signed [15:0] r12c15,
    output signed [15:0] r12c16,
    output signed [15:0] r12c17,
    output signed [15:0] r12c18,
    output signed [15:0] r12c19,
    output signed [15:0] r12c20,
    output signed [15:0] r12c21,
    output signed [15:0] r12c22,
    output signed [15:0] r12c23,
    output signed [15:0] r12c24,
    output signed [15:0] r12c25,
    output signed [15:0] r12c26,
    output signed [15:0] r12c27,
    output signed [15:0] r12c28,
    output signed [15:0] r12c29,
    output signed [15:0] r12c30,
    output signed [15:0] r12c31,
    output signed [15:0] r13c0,
    output signed [15:0] r13c1,
    output signed [15:0] r13c2,
    output signed [15:0] r13c3,
    output signed [15:0] r13c4,
    output signed [15:0] r13c5,
    output signed [15:0] r13c6,
    output signed [15:0] r13c7,
    output signed [15:0] r13c8,
    output signed [15:0] r13c9,
    output signed [15:0] r13c10,
    output signed [15:0] r13c11,
    output signed [15:0] r13c12,
    output signed [15:0] r13c13,
    output signed [15:0] r13c14,
    output signed [15:0] r13c15,
    output signed [15:0] r13c16,
    output signed [15:0] r13c17,
    output signed [15:0] r13c18,
    output signed [15:0] r13c19,
    output signed [15:0] r13c20,
    output signed [15:0] r13c21,
    output signed [15:0] r13c22,
    output signed [15:0] r13c23,
    output signed [15:0] r13c24,
    output signed [15:0] r13c25,
    output signed [15:0] r13c26,
    output signed [15:0] r13c27,
    output signed [15:0] r13c28,
    output signed [15:0] r13c29,
    output signed [15:0] r13c30,
    output signed [15:0] r13c31,
    output signed [15:0] r14c0,
    output signed [15:0] r14c1,
    output signed [15:0] r14c2,
    output signed [15:0] r14c3,
    output signed [15:0] r14c4,
    output signed [15:0] r14c5,
    output signed [15:0] r14c6,
    output signed [15:0] r14c7,
    output signed [15:0] r14c8,
    output signed [15:0] r14c9,
    output signed [15:0] r14c10,
    output signed [15:0] r14c11,
    output signed [15:0] r14c12,
    output signed [15:0] r14c13,
    output signed [15:0] r14c14,
    output signed [15:0] r14c15,
    output signed [15:0] r14c16,
    output signed [15:0] r14c17,
    output signed [15:0] r14c18,
    output signed [15:0] r14c19,
    output signed [15:0] r14c20,
    output signed [15:0] r14c21,
    output signed [15:0] r14c22,
    output signed [15:0] r14c23,
    output signed [15:0] r14c24,
    output signed [15:0] r14c25,
    output signed [15:0] r14c26,
    output signed [15:0] r14c27,
    output signed [15:0] r14c28,
    output signed [15:0] r14c29,
    output signed [15:0] r14c30,
    output signed [15:0] r14c31,
    output signed [15:0] r15c0,
    output signed [15:0] r15c1,
    output signed [15:0] r15c2,
    output signed [15:0] r15c3,
    output signed [15:0] r15c4,
    output signed [15:0] r15c5,
    output signed [15:0] r15c6,
    output signed [15:0] r15c7,
    output signed [15:0] r15c8,
    output signed [15:0] r15c9,
    output signed [15:0] r15c10,
    output signed [15:0] r15c11,
    output signed [15:0] r15c12,
    output signed [15:0] r15c13,
    output signed [15:0] r15c14,
    output signed [15:0] r15c15,
    output signed [15:0] r15c16,
    output signed [15:0] r15c17,
    output signed [15:0] r15c18,
    output signed [15:0] r15c19,
    output signed [15:0] r15c20,
    output signed [15:0] r15c21,
    output signed [15:0] r15c22,
    output signed [15:0] r15c23,
    output signed [15:0] r15c24,
    output signed [15:0] r15c25,
    output signed [15:0] r15c26,
    output signed [15:0] r15c27,
    output signed [15:0] r15c28,
    output signed [15:0] r15c29,
    output signed [15:0] r15c30,
    output signed [15:0] r15c31,
    output signed [15:0] r16c0,
    output signed [15:0] r16c1,
    output signed [15:0] r16c2,
    output signed [15:0] r16c3,
    output signed [15:0] r16c4,
    output signed [15:0] r16c5,
    output signed [15:0] r16c6,
    output signed [15:0] r16c7,
    output signed [15:0] r16c8,
    output signed [15:0] r16c9,
    output signed [15:0] r16c10,
    output signed [15:0] r16c11,
    output signed [15:0] r16c12,
    output signed [15:0] r16c13,
    output signed [15:0] r16c14,
    output signed [15:0] r16c15,
    output signed [15:0] r16c16,
    output signed [15:0] r16c17,
    output signed [15:0] r16c18,
    output signed [15:0] r16c19,
    output signed [15:0] r16c20,
    output signed [15:0] r16c21,
    output signed [15:0] r16c22,
    output signed [15:0] r16c23,
    output signed [15:0] r16c24,
    output signed [15:0] r16c25,
    output signed [15:0] r16c26,
    output signed [15:0] r16c27,
    output signed [15:0] r16c28,
    output signed [15:0] r16c29,
    output signed [15:0] r16c30,
    output signed [15:0] r16c31,
    output signed [15:0] r17c0,
    output signed [15:0] r17c1,
    output signed [15:0] r17c2,
    output signed [15:0] r17c3,
    output signed [15:0] r17c4,
    output signed [15:0] r17c5,
    output signed [15:0] r17c6,
    output signed [15:0] r17c7,
    output signed [15:0] r17c8,
    output signed [15:0] r17c9,
    output signed [15:0] r17c10,
    output signed [15:0] r17c11,
    output signed [15:0] r17c12,
    output signed [15:0] r17c13,
    output signed [15:0] r17c14,
    output signed [15:0] r17c15,
    output signed [15:0] r17c16,
    output signed [15:0] r17c17,
    output signed [15:0] r17c18,
    output signed [15:0] r17c19,
    output signed [15:0] r17c20,
    output signed [15:0] r17c21,
    output signed [15:0] r17c22,
    output signed [15:0] r17c23,
    output signed [15:0] r17c24,
    output signed [15:0] r17c25,
    output signed [15:0] r17c26,
    output signed [15:0] r17c27,
    output signed [15:0] r17c28,
    output signed [15:0] r17c29,
    output signed [15:0] r17c30,
    output signed [15:0] r17c31,
    output signed [15:0] r18c0,
    output signed [15:0] r18c1,
    output signed [15:0] r18c2,
    output signed [15:0] r18c3,
    output signed [15:0] r18c4,
    output signed [15:0] r18c5,
    output signed [15:0] r18c6,
    output signed [15:0] r18c7,
    output signed [15:0] r18c8,
    output signed [15:0] r18c9,
    output signed [15:0] r18c10,
    output signed [15:0] r18c11,
    output signed [15:0] r18c12,
    output signed [15:0] r18c13,
    output signed [15:0] r18c14,
    output signed [15:0] r18c15,
    output signed [15:0] r18c16,
    output signed [15:0] r18c17,
    output signed [15:0] r18c18,
    output signed [15:0] r18c19,
    output signed [15:0] r18c20,
    output signed [15:0] r18c21,
    output signed [15:0] r18c22,
    output signed [15:0] r18c23,
    output signed [15:0] r18c24,
    output signed [15:0] r18c25,
    output signed [15:0] r18c26,
    output signed [15:0] r18c27,
    output signed [15:0] r18c28,
    output signed [15:0] r18c29,
    output signed [15:0] r18c30,
    output signed [15:0] r18c31,
    output signed [15:0] r19c0,
    output signed [15:0] r19c1,
    output signed [15:0] r19c2,
    output signed [15:0] r19c3,
    output signed [15:0] r19c4,
    output signed [15:0] r19c5,
    output signed [15:0] r19c6,
    output signed [15:0] r19c7,
    output signed [15:0] r19c8,
    output signed [15:0] r19c9,
    output signed [15:0] r19c10,
    output signed [15:0] r19c11,
    output signed [15:0] r19c12,
    output signed [15:0] r19c13,
    output signed [15:0] r19c14,
    output signed [15:0] r19c15,
    output signed [15:0] r19c16,
    output signed [15:0] r19c17,
    output signed [15:0] r19c18,
    output signed [15:0] r19c19,
    output signed [15:0] r19c20,
    output signed [15:0] r19c21,
    output signed [15:0] r19c22,
    output signed [15:0] r19c23,
    output signed [15:0] r19c24,
    output signed [15:0] r19c25,
    output signed [15:0] r19c26,
    output signed [15:0] r19c27,
    output signed [15:0] r19c28,
    output signed [15:0] r19c29,
    output signed [15:0] r19c30,
    output signed [15:0] r19c31,
    output signed [15:0] r20c0,
    output signed [15:0] r20c1,
    output signed [15:0] r20c2,
    output signed [15:0] r20c3,
    output signed [15:0] r20c4,
    output signed [15:0] r20c5,
    output signed [15:0] r20c6,
    output signed [15:0] r20c7,
    output signed [15:0] r20c8,
    output signed [15:0] r20c9,
    output signed [15:0] r20c10,
    output signed [15:0] r20c11,
    output signed [15:0] r20c12,
    output signed [15:0] r20c13,
    output signed [15:0] r20c14,
    output signed [15:0] r20c15,
    output signed [15:0] r20c16,
    output signed [15:0] r20c17,
    output signed [15:0] r20c18,
    output signed [15:0] r20c19,
    output signed [15:0] r20c20,
    output signed [15:0] r20c21,
    output signed [15:0] r20c22,
    output signed [15:0] r20c23,
    output signed [15:0] r20c24,
    output signed [15:0] r20c25,
    output signed [15:0] r20c26,
    output signed [15:0] r20c27,
    output signed [15:0] r20c28,
    output signed [15:0] r20c29,
    output signed [15:0] r20c30,
    output signed [15:0] r20c31,
    output signed [15:0] r21c0,
    output signed [15:0] r21c1,
    output signed [15:0] r21c2,
    output signed [15:0] r21c3,
    output signed [15:0] r21c4,
    output signed [15:0] r21c5,
    output signed [15:0] r21c6,
    output signed [15:0] r21c7,
    output signed [15:0] r21c8,
    output signed [15:0] r21c9,
    output signed [15:0] r21c10,
    output signed [15:0] r21c11,
    output signed [15:0] r21c12,
    output signed [15:0] r21c13,
    output signed [15:0] r21c14,
    output signed [15:0] r21c15,
    output signed [15:0] r21c16,
    output signed [15:0] r21c17,
    output signed [15:0] r21c18,
    output signed [15:0] r21c19,
    output signed [15:0] r21c20,
    output signed [15:0] r21c21,
    output signed [15:0] r21c22,
    output signed [15:0] r21c23,
    output signed [15:0] r21c24,
    output signed [15:0] r21c25,
    output signed [15:0] r21c26,
    output signed [15:0] r21c27,
    output signed [15:0] r21c28,
    output signed [15:0] r21c29,
    output signed [15:0] r21c30,
    output signed [15:0] r21c31,
    output signed [15:0] r22c0,
    output signed [15:0] r22c1,
    output signed [15:0] r22c2,
    output signed [15:0] r22c3,
    output signed [15:0] r22c4,
    output signed [15:0] r22c5,
    output signed [15:0] r22c6,
    output signed [15:0] r22c7,
    output signed [15:0] r22c8,
    output signed [15:0] r22c9,
    output signed [15:0] r22c10,
    output signed [15:0] r22c11,
    output signed [15:0] r22c12,
    output signed [15:0] r22c13,
    output signed [15:0] r22c14,
    output signed [15:0] r22c15,
    output signed [15:0] r22c16,
    output signed [15:0] r22c17,
    output signed [15:0] r22c18,
    output signed [15:0] r22c19,
    output signed [15:0] r22c20,
    output signed [15:0] r22c21,
    output signed [15:0] r22c22,
    output signed [15:0] r22c23,
    output signed [15:0] r22c24,
    output signed [15:0] r22c25,
    output signed [15:0] r22c26,
    output signed [15:0] r22c27,
    output signed [15:0] r22c28,
    output signed [15:0] r22c29,
    output signed [15:0] r22c30,
    output signed [15:0] r22c31,
    output signed [15:0] r23c0,
    output signed [15:0] r23c1,
    output signed [15:0] r23c2,
    output signed [15:0] r23c3,
    output signed [15:0] r23c4,
    output signed [15:0] r23c5,
    output signed [15:0] r23c6,
    output signed [15:0] r23c7,
    output signed [15:0] r23c8,
    output signed [15:0] r23c9,
    output signed [15:0] r23c10,
    output signed [15:0] r23c11,
    output signed [15:0] r23c12,
    output signed [15:0] r23c13,
    output signed [15:0] r23c14,
    output signed [15:0] r23c15,
    output signed [15:0] r23c16,
    output signed [15:0] r23c17,
    output signed [15:0] r23c18,
    output signed [15:0] r23c19,
    output signed [15:0] r23c20,
    output signed [15:0] r23c21,
    output signed [15:0] r23c22,
    output signed [15:0] r23c23,
    output signed [15:0] r23c24,
    output signed [15:0] r23c25,
    output signed [15:0] r23c26,
    output signed [15:0] r23c27,
    output signed [15:0] r23c28,
    output signed [15:0] r23c29,
    output signed [15:0] r23c30,
    output signed [15:0] r23c31,
    output signed [15:0] r24c0,
    output signed [15:0] r24c1,
    output signed [15:0] r24c2,
    output signed [15:0] r24c3,
    output signed [15:0] r24c4,
    output signed [15:0] r24c5,
    output signed [15:0] r24c6,
    output signed [15:0] r24c7,
    output signed [15:0] r24c8,
    output signed [15:0] r24c9,
    output signed [15:0] r24c10,
    output signed [15:0] r24c11,
    output signed [15:0] r24c12,
    output signed [15:0] r24c13,
    output signed [15:0] r24c14,
    output signed [15:0] r24c15,
    output signed [15:0] r24c16,
    output signed [15:0] r24c17,
    output signed [15:0] r24c18,
    output signed [15:0] r24c19,
    output signed [15:0] r24c20,
    output signed [15:0] r24c21,
    output signed [15:0] r24c22,
    output signed [15:0] r24c23,
    output signed [15:0] r24c24,
    output signed [15:0] r24c25,
    output signed [15:0] r24c26,
    output signed [15:0] r24c27,
    output signed [15:0] r24c28,
    output signed [15:0] r24c29,
    output signed [15:0] r24c30,
    output signed [15:0] r24c31,
    output signed [15:0] r25c0,
    output signed [15:0] r25c1,
    output signed [15:0] r25c2,
    output signed [15:0] r25c3,
    output signed [15:0] r25c4,
    output signed [15:0] r25c5,
    output signed [15:0] r25c6,
    output signed [15:0] r25c7,
    output signed [15:0] r25c8,
    output signed [15:0] r25c9,
    output signed [15:0] r25c10,
    output signed [15:0] r25c11,
    output signed [15:0] r25c12,
    output signed [15:0] r25c13,
    output signed [15:0] r25c14,
    output signed [15:0] r25c15,
    output signed [15:0] r25c16,
    output signed [15:0] r25c17,
    output signed [15:0] r25c18,
    output signed [15:0] r25c19,
    output signed [15:0] r25c20,
    output signed [15:0] r25c21,
    output signed [15:0] r25c22,
    output signed [15:0] r25c23,
    output signed [15:0] r25c24,
    output signed [15:0] r25c25,
    output signed [15:0] r25c26,
    output signed [15:0] r25c27,
    output signed [15:0] r25c28,
    output signed [15:0] r25c29,
    output signed [15:0] r25c30,
    output signed [15:0] r25c31,
    output signed [15:0] r26c0,
    output signed [15:0] r26c1,
    output signed [15:0] r26c2,
    output signed [15:0] r26c3,
    output signed [15:0] r26c4,
    output signed [15:0] r26c5,
    output signed [15:0] r26c6,
    output signed [15:0] r26c7,
    output signed [15:0] r26c8,
    output signed [15:0] r26c9,
    output signed [15:0] r26c10,
    output signed [15:0] r26c11,
    output signed [15:0] r26c12,
    output signed [15:0] r26c13,
    output signed [15:0] r26c14,
    output signed [15:0] r26c15,
    output signed [15:0] r26c16,
    output signed [15:0] r26c17,
    output signed [15:0] r26c18,
    output signed [15:0] r26c19,
    output signed [15:0] r26c20,
    output signed [15:0] r26c21,
    output signed [15:0] r26c22,
    output signed [15:0] r26c23,
    output signed [15:0] r26c24,
    output signed [15:0] r26c25,
    output signed [15:0] r26c26,
    output signed [15:0] r26c27,
    output signed [15:0] r26c28,
    output signed [15:0] r26c29,
    output signed [15:0] r26c30,
    output signed [15:0] r26c31,
    output signed [15:0] r27c0,
    output signed [15:0] r27c1,
    output signed [15:0] r27c2,
    output signed [15:0] r27c3,
    output signed [15:0] r27c4,
    output signed [15:0] r27c5,
    output signed [15:0] r27c6,
    output signed [15:0] r27c7,
    output signed [15:0] r27c8,
    output signed [15:0] r27c9,
    output signed [15:0] r27c10,
    output signed [15:0] r27c11,
    output signed [15:0] r27c12,
    output signed [15:0] r27c13,
    output signed [15:0] r27c14,
    output signed [15:0] r27c15,
    output signed [15:0] r27c16,
    output signed [15:0] r27c17,
    output signed [15:0] r27c18,
    output signed [15:0] r27c19,
    output signed [15:0] r27c20,
    output signed [15:0] r27c21,
    output signed [15:0] r27c22,
    output signed [15:0] r27c23,
    output signed [15:0] r27c24,
    output signed [15:0] r27c25,
    output signed [15:0] r27c26,
    output signed [15:0] r27c27,
    output signed [15:0] r27c28,
    output signed [15:0] r27c29,
    output signed [15:0] r27c30,
    output signed [15:0] r27c31,
    output signed [15:0] r28c0,
    output signed [15:0] r28c1,
    output signed [15:0] r28c2,
    output signed [15:0] r28c3,
    output signed [15:0] r28c4,
    output signed [15:0] r28c5,
    output signed [15:0] r28c6,
    output signed [15:0] r28c7,
    output signed [15:0] r28c8,
    output signed [15:0] r28c9,
    output signed [15:0] r28c10,
    output signed [15:0] r28c11,
    output signed [15:0] r28c12,
    output signed [15:0] r28c13,
    output signed [15:0] r28c14,
    output signed [15:0] r28c15,
    output signed [15:0] r28c16,
    output signed [15:0] r28c17,
    output signed [15:0] r28c18,
    output signed [15:0] r28c19,
    output signed [15:0] r28c20,
    output signed [15:0] r28c21,
    output signed [15:0] r28c22,
    output signed [15:0] r28c23,
    output signed [15:0] r28c24,
    output signed [15:0] r28c25,
    output signed [15:0] r28c26,
    output signed [15:0] r28c27,
    output signed [15:0] r28c28,
    output signed [15:0] r28c29,
    output signed [15:0] r28c30,
    output signed [15:0] r28c31,
    output signed [15:0] r29c0,
    output signed [15:0] r29c1,
    output signed [15:0] r29c2,
    output signed [15:0] r29c3,
    output signed [15:0] r29c4,
    output signed [15:0] r29c5,
    output signed [15:0] r29c6,
    output signed [15:0] r29c7,
    output signed [15:0] r29c8,
    output signed [15:0] r29c9,
    output signed [15:0] r29c10,
    output signed [15:0] r29c11,
    output signed [15:0] r29c12,
    output signed [15:0] r29c13,
    output signed [15:0] r29c14,
    output signed [15:0] r29c15,
    output signed [15:0] r29c16,
    output signed [15:0] r29c17,
    output signed [15:0] r29c18,
    output signed [15:0] r29c19,
    output signed [15:0] r29c20,
    output signed [15:0] r29c21,
    output signed [15:0] r29c22,
    output signed [15:0] r29c23,
    output signed [15:0] r29c24,
    output signed [15:0] r29c25,
    output signed [15:0] r29c26,
    output signed [15:0] r29c27,
    output signed [15:0] r29c28,
    output signed [15:0] r29c29,
    output signed [15:0] r29c30,
    output signed [15:0] r29c31,
    output signed [15:0] r30c0,
    output signed [15:0] r30c1,
    output signed [15:0] r30c2,
    output signed [15:0] r30c3,
    output signed [15:0] r30c4,
    output signed [15:0] r30c5,
    output signed [15:0] r30c6,
    output signed [15:0] r30c7,
    output signed [15:0] r30c8,
    output signed [15:0] r30c9,
    output signed [15:0] r30c10,
    output signed [15:0] r30c11,
    output signed [15:0] r30c12,
    output signed [15:0] r30c13,
    output signed [15:0] r30c14,
    output signed [15:0] r30c15,
    output signed [15:0] r30c16,
    output signed [15:0] r30c17,
    output signed [15:0] r30c18,
    output signed [15:0] r30c19,
    output signed [15:0] r30c20,
    output signed [15:0] r30c21,
    output signed [15:0] r30c22,
    output signed [15:0] r30c23,
    output signed [15:0] r30c24,
    output signed [15:0] r30c25,
    output signed [15:0] r30c26,
    output signed [15:0] r30c27,
    output signed [15:0] r30c28,
    output signed [15:0] r30c29,
    output signed [15:0] r30c30,
    output signed [15:0] r30c31,
    output signed [15:0] r31c0,
    output signed [15:0] r31c1,
    output signed [15:0] r31c2,
    output signed [15:0] r31c3,
    output signed [15:0] r31c4,
    output signed [15:0] r31c5,
    output signed [15:0] r31c6,
    output signed [15:0] r31c7,
    output signed [15:0] r31c8,
    output signed [15:0] r31c9,
    output signed [15:0] r31c10,
    output signed [15:0] r31c11,
    output signed [15:0] r31c12,
    output signed [15:0] r31c13,
    output signed [15:0] r31c14,
    output signed [15:0] r31c15,
    output signed [15:0] r31c16,
    output signed [15:0] r31c17,
    output signed [15:0] r31c18,
    output signed [15:0] r31c19,
    output signed [15:0] r31c20,
    output signed [15:0] r31c21,
    output signed [15:0] r31c22,
    output signed [15:0] r31c23,
    output signed [15:0] r31c24,
    output signed [15:0] r31c25,
    output signed [15:0] r31c26,
    output signed [15:0] r31c27,
    output signed [15:0] r31c28,
    output signed [15:0] r31c29,
    output signed [15:0] r31c30,
    output signed [15:0] r31c31
);

    // Row 0
    mac_unit u0_0(.clk(clk),.reset(reset),.a(a0),.b(b0),.out(r0c0));
    mac_unit u0_1(.clk(clk),.reset(reset),.a(a0),.b(b1),.out(r0c1));
    mac_unit u0_2(.clk(clk),.reset(reset),.a(a0),.b(b2),.out(r0c2));
    mac_unit u0_3(.clk(clk),.reset(reset),.a(a0),.b(b3),.out(r0c3));
    mac_unit u0_4(.clk(clk),.reset(reset),.a(a0),.b(b4),.out(r0c4));
    mac_unit u0_5(.clk(clk),.reset(reset),.a(a0),.b(b5),.out(r0c5));
    mac_unit u0_6(.clk(clk),.reset(reset),.a(a0),.b(b6),.out(r0c6));
    mac_unit u0_7(.clk(clk),.reset(reset),.a(a0),.b(b7),.out(r0c7));
    mac_unit u0_8(.clk(clk),.reset(reset),.a(a0),.b(b8),.out(r0c8));
    mac_unit u0_9(.clk(clk),.reset(reset),.a(a0),.b(b9),.out(r0c9));
    mac_unit u0_10(.clk(clk),.reset(reset),.a(a0),.b(b10),.out(r0c10));
    mac_unit u0_11(.clk(clk),.reset(reset),.a(a0),.b(b11),.out(r0c11));
    mac_unit u0_12(.clk(clk),.reset(reset),.a(a0),.b(b12),.out(r0c12));
    mac_unit u0_13(.clk(clk),.reset(reset),.a(a0),.b(b13),.out(r0c13));
    mac_unit u0_14(.clk(clk),.reset(reset),.a(a0),.b(b14),.out(r0c14));
    mac_unit u0_15(.clk(clk),.reset(reset),.a(a0),.b(b15),.out(r0c15));
    mac_unit u0_16(.clk(clk),.reset(reset),.a(a0),.b(b16),.out(r0c16));
    mac_unit u0_17(.clk(clk),.reset(reset),.a(a0),.b(b17),.out(r0c17));
    mac_unit u0_18(.clk(clk),.reset(reset),.a(a0),.b(b18),.out(r0c18));
    mac_unit u0_19(.clk(clk),.reset(reset),.a(a0),.b(b19),.out(r0c19));
    mac_unit u0_20(.clk(clk),.reset(reset),.a(a0),.b(b20),.out(r0c20));
    mac_unit u0_21(.clk(clk),.reset(reset),.a(a0),.b(b21),.out(r0c21));
    mac_unit u0_22(.clk(clk),.reset(reset),.a(a0),.b(b22),.out(r0c22));
    mac_unit u0_23(.clk(clk),.reset(reset),.a(a0),.b(b23),.out(r0c23));
    mac_unit u0_24(.clk(clk),.reset(reset),.a(a0),.b(b24),.out(r0c24));
    mac_unit u0_25(.clk(clk),.reset(reset),.a(a0),.b(b25),.out(r0c25));
    mac_unit u0_26(.clk(clk),.reset(reset),.a(a0),.b(b26),.out(r0c26));
    mac_unit u0_27(.clk(clk),.reset(reset),.a(a0),.b(b27),.out(r0c27));
    mac_unit u0_28(.clk(clk),.reset(reset),.a(a0),.b(b28),.out(r0c28));
    mac_unit u0_29(.clk(clk),.reset(reset),.a(a0),.b(b29),.out(r0c29));
    mac_unit u0_30(.clk(clk),.reset(reset),.a(a0),.b(b30),.out(r0c30));
    mac_unit u0_31(.clk(clk),.reset(reset),.a(a0),.b(b31),.out(r0c31));

    // Row 1
    mac_unit u1_0(.clk(clk),.reset(reset),.a(a1),.b(b0),.out(r1c0));
    mac_unit u1_1(.clk(clk),.reset(reset),.a(a1),.b(b1),.out(r1c1));
    mac_unit u1_2(.clk(clk),.reset(reset),.a(a1),.b(b2),.out(r1c2));
    mac_unit u1_3(.clk(clk),.reset(reset),.a(a1),.b(b3),.out(r1c3));
    mac_unit u1_4(.clk(clk),.reset(reset),.a(a1),.b(b4),.out(r1c4));
    mac_unit u1_5(.clk(clk),.reset(reset),.a(a1),.b(b5),.out(r1c5));
    mac_unit u1_6(.clk(clk),.reset(reset),.a(a1),.b(b6),.out(r1c6));
    mac_unit u1_7(.clk(clk),.reset(reset),.a(a1),.b(b7),.out(r1c7));
    mac_unit u1_8(.clk(clk),.reset(reset),.a(a1),.b(b8),.out(r1c8));
    mac_unit u1_9(.clk(clk),.reset(reset),.a(a1),.b(b9),.out(r1c9));
    mac_unit u1_10(.clk(clk),.reset(reset),.a(a1),.b(b10),.out(r1c10));
    mac_unit u1_11(.clk(clk),.reset(reset),.a(a1),.b(b11),.out(r1c11));
    mac_unit u1_12(.clk(clk),.reset(reset),.a(a1),.b(b12),.out(r1c12));
    mac_unit u1_13(.clk(clk),.reset(reset),.a(a1),.b(b13),.out(r1c13));
    mac_unit u1_14(.clk(clk),.reset(reset),.a(a1),.b(b14),.out(r1c14));
    mac_unit u1_15(.clk(clk),.reset(reset),.a(a1),.b(b15),.out(r1c15));
    mac_unit u1_16(.clk(clk),.reset(reset),.a(a1),.b(b16),.out(r1c16));
    mac_unit u1_17(.clk(clk),.reset(reset),.a(a1),.b(b17),.out(r1c17));
    mac_unit u1_18(.clk(clk),.reset(reset),.a(a1),.b(b18),.out(r1c18));
    mac_unit u1_19(.clk(clk),.reset(reset),.a(a1),.b(b19),.out(r1c19));
    mac_unit u1_20(.clk(clk),.reset(reset),.a(a1),.b(b20),.out(r1c20));
    mac_unit u1_21(.clk(clk),.reset(reset),.a(a1),.b(b21),.out(r1c21));
    mac_unit u1_22(.clk(clk),.reset(reset),.a(a1),.b(b22),.out(r1c22));
    mac_unit u1_23(.clk(clk),.reset(reset),.a(a1),.b(b23),.out(r1c23));
    mac_unit u1_24(.clk(clk),.reset(reset),.a(a1),.b(b24),.out(r1c24));
    mac_unit u1_25(.clk(clk),.reset(reset),.a(a1),.b(b25),.out(r1c25));
    mac_unit u1_26(.clk(clk),.reset(reset),.a(a1),.b(b26),.out(r1c26));
    mac_unit u1_27(.clk(clk),.reset(reset),.a(a1),.b(b27),.out(r1c27));
    mac_unit u1_28(.clk(clk),.reset(reset),.a(a1),.b(b28),.out(r1c28));
    mac_unit u1_29(.clk(clk),.reset(reset),.a(a1),.b(b29),.out(r1c29));
    mac_unit u1_30(.clk(clk),.reset(reset),.a(a1),.b(b30),.out(r1c30));
    mac_unit u1_31(.clk(clk),.reset(reset),.a(a1),.b(b31),.out(r1c31));

    // Row 2
    mac_unit u2_0(.clk(clk),.reset(reset),.a(a2),.b(b0),.out(r2c0));
    mac_unit u2_1(.clk(clk),.reset(reset),.a(a2),.b(b1),.out(r2c1));
    mac_unit u2_2(.clk(clk),.reset(reset),.a(a2),.b(b2),.out(r2c2));
    mac_unit u2_3(.clk(clk),.reset(reset),.a(a2),.b(b3),.out(r2c3));
    mac_unit u2_4(.clk(clk),.reset(reset),.a(a2),.b(b4),.out(r2c4));
    mac_unit u2_5(.clk(clk),.reset(reset),.a(a2),.b(b5),.out(r2c5));
    mac_unit u2_6(.clk(clk),.reset(reset),.a(a2),.b(b6),.out(r2c6));
    mac_unit u2_7(.clk(clk),.reset(reset),.a(a2),.b(b7),.out(r2c7));
    mac_unit u2_8(.clk(clk),.reset(reset),.a(a2),.b(b8),.out(r2c8));
    mac_unit u2_9(.clk(clk),.reset(reset),.a(a2),.b(b9),.out(r2c9));
    mac_unit u2_10(.clk(clk),.reset(reset),.a(a2),.b(b10),.out(r2c10));
    mac_unit u2_11(.clk(clk),.reset(reset),.a(a2),.b(b11),.out(r2c11));
    mac_unit u2_12(.clk(clk),.reset(reset),.a(a2),.b(b12),.out(r2c12));
    mac_unit u2_13(.clk(clk),.reset(reset),.a(a2),.b(b13),.out(r2c13));
    mac_unit u2_14(.clk(clk),.reset(reset),.a(a2),.b(b14),.out(r2c14));
    mac_unit u2_15(.clk(clk),.reset(reset),.a(a2),.b(b15),.out(r2c15));
    mac_unit u2_16(.clk(clk),.reset(reset),.a(a2),.b(b16),.out(r2c16));
    mac_unit u2_17(.clk(clk),.reset(reset),.a(a2),.b(b17),.out(r2c17));
    mac_unit u2_18(.clk(clk),.reset(reset),.a(a2),.b(b18),.out(r2c18));
    mac_unit u2_19(.clk(clk),.reset(reset),.a(a2),.b(b19),.out(r2c19));
    mac_unit u2_20(.clk(clk),.reset(reset),.a(a2),.b(b20),.out(r2c20));
    mac_unit u2_21(.clk(clk),.reset(reset),.a(a2),.b(b21),.out(r2c21));
    mac_unit u2_22(.clk(clk),.reset(reset),.a(a2),.b(b22),.out(r2c22));
    mac_unit u2_23(.clk(clk),.reset(reset),.a(a2),.b(b23),.out(r2c23));
    mac_unit u2_24(.clk(clk),.reset(reset),.a(a2),.b(b24),.out(r2c24));
    mac_unit u2_25(.clk(clk),.reset(reset),.a(a2),.b(b25),.out(r2c25));
    mac_unit u2_26(.clk(clk),.reset(reset),.a(a2),.b(b26),.out(r2c26));
    mac_unit u2_27(.clk(clk),.reset(reset),.a(a2),.b(b27),.out(r2c27));
    mac_unit u2_28(.clk(clk),.reset(reset),.a(a2),.b(b28),.out(r2c28));
    mac_unit u2_29(.clk(clk),.reset(reset),.a(a2),.b(b29),.out(r2c29));
    mac_unit u2_30(.clk(clk),.reset(reset),.a(a2),.b(b30),.out(r2c30));
    mac_unit u2_31(.clk(clk),.reset(reset),.a(a2),.b(b31),.out(r2c31));

    // Row 3
    mac_unit u3_0(.clk(clk),.reset(reset),.a(a3),.b(b0),.out(r3c0));
    mac_unit u3_1(.clk(clk),.reset(reset),.a(a3),.b(b1),.out(r3c1));
    mac_unit u3_2(.clk(clk),.reset(reset),.a(a3),.b(b2),.out(r3c2));
    mac_unit u3_3(.clk(clk),.reset(reset),.a(a3),.b(b3),.out(r3c3));
    mac_unit u3_4(.clk(clk),.reset(reset),.a(a3),.b(b4),.out(r3c4));
    mac_unit u3_5(.clk(clk),.reset(reset),.a(a3),.b(b5),.out(r3c5));
    mac_unit u3_6(.clk(clk),.reset(reset),.a(a3),.b(b6),.out(r3c6));
    mac_unit u3_7(.clk(clk),.reset(reset),.a(a3),.b(b7),.out(r3c7));
    mac_unit u3_8(.clk(clk),.reset(reset),.a(a3),.b(b8),.out(r3c8));
    mac_unit u3_9(.clk(clk),.reset(reset),.a(a3),.b(b9),.out(r3c9));
    mac_unit u3_10(.clk(clk),.reset(reset),.a(a3),.b(b10),.out(r3c10));
    mac_unit u3_11(.clk(clk),.reset(reset),.a(a3),.b(b11),.out(r3c11));
    mac_unit u3_12(.clk(clk),.reset(reset),.a(a3),.b(b12),.out(r3c12));
    mac_unit u3_13(.clk(clk),.reset(reset),.a(a3),.b(b13),.out(r3c13));
    mac_unit u3_14(.clk(clk),.reset(reset),.a(a3),.b(b14),.out(r3c14));
    mac_unit u3_15(.clk(clk),.reset(reset),.a(a3),.b(b15),.out(r3c15));
    mac_unit u3_16(.clk(clk),.reset(reset),.a(a3),.b(b16),.out(r3c16));
    mac_unit u3_17(.clk(clk),.reset(reset),.a(a3),.b(b17),.out(r3c17));
    mac_unit u3_18(.clk(clk),.reset(reset),.a(a3),.b(b18),.out(r3c18));
    mac_unit u3_19(.clk(clk),.reset(reset),.a(a3),.b(b19),.out(r3c19));
    mac_unit u3_20(.clk(clk),.reset(reset),.a(a3),.b(b20),.out(r3c20));
    mac_unit u3_21(.clk(clk),.reset(reset),.a(a3),.b(b21),.out(r3c21));
    mac_unit u3_22(.clk(clk),.reset(reset),.a(a3),.b(b22),.out(r3c22));
    mac_unit u3_23(.clk(clk),.reset(reset),.a(a3),.b(b23),.out(r3c23));
    mac_unit u3_24(.clk(clk),.reset(reset),.a(a3),.b(b24),.out(r3c24));
    mac_unit u3_25(.clk(clk),.reset(reset),.a(a3),.b(b25),.out(r3c25));
    mac_unit u3_26(.clk(clk),.reset(reset),.a(a3),.b(b26),.out(r3c26));
    mac_unit u3_27(.clk(clk),.reset(reset),.a(a3),.b(b27),.out(r3c27));
    mac_unit u3_28(.clk(clk),.reset(reset),.a(a3),.b(b28),.out(r3c28));
    mac_unit u3_29(.clk(clk),.reset(reset),.a(a3),.b(b29),.out(r3c29));
    mac_unit u3_30(.clk(clk),.reset(reset),.a(a3),.b(b30),.out(r3c30));
    mac_unit u3_31(.clk(clk),.reset(reset),.a(a3),.b(b31),.out(r3c31));

    // Row 4
    mac_unit u4_0(.clk(clk),.reset(reset),.a(a4),.b(b0),.out(r4c0));
    mac_unit u4_1(.clk(clk),.reset(reset),.a(a4),.b(b1),.out(r4c1));
    mac_unit u4_2(.clk(clk),.reset(reset),.a(a4),.b(b2),.out(r4c2));
    mac_unit u4_3(.clk(clk),.reset(reset),.a(a4),.b(b3),.out(r4c3));
    mac_unit u4_4(.clk(clk),.reset(reset),.a(a4),.b(b4),.out(r4c4));
    mac_unit u4_5(.clk(clk),.reset(reset),.a(a4),.b(b5),.out(r4c5));
    mac_unit u4_6(.clk(clk),.reset(reset),.a(a4),.b(b6),.out(r4c6));
    mac_unit u4_7(.clk(clk),.reset(reset),.a(a4),.b(b7),.out(r4c7));
    mac_unit u4_8(.clk(clk),.reset(reset),.a(a4),.b(b8),.out(r4c8));
    mac_unit u4_9(.clk(clk),.reset(reset),.a(a4),.b(b9),.out(r4c9));
    mac_unit u4_10(.clk(clk),.reset(reset),.a(a4),.b(b10),.out(r4c10));
    mac_unit u4_11(.clk(clk),.reset(reset),.a(a4),.b(b11),.out(r4c11));
    mac_unit u4_12(.clk(clk),.reset(reset),.a(a4),.b(b12),.out(r4c12));
    mac_unit u4_13(.clk(clk),.reset(reset),.a(a4),.b(b13),.out(r4c13));
    mac_unit u4_14(.clk(clk),.reset(reset),.a(a4),.b(b14),.out(r4c14));
    mac_unit u4_15(.clk(clk),.reset(reset),.a(a4),.b(b15),.out(r4c15));
    mac_unit u4_16(.clk(clk),.reset(reset),.a(a4),.b(b16),.out(r4c16));
    mac_unit u4_17(.clk(clk),.reset(reset),.a(a4),.b(b17),.out(r4c17));
    mac_unit u4_18(.clk(clk),.reset(reset),.a(a4),.b(b18),.out(r4c18));
    mac_unit u4_19(.clk(clk),.reset(reset),.a(a4),.b(b19),.out(r4c19));
    mac_unit u4_20(.clk(clk),.reset(reset),.a(a4),.b(b20),.out(r4c20));
    mac_unit u4_21(.clk(clk),.reset(reset),.a(a4),.b(b21),.out(r4c21));
    mac_unit u4_22(.clk(clk),.reset(reset),.a(a4),.b(b22),.out(r4c22));
    mac_unit u4_23(.clk(clk),.reset(reset),.a(a4),.b(b23),.out(r4c23));
    mac_unit u4_24(.clk(clk),.reset(reset),.a(a4),.b(b24),.out(r4c24));
    mac_unit u4_25(.clk(clk),.reset(reset),.a(a4),.b(b25),.out(r4c25));
    mac_unit u4_26(.clk(clk),.reset(reset),.a(a4),.b(b26),.out(r4c26));
    mac_unit u4_27(.clk(clk),.reset(reset),.a(a4),.b(b27),.out(r4c27));
    mac_unit u4_28(.clk(clk),.reset(reset),.a(a4),.b(b28),.out(r4c28));
    mac_unit u4_29(.clk(clk),.reset(reset),.a(a4),.b(b29),.out(r4c29));
    mac_unit u4_30(.clk(clk),.reset(reset),.a(a4),.b(b30),.out(r4c30));
    mac_unit u4_31(.clk(clk),.reset(reset),.a(a4),.b(b31),.out(r4c31));

    // Row 5
    mac_unit u5_0(.clk(clk),.reset(reset),.a(a5),.b(b0),.out(r5c0));
    mac_unit u5_1(.clk(clk),.reset(reset),.a(a5),.b(b1),.out(r5c1));
    mac_unit u5_2(.clk(clk),.reset(reset),.a(a5),.b(b2),.out(r5c2));
    mac_unit u5_3(.clk(clk),.reset(reset),.a(a5),.b(b3),.out(r5c3));
    mac_unit u5_4(.clk(clk),.reset(reset),.a(a5),.b(b4),.out(r5c4));
    mac_unit u5_5(.clk(clk),.reset(reset),.a(a5),.b(b5),.out(r5c5));
    mac_unit u5_6(.clk(clk),.reset(reset),.a(a5),.b(b6),.out(r5c6));
    mac_unit u5_7(.clk(clk),.reset(reset),.a(a5),.b(b7),.out(r5c7));
    mac_unit u5_8(.clk(clk),.reset(reset),.a(a5),.b(b8),.out(r5c8));
    mac_unit u5_9(.clk(clk),.reset(reset),.a(a5),.b(b9),.out(r5c9));
    mac_unit u5_10(.clk(clk),.reset(reset),.a(a5),.b(b10),.out(r5c10));
    mac_unit u5_11(.clk(clk),.reset(reset),.a(a5),.b(b11),.out(r5c11));
    mac_unit u5_12(.clk(clk),.reset(reset),.a(a5),.b(b12),.out(r5c12));
    mac_unit u5_13(.clk(clk),.reset(reset),.a(a5),.b(b13),.out(r5c13));
    mac_unit u5_14(.clk(clk),.reset(reset),.a(a5),.b(b14),.out(r5c14));
    mac_unit u5_15(.clk(clk),.reset(reset),.a(a5),.b(b15),.out(r5c15));
    mac_unit u5_16(.clk(clk),.reset(reset),.a(a5),.b(b16),.out(r5c16));
    mac_unit u5_17(.clk(clk),.reset(reset),.a(a5),.b(b17),.out(r5c17));
    mac_unit u5_18(.clk(clk),.reset(reset),.a(a5),.b(b18),.out(r5c18));
    mac_unit u5_19(.clk(clk),.reset(reset),.a(a5),.b(b19),.out(r5c19));
    mac_unit u5_20(.clk(clk),.reset(reset),.a(a5),.b(b20),.out(r5c20));
    mac_unit u5_21(.clk(clk),.reset(reset),.a(a5),.b(b21),.out(r5c21));
    mac_unit u5_22(.clk(clk),.reset(reset),.a(a5),.b(b22),.out(r5c22));
    mac_unit u5_23(.clk(clk),.reset(reset),.a(a5),.b(b23),.out(r5c23));
    mac_unit u5_24(.clk(clk),.reset(reset),.a(a5),.b(b24),.out(r5c24));
    mac_unit u5_25(.clk(clk),.reset(reset),.a(a5),.b(b25),.out(r5c25));
    mac_unit u5_26(.clk(clk),.reset(reset),.a(a5),.b(b26),.out(r5c26));
    mac_unit u5_27(.clk(clk),.reset(reset),.a(a5),.b(b27),.out(r5c27));
    mac_unit u5_28(.clk(clk),.reset(reset),.a(a5),.b(b28),.out(r5c28));
    mac_unit u5_29(.clk(clk),.reset(reset),.a(a5),.b(b29),.out(r5c29));
    mac_unit u5_30(.clk(clk),.reset(reset),.a(a5),.b(b30),.out(r5c30));
    mac_unit u5_31(.clk(clk),.reset(reset),.a(a5),.b(b31),.out(r5c31));

    // Row 6
    mac_unit u6_0(.clk(clk),.reset(reset),.a(a6),.b(b0),.out(r6c0));
    mac_unit u6_1(.clk(clk),.reset(reset),.a(a6),.b(b1),.out(r6c1));
    mac_unit u6_2(.clk(clk),.reset(reset),.a(a6),.b(b2),.out(r6c2));
    mac_unit u6_3(.clk(clk),.reset(reset),.a(a6),.b(b3),.out(r6c3));
    mac_unit u6_4(.clk(clk),.reset(reset),.a(a6),.b(b4),.out(r6c4));
    mac_unit u6_5(.clk(clk),.reset(reset),.a(a6),.b(b5),.out(r6c5));
    mac_unit u6_6(.clk(clk),.reset(reset),.a(a6),.b(b6),.out(r6c6));
    mac_unit u6_7(.clk(clk),.reset(reset),.a(a6),.b(b7),.out(r6c7));
    mac_unit u6_8(.clk(clk),.reset(reset),.a(a6),.b(b8),.out(r6c8));
    mac_unit u6_9(.clk(clk),.reset(reset),.a(a6),.b(b9),.out(r6c9));
    mac_unit u6_10(.clk(clk),.reset(reset),.a(a6),.b(b10),.out(r6c10));
    mac_unit u6_11(.clk(clk),.reset(reset),.a(a6),.b(b11),.out(r6c11));
    mac_unit u6_12(.clk(clk),.reset(reset),.a(a6),.b(b12),.out(r6c12));
    mac_unit u6_13(.clk(clk),.reset(reset),.a(a6),.b(b13),.out(r6c13));
    mac_unit u6_14(.clk(clk),.reset(reset),.a(a6),.b(b14),.out(r6c14));
    mac_unit u6_15(.clk(clk),.reset(reset),.a(a6),.b(b15),.out(r6c15));
    mac_unit u6_16(.clk(clk),.reset(reset),.a(a6),.b(b16),.out(r6c16));
    mac_unit u6_17(.clk(clk),.reset(reset),.a(a6),.b(b17),.out(r6c17));
    mac_unit u6_18(.clk(clk),.reset(reset),.a(a6),.b(b18),.out(r6c18));
    mac_unit u6_19(.clk(clk),.reset(reset),.a(a6),.b(b19),.out(r6c19));
    mac_unit u6_20(.clk(clk),.reset(reset),.a(a6),.b(b20),.out(r6c20));
    mac_unit u6_21(.clk(clk),.reset(reset),.a(a6),.b(b21),.out(r6c21));
    mac_unit u6_22(.clk(clk),.reset(reset),.a(a6),.b(b22),.out(r6c22));
    mac_unit u6_23(.clk(clk),.reset(reset),.a(a6),.b(b23),.out(r6c23));
    mac_unit u6_24(.clk(clk),.reset(reset),.a(a6),.b(b24),.out(r6c24));
    mac_unit u6_25(.clk(clk),.reset(reset),.a(a6),.b(b25),.out(r6c25));
    mac_unit u6_26(.clk(clk),.reset(reset),.a(a6),.b(b26),.out(r6c26));
    mac_unit u6_27(.clk(clk),.reset(reset),.a(a6),.b(b27),.out(r6c27));
    mac_unit u6_28(.clk(clk),.reset(reset),.a(a6),.b(b28),.out(r6c28));
    mac_unit u6_29(.clk(clk),.reset(reset),.a(a6),.b(b29),.out(r6c29));
    mac_unit u6_30(.clk(clk),.reset(reset),.a(a6),.b(b30),.out(r6c30));
    mac_unit u6_31(.clk(clk),.reset(reset),.a(a6),.b(b31),.out(r6c31));

    // Row 7
    mac_unit u7_0(.clk(clk),.reset(reset),.a(a7),.b(b0),.out(r7c0));
    mac_unit u7_1(.clk(clk),.reset(reset),.a(a7),.b(b1),.out(r7c1));
    mac_unit u7_2(.clk(clk),.reset(reset),.a(a7),.b(b2),.out(r7c2));
    mac_unit u7_3(.clk(clk),.reset(reset),.a(a7),.b(b3),.out(r7c3));
    mac_unit u7_4(.clk(clk),.reset(reset),.a(a7),.b(b4),.out(r7c4));
    mac_unit u7_5(.clk(clk),.reset(reset),.a(a7),.b(b5),.out(r7c5));
    mac_unit u7_6(.clk(clk),.reset(reset),.a(a7),.b(b6),.out(r7c6));
    mac_unit u7_7(.clk(clk),.reset(reset),.a(a7),.b(b7),.out(r7c7));
    mac_unit u7_8(.clk(clk),.reset(reset),.a(a7),.b(b8),.out(r7c8));
    mac_unit u7_9(.clk(clk),.reset(reset),.a(a7),.b(b9),.out(r7c9));
    mac_unit u7_10(.clk(clk),.reset(reset),.a(a7),.b(b10),.out(r7c10));
    mac_unit u7_11(.clk(clk),.reset(reset),.a(a7),.b(b11),.out(r7c11));
    mac_unit u7_12(.clk(clk),.reset(reset),.a(a7),.b(b12),.out(r7c12));
    mac_unit u7_13(.clk(clk),.reset(reset),.a(a7),.b(b13),.out(r7c13));
    mac_unit u7_14(.clk(clk),.reset(reset),.a(a7),.b(b14),.out(r7c14));
    mac_unit u7_15(.clk(clk),.reset(reset),.a(a7),.b(b15),.out(r7c15));
    mac_unit u7_16(.clk(clk),.reset(reset),.a(a7),.b(b16),.out(r7c16));
    mac_unit u7_17(.clk(clk),.reset(reset),.a(a7),.b(b17),.out(r7c17));
    mac_unit u7_18(.clk(clk),.reset(reset),.a(a7),.b(b18),.out(r7c18));
    mac_unit u7_19(.clk(clk),.reset(reset),.a(a7),.b(b19),.out(r7c19));
    mac_unit u7_20(.clk(clk),.reset(reset),.a(a7),.b(b20),.out(r7c20));
    mac_unit u7_21(.clk(clk),.reset(reset),.a(a7),.b(b21),.out(r7c21));
    mac_unit u7_22(.clk(clk),.reset(reset),.a(a7),.b(b22),.out(r7c22));
    mac_unit u7_23(.clk(clk),.reset(reset),.a(a7),.b(b23),.out(r7c23));
    mac_unit u7_24(.clk(clk),.reset(reset),.a(a7),.b(b24),.out(r7c24));
    mac_unit u7_25(.clk(clk),.reset(reset),.a(a7),.b(b25),.out(r7c25));
    mac_unit u7_26(.clk(clk),.reset(reset),.a(a7),.b(b26),.out(r7c26));
    mac_unit u7_27(.clk(clk),.reset(reset),.a(a7),.b(b27),.out(r7c27));
    mac_unit u7_28(.clk(clk),.reset(reset),.a(a7),.b(b28),.out(r7c28));
    mac_unit u7_29(.clk(clk),.reset(reset),.a(a7),.b(b29),.out(r7c29));
    mac_unit u7_30(.clk(clk),.reset(reset),.a(a7),.b(b30),.out(r7c30));
    mac_unit u7_31(.clk(clk),.reset(reset),.a(a7),.b(b31),.out(r7c31));

    // Row 8
    mac_unit u8_0(.clk(clk),.reset(reset),.a(a8),.b(b0),.out(r8c0));
    mac_unit u8_1(.clk(clk),.reset(reset),.a(a8),.b(b1),.out(r8c1));
    mac_unit u8_2(.clk(clk),.reset(reset),.a(a8),.b(b2),.out(r8c2));
    mac_unit u8_3(.clk(clk),.reset(reset),.a(a8),.b(b3),.out(r8c3));
    mac_unit u8_4(.clk(clk),.reset(reset),.a(a8),.b(b4),.out(r8c4));
    mac_unit u8_5(.clk(clk),.reset(reset),.a(a8),.b(b5),.out(r8c5));
    mac_unit u8_6(.clk(clk),.reset(reset),.a(a8),.b(b6),.out(r8c6));
    mac_unit u8_7(.clk(clk),.reset(reset),.a(a8),.b(b7),.out(r8c7));
    mac_unit u8_8(.clk(clk),.reset(reset),.a(a8),.b(b8),.out(r8c8));
    mac_unit u8_9(.clk(clk),.reset(reset),.a(a8),.b(b9),.out(r8c9));
    mac_unit u8_10(.clk(clk),.reset(reset),.a(a8),.b(b10),.out(r8c10));
    mac_unit u8_11(.clk(clk),.reset(reset),.a(a8),.b(b11),.out(r8c11));
    mac_unit u8_12(.clk(clk),.reset(reset),.a(a8),.b(b12),.out(r8c12));
    mac_unit u8_13(.clk(clk),.reset(reset),.a(a8),.b(b13),.out(r8c13));
    mac_unit u8_14(.clk(clk),.reset(reset),.a(a8),.b(b14),.out(r8c14));
    mac_unit u8_15(.clk(clk),.reset(reset),.a(a8),.b(b15),.out(r8c15));
    mac_unit u8_16(.clk(clk),.reset(reset),.a(a8),.b(b16),.out(r8c16));
    mac_unit u8_17(.clk(clk),.reset(reset),.a(a8),.b(b17),.out(r8c17));
    mac_unit u8_18(.clk(clk),.reset(reset),.a(a8),.b(b18),.out(r8c18));
    mac_unit u8_19(.clk(clk),.reset(reset),.a(a8),.b(b19),.out(r8c19));
    mac_unit u8_20(.clk(clk),.reset(reset),.a(a8),.b(b20),.out(r8c20));
    mac_unit u8_21(.clk(clk),.reset(reset),.a(a8),.b(b21),.out(r8c21));
    mac_unit u8_22(.clk(clk),.reset(reset),.a(a8),.b(b22),.out(r8c22));
    mac_unit u8_23(.clk(clk),.reset(reset),.a(a8),.b(b23),.out(r8c23));
    mac_unit u8_24(.clk(clk),.reset(reset),.a(a8),.b(b24),.out(r8c24));
    mac_unit u8_25(.clk(clk),.reset(reset),.a(a8),.b(b25),.out(r8c25));
    mac_unit u8_26(.clk(clk),.reset(reset),.a(a8),.b(b26),.out(r8c26));
    mac_unit u8_27(.clk(clk),.reset(reset),.a(a8),.b(b27),.out(r8c27));
    mac_unit u8_28(.clk(clk),.reset(reset),.a(a8),.b(b28),.out(r8c28));
    mac_unit u8_29(.clk(clk),.reset(reset),.a(a8),.b(b29),.out(r8c29));
    mac_unit u8_30(.clk(clk),.reset(reset),.a(a8),.b(b30),.out(r8c30));
    mac_unit u8_31(.clk(clk),.reset(reset),.a(a8),.b(b31),.out(r8c31));

    // Row 9
    mac_unit u9_0(.clk(clk),.reset(reset),.a(a9),.b(b0),.out(r9c0));
    mac_unit u9_1(.clk(clk),.reset(reset),.a(a9),.b(b1),.out(r9c1));
    mac_unit u9_2(.clk(clk),.reset(reset),.a(a9),.b(b2),.out(r9c2));
    mac_unit u9_3(.clk(clk),.reset(reset),.a(a9),.b(b3),.out(r9c3));
    mac_unit u9_4(.clk(clk),.reset(reset),.a(a9),.b(b4),.out(r9c4));
    mac_unit u9_5(.clk(clk),.reset(reset),.a(a9),.b(b5),.out(r9c5));
    mac_unit u9_6(.clk(clk),.reset(reset),.a(a9),.b(b6),.out(r9c6));
    mac_unit u9_7(.clk(clk),.reset(reset),.a(a9),.b(b7),.out(r9c7));
    mac_unit u9_8(.clk(clk),.reset(reset),.a(a9),.b(b8),.out(r9c8));
    mac_unit u9_9(.clk(clk),.reset(reset),.a(a9),.b(b9),.out(r9c9));
    mac_unit u9_10(.clk(clk),.reset(reset),.a(a9),.b(b10),.out(r9c10));
    mac_unit u9_11(.clk(clk),.reset(reset),.a(a9),.b(b11),.out(r9c11));
    mac_unit u9_12(.clk(clk),.reset(reset),.a(a9),.b(b12),.out(r9c12));
    mac_unit u9_13(.clk(clk),.reset(reset),.a(a9),.b(b13),.out(r9c13));
    mac_unit u9_14(.clk(clk),.reset(reset),.a(a9),.b(b14),.out(r9c14));
    mac_unit u9_15(.clk(clk),.reset(reset),.a(a9),.b(b15),.out(r9c15));
    mac_unit u9_16(.clk(clk),.reset(reset),.a(a9),.b(b16),.out(r9c16));
    mac_unit u9_17(.clk(clk),.reset(reset),.a(a9),.b(b17),.out(r9c17));
    mac_unit u9_18(.clk(clk),.reset(reset),.a(a9),.b(b18),.out(r9c18));
    mac_unit u9_19(.clk(clk),.reset(reset),.a(a9),.b(b19),.out(r9c19));
    mac_unit u9_20(.clk(clk),.reset(reset),.a(a9),.b(b20),.out(r9c20));
    mac_unit u9_21(.clk(clk),.reset(reset),.a(a9),.b(b21),.out(r9c21));
    mac_unit u9_22(.clk(clk),.reset(reset),.a(a9),.b(b22),.out(r9c22));
    mac_unit u9_23(.clk(clk),.reset(reset),.a(a9),.b(b23),.out(r9c23));
    mac_unit u9_24(.clk(clk),.reset(reset),.a(a9),.b(b24),.out(r9c24));
    mac_unit u9_25(.clk(clk),.reset(reset),.a(a9),.b(b25),.out(r9c25));
    mac_unit u9_26(.clk(clk),.reset(reset),.a(a9),.b(b26),.out(r9c26));
    mac_unit u9_27(.clk(clk),.reset(reset),.a(a9),.b(b27),.out(r9c27));
    mac_unit u9_28(.clk(clk),.reset(reset),.a(a9),.b(b28),.out(r9c28));
    mac_unit u9_29(.clk(clk),.reset(reset),.a(a9),.b(b29),.out(r9c29));
    mac_unit u9_30(.clk(clk),.reset(reset),.a(a9),.b(b30),.out(r9c30));
    mac_unit u9_31(.clk(clk),.reset(reset),.a(a9),.b(b31),.out(r9c31));

    // Row 10
    mac_unit u10_0(.clk(clk),.reset(reset),.a(a10),.b(b0),.out(r10c0));
    mac_unit u10_1(.clk(clk),.reset(reset),.a(a10),.b(b1),.out(r10c1));
    mac_unit u10_2(.clk(clk),.reset(reset),.a(a10),.b(b2),.out(r10c2));
    mac_unit u10_3(.clk(clk),.reset(reset),.a(a10),.b(b3),.out(r10c3));
    mac_unit u10_4(.clk(clk),.reset(reset),.a(a10),.b(b4),.out(r10c4));
    mac_unit u10_5(.clk(clk),.reset(reset),.a(a10),.b(b5),.out(r10c5));
    mac_unit u10_6(.clk(clk),.reset(reset),.a(a10),.b(b6),.out(r10c6));
    mac_unit u10_7(.clk(clk),.reset(reset),.a(a10),.b(b7),.out(r10c7));
    mac_unit u10_8(.clk(clk),.reset(reset),.a(a10),.b(b8),.out(r10c8));
    mac_unit u10_9(.clk(clk),.reset(reset),.a(a10),.b(b9),.out(r10c9));
    mac_unit u10_10(.clk(clk),.reset(reset),.a(a10),.b(b10),.out(r10c10));
    mac_unit u10_11(.clk(clk),.reset(reset),.a(a10),.b(b11),.out(r10c11));
    mac_unit u10_12(.clk(clk),.reset(reset),.a(a10),.b(b12),.out(r10c12));
    mac_unit u10_13(.clk(clk),.reset(reset),.a(a10),.b(b13),.out(r10c13));
    mac_unit u10_14(.clk(clk),.reset(reset),.a(a10),.b(b14),.out(r10c14));
    mac_unit u10_15(.clk(clk),.reset(reset),.a(a10),.b(b15),.out(r10c15));
    mac_unit u10_16(.clk(clk),.reset(reset),.a(a10),.b(b16),.out(r10c16));
    mac_unit u10_17(.clk(clk),.reset(reset),.a(a10),.b(b17),.out(r10c17));
    mac_unit u10_18(.clk(clk),.reset(reset),.a(a10),.b(b18),.out(r10c18));
    mac_unit u10_19(.clk(clk),.reset(reset),.a(a10),.b(b19),.out(r10c19));
    mac_unit u10_20(.clk(clk),.reset(reset),.a(a10),.b(b20),.out(r10c20));
    mac_unit u10_21(.clk(clk),.reset(reset),.a(a10),.b(b21),.out(r10c21));
    mac_unit u10_22(.clk(clk),.reset(reset),.a(a10),.b(b22),.out(r10c22));
    mac_unit u10_23(.clk(clk),.reset(reset),.a(a10),.b(b23),.out(r10c23));
    mac_unit u10_24(.clk(clk),.reset(reset),.a(a10),.b(b24),.out(r10c24));
    mac_unit u10_25(.clk(clk),.reset(reset),.a(a10),.b(b25),.out(r10c25));
    mac_unit u10_26(.clk(clk),.reset(reset),.a(a10),.b(b26),.out(r10c26));
    mac_unit u10_27(.clk(clk),.reset(reset),.a(a10),.b(b27),.out(r10c27));
    mac_unit u10_28(.clk(clk),.reset(reset),.a(a10),.b(b28),.out(r10c28));
    mac_unit u10_29(.clk(clk),.reset(reset),.a(a10),.b(b29),.out(r10c29));
    mac_unit u10_30(.clk(clk),.reset(reset),.a(a10),.b(b30),.out(r10c30));
    mac_unit u10_31(.clk(clk),.reset(reset),.a(a10),.b(b31),.out(r10c31));

    // Row 11
    mac_unit u11_0(.clk(clk),.reset(reset),.a(a11),.b(b0),.out(r11c0));
    mac_unit u11_1(.clk(clk),.reset(reset),.a(a11),.b(b1),.out(r11c1));
    mac_unit u11_2(.clk(clk),.reset(reset),.a(a11),.b(b2),.out(r11c2));
    mac_unit u11_3(.clk(clk),.reset(reset),.a(a11),.b(b3),.out(r11c3));
    mac_unit u11_4(.clk(clk),.reset(reset),.a(a11),.b(b4),.out(r11c4));
    mac_unit u11_5(.clk(clk),.reset(reset),.a(a11),.b(b5),.out(r11c5));
    mac_unit u11_6(.clk(clk),.reset(reset),.a(a11),.b(b6),.out(r11c6));
    mac_unit u11_7(.clk(clk),.reset(reset),.a(a11),.b(b7),.out(r11c7));
    mac_unit u11_8(.clk(clk),.reset(reset),.a(a11),.b(b8),.out(r11c8));
    mac_unit u11_9(.clk(clk),.reset(reset),.a(a11),.b(b9),.out(r11c9));
    mac_unit u11_10(.clk(clk),.reset(reset),.a(a11),.b(b10),.out(r11c10));
    mac_unit u11_11(.clk(clk),.reset(reset),.a(a11),.b(b11),.out(r11c11));
    mac_unit u11_12(.clk(clk),.reset(reset),.a(a11),.b(b12),.out(r11c12));
    mac_unit u11_13(.clk(clk),.reset(reset),.a(a11),.b(b13),.out(r11c13));
    mac_unit u11_14(.clk(clk),.reset(reset),.a(a11),.b(b14),.out(r11c14));
    mac_unit u11_15(.clk(clk),.reset(reset),.a(a11),.b(b15),.out(r11c15));
    mac_unit u11_16(.clk(clk),.reset(reset),.a(a11),.b(b16),.out(r11c16));
    mac_unit u11_17(.clk(clk),.reset(reset),.a(a11),.b(b17),.out(r11c17));
    mac_unit u11_18(.clk(clk),.reset(reset),.a(a11),.b(b18),.out(r11c18));
    mac_unit u11_19(.clk(clk),.reset(reset),.a(a11),.b(b19),.out(r11c19));
    mac_unit u11_20(.clk(clk),.reset(reset),.a(a11),.b(b20),.out(r11c20));
    mac_unit u11_21(.clk(clk),.reset(reset),.a(a11),.b(b21),.out(r11c21));
    mac_unit u11_22(.clk(clk),.reset(reset),.a(a11),.b(b22),.out(r11c22));
    mac_unit u11_23(.clk(clk),.reset(reset),.a(a11),.b(b23),.out(r11c23));
    mac_unit u11_24(.clk(clk),.reset(reset),.a(a11),.b(b24),.out(r11c24));
    mac_unit u11_25(.clk(clk),.reset(reset),.a(a11),.b(b25),.out(r11c25));
    mac_unit u11_26(.clk(clk),.reset(reset),.a(a11),.b(b26),.out(r11c26));
    mac_unit u11_27(.clk(clk),.reset(reset),.a(a11),.b(b27),.out(r11c27));
    mac_unit u11_28(.clk(clk),.reset(reset),.a(a11),.b(b28),.out(r11c28));
    mac_unit u11_29(.clk(clk),.reset(reset),.a(a11),.b(b29),.out(r11c29));
    mac_unit u11_30(.clk(clk),.reset(reset),.a(a11),.b(b30),.out(r11c30));
    mac_unit u11_31(.clk(clk),.reset(reset),.a(a11),.b(b31),.out(r11c31));

    // Row 12
    mac_unit u12_0(.clk(clk),.reset(reset),.a(a12),.b(b0),.out(r12c0));
    mac_unit u12_1(.clk(clk),.reset(reset),.a(a12),.b(b1),.out(r12c1));
    mac_unit u12_2(.clk(clk),.reset(reset),.a(a12),.b(b2),.out(r12c2));
    mac_unit u12_3(.clk(clk),.reset(reset),.a(a12),.b(b3),.out(r12c3));
    mac_unit u12_4(.clk(clk),.reset(reset),.a(a12),.b(b4),.out(r12c4));
    mac_unit u12_5(.clk(clk),.reset(reset),.a(a12),.b(b5),.out(r12c5));
    mac_unit u12_6(.clk(clk),.reset(reset),.a(a12),.b(b6),.out(r12c6));
    mac_unit u12_7(.clk(clk),.reset(reset),.a(a12),.b(b7),.out(r12c7));
    mac_unit u12_8(.clk(clk),.reset(reset),.a(a12),.b(b8),.out(r12c8));
    mac_unit u12_9(.clk(clk),.reset(reset),.a(a12),.b(b9),.out(r12c9));
    mac_unit u12_10(.clk(clk),.reset(reset),.a(a12),.b(b10),.out(r12c10));
    mac_unit u12_11(.clk(clk),.reset(reset),.a(a12),.b(b11),.out(r12c11));
    mac_unit u12_12(.clk(clk),.reset(reset),.a(a12),.b(b12),.out(r12c12));
    mac_unit u12_13(.clk(clk),.reset(reset),.a(a12),.b(b13),.out(r12c13));
    mac_unit u12_14(.clk(clk),.reset(reset),.a(a12),.b(b14),.out(r12c14));
    mac_unit u12_15(.clk(clk),.reset(reset),.a(a12),.b(b15),.out(r12c15));
    mac_unit u12_16(.clk(clk),.reset(reset),.a(a12),.b(b16),.out(r12c16));
    mac_unit u12_17(.clk(clk),.reset(reset),.a(a12),.b(b17),.out(r12c17));
    mac_unit u12_18(.clk(clk),.reset(reset),.a(a12),.b(b18),.out(r12c18));
    mac_unit u12_19(.clk(clk),.reset(reset),.a(a12),.b(b19),.out(r12c19));
    mac_unit u12_20(.clk(clk),.reset(reset),.a(a12),.b(b20),.out(r12c20));
    mac_unit u12_21(.clk(clk),.reset(reset),.a(a12),.b(b21),.out(r12c21));
    mac_unit u12_22(.clk(clk),.reset(reset),.a(a12),.b(b22),.out(r12c22));
    mac_unit u12_23(.clk(clk),.reset(reset),.a(a12),.b(b23),.out(r12c23));
    mac_unit u12_24(.clk(clk),.reset(reset),.a(a12),.b(b24),.out(r12c24));
    mac_unit u12_25(.clk(clk),.reset(reset),.a(a12),.b(b25),.out(r12c25));
    mac_unit u12_26(.clk(clk),.reset(reset),.a(a12),.b(b26),.out(r12c26));
    mac_unit u12_27(.clk(clk),.reset(reset),.a(a12),.b(b27),.out(r12c27));
    mac_unit u12_28(.clk(clk),.reset(reset),.a(a12),.b(b28),.out(r12c28));
    mac_unit u12_29(.clk(clk),.reset(reset),.a(a12),.b(b29),.out(r12c29));
    mac_unit u12_30(.clk(clk),.reset(reset),.a(a12),.b(b30),.out(r12c30));
    mac_unit u12_31(.clk(clk),.reset(reset),.a(a12),.b(b31),.out(r12c31));

    // Row 13
    mac_unit u13_0(.clk(clk),.reset(reset),.a(a13),.b(b0),.out(r13c0));
    mac_unit u13_1(.clk(clk),.reset(reset),.a(a13),.b(b1),.out(r13c1));
    mac_unit u13_2(.clk(clk),.reset(reset),.a(a13),.b(b2),.out(r13c2));
    mac_unit u13_3(.clk(clk),.reset(reset),.a(a13),.b(b3),.out(r13c3));
    mac_unit u13_4(.clk(clk),.reset(reset),.a(a13),.b(b4),.out(r13c4));
    mac_unit u13_5(.clk(clk),.reset(reset),.a(a13),.b(b5),.out(r13c5));
    mac_unit u13_6(.clk(clk),.reset(reset),.a(a13),.b(b6),.out(r13c6));
    mac_unit u13_7(.clk(clk),.reset(reset),.a(a13),.b(b7),.out(r13c7));
    mac_unit u13_8(.clk(clk),.reset(reset),.a(a13),.b(b8),.out(r13c8));
    mac_unit u13_9(.clk(clk),.reset(reset),.a(a13),.b(b9),.out(r13c9));
    mac_unit u13_10(.clk(clk),.reset(reset),.a(a13),.b(b10),.out(r13c10));
    mac_unit u13_11(.clk(clk),.reset(reset),.a(a13),.b(b11),.out(r13c11));
    mac_unit u13_12(.clk(clk),.reset(reset),.a(a13),.b(b12),.out(r13c12));
    mac_unit u13_13(.clk(clk),.reset(reset),.a(a13),.b(b13),.out(r13c13));
    mac_unit u13_14(.clk(clk),.reset(reset),.a(a13),.b(b14),.out(r13c14));
    mac_unit u13_15(.clk(clk),.reset(reset),.a(a13),.b(b15),.out(r13c15));
    mac_unit u13_16(.clk(clk),.reset(reset),.a(a13),.b(b16),.out(r13c16));
    mac_unit u13_17(.clk(clk),.reset(reset),.a(a13),.b(b17),.out(r13c17));
    mac_unit u13_18(.clk(clk),.reset(reset),.a(a13),.b(b18),.out(r13c18));
    mac_unit u13_19(.clk(clk),.reset(reset),.a(a13),.b(b19),.out(r13c19));
    mac_unit u13_20(.clk(clk),.reset(reset),.a(a13),.b(b20),.out(r13c20));
    mac_unit u13_21(.clk(clk),.reset(reset),.a(a13),.b(b21),.out(r13c21));
    mac_unit u13_22(.clk(clk),.reset(reset),.a(a13),.b(b22),.out(r13c22));
    mac_unit u13_23(.clk(clk),.reset(reset),.a(a13),.b(b23),.out(r13c23));
    mac_unit u13_24(.clk(clk),.reset(reset),.a(a13),.b(b24),.out(r13c24));
    mac_unit u13_25(.clk(clk),.reset(reset),.a(a13),.b(b25),.out(r13c25));
    mac_unit u13_26(.clk(clk),.reset(reset),.a(a13),.b(b26),.out(r13c26));
    mac_unit u13_27(.clk(clk),.reset(reset),.a(a13),.b(b27),.out(r13c27));
    mac_unit u13_28(.clk(clk),.reset(reset),.a(a13),.b(b28),.out(r13c28));
    mac_unit u13_29(.clk(clk),.reset(reset),.a(a13),.b(b29),.out(r13c29));
    mac_unit u13_30(.clk(clk),.reset(reset),.a(a13),.b(b30),.out(r13c30));
    mac_unit u13_31(.clk(clk),.reset(reset),.a(a13),.b(b31),.out(r13c31));

    // Row 14
    mac_unit u14_0(.clk(clk),.reset(reset),.a(a14),.b(b0),.out(r14c0));
    mac_unit u14_1(.clk(clk),.reset(reset),.a(a14),.b(b1),.out(r14c1));
    mac_unit u14_2(.clk(clk),.reset(reset),.a(a14),.b(b2),.out(r14c2));
    mac_unit u14_3(.clk(clk),.reset(reset),.a(a14),.b(b3),.out(r14c3));
    mac_unit u14_4(.clk(clk),.reset(reset),.a(a14),.b(b4),.out(r14c4));
    mac_unit u14_5(.clk(clk),.reset(reset),.a(a14),.b(b5),.out(r14c5));
    mac_unit u14_6(.clk(clk),.reset(reset),.a(a14),.b(b6),.out(r14c6));
    mac_unit u14_7(.clk(clk),.reset(reset),.a(a14),.b(b7),.out(r14c7));
    mac_unit u14_8(.clk(clk),.reset(reset),.a(a14),.b(b8),.out(r14c8));
    mac_unit u14_9(.clk(clk),.reset(reset),.a(a14),.b(b9),.out(r14c9));
    mac_unit u14_10(.clk(clk),.reset(reset),.a(a14),.b(b10),.out(r14c10));
    mac_unit u14_11(.clk(clk),.reset(reset),.a(a14),.b(b11),.out(r14c11));
    mac_unit u14_12(.clk(clk),.reset(reset),.a(a14),.b(b12),.out(r14c12));
    mac_unit u14_13(.clk(clk),.reset(reset),.a(a14),.b(b13),.out(r14c13));
    mac_unit u14_14(.clk(clk),.reset(reset),.a(a14),.b(b14),.out(r14c14));
    mac_unit u14_15(.clk(clk),.reset(reset),.a(a14),.b(b15),.out(r14c15));
    mac_unit u14_16(.clk(clk),.reset(reset),.a(a14),.b(b16),.out(r14c16));
    mac_unit u14_17(.clk(clk),.reset(reset),.a(a14),.b(b17),.out(r14c17));
    mac_unit u14_18(.clk(clk),.reset(reset),.a(a14),.b(b18),.out(r14c18));
    mac_unit u14_19(.clk(clk),.reset(reset),.a(a14),.b(b19),.out(r14c19));
    mac_unit u14_20(.clk(clk),.reset(reset),.a(a14),.b(b20),.out(r14c20));
    mac_unit u14_21(.clk(clk),.reset(reset),.a(a14),.b(b21),.out(r14c21));
    mac_unit u14_22(.clk(clk),.reset(reset),.a(a14),.b(b22),.out(r14c22));
    mac_unit u14_23(.clk(clk),.reset(reset),.a(a14),.b(b23),.out(r14c23));
    mac_unit u14_24(.clk(clk),.reset(reset),.a(a14),.b(b24),.out(r14c24));
    mac_unit u14_25(.clk(clk),.reset(reset),.a(a14),.b(b25),.out(r14c25));
    mac_unit u14_26(.clk(clk),.reset(reset),.a(a14),.b(b26),.out(r14c26));
    mac_unit u14_27(.clk(clk),.reset(reset),.a(a14),.b(b27),.out(r14c27));
    mac_unit u14_28(.clk(clk),.reset(reset),.a(a14),.b(b28),.out(r14c28));
    mac_unit u14_29(.clk(clk),.reset(reset),.a(a14),.b(b29),.out(r14c29));
    mac_unit u14_30(.clk(clk),.reset(reset),.a(a14),.b(b30),.out(r14c30));
    mac_unit u14_31(.clk(clk),.reset(reset),.a(a14),.b(b31),.out(r14c31));

    // Row 15
    mac_unit u15_0(.clk(clk),.reset(reset),.a(a15),.b(b0),.out(r15c0));
    mac_unit u15_1(.clk(clk),.reset(reset),.a(a15),.b(b1),.out(r15c1));
    mac_unit u15_2(.clk(clk),.reset(reset),.a(a15),.b(b2),.out(r15c2));
    mac_unit u15_3(.clk(clk),.reset(reset),.a(a15),.b(b3),.out(r15c3));
    mac_unit u15_4(.clk(clk),.reset(reset),.a(a15),.b(b4),.out(r15c4));
    mac_unit u15_5(.clk(clk),.reset(reset),.a(a15),.b(b5),.out(r15c5));
    mac_unit u15_6(.clk(clk),.reset(reset),.a(a15),.b(b6),.out(r15c6));
    mac_unit u15_7(.clk(clk),.reset(reset),.a(a15),.b(b7),.out(r15c7));
    mac_unit u15_8(.clk(clk),.reset(reset),.a(a15),.b(b8),.out(r15c8));
    mac_unit u15_9(.clk(clk),.reset(reset),.a(a15),.b(b9),.out(r15c9));
    mac_unit u15_10(.clk(clk),.reset(reset),.a(a15),.b(b10),.out(r15c10));
    mac_unit u15_11(.clk(clk),.reset(reset),.a(a15),.b(b11),.out(r15c11));
    mac_unit u15_12(.clk(clk),.reset(reset),.a(a15),.b(b12),.out(r15c12));
    mac_unit u15_13(.clk(clk),.reset(reset),.a(a15),.b(b13),.out(r15c13));
    mac_unit u15_14(.clk(clk),.reset(reset),.a(a15),.b(b14),.out(r15c14));
    mac_unit u15_15(.clk(clk),.reset(reset),.a(a15),.b(b15),.out(r15c15));
    mac_unit u15_16(.clk(clk),.reset(reset),.a(a15),.b(b16),.out(r15c16));
    mac_unit u15_17(.clk(clk),.reset(reset),.a(a15),.b(b17),.out(r15c17));
    mac_unit u15_18(.clk(clk),.reset(reset),.a(a15),.b(b18),.out(r15c18));
    mac_unit u15_19(.clk(clk),.reset(reset),.a(a15),.b(b19),.out(r15c19));
    mac_unit u15_20(.clk(clk),.reset(reset),.a(a15),.b(b20),.out(r15c20));
    mac_unit u15_21(.clk(clk),.reset(reset),.a(a15),.b(b21),.out(r15c21));
    mac_unit u15_22(.clk(clk),.reset(reset),.a(a15),.b(b22),.out(r15c22));
    mac_unit u15_23(.clk(clk),.reset(reset),.a(a15),.b(b23),.out(r15c23));
    mac_unit u15_24(.clk(clk),.reset(reset),.a(a15),.b(b24),.out(r15c24));
    mac_unit u15_25(.clk(clk),.reset(reset),.a(a15),.b(b25),.out(r15c25));
    mac_unit u15_26(.clk(clk),.reset(reset),.a(a15),.b(b26),.out(r15c26));
    mac_unit u15_27(.clk(clk),.reset(reset),.a(a15),.b(b27),.out(r15c27));
    mac_unit u15_28(.clk(clk),.reset(reset),.a(a15),.b(b28),.out(r15c28));
    mac_unit u15_29(.clk(clk),.reset(reset),.a(a15),.b(b29),.out(r15c29));
    mac_unit u15_30(.clk(clk),.reset(reset),.a(a15),.b(b30),.out(r15c30));
    mac_unit u15_31(.clk(clk),.reset(reset),.a(a15),.b(b31),.out(r15c31));

    // Row 16
    mac_unit u16_0(.clk(clk),.reset(reset),.a(a16),.b(b0),.out(r16c0));
    mac_unit u16_1(.clk(clk),.reset(reset),.a(a16),.b(b1),.out(r16c1));
    mac_unit u16_2(.clk(clk),.reset(reset),.a(a16),.b(b2),.out(r16c2));
    mac_unit u16_3(.clk(clk),.reset(reset),.a(a16),.b(b3),.out(r16c3));
    mac_unit u16_4(.clk(clk),.reset(reset),.a(a16),.b(b4),.out(r16c4));
    mac_unit u16_5(.clk(clk),.reset(reset),.a(a16),.b(b5),.out(r16c5));
    mac_unit u16_6(.clk(clk),.reset(reset),.a(a16),.b(b6),.out(r16c6));
    mac_unit u16_7(.clk(clk),.reset(reset),.a(a16),.b(b7),.out(r16c7));
    mac_unit u16_8(.clk(clk),.reset(reset),.a(a16),.b(b8),.out(r16c8));
    mac_unit u16_9(.clk(clk),.reset(reset),.a(a16),.b(b9),.out(r16c9));
    mac_unit u16_10(.clk(clk),.reset(reset),.a(a16),.b(b10),.out(r16c10));
    mac_unit u16_11(.clk(clk),.reset(reset),.a(a16),.b(b11),.out(r16c11));
    mac_unit u16_12(.clk(clk),.reset(reset),.a(a16),.b(b12),.out(r16c12));
    mac_unit u16_13(.clk(clk),.reset(reset),.a(a16),.b(b13),.out(r16c13));
    mac_unit u16_14(.clk(clk),.reset(reset),.a(a16),.b(b14),.out(r16c14));
    mac_unit u16_15(.clk(clk),.reset(reset),.a(a16),.b(b15),.out(r16c15));
    mac_unit u16_16(.clk(clk),.reset(reset),.a(a16),.b(b16),.out(r16c16));
    mac_unit u16_17(.clk(clk),.reset(reset),.a(a16),.b(b17),.out(r16c17));
    mac_unit u16_18(.clk(clk),.reset(reset),.a(a16),.b(b18),.out(r16c18));
    mac_unit u16_19(.clk(clk),.reset(reset),.a(a16),.b(b19),.out(r16c19));
    mac_unit u16_20(.clk(clk),.reset(reset),.a(a16),.b(b20),.out(r16c20));
    mac_unit u16_21(.clk(clk),.reset(reset),.a(a16),.b(b21),.out(r16c21));
    mac_unit u16_22(.clk(clk),.reset(reset),.a(a16),.b(b22),.out(r16c22));
    mac_unit u16_23(.clk(clk),.reset(reset),.a(a16),.b(b23),.out(r16c23));
    mac_unit u16_24(.clk(clk),.reset(reset),.a(a16),.b(b24),.out(r16c24));
    mac_unit u16_25(.clk(clk),.reset(reset),.a(a16),.b(b25),.out(r16c25));
    mac_unit u16_26(.clk(clk),.reset(reset),.a(a16),.b(b26),.out(r16c26));
    mac_unit u16_27(.clk(clk),.reset(reset),.a(a16),.b(b27),.out(r16c27));
    mac_unit u16_28(.clk(clk),.reset(reset),.a(a16),.b(b28),.out(r16c28));
    mac_unit u16_29(.clk(clk),.reset(reset),.a(a16),.b(b29),.out(r16c29));
    mac_unit u16_30(.clk(clk),.reset(reset),.a(a16),.b(b30),.out(r16c30));
    mac_unit u16_31(.clk(clk),.reset(reset),.a(a16),.b(b31),.out(r16c31));

    // Row 17
    mac_unit u17_0(.clk(clk),.reset(reset),.a(a17),.b(b0),.out(r17c0));
    mac_unit u17_1(.clk(clk),.reset(reset),.a(a17),.b(b1),.out(r17c1));
    mac_unit u17_2(.clk(clk),.reset(reset),.a(a17),.b(b2),.out(r17c2));
    mac_unit u17_3(.clk(clk),.reset(reset),.a(a17),.b(b3),.out(r17c3));
    mac_unit u17_4(.clk(clk),.reset(reset),.a(a17),.b(b4),.out(r17c4));
    mac_unit u17_5(.clk(clk),.reset(reset),.a(a17),.b(b5),.out(r17c5));
    mac_unit u17_6(.clk(clk),.reset(reset),.a(a17),.b(b6),.out(r17c6));
    mac_unit u17_7(.clk(clk),.reset(reset),.a(a17),.b(b7),.out(r17c7));
    mac_unit u17_8(.clk(clk),.reset(reset),.a(a17),.b(b8),.out(r17c8));
    mac_unit u17_9(.clk(clk),.reset(reset),.a(a17),.b(b9),.out(r17c9));
    mac_unit u17_10(.clk(clk),.reset(reset),.a(a17),.b(b10),.out(r17c10));
    mac_unit u17_11(.clk(clk),.reset(reset),.a(a17),.b(b11),.out(r17c11));
    mac_unit u17_12(.clk(clk),.reset(reset),.a(a17),.b(b12),.out(r17c12));
    mac_unit u17_13(.clk(clk),.reset(reset),.a(a17),.b(b13),.out(r17c13));
    mac_unit u17_14(.clk(clk),.reset(reset),.a(a17),.b(b14),.out(r17c14));
    mac_unit u17_15(.clk(clk),.reset(reset),.a(a17),.b(b15),.out(r17c15));
    mac_unit u17_16(.clk(clk),.reset(reset),.a(a17),.b(b16),.out(r17c16));
    mac_unit u17_17(.clk(clk),.reset(reset),.a(a17),.b(b17),.out(r17c17));
    mac_unit u17_18(.clk(clk),.reset(reset),.a(a17),.b(b18),.out(r17c18));
    mac_unit u17_19(.clk(clk),.reset(reset),.a(a17),.b(b19),.out(r17c19));
    mac_unit u17_20(.clk(clk),.reset(reset),.a(a17),.b(b20),.out(r17c20));
    mac_unit u17_21(.clk(clk),.reset(reset),.a(a17),.b(b21),.out(r17c21));
    mac_unit u17_22(.clk(clk),.reset(reset),.a(a17),.b(b22),.out(r17c22));
    mac_unit u17_23(.clk(clk),.reset(reset),.a(a17),.b(b23),.out(r17c23));
    mac_unit u17_24(.clk(clk),.reset(reset),.a(a17),.b(b24),.out(r17c24));
    mac_unit u17_25(.clk(clk),.reset(reset),.a(a17),.b(b25),.out(r17c25));
    mac_unit u17_26(.clk(clk),.reset(reset),.a(a17),.b(b26),.out(r17c26));
    mac_unit u17_27(.clk(clk),.reset(reset),.a(a17),.b(b27),.out(r17c27));
    mac_unit u17_28(.clk(clk),.reset(reset),.a(a17),.b(b28),.out(r17c28));
    mac_unit u17_29(.clk(clk),.reset(reset),.a(a17),.b(b29),.out(r17c29));
    mac_unit u17_30(.clk(clk),.reset(reset),.a(a17),.b(b30),.out(r17c30));
    mac_unit u17_31(.clk(clk),.reset(reset),.a(a17),.b(b31),.out(r17c31));

    // Row 18
    mac_unit u18_0(.clk(clk),.reset(reset),.a(a18),.b(b0),.out(r18c0));
    mac_unit u18_1(.clk(clk),.reset(reset),.a(a18),.b(b1),.out(r18c1));
    mac_unit u18_2(.clk(clk),.reset(reset),.a(a18),.b(b2),.out(r18c2));
    mac_unit u18_3(.clk(clk),.reset(reset),.a(a18),.b(b3),.out(r18c3));
    mac_unit u18_4(.clk(clk),.reset(reset),.a(a18),.b(b4),.out(r18c4));
    mac_unit u18_5(.clk(clk),.reset(reset),.a(a18),.b(b5),.out(r18c5));
    mac_unit u18_6(.clk(clk),.reset(reset),.a(a18),.b(b6),.out(r18c6));
    mac_unit u18_7(.clk(clk),.reset(reset),.a(a18),.b(b7),.out(r18c7));
    mac_unit u18_8(.clk(clk),.reset(reset),.a(a18),.b(b8),.out(r18c8));
    mac_unit u18_9(.clk(clk),.reset(reset),.a(a18),.b(b9),.out(r18c9));
    mac_unit u18_10(.clk(clk),.reset(reset),.a(a18),.b(b10),.out(r18c10));
    mac_unit u18_11(.clk(clk),.reset(reset),.a(a18),.b(b11),.out(r18c11));
    mac_unit u18_12(.clk(clk),.reset(reset),.a(a18),.b(b12),.out(r18c12));
    mac_unit u18_13(.clk(clk),.reset(reset),.a(a18),.b(b13),.out(r18c13));
    mac_unit u18_14(.clk(clk),.reset(reset),.a(a18),.b(b14),.out(r18c14));
    mac_unit u18_15(.clk(clk),.reset(reset),.a(a18),.b(b15),.out(r18c15));
    mac_unit u18_16(.clk(clk),.reset(reset),.a(a18),.b(b16),.out(r18c16));
    mac_unit u18_17(.clk(clk),.reset(reset),.a(a18),.b(b17),.out(r18c17));
    mac_unit u18_18(.clk(clk),.reset(reset),.a(a18),.b(b18),.out(r18c18));
    mac_unit u18_19(.clk(clk),.reset(reset),.a(a18),.b(b19),.out(r18c19));
    mac_unit u18_20(.clk(clk),.reset(reset),.a(a18),.b(b20),.out(r18c20));
    mac_unit u18_21(.clk(clk),.reset(reset),.a(a18),.b(b21),.out(r18c21));
    mac_unit u18_22(.clk(clk),.reset(reset),.a(a18),.b(b22),.out(r18c22));
    mac_unit u18_23(.clk(clk),.reset(reset),.a(a18),.b(b23),.out(r18c23));
    mac_unit u18_24(.clk(clk),.reset(reset),.a(a18),.b(b24),.out(r18c24));
    mac_unit u18_25(.clk(clk),.reset(reset),.a(a18),.b(b25),.out(r18c25));
    mac_unit u18_26(.clk(clk),.reset(reset),.a(a18),.b(b26),.out(r18c26));
    mac_unit u18_27(.clk(clk),.reset(reset),.a(a18),.b(b27),.out(r18c27));
    mac_unit u18_28(.clk(clk),.reset(reset),.a(a18),.b(b28),.out(r18c28));
    mac_unit u18_29(.clk(clk),.reset(reset),.a(a18),.b(b29),.out(r18c29));
    mac_unit u18_30(.clk(clk),.reset(reset),.a(a18),.b(b30),.out(r18c30));
    mac_unit u18_31(.clk(clk),.reset(reset),.a(a18),.b(b31),.out(r18c31));

    // Row 19
    mac_unit u19_0(.clk(clk),.reset(reset),.a(a19),.b(b0),.out(r19c0));
    mac_unit u19_1(.clk(clk),.reset(reset),.a(a19),.b(b1),.out(r19c1));
    mac_unit u19_2(.clk(clk),.reset(reset),.a(a19),.b(b2),.out(r19c2));
    mac_unit u19_3(.clk(clk),.reset(reset),.a(a19),.b(b3),.out(r19c3));
    mac_unit u19_4(.clk(clk),.reset(reset),.a(a19),.b(b4),.out(r19c4));
    mac_unit u19_5(.clk(clk),.reset(reset),.a(a19),.b(b5),.out(r19c5));
    mac_unit u19_6(.clk(clk),.reset(reset),.a(a19),.b(b6),.out(r19c6));
    mac_unit u19_7(.clk(clk),.reset(reset),.a(a19),.b(b7),.out(r19c7));
    mac_unit u19_8(.clk(clk),.reset(reset),.a(a19),.b(b8),.out(r19c8));
    mac_unit u19_9(.clk(clk),.reset(reset),.a(a19),.b(b9),.out(r19c9));
    mac_unit u19_10(.clk(clk),.reset(reset),.a(a19),.b(b10),.out(r19c10));
    mac_unit u19_11(.clk(clk),.reset(reset),.a(a19),.b(b11),.out(r19c11));
    mac_unit u19_12(.clk(clk),.reset(reset),.a(a19),.b(b12),.out(r19c12));
    mac_unit u19_13(.clk(clk),.reset(reset),.a(a19),.b(b13),.out(r19c13));
    mac_unit u19_14(.clk(clk),.reset(reset),.a(a19),.b(b14),.out(r19c14));
    mac_unit u19_15(.clk(clk),.reset(reset),.a(a19),.b(b15),.out(r19c15));
    mac_unit u19_16(.clk(clk),.reset(reset),.a(a19),.b(b16),.out(r19c16));
    mac_unit u19_17(.clk(clk),.reset(reset),.a(a19),.b(b17),.out(r19c17));
    mac_unit u19_18(.clk(clk),.reset(reset),.a(a19),.b(b18),.out(r19c18));
    mac_unit u19_19(.clk(clk),.reset(reset),.a(a19),.b(b19),.out(r19c19));
    mac_unit u19_20(.clk(clk),.reset(reset),.a(a19),.b(b20),.out(r19c20));
    mac_unit u19_21(.clk(clk),.reset(reset),.a(a19),.b(b21),.out(r19c21));
    mac_unit u19_22(.clk(clk),.reset(reset),.a(a19),.b(b22),.out(r19c22));
    mac_unit u19_23(.clk(clk),.reset(reset),.a(a19),.b(b23),.out(r19c23));
    mac_unit u19_24(.clk(clk),.reset(reset),.a(a19),.b(b24),.out(r19c24));
    mac_unit u19_25(.clk(clk),.reset(reset),.a(a19),.b(b25),.out(r19c25));
    mac_unit u19_26(.clk(clk),.reset(reset),.a(a19),.b(b26),.out(r19c26));
    mac_unit u19_27(.clk(clk),.reset(reset),.a(a19),.b(b27),.out(r19c27));
    mac_unit u19_28(.clk(clk),.reset(reset),.a(a19),.b(b28),.out(r19c28));
    mac_unit u19_29(.clk(clk),.reset(reset),.a(a19),.b(b29),.out(r19c29));
    mac_unit u19_30(.clk(clk),.reset(reset),.a(a19),.b(b30),.out(r19c30));
    mac_unit u19_31(.clk(clk),.reset(reset),.a(a19),.b(b31),.out(r19c31));

    // Row 20
    mac_unit u20_0(.clk(clk),.reset(reset),.a(a20),.b(b0),.out(r20c0));
    mac_unit u20_1(.clk(clk),.reset(reset),.a(a20),.b(b1),.out(r20c1));
    mac_unit u20_2(.clk(clk),.reset(reset),.a(a20),.b(b2),.out(r20c2));
    mac_unit u20_3(.clk(clk),.reset(reset),.a(a20),.b(b3),.out(r20c3));
    mac_unit u20_4(.clk(clk),.reset(reset),.a(a20),.b(b4),.out(r20c4));
    mac_unit u20_5(.clk(clk),.reset(reset),.a(a20),.b(b5),.out(r20c5));
    mac_unit u20_6(.clk(clk),.reset(reset),.a(a20),.b(b6),.out(r20c6));
    mac_unit u20_7(.clk(clk),.reset(reset),.a(a20),.b(b7),.out(r20c7));
    mac_unit u20_8(.clk(clk),.reset(reset),.a(a20),.b(b8),.out(r20c8));
    mac_unit u20_9(.clk(clk),.reset(reset),.a(a20),.b(b9),.out(r20c9));
    mac_unit u20_10(.clk(clk),.reset(reset),.a(a20),.b(b10),.out(r20c10));
    mac_unit u20_11(.clk(clk),.reset(reset),.a(a20),.b(b11),.out(r20c11));
    mac_unit u20_12(.clk(clk),.reset(reset),.a(a20),.b(b12),.out(r20c12));
    mac_unit u20_13(.clk(clk),.reset(reset),.a(a20),.b(b13),.out(r20c13));
    mac_unit u20_14(.clk(clk),.reset(reset),.a(a20),.b(b14),.out(r20c14));
    mac_unit u20_15(.clk(clk),.reset(reset),.a(a20),.b(b15),.out(r20c15));
    mac_unit u20_16(.clk(clk),.reset(reset),.a(a20),.b(b16),.out(r20c16));
    mac_unit u20_17(.clk(clk),.reset(reset),.a(a20),.b(b17),.out(r20c17));
    mac_unit u20_18(.clk(clk),.reset(reset),.a(a20),.b(b18),.out(r20c18));
    mac_unit u20_19(.clk(clk),.reset(reset),.a(a20),.b(b19),.out(r20c19));
    mac_unit u20_20(.clk(clk),.reset(reset),.a(a20),.b(b20),.out(r20c20));
    mac_unit u20_21(.clk(clk),.reset(reset),.a(a20),.b(b21),.out(r20c21));
    mac_unit u20_22(.clk(clk),.reset(reset),.a(a20),.b(b22),.out(r20c22));
    mac_unit u20_23(.clk(clk),.reset(reset),.a(a20),.b(b23),.out(r20c23));
    mac_unit u20_24(.clk(clk),.reset(reset),.a(a20),.b(b24),.out(r20c24));
    mac_unit u20_25(.clk(clk),.reset(reset),.a(a20),.b(b25),.out(r20c25));
    mac_unit u20_26(.clk(clk),.reset(reset),.a(a20),.b(b26),.out(r20c26));
    mac_unit u20_27(.clk(clk),.reset(reset),.a(a20),.b(b27),.out(r20c27));
    mac_unit u20_28(.clk(clk),.reset(reset),.a(a20),.b(b28),.out(r20c28));
    mac_unit u20_29(.clk(clk),.reset(reset),.a(a20),.b(b29),.out(r20c29));
    mac_unit u20_30(.clk(clk),.reset(reset),.a(a20),.b(b30),.out(r20c30));
    mac_unit u20_31(.clk(clk),.reset(reset),.a(a20),.b(b31),.out(r20c31));

    // Row 21
    mac_unit u21_0(.clk(clk),.reset(reset),.a(a21),.b(b0),.out(r21c0));
    mac_unit u21_1(.clk(clk),.reset(reset),.a(a21),.b(b1),.out(r21c1));
    mac_unit u21_2(.clk(clk),.reset(reset),.a(a21),.b(b2),.out(r21c2));
    mac_unit u21_3(.clk(clk),.reset(reset),.a(a21),.b(b3),.out(r21c3));
    mac_unit u21_4(.clk(clk),.reset(reset),.a(a21),.b(b4),.out(r21c4));
    mac_unit u21_5(.clk(clk),.reset(reset),.a(a21),.b(b5),.out(r21c5));
    mac_unit u21_6(.clk(clk),.reset(reset),.a(a21),.b(b6),.out(r21c6));
    mac_unit u21_7(.clk(clk),.reset(reset),.a(a21),.b(b7),.out(r21c7));
    mac_unit u21_8(.clk(clk),.reset(reset),.a(a21),.b(b8),.out(r21c8));
    mac_unit u21_9(.clk(clk),.reset(reset),.a(a21),.b(b9),.out(r21c9));
    mac_unit u21_10(.clk(clk),.reset(reset),.a(a21),.b(b10),.out(r21c10));
    mac_unit u21_11(.clk(clk),.reset(reset),.a(a21),.b(b11),.out(r21c11));
    mac_unit u21_12(.clk(clk),.reset(reset),.a(a21),.b(b12),.out(r21c12));
    mac_unit u21_13(.clk(clk),.reset(reset),.a(a21),.b(b13),.out(r21c13));
    mac_unit u21_14(.clk(clk),.reset(reset),.a(a21),.b(b14),.out(r21c14));
    mac_unit u21_15(.clk(clk),.reset(reset),.a(a21),.b(b15),.out(r21c15));
    mac_unit u21_16(.clk(clk),.reset(reset),.a(a21),.b(b16),.out(r21c16));
    mac_unit u21_17(.clk(clk),.reset(reset),.a(a21),.b(b17),.out(r21c17));
    mac_unit u21_18(.clk(clk),.reset(reset),.a(a21),.b(b18),.out(r21c18));
    mac_unit u21_19(.clk(clk),.reset(reset),.a(a21),.b(b19),.out(r21c19));
    mac_unit u21_20(.clk(clk),.reset(reset),.a(a21),.b(b20),.out(r21c20));
    mac_unit u21_21(.clk(clk),.reset(reset),.a(a21),.b(b21),.out(r21c21));
    mac_unit u21_22(.clk(clk),.reset(reset),.a(a21),.b(b22),.out(r21c22));
    mac_unit u21_23(.clk(clk),.reset(reset),.a(a21),.b(b23),.out(r21c23));
    mac_unit u21_24(.clk(clk),.reset(reset),.a(a21),.b(b24),.out(r21c24));
    mac_unit u21_25(.clk(clk),.reset(reset),.a(a21),.b(b25),.out(r21c25));
    mac_unit u21_26(.clk(clk),.reset(reset),.a(a21),.b(b26),.out(r21c26));
    mac_unit u21_27(.clk(clk),.reset(reset),.a(a21),.b(b27),.out(r21c27));
    mac_unit u21_28(.clk(clk),.reset(reset),.a(a21),.b(b28),.out(r21c28));
    mac_unit u21_29(.clk(clk),.reset(reset),.a(a21),.b(b29),.out(r21c29));
    mac_unit u21_30(.clk(clk),.reset(reset),.a(a21),.b(b30),.out(r21c30));
    mac_unit u21_31(.clk(clk),.reset(reset),.a(a21),.b(b31),.out(r21c31));

    // Row 22
    mac_unit u22_0(.clk(clk),.reset(reset),.a(a22),.b(b0),.out(r22c0));
    mac_unit u22_1(.clk(clk),.reset(reset),.a(a22),.b(b1),.out(r22c1));
    mac_unit u22_2(.clk(clk),.reset(reset),.a(a22),.b(b2),.out(r22c2));
    mac_unit u22_3(.clk(clk),.reset(reset),.a(a22),.b(b3),.out(r22c3));
    mac_unit u22_4(.clk(clk),.reset(reset),.a(a22),.b(b4),.out(r22c4));
    mac_unit u22_5(.clk(clk),.reset(reset),.a(a22),.b(b5),.out(r22c5));
    mac_unit u22_6(.clk(clk),.reset(reset),.a(a22),.b(b6),.out(r22c6));
    mac_unit u22_7(.clk(clk),.reset(reset),.a(a22),.b(b7),.out(r22c7));
    mac_unit u22_8(.clk(clk),.reset(reset),.a(a22),.b(b8),.out(r22c8));
    mac_unit u22_9(.clk(clk),.reset(reset),.a(a22),.b(b9),.out(r22c9));
    mac_unit u22_10(.clk(clk),.reset(reset),.a(a22),.b(b10),.out(r22c10));
    mac_unit u22_11(.clk(clk),.reset(reset),.a(a22),.b(b11),.out(r22c11));
    mac_unit u22_12(.clk(clk),.reset(reset),.a(a22),.b(b12),.out(r22c12));
    mac_unit u22_13(.clk(clk),.reset(reset),.a(a22),.b(b13),.out(r22c13));
    mac_unit u22_14(.clk(clk),.reset(reset),.a(a22),.b(b14),.out(r22c14));
    mac_unit u22_15(.clk(clk),.reset(reset),.a(a22),.b(b15),.out(r22c15));
    mac_unit u22_16(.clk(clk),.reset(reset),.a(a22),.b(b16),.out(r22c16));
    mac_unit u22_17(.clk(clk),.reset(reset),.a(a22),.b(b17),.out(r22c17));
    mac_unit u22_18(.clk(clk),.reset(reset),.a(a22),.b(b18),.out(r22c18));
    mac_unit u22_19(.clk(clk),.reset(reset),.a(a22),.b(b19),.out(r22c19));
    mac_unit u22_20(.clk(clk),.reset(reset),.a(a22),.b(b20),.out(r22c20));
    mac_unit u22_21(.clk(clk),.reset(reset),.a(a22),.b(b21),.out(r22c21));
    mac_unit u22_22(.clk(clk),.reset(reset),.a(a22),.b(b22),.out(r22c22));
    mac_unit u22_23(.clk(clk),.reset(reset),.a(a22),.b(b23),.out(r22c23));
    mac_unit u22_24(.clk(clk),.reset(reset),.a(a22),.b(b24),.out(r22c24));
    mac_unit u22_25(.clk(clk),.reset(reset),.a(a22),.b(b25),.out(r22c25));
    mac_unit u22_26(.clk(clk),.reset(reset),.a(a22),.b(b26),.out(r22c26));
    mac_unit u22_27(.clk(clk),.reset(reset),.a(a22),.b(b27),.out(r22c27));
    mac_unit u22_28(.clk(clk),.reset(reset),.a(a22),.b(b28),.out(r22c28));
    mac_unit u22_29(.clk(clk),.reset(reset),.a(a22),.b(b29),.out(r22c29));
    mac_unit u22_30(.clk(clk),.reset(reset),.a(a22),.b(b30),.out(r22c30));
    mac_unit u22_31(.clk(clk),.reset(reset),.a(a22),.b(b31),.out(r22c31));

    // Row 23
    mac_unit u23_0(.clk(clk),.reset(reset),.a(a23),.b(b0),.out(r23c0));
    mac_unit u23_1(.clk(clk),.reset(reset),.a(a23),.b(b1),.out(r23c1));
    mac_unit u23_2(.clk(clk),.reset(reset),.a(a23),.b(b2),.out(r23c2));
    mac_unit u23_3(.clk(clk),.reset(reset),.a(a23),.b(b3),.out(r23c3));
    mac_unit u23_4(.clk(clk),.reset(reset),.a(a23),.b(b4),.out(r23c4));
    mac_unit u23_5(.clk(clk),.reset(reset),.a(a23),.b(b5),.out(r23c5));
    mac_unit u23_6(.clk(clk),.reset(reset),.a(a23),.b(b6),.out(r23c6));
    mac_unit u23_7(.clk(clk),.reset(reset),.a(a23),.b(b7),.out(r23c7));
    mac_unit u23_8(.clk(clk),.reset(reset),.a(a23),.b(b8),.out(r23c8));
    mac_unit u23_9(.clk(clk),.reset(reset),.a(a23),.b(b9),.out(r23c9));
    mac_unit u23_10(.clk(clk),.reset(reset),.a(a23),.b(b10),.out(r23c10));
    mac_unit u23_11(.clk(clk),.reset(reset),.a(a23),.b(b11),.out(r23c11));
    mac_unit u23_12(.clk(clk),.reset(reset),.a(a23),.b(b12),.out(r23c12));
    mac_unit u23_13(.clk(clk),.reset(reset),.a(a23),.b(b13),.out(r23c13));
    mac_unit u23_14(.clk(clk),.reset(reset),.a(a23),.b(b14),.out(r23c14));
    mac_unit u23_15(.clk(clk),.reset(reset),.a(a23),.b(b15),.out(r23c15));
    mac_unit u23_16(.clk(clk),.reset(reset),.a(a23),.b(b16),.out(r23c16));
    mac_unit u23_17(.clk(clk),.reset(reset),.a(a23),.b(b17),.out(r23c17));
    mac_unit u23_18(.clk(clk),.reset(reset),.a(a23),.b(b18),.out(r23c18));
    mac_unit u23_19(.clk(clk),.reset(reset),.a(a23),.b(b19),.out(r23c19));
    mac_unit u23_20(.clk(clk),.reset(reset),.a(a23),.b(b20),.out(r23c20));
    mac_unit u23_21(.clk(clk),.reset(reset),.a(a23),.b(b21),.out(r23c21));
    mac_unit u23_22(.clk(clk),.reset(reset),.a(a23),.b(b22),.out(r23c22));
    mac_unit u23_23(.clk(clk),.reset(reset),.a(a23),.b(b23),.out(r23c23));
    mac_unit u23_24(.clk(clk),.reset(reset),.a(a23),.b(b24),.out(r23c24));
    mac_unit u23_25(.clk(clk),.reset(reset),.a(a23),.b(b25),.out(r23c25));
    mac_unit u23_26(.clk(clk),.reset(reset),.a(a23),.b(b26),.out(r23c26));
    mac_unit u23_27(.clk(clk),.reset(reset),.a(a23),.b(b27),.out(r23c27));
    mac_unit u23_28(.clk(clk),.reset(reset),.a(a23),.b(b28),.out(r23c28));
    mac_unit u23_29(.clk(clk),.reset(reset),.a(a23),.b(b29),.out(r23c29));
    mac_unit u23_30(.clk(clk),.reset(reset),.a(a23),.b(b30),.out(r23c30));
    mac_unit u23_31(.clk(clk),.reset(reset),.a(a23),.b(b31),.out(r23c31));

    // Row 24
    mac_unit u24_0(.clk(clk),.reset(reset),.a(a24),.b(b0),.out(r24c0));
    mac_unit u24_1(.clk(clk),.reset(reset),.a(a24),.b(b1),.out(r24c1));
    mac_unit u24_2(.clk(clk),.reset(reset),.a(a24),.b(b2),.out(r24c2));
    mac_unit u24_3(.clk(clk),.reset(reset),.a(a24),.b(b3),.out(r24c3));
    mac_unit u24_4(.clk(clk),.reset(reset),.a(a24),.b(b4),.out(r24c4));
    mac_unit u24_5(.clk(clk),.reset(reset),.a(a24),.b(b5),.out(r24c5));
    mac_unit u24_6(.clk(clk),.reset(reset),.a(a24),.b(b6),.out(r24c6));
    mac_unit u24_7(.clk(clk),.reset(reset),.a(a24),.b(b7),.out(r24c7));
    mac_unit u24_8(.clk(clk),.reset(reset),.a(a24),.b(b8),.out(r24c8));
    mac_unit u24_9(.clk(clk),.reset(reset),.a(a24),.b(b9),.out(r24c9));
    mac_unit u24_10(.clk(clk),.reset(reset),.a(a24),.b(b10),.out(r24c10));
    mac_unit u24_11(.clk(clk),.reset(reset),.a(a24),.b(b11),.out(r24c11));
    mac_unit u24_12(.clk(clk),.reset(reset),.a(a24),.b(b12),.out(r24c12));
    mac_unit u24_13(.clk(clk),.reset(reset),.a(a24),.b(b13),.out(r24c13));
    mac_unit u24_14(.clk(clk),.reset(reset),.a(a24),.b(b14),.out(r24c14));
    mac_unit u24_15(.clk(clk),.reset(reset),.a(a24),.b(b15),.out(r24c15));
    mac_unit u24_16(.clk(clk),.reset(reset),.a(a24),.b(b16),.out(r24c16));
    mac_unit u24_17(.clk(clk),.reset(reset),.a(a24),.b(b17),.out(r24c17));
    mac_unit u24_18(.clk(clk),.reset(reset),.a(a24),.b(b18),.out(r24c18));
    mac_unit u24_19(.clk(clk),.reset(reset),.a(a24),.b(b19),.out(r24c19));
    mac_unit u24_20(.clk(clk),.reset(reset),.a(a24),.b(b20),.out(r24c20));
    mac_unit u24_21(.clk(clk),.reset(reset),.a(a24),.b(b21),.out(r24c21));
    mac_unit u24_22(.clk(clk),.reset(reset),.a(a24),.b(b22),.out(r24c22));
    mac_unit u24_23(.clk(clk),.reset(reset),.a(a24),.b(b23),.out(r24c23));
    mac_unit u24_24(.clk(clk),.reset(reset),.a(a24),.b(b24),.out(r24c24));
    mac_unit u24_25(.clk(clk),.reset(reset),.a(a24),.b(b25),.out(r24c25));
    mac_unit u24_26(.clk(clk),.reset(reset),.a(a24),.b(b26),.out(r24c26));
    mac_unit u24_27(.clk(clk),.reset(reset),.a(a24),.b(b27),.out(r24c27));
    mac_unit u24_28(.clk(clk),.reset(reset),.a(a24),.b(b28),.out(r24c28));
    mac_unit u24_29(.clk(clk),.reset(reset),.a(a24),.b(b29),.out(r24c29));
    mac_unit u24_30(.clk(clk),.reset(reset),.a(a24),.b(b30),.out(r24c30));
    mac_unit u24_31(.clk(clk),.reset(reset),.a(a24),.b(b31),.out(r24c31));

    // Row 25
    mac_unit u25_0(.clk(clk),.reset(reset),.a(a25),.b(b0),.out(r25c0));
    mac_unit u25_1(.clk(clk),.reset(reset),.a(a25),.b(b1),.out(r25c1));
    mac_unit u25_2(.clk(clk),.reset(reset),.a(a25),.b(b2),.out(r25c2));
    mac_unit u25_3(.clk(clk),.reset(reset),.a(a25),.b(b3),.out(r25c3));
    mac_unit u25_4(.clk(clk),.reset(reset),.a(a25),.b(b4),.out(r25c4));
    mac_unit u25_5(.clk(clk),.reset(reset),.a(a25),.b(b5),.out(r25c5));
    mac_unit u25_6(.clk(clk),.reset(reset),.a(a25),.b(b6),.out(r25c6));
    mac_unit u25_7(.clk(clk),.reset(reset),.a(a25),.b(b7),.out(r25c7));
    mac_unit u25_8(.clk(clk),.reset(reset),.a(a25),.b(b8),.out(r25c8));
    mac_unit u25_9(.clk(clk),.reset(reset),.a(a25),.b(b9),.out(r25c9));
    mac_unit u25_10(.clk(clk),.reset(reset),.a(a25),.b(b10),.out(r25c10));
    mac_unit u25_11(.clk(clk),.reset(reset),.a(a25),.b(b11),.out(r25c11));
    mac_unit u25_12(.clk(clk),.reset(reset),.a(a25),.b(b12),.out(r25c12));
    mac_unit u25_13(.clk(clk),.reset(reset),.a(a25),.b(b13),.out(r25c13));
    mac_unit u25_14(.clk(clk),.reset(reset),.a(a25),.b(b14),.out(r25c14));
    mac_unit u25_15(.clk(clk),.reset(reset),.a(a25),.b(b15),.out(r25c15));
    mac_unit u25_16(.clk(clk),.reset(reset),.a(a25),.b(b16),.out(r25c16));
    mac_unit u25_17(.clk(clk),.reset(reset),.a(a25),.b(b17),.out(r25c17));
    mac_unit u25_18(.clk(clk),.reset(reset),.a(a25),.b(b18),.out(r25c18));
    mac_unit u25_19(.clk(clk),.reset(reset),.a(a25),.b(b19),.out(r25c19));
    mac_unit u25_20(.clk(clk),.reset(reset),.a(a25),.b(b20),.out(r25c20));
    mac_unit u25_21(.clk(clk),.reset(reset),.a(a25),.b(b21),.out(r25c21));
    mac_unit u25_22(.clk(clk),.reset(reset),.a(a25),.b(b22),.out(r25c22));
    mac_unit u25_23(.clk(clk),.reset(reset),.a(a25),.b(b23),.out(r25c23));
    mac_unit u25_24(.clk(clk),.reset(reset),.a(a25),.b(b24),.out(r25c24));
    mac_unit u25_25(.clk(clk),.reset(reset),.a(a25),.b(b25),.out(r25c25));
    mac_unit u25_26(.clk(clk),.reset(reset),.a(a25),.b(b26),.out(r25c26));
    mac_unit u25_27(.clk(clk),.reset(reset),.a(a25),.b(b27),.out(r25c27));
    mac_unit u25_28(.clk(clk),.reset(reset),.a(a25),.b(b28),.out(r25c28));
    mac_unit u25_29(.clk(clk),.reset(reset),.a(a25),.b(b29),.out(r25c29));
    mac_unit u25_30(.clk(clk),.reset(reset),.a(a25),.b(b30),.out(r25c30));
    mac_unit u25_31(.clk(clk),.reset(reset),.a(a25),.b(b31),.out(r25c31));

    // Row 26
    mac_unit u26_0(.clk(clk),.reset(reset),.a(a26),.b(b0),.out(r26c0));
    mac_unit u26_1(.clk(clk),.reset(reset),.a(a26),.b(b1),.out(r26c1));
    mac_unit u26_2(.clk(clk),.reset(reset),.a(a26),.b(b2),.out(r26c2));
    mac_unit u26_3(.clk(clk),.reset(reset),.a(a26),.b(b3),.out(r26c3));
    mac_unit u26_4(.clk(clk),.reset(reset),.a(a26),.b(b4),.out(r26c4));
    mac_unit u26_5(.clk(clk),.reset(reset),.a(a26),.b(b5),.out(r26c5));
    mac_unit u26_6(.clk(clk),.reset(reset),.a(a26),.b(b6),.out(r26c6));
    mac_unit u26_7(.clk(clk),.reset(reset),.a(a26),.b(b7),.out(r26c7));
    mac_unit u26_8(.clk(clk),.reset(reset),.a(a26),.b(b8),.out(r26c8));
    mac_unit u26_9(.clk(clk),.reset(reset),.a(a26),.b(b9),.out(r26c9));
    mac_unit u26_10(.clk(clk),.reset(reset),.a(a26),.b(b10),.out(r26c10));
    mac_unit u26_11(.clk(clk),.reset(reset),.a(a26),.b(b11),.out(r26c11));
    mac_unit u26_12(.clk(clk),.reset(reset),.a(a26),.b(b12),.out(r26c12));
    mac_unit u26_13(.clk(clk),.reset(reset),.a(a26),.b(b13),.out(r26c13));
    mac_unit u26_14(.clk(clk),.reset(reset),.a(a26),.b(b14),.out(r26c14));
    mac_unit u26_15(.clk(clk),.reset(reset),.a(a26),.b(b15),.out(r26c15));
    mac_unit u26_16(.clk(clk),.reset(reset),.a(a26),.b(b16),.out(r26c16));
    mac_unit u26_17(.clk(clk),.reset(reset),.a(a26),.b(b17),.out(r26c17));
    mac_unit u26_18(.clk(clk),.reset(reset),.a(a26),.b(b18),.out(r26c18));
    mac_unit u26_19(.clk(clk),.reset(reset),.a(a26),.b(b19),.out(r26c19));
    mac_unit u26_20(.clk(clk),.reset(reset),.a(a26),.b(b20),.out(r26c20));
    mac_unit u26_21(.clk(clk),.reset(reset),.a(a26),.b(b21),.out(r26c21));
    mac_unit u26_22(.clk(clk),.reset(reset),.a(a26),.b(b22),.out(r26c22));
    mac_unit u26_23(.clk(clk),.reset(reset),.a(a26),.b(b23),.out(r26c23));
    mac_unit u26_24(.clk(clk),.reset(reset),.a(a26),.b(b24),.out(r26c24));
    mac_unit u26_25(.clk(clk),.reset(reset),.a(a26),.b(b25),.out(r26c25));
    mac_unit u26_26(.clk(clk),.reset(reset),.a(a26),.b(b26),.out(r26c26));
    mac_unit u26_27(.clk(clk),.reset(reset),.a(a26),.b(b27),.out(r26c27));
    mac_unit u26_28(.clk(clk),.reset(reset),.a(a26),.b(b28),.out(r26c28));
    mac_unit u26_29(.clk(clk),.reset(reset),.a(a26),.b(b29),.out(r26c29));
    mac_unit u26_30(.clk(clk),.reset(reset),.a(a26),.b(b30),.out(r26c30));
    mac_unit u26_31(.clk(clk),.reset(reset),.a(a26),.b(b31),.out(r26c31));

    // Row 27
    mac_unit u27_0(.clk(clk),.reset(reset),.a(a27),.b(b0),.out(r27c0));
    mac_unit u27_1(.clk(clk),.reset(reset),.a(a27),.b(b1),.out(r27c1));
    mac_unit u27_2(.clk(clk),.reset(reset),.a(a27),.b(b2),.out(r27c2));
    mac_unit u27_3(.clk(clk),.reset(reset),.a(a27),.b(b3),.out(r27c3));
    mac_unit u27_4(.clk(clk),.reset(reset),.a(a27),.b(b4),.out(r27c4));
    mac_unit u27_5(.clk(clk),.reset(reset),.a(a27),.b(b5),.out(r27c5));
    mac_unit u27_6(.clk(clk),.reset(reset),.a(a27),.b(b6),.out(r27c6));
    mac_unit u27_7(.clk(clk),.reset(reset),.a(a27),.b(b7),.out(r27c7));
    mac_unit u27_8(.clk(clk),.reset(reset),.a(a27),.b(b8),.out(r27c8));
    mac_unit u27_9(.clk(clk),.reset(reset),.a(a27),.b(b9),.out(r27c9));
    mac_unit u27_10(.clk(clk),.reset(reset),.a(a27),.b(b10),.out(r27c10));
    mac_unit u27_11(.clk(clk),.reset(reset),.a(a27),.b(b11),.out(r27c11));
    mac_unit u27_12(.clk(clk),.reset(reset),.a(a27),.b(b12),.out(r27c12));
    mac_unit u27_13(.clk(clk),.reset(reset),.a(a27),.b(b13),.out(r27c13));
    mac_unit u27_14(.clk(clk),.reset(reset),.a(a27),.b(b14),.out(r27c14));
    mac_unit u27_15(.clk(clk),.reset(reset),.a(a27),.b(b15),.out(r27c15));
    mac_unit u27_16(.clk(clk),.reset(reset),.a(a27),.b(b16),.out(r27c16));
    mac_unit u27_17(.clk(clk),.reset(reset),.a(a27),.b(b17),.out(r27c17));
    mac_unit u27_18(.clk(clk),.reset(reset),.a(a27),.b(b18),.out(r27c18));
    mac_unit u27_19(.clk(clk),.reset(reset),.a(a27),.b(b19),.out(r27c19));
    mac_unit u27_20(.clk(clk),.reset(reset),.a(a27),.b(b20),.out(r27c20));
    mac_unit u27_21(.clk(clk),.reset(reset),.a(a27),.b(b21),.out(r27c21));
    mac_unit u27_22(.clk(clk),.reset(reset),.a(a27),.b(b22),.out(r27c22));
    mac_unit u27_23(.clk(clk),.reset(reset),.a(a27),.b(b23),.out(r27c23));
    mac_unit u27_24(.clk(clk),.reset(reset),.a(a27),.b(b24),.out(r27c24));
    mac_unit u27_25(.clk(clk),.reset(reset),.a(a27),.b(b25),.out(r27c25));
    mac_unit u27_26(.clk(clk),.reset(reset),.a(a27),.b(b26),.out(r27c26));
    mac_unit u27_27(.clk(clk),.reset(reset),.a(a27),.b(b27),.out(r27c27));
    mac_unit u27_28(.clk(clk),.reset(reset),.a(a27),.b(b28),.out(r27c28));
    mac_unit u27_29(.clk(clk),.reset(reset),.a(a27),.b(b29),.out(r27c29));
    mac_unit u27_30(.clk(clk),.reset(reset),.a(a27),.b(b30),.out(r27c30));
    mac_unit u27_31(.clk(clk),.reset(reset),.a(a27),.b(b31),.out(r27c31));

    // Row 28
    mac_unit u28_0(.clk(clk),.reset(reset),.a(a28),.b(b0),.out(r28c0));
    mac_unit u28_1(.clk(clk),.reset(reset),.a(a28),.b(b1),.out(r28c1));
    mac_unit u28_2(.clk(clk),.reset(reset),.a(a28),.b(b2),.out(r28c2));
    mac_unit u28_3(.clk(clk),.reset(reset),.a(a28),.b(b3),.out(r28c3));
    mac_unit u28_4(.clk(clk),.reset(reset),.a(a28),.b(b4),.out(r28c4));
    mac_unit u28_5(.clk(clk),.reset(reset),.a(a28),.b(b5),.out(r28c5));
    mac_unit u28_6(.clk(clk),.reset(reset),.a(a28),.b(b6),.out(r28c6));
    mac_unit u28_7(.clk(clk),.reset(reset),.a(a28),.b(b7),.out(r28c7));
    mac_unit u28_8(.clk(clk),.reset(reset),.a(a28),.b(b8),.out(r28c8));
    mac_unit u28_9(.clk(clk),.reset(reset),.a(a28),.b(b9),.out(r28c9));
    mac_unit u28_10(.clk(clk),.reset(reset),.a(a28),.b(b10),.out(r28c10));
    mac_unit u28_11(.clk(clk),.reset(reset),.a(a28),.b(b11),.out(r28c11));
    mac_unit u28_12(.clk(clk),.reset(reset),.a(a28),.b(b12),.out(r28c12));
    mac_unit u28_13(.clk(clk),.reset(reset),.a(a28),.b(b13),.out(r28c13));
    mac_unit u28_14(.clk(clk),.reset(reset),.a(a28),.b(b14),.out(r28c14));
    mac_unit u28_15(.clk(clk),.reset(reset),.a(a28),.b(b15),.out(r28c15));
    mac_unit u28_16(.clk(clk),.reset(reset),.a(a28),.b(b16),.out(r28c16));
    mac_unit u28_17(.clk(clk),.reset(reset),.a(a28),.b(b17),.out(r28c17));
    mac_unit u28_18(.clk(clk),.reset(reset),.a(a28),.b(b18),.out(r28c18));
    mac_unit u28_19(.clk(clk),.reset(reset),.a(a28),.b(b19),.out(r28c19));
    mac_unit u28_20(.clk(clk),.reset(reset),.a(a28),.b(b20),.out(r28c20));
    mac_unit u28_21(.clk(clk),.reset(reset),.a(a28),.b(b21),.out(r28c21));
    mac_unit u28_22(.clk(clk),.reset(reset),.a(a28),.b(b22),.out(r28c22));
    mac_unit u28_23(.clk(clk),.reset(reset),.a(a28),.b(b23),.out(r28c23));
    mac_unit u28_24(.clk(clk),.reset(reset),.a(a28),.b(b24),.out(r28c24));
    mac_unit u28_25(.clk(clk),.reset(reset),.a(a28),.b(b25),.out(r28c25));
    mac_unit u28_26(.clk(clk),.reset(reset),.a(a28),.b(b26),.out(r28c26));
    mac_unit u28_27(.clk(clk),.reset(reset),.a(a28),.b(b27),.out(r28c27));
    mac_unit u28_28(.clk(clk),.reset(reset),.a(a28),.b(b28),.out(r28c28));
    mac_unit u28_29(.clk(clk),.reset(reset),.a(a28),.b(b29),.out(r28c29));
    mac_unit u28_30(.clk(clk),.reset(reset),.a(a28),.b(b30),.out(r28c30));
    mac_unit u28_31(.clk(clk),.reset(reset),.a(a28),.b(b31),.out(r28c31));

    // Row 29
    mac_unit u29_0(.clk(clk),.reset(reset),.a(a29),.b(b0),.out(r29c0));
    mac_unit u29_1(.clk(clk),.reset(reset),.a(a29),.b(b1),.out(r29c1));
    mac_unit u29_2(.clk(clk),.reset(reset),.a(a29),.b(b2),.out(r29c2));
    mac_unit u29_3(.clk(clk),.reset(reset),.a(a29),.b(b3),.out(r29c3));
    mac_unit u29_4(.clk(clk),.reset(reset),.a(a29),.b(b4),.out(r29c4));
    mac_unit u29_5(.clk(clk),.reset(reset),.a(a29),.b(b5),.out(r29c5));
    mac_unit u29_6(.clk(clk),.reset(reset),.a(a29),.b(b6),.out(r29c6));
    mac_unit u29_7(.clk(clk),.reset(reset),.a(a29),.b(b7),.out(r29c7));
    mac_unit u29_8(.clk(clk),.reset(reset),.a(a29),.b(b8),.out(r29c8));
    mac_unit u29_9(.clk(clk),.reset(reset),.a(a29),.b(b9),.out(r29c9));
    mac_unit u29_10(.clk(clk),.reset(reset),.a(a29),.b(b10),.out(r29c10));
    mac_unit u29_11(.clk(clk),.reset(reset),.a(a29),.b(b11),.out(r29c11));
    mac_unit u29_12(.clk(clk),.reset(reset),.a(a29),.b(b12),.out(r29c12));
    mac_unit u29_13(.clk(clk),.reset(reset),.a(a29),.b(b13),.out(r29c13));
    mac_unit u29_14(.clk(clk),.reset(reset),.a(a29),.b(b14),.out(r29c14));
    mac_unit u29_15(.clk(clk),.reset(reset),.a(a29),.b(b15),.out(r29c15));
    mac_unit u29_16(.clk(clk),.reset(reset),.a(a29),.b(b16),.out(r29c16));
    mac_unit u29_17(.clk(clk),.reset(reset),.a(a29),.b(b17),.out(r29c17));
    mac_unit u29_18(.clk(clk),.reset(reset),.a(a29),.b(b18),.out(r29c18));
    mac_unit u29_19(.clk(clk),.reset(reset),.a(a29),.b(b19),.out(r29c19));
    mac_unit u29_20(.clk(clk),.reset(reset),.a(a29),.b(b20),.out(r29c20));
    mac_unit u29_21(.clk(clk),.reset(reset),.a(a29),.b(b21),.out(r29c21));
    mac_unit u29_22(.clk(clk),.reset(reset),.a(a29),.b(b22),.out(r29c22));
    mac_unit u29_23(.clk(clk),.reset(reset),.a(a29),.b(b23),.out(r29c23));
    mac_unit u29_24(.clk(clk),.reset(reset),.a(a29),.b(b24),.out(r29c24));
    mac_unit u29_25(.clk(clk),.reset(reset),.a(a29),.b(b25),.out(r29c25));
    mac_unit u29_26(.clk(clk),.reset(reset),.a(a29),.b(b26),.out(r29c26));
    mac_unit u29_27(.clk(clk),.reset(reset),.a(a29),.b(b27),.out(r29c27));
    mac_unit u29_28(.clk(clk),.reset(reset),.a(a29),.b(b28),.out(r29c28));
    mac_unit u29_29(.clk(clk),.reset(reset),.a(a29),.b(b29),.out(r29c29));
    mac_unit u29_30(.clk(clk),.reset(reset),.a(a29),.b(b30),.out(r29c30));
    mac_unit u29_31(.clk(clk),.reset(reset),.a(a29),.b(b31),.out(r29c31));

    // Row 30
    mac_unit u30_0(.clk(clk),.reset(reset),.a(a30),.b(b0),.out(r30c0));
    mac_unit u30_1(.clk(clk),.reset(reset),.a(a30),.b(b1),.out(r30c1));
    mac_unit u30_2(.clk(clk),.reset(reset),.a(a30),.b(b2),.out(r30c2));
    mac_unit u30_3(.clk(clk),.reset(reset),.a(a30),.b(b3),.out(r30c3));
    mac_unit u30_4(.clk(clk),.reset(reset),.a(a30),.b(b4),.out(r30c4));
    mac_unit u30_5(.clk(clk),.reset(reset),.a(a30),.b(b5),.out(r30c5));
    mac_unit u30_6(.clk(clk),.reset(reset),.a(a30),.b(b6),.out(r30c6));
    mac_unit u30_7(.clk(clk),.reset(reset),.a(a30),.b(b7),.out(r30c7));
    mac_unit u30_8(.clk(clk),.reset(reset),.a(a30),.b(b8),.out(r30c8));
    mac_unit u30_9(.clk(clk),.reset(reset),.a(a30),.b(b9),.out(r30c9));
    mac_unit u30_10(.clk(clk),.reset(reset),.a(a30),.b(b10),.out(r30c10));
    mac_unit u30_11(.clk(clk),.reset(reset),.a(a30),.b(b11),.out(r30c11));
    mac_unit u30_12(.clk(clk),.reset(reset),.a(a30),.b(b12),.out(r30c12));
    mac_unit u30_13(.clk(clk),.reset(reset),.a(a30),.b(b13),.out(r30c13));
    mac_unit u30_14(.clk(clk),.reset(reset),.a(a30),.b(b14),.out(r30c14));
    mac_unit u30_15(.clk(clk),.reset(reset),.a(a30),.b(b15),.out(r30c15));
    mac_unit u30_16(.clk(clk),.reset(reset),.a(a30),.b(b16),.out(r30c16));
    mac_unit u30_17(.clk(clk),.reset(reset),.a(a30),.b(b17),.out(r30c17));
    mac_unit u30_18(.clk(clk),.reset(reset),.a(a30),.b(b18),.out(r30c18));
    mac_unit u30_19(.clk(clk),.reset(reset),.a(a30),.b(b19),.out(r30c19));
    mac_unit u30_20(.clk(clk),.reset(reset),.a(a30),.b(b20),.out(r30c20));
    mac_unit u30_21(.clk(clk),.reset(reset),.a(a30),.b(b21),.out(r30c21));
    mac_unit u30_22(.clk(clk),.reset(reset),.a(a30),.b(b22),.out(r30c22));
    mac_unit u30_23(.clk(clk),.reset(reset),.a(a30),.b(b23),.out(r30c23));
    mac_unit u30_24(.clk(clk),.reset(reset),.a(a30),.b(b24),.out(r30c24));
    mac_unit u30_25(.clk(clk),.reset(reset),.a(a30),.b(b25),.out(r30c25));
    mac_unit u30_26(.clk(clk),.reset(reset),.a(a30),.b(b26),.out(r30c26));
    mac_unit u30_27(.clk(clk),.reset(reset),.a(a30),.b(b27),.out(r30c27));
    mac_unit u30_28(.clk(clk),.reset(reset),.a(a30),.b(b28),.out(r30c28));
    mac_unit u30_29(.clk(clk),.reset(reset),.a(a30),.b(b29),.out(r30c29));
    mac_unit u30_30(.clk(clk),.reset(reset),.a(a30),.b(b30),.out(r30c30));
    mac_unit u30_31(.clk(clk),.reset(reset),.a(a30),.b(b31),.out(r30c31));

    // Row 31
    mac_unit u31_0(.clk(clk),.reset(reset),.a(a31),.b(b0),.out(r31c0));
    mac_unit u31_1(.clk(clk),.reset(reset),.a(a31),.b(b1),.out(r31c1));
    mac_unit u31_2(.clk(clk),.reset(reset),.a(a31),.b(b2),.out(r31c2));
    mac_unit u31_3(.clk(clk),.reset(reset),.a(a31),.b(b3),.out(r31c3));
    mac_unit u31_4(.clk(clk),.reset(reset),.a(a31),.b(b4),.out(r31c4));
    mac_unit u31_5(.clk(clk),.reset(reset),.a(a31),.b(b5),.out(r31c5));
    mac_unit u31_6(.clk(clk),.reset(reset),.a(a31),.b(b6),.out(r31c6));
    mac_unit u31_7(.clk(clk),.reset(reset),.a(a31),.b(b7),.out(r31c7));
    mac_unit u31_8(.clk(clk),.reset(reset),.a(a31),.b(b8),.out(r31c8));
    mac_unit u31_9(.clk(clk),.reset(reset),.a(a31),.b(b9),.out(r31c9));
    mac_unit u31_10(.clk(clk),.reset(reset),.a(a31),.b(b10),.out(r31c10));
    mac_unit u31_11(.clk(clk),.reset(reset),.a(a31),.b(b11),.out(r31c11));
    mac_unit u31_12(.clk(clk),.reset(reset),.a(a31),.b(b12),.out(r31c12));
    mac_unit u31_13(.clk(clk),.reset(reset),.a(a31),.b(b13),.out(r31c13));
    mac_unit u31_14(.clk(clk),.reset(reset),.a(a31),.b(b14),.out(r31c14));
    mac_unit u31_15(.clk(clk),.reset(reset),.a(a31),.b(b15),.out(r31c15));
    mac_unit u31_16(.clk(clk),.reset(reset),.a(a31),.b(b16),.out(r31c16));
    mac_unit u31_17(.clk(clk),.reset(reset),.a(a31),.b(b17),.out(r31c17));
    mac_unit u31_18(.clk(clk),.reset(reset),.a(a31),.b(b18),.out(r31c18));
    mac_unit u31_19(.clk(clk),.reset(reset),.a(a31),.b(b19),.out(r31c19));
    mac_unit u31_20(.clk(clk),.reset(reset),.a(a31),.b(b20),.out(r31c20));
    mac_unit u31_21(.clk(clk),.reset(reset),.a(a31),.b(b21),.out(r31c21));
    mac_unit u31_22(.clk(clk),.reset(reset),.a(a31),.b(b22),.out(r31c22));
    mac_unit u31_23(.clk(clk),.reset(reset),.a(a31),.b(b23),.out(r31c23));
    mac_unit u31_24(.clk(clk),.reset(reset),.a(a31),.b(b24),.out(r31c24));
    mac_unit u31_25(.clk(clk),.reset(reset),.a(a31),.b(b25),.out(r31c25));
    mac_unit u31_26(.clk(clk),.reset(reset),.a(a31),.b(b26),.out(r31c26));
    mac_unit u31_27(.clk(clk),.reset(reset),.a(a31),.b(b27),.out(r31c27));
    mac_unit u31_28(.clk(clk),.reset(reset),.a(a31),.b(b28),.out(r31c28));
    mac_unit u31_29(.clk(clk),.reset(reset),.a(a31),.b(b29),.out(r31c29));
    mac_unit u31_30(.clk(clk),.reset(reset),.a(a31),.b(b30),.out(r31c30));
    mac_unit u31_31(.clk(clk),.reset(reset),.a(a31),.b(b31),.out(r31c31));

endmodule
