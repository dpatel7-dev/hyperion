// ─────────────────────────────────────────
// HYPERION REDUCTION UNIT
// Sums all 16 row outputs per column
// Converts 16×16 matrix → 16 vector
// This is what makes Hyperion a true
// inference engine
//
// Without this: out[col] = a0 × w[col]
// With this:    out[col] = Σ a[row] × w[col]
//
// Same operation as a real TPU output stage
// ─────────────────────────────────────────

module reduction_unit (
    input  clk,
    input  reset,
    input  enable,

    // 16 rows × 16 columns = 256 inputs
    input  signed [15:0] r0c0,r0c1,r0c2,r0c3,
    input  signed [15:0] r0c4,r0c5,r0c6,r0c7,
    input  signed [15:0] r0c8,r0c9,r0c10,r0c11,
    input  signed [15:0] r0c12,r0c13,r0c14,r0c15,

    input  signed [15:0] r1c0,r1c1,r1c2,r1c3,
    input  signed [15:0] r1c4,r1c5,r1c6,r1c7,
    input  signed [15:0] r1c8,r1c9,r1c10,r1c11,
    input  signed [15:0] r1c12,r1c13,r1c14,r1c15,

    input  signed [15:0] r2c0,r2c1,r2c2,r2c3,
    input  signed [15:0] r2c4,r2c5,r2c6,r2c7,
    input  signed [15:0] r2c8,r2c9,r2c10,r2c11,
    input  signed [15:0] r2c12,r2c13,r2c14,r2c15,

    input  signed [15:0] r3c0,r3c1,r3c2,r3c3,
    input  signed [15:0] r3c4,r3c5,r3c6,r3c7,
    input  signed [15:0] r3c8,r3c9,r3c10,r3c11,
    input  signed [15:0] r3c12,r3c13,r3c14,r3c15,

    input  signed [15:0] r4c0,r4c1,r4c2,r4c3,
    input  signed [15:0] r4c4,r4c5,r4c6,r4c7,
    input  signed [15:0] r4c8,r4c9,r4c10,r4c11,
    input  signed [15:0] r4c12,r4c13,r4c14,r4c15,

    input  signed [15:0] r5c0,r5c1,r5c2,r5c3,
    input  signed [15:0] r5c4,r5c5,r5c6,r5c7,
    input  signed [15:0] r5c8,r5c9,r5c10,r5c11,
    input  signed [15:0] r5c12,r5c13,r5c14,r5c15,

    input  signed [15:0] r6c0,r6c1,r6c2,r6c3,
    input  signed [15:0] r6c4,r6c5,r6c6,r6c7,
    input  signed [15:0] r6c8,r6c9,r6c10,r6c11,
    input  signed [15:0] r6c12,r6c13,r6c14,r6c15,

    input  signed [15:0] r7c0,r7c1,r7c2,r7c3,
    input  signed [15:0] r7c4,r7c5,r7c6,r7c7,
    input  signed [15:0] r7c8,r7c9,r7c10,r7c11,
    input  signed [15:0] r7c12,r7c13,r7c14,r7c15,

    input  signed [15:0] r8c0,r8c1,r8c2,r8c3,
    input  signed [15:0] r8c4,r8c5,r8c6,r8c7,
    input  signed [15:0] r8c8,r8c9,r8c10,r8c11,
    input  signed [15:0] r8c12,r8c13,r8c14,r8c15,

    input  signed [15:0] r9c0,r9c1,r9c2,r9c3,
    input  signed [15:0] r9c4,r9c5,r9c6,r9c7,
    input  signed [15:0] r9c8,r9c9,r9c10,r9c11,
    input  signed [15:0] r9c12,r9c13,r9c14,r9c15,

    input  signed [15:0] r10c0,r10c1,r10c2,r10c3,
    input  signed [15:0] r10c4,r10c5,r10c6,r10c7,
    input  signed [15:0] r10c8,r10c9,r10c10,r10c11,
    input  signed [15:0] r10c12,r10c13,r10c14,r10c15,

    input  signed [15:0] r11c0,r11c1,r11c2,r11c3,
    input  signed [15:0] r11c4,r11c5,r11c6,r11c7,
    input  signed [15:0] r11c8,r11c9,r11c10,r11c11,
    input  signed [15:0] r11c12,r11c13,r11c14,r11c15,

    input  signed [15:0] r12c0,r12c1,r12c2,r12c3,
    input  signed [15:0] r12c4,r12c5,r12c6,r12c7,
    input  signed [15:0] r12c8,r12c9,r12c10,r12c11,
    input  signed [15:0] r12c12,r12c13,r12c14,r12c15,

    input  signed [15:0] r13c0,r13c1,r13c2,r13c3,
    input  signed [15:0] r13c4,r13c5,r13c6,r13c7,
    input  signed [15:0] r13c8,r13c9,r13c10,r13c11,
    input  signed [15:0] r13c12,r13c13,r13c14,r13c15,

    input  signed [15:0] r14c0,r14c1,r14c2,r14c3,
    input  signed [15:0] r14c4,r14c5,r14c6,r14c7,
    input  signed [15:0] r14c8,r14c9,r14c10,r14c11,
    input  signed [15:0] r14c12,r14c13,r14c14,r14c15,

    input  signed [15:0] r15c0,r15c1,r15c2,r15c3,
    input  signed [15:0] r15c4,r15c5,r15c6,r15c7,
    input  signed [15:0] r15c8,r15c9,r15c10,r15c11,
    input  signed [15:0] r15c12,r15c13,r15c14,r15c15,

    // 16 outputs — one per column, all rows summed
    output signed [15:0] out0,out1,out2,out3,
    output signed [15:0] out4,out5,out6,out7,
    output signed [15:0] out8,out9,out10,out11,
    output signed [15:0] out12,out13,out14,out15
);

    // sum all 16 rows for each column
    // use 19-bit intermediate to avoid overflow
    // (16 values of 16-bit = up to 19 bits needed)
    // then clip back to 16-bit

    wire signed [18:0] sum0 = r0c0+r1c0+r2c0+r3c0+r4c0+r5c0+r6c0+r7c0+r8c0+r9c0+r10c0+r11c0+r12c0+r13c0+r14c0+r15c0;
    wire signed [18:0] sum1 = r0c1+r1c1+r2c1+r3c1+r4c1+r5c1+r6c1+r7c1+r8c1+r9c1+r10c1+r11c1+r12c1+r13c1+r14c1+r15c1;
    wire signed [18:0] sum2 = r0c2+r1c2+r2c2+r3c2+r4c2+r5c2+r6c2+r7c2+r8c2+r9c2+r10c2+r11c2+r12c2+r13c2+r14c2+r15c2;
    wire signed [18:0] sum3 = r0c3+r1c3+r2c3+r3c3+r4c3+r5c3+r6c3+r7c3+r8c3+r9c3+r10c3+r11c3+r12c3+r13c3+r14c3+r15c3;
    wire signed [18:0] sum4 = r0c4+r1c4+r2c4+r3c4+r4c4+r5c4+r6c4+r7c4+r8c4+r9c4+r10c4+r11c4+r12c4+r13c4+r14c4+r15c4;
    wire signed [18:0] sum5 = r0c5+r1c5+r2c5+r3c5+r4c5+r5c5+r6c5+r7c5+r8c5+r9c5+r10c5+r11c5+r12c5+r13c5+r14c5+r15c5;
    wire signed [18:0] sum6 = r0c6+r1c6+r2c6+r3c6+r4c6+r5c6+r6c6+r7c6+r8c6+r9c6+r10c6+r11c6+r12c6+r13c6+r14c6+r15c6;
    wire signed [18:0] sum7 = r0c7+r1c7+r2c7+r3c7+r4c7+r5c7+r6c7+r7c7+r8c7+r9c7+r10c7+r11c7+r12c7+r13c7+r14c7+r15c7;
    wire signed [18:0] sum8 = r0c8+r1c8+r2c8+r3c8+r4c8+r5c8+r6c8+r7c8+r8c8+r9c8+r10c8+r11c8+r12c8+r13c8+r14c8+r15c8;
    wire signed [18:0] sum9 = r0c9+r1c9+r2c9+r3c9+r4c9+r5c9+r6c9+r7c9+r8c9+r9c9+r10c9+r11c9+r12c9+r13c9+r14c9+r15c9;
    wire signed [18:0] sum10 = r0c10+r1c10+r2c10+r3c10+r4c10+r5c10+r6c10+r7c10+r8c10+r9c10+r10c10+r11c10+r12c10+r13c10+r14c10+r15c10;
    wire signed [18:0] sum11 = r0c11+r1c11+r2c11+r3c11+r4c11+r5c11+r6c11+r7c11+r8c11+r9c11+r10c11+r11c11+r12c11+r13c11+r14c11+r15c11;
    wire signed [18:0] sum12 = r0c12+r1c12+r2c12+r3c12+r4c12+r5c12+r6c12+r7c12+r8c12+r9c12+r10c12+r11c12+r12c12+r13c12+r14c12+r15c12;
    wire signed [18:0] sum13 = r0c13+r1c13+r2c13+r3c13+r4c13+r5c13+r6c13+r7c13+r8c13+r9c13+r10c13+r11c13+r12c13+r13c13+r14c13+r15c13;
    wire signed [18:0] sum14 = r0c14+r1c14+r2c14+r3c14+r4c14+r5c14+r6c14+r7c14+r8c14+r9c14+r10c14+r11c14+r12c14+r13c14+r14c14+r15c14;
    wire signed [18:0] sum15 = r0c15+r1c15+r2c15+r3c15+r4c15+r5c15+r6c15+r7c15+r8c15+r9c15+r10c15+r11c15+r12c15+r13c15+r14c15+r15c15;

    // clip to 16-bit and gate with enable
    assign out0  = enable ? sum0[15:0]  : 16'sd0;
    assign out1  = enable ? sum1[15:0]  : 16'sd0;
    assign out2  = enable ? sum2[15:0]  : 16'sd0;
    assign out3  = enable ? sum3[15:0]  : 16'sd0;
    assign out4  = enable ? sum4[15:0]  : 16'sd0;
    assign out5  = enable ? sum5[15:0]  : 16'sd0;
    assign out6  = enable ? sum6[15:0]  : 16'sd0;
    assign out7  = enable ? sum7[15:0]  : 16'sd0;
    assign out8  = enable ? sum8[15:0]  : 16'sd0;
    assign out9  = enable ? sum9[15:0]  : 16'sd0;
    assign out10 = enable ? sum10[15:0] : 16'sd0;
    assign out11 = enable ? sum11[15:0] : 16'sd0;
    assign out12 = enable ? sum12[15:0] : 16'sd0;
    assign out13 = enable ? sum13[15:0] : 16'sd0;
    assign out14 = enable ? sum14[15:0] : 16'sd0;
    assign out15 = enable ? sum15[15:0] : 16'sd0;

endmodule