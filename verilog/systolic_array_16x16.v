// ─────────────────────────────────────────
// HYPERION 16x16 SYSTOLIC ARRAY
// 256 MAC units running in parallel
// ─────────────────────────────────────────

module systolic_array_16x16 (
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
    output signed [15:0] r15c15
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

endmodule
