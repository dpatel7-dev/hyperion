// ─────────────────────────────────────────
// HYPERION DEEPER — 3 stacked layers
// Layer 1: input × W1 + B1 → ReLU
// Layer 2: L1 × W2 + B2 → ReLU
// Layer 3: L2 × W3 + B3 → ReLU
// 768 MAC operations per inference pass
// GPT-2 small has 12 of these
// Hyperion has 3 — same principle
// ─────────────────────────────────────────

module hyperion_deeper (
    input  clk,
    input  reset,
    input  start,

    // 16 raw inputs
    input  signed [7:0] a0,a1,a2,a3,a4,a5,a6,a7,
    input  signed [7:0] a8,a9,a10,a11,a12,a13,a14,a15,

    // layer 1 weights + biases
    input  signed [7:0]  w1_0,w1_1,w1_2,w1_3,w1_4,w1_5,w1_6,w1_7,
    input  signed [7:0]  w1_8,w1_9,w1_10,w1_11,w1_12,w1_13,w1_14,w1_15,
    input  signed [15:0] b1_0,b1_1,b1_2,b1_3,b1_4,b1_5,b1_6,b1_7,
    input  signed [15:0] b1_8,b1_9,b1_10,b1_11,b1_12,b1_13,b1_14,b1_15,

    // layer 2 weights + biases
    input  signed [7:0]  w2_0,w2_1,w2_2,w2_3,w2_4,w2_5,w2_6,w2_7,
    input  signed [7:0]  w2_8,w2_9,w2_10,w2_11,w2_12,w2_13,w2_14,w2_15,
    input  signed [15:0] b2_0,b2_1,b2_2,b2_3,b2_4,b2_5,b2_6,b2_7,
    input  signed [15:0] b2_8,b2_9,b2_10,b2_11,b2_12,b2_13,b2_14,b2_15,

    // layer 3 weights + biases
    input  signed [7:0]  w3_0,w3_1,w3_2,w3_3,w3_4,w3_5,w3_6,w3_7,
    input  signed [7:0]  w3_8,w3_9,w3_10,w3_11,w3_12,w3_13,w3_14,w3_15,
    input  signed [15:0] b3_0,b3_1,b3_2,b3_3,b3_4,b3_5,b3_6,b3_7,
    input  signed [15:0] b3_8,b3_9,b3_10,b3_11,b3_12,b3_13,b3_14,b3_15,

    // final outputs
    output signed [15:0] out0,out1,out2,out3,
    output signed [15:0] out4,out5,out6,out7,
    output signed [15:0] out8,out9,out10,out11,
    output signed [15:0] out12,out13,out14,out15,

    output layer1_done,
    output layer2_done,
    output layer3_done
);

    // ── layer 1 → layer 2 wires ──
    wire signed [15:0] l1_out0,l1_out1,l1_out2,l1_out3;
    wire signed [15:0] l1_out4,l1_out5,l1_out6,l1_out7;
    wire signed [15:0] l1_out8,l1_out9,l1_out10,l1_out11;
    wire signed [15:0] l1_out12,l1_out13,l1_out14,l1_out15;

    // ── layer 2 → layer 3 wires ──
    wire signed [15:0] l2_out0,l2_out1,l2_out2,l2_out3;
    wire signed [15:0] l2_out4,l2_out5,l2_out6,l2_out7;
    wire signed [15:0] l2_out8,l2_out9,l2_out10,l2_out11;
    wire signed [15:0] l2_out12,l2_out13,l2_out14,l2_out15;

    // quantize 16-bit → 8-bit between layers
    wire signed [7:0] l1_q0=l1_out0[7:0], l1_q1=l1_out1[7:0];
    wire signed [7:0] l1_q2=l1_out2[7:0], l1_q3=l1_out3[7:0];
    wire signed [7:0] l1_q4=l1_out4[7:0], l1_q5=l1_out5[7:0];
    wire signed [7:0] l1_q6=l1_out6[7:0], l1_q7=l1_out7[7:0];
    wire signed [7:0] l1_q8=l1_out8[7:0], l1_q9=l1_out9[7:0];
    wire signed [7:0] l1_q10=l1_out10[7:0], l1_q11=l1_out11[7:0];
    wire signed [7:0] l1_q12=l1_out12[7:0], l1_q13=l1_out13[7:0];
    wire signed [7:0] l1_q14=l1_out14[7:0], l1_q15=l1_out15[7:0];

    wire signed [7:0] l2_q0=l2_out0[7:0], l2_q1=l2_out1[7:0];
    wire signed [7:0] l2_q2=l2_out2[7:0], l2_q3=l2_out3[7:0];
    wire signed [7:0] l2_q4=l2_out4[7:0], l2_q5=l2_out5[7:0];
    wire signed [7:0] l2_q6=l2_out6[7:0], l2_q7=l2_out7[7:0];
    wire signed [7:0] l2_q8=l2_out8[7:0], l2_q9=l2_out9[7:0];
    wire signed [7:0] l2_q10=l2_out10[7:0], l2_q11=l2_out11[7:0];
    wire signed [7:0] l2_q12=l2_out12[7:0], l2_q13=l2_out13[7:0];
    wire signed [7:0] l2_q14=l2_out14[7:0], l2_q15=l2_out15[7:0];

    // ── LAYER 1 ──
    hyperion_layer layer1 (
        .clk(clk),.reset(reset),.start(start),
        .a0(a0),.a1(a1),.a2(a2),.a3(a3),
        .a4(a4),.a5(a5),.a6(a6),.a7(a7),
        .a8(a8),.a9(a9),.a10(a10),.a11(a11),
        .a12(a12),.a13(a13),.a14(a14),.a15(a15),
        .w0(w1_0),.w1(w1_1),.w2(w1_2),.w3(w1_3),
        .w4(w1_4),.w5(w1_5),.w6(w1_6),.w7(w1_7),
        .w8(w1_8),.w9(w1_9),.w10(w1_10),.w11(w1_11),
        .w12(w1_12),.w13(w1_13),.w14(w1_14),.w15(w1_15),
        .bias0(b1_0),.bias1(b1_1),.bias2(b1_2),.bias3(b1_3),
        .bias4(b1_4),.bias5(b1_5),.bias6(b1_6),.bias7(b1_7),
        .bias8(b1_8),.bias9(b1_9),.bias10(b1_10),.bias11(b1_11),
        .bias12(b1_12),.bias13(b1_13),.bias14(b1_14),.bias15(b1_15),
        .out0(l1_out0),.out1(l1_out1),.out2(l1_out2),.out3(l1_out3),
        .out4(l1_out4),.out5(l1_out5),.out6(l1_out6),.out7(l1_out7),
        .out8(l1_out8),.out9(l1_out9),.out10(l1_out10),.out11(l1_out11),
        .out12(l1_out12),.out13(l1_out13),.out14(l1_out14),.out15(l1_out15),
        .done(layer1_done)
    );

    // ── LAYER 2 ──
    hyperion_layer layer2 (
        .clk(clk),.reset(reset),.start(layer1_done),
        .a0(l1_q0),.a1(l1_q1),.a2(l1_q2),.a3(l1_q3),
        .a4(l1_q4),.a5(l1_q5),.a6(l1_q6),.a7(l1_q7),
        .a8(l1_q8),.a9(l1_q9),.a10(l1_q10),.a11(l1_q11),
        .a12(l1_q12),.a13(l1_q13),.a14(l1_q14),.a15(l1_q15),
        .w0(w2_0),.w1(w2_1),.w2(w2_2),.w3(w2_3),
        .w4(w2_4),.w5(w2_5),.w6(w2_6),.w7(w2_7),
        .w8(w2_8),.w9(w2_9),.w10(w2_10),.w11(w2_11),
        .w12(w2_12),.w13(w2_13),.w14(w2_14),.w15(w2_15),
        .bias0(b2_0),.bias1(b2_1),.bias2(b2_2),.bias3(b2_3),
        .bias4(b2_4),.bias5(b2_5),.bias6(b2_6),.bias7(b2_7),
        .bias8(b2_8),.bias9(b2_9),.bias10(b2_10),.bias11(b2_11),
        .bias12(b2_12),.bias13(b2_13),.bias14(b2_14),.bias15(b2_15),
        .out0(l2_out0),.out1(l2_out1),.out2(l2_out2),.out3(l2_out3),
        .out4(l2_out4),.out5(l2_out5),.out6(l2_out6),.out7(l2_out7),
        .out8(l2_out8),.out9(l2_out9),.out10(l2_out10),.out11(l2_out11),
        .out12(l2_out12),.out13(l2_out13),.out14(l2_out14),.out15(l2_out15),
        .done(layer2_done)
    );

    // ── LAYER 3 ──
    hyperion_layer layer3 (
        .clk(clk),.reset(reset),.start(layer2_done),
        .a0(l2_q0),.a1(l2_q1),.a2(l2_q2),.a3(l2_q3),
        .a4(l2_q4),.a5(l2_q5),.a6(l2_q6),.a7(l2_q7),
        .a8(l2_q8),.a9(l2_q9),.a10(l2_q10),.a11(l2_q11),
        .a12(l2_q12),.a13(l2_q13),.a14(l2_q14),.a15(l2_q15),
        .w0(w3_0),.w1(w3_1),.w2(w3_2),.w3(w3_3),
        .w4(w3_4),.w5(w3_5),.w6(w3_6),.w7(w3_7),
        .w8(w3_8),.w9(w3_9),.w10(w3_10),.w11(w3_11),
        .w12(w3_12),.w13(w3_13),.w14(w3_14),.w15(w3_15),
        .bias0(b3_0),.bias1(b3_1),.bias2(b3_2),.bias3(b3_3),
        .bias4(b3_4),.bias5(b3_5),.bias6(b3_6),.bias7(b3_7),
        .bias8(b3_8),.bias9(b3_9),.bias10(b3_10),.bias11(b3_11),
        .bias12(b3_12),.bias13(b3_13),.bias14(b3_14),.bias15(b3_15),
        .out0(out0),.out1(out1),.out2(out2),.out3(out3),
        .out4(out4),.out5(out5),.out6(out6),.out7(out7),
        .out8(out8),.out9(out9),.out10(out10),.out11(out11),
        .out12(out12),.out13(out13),.out14(out14),.out15(out15),
        .done(layer3_done)
    );

endmodule