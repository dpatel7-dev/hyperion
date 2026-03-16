// ─────────────────────────────────────────
// HYPERION TRANSFORMER DEEP
// 2 stacked transformer blocks
//
// Pipeline:
//   input
//     → Transformer Block 1
//     → Transformer Block 2
//     → output
//
// GPT-2 small:  12 stacked blocks
// GPT-3:        96 stacked blocks
// Hyperion:      2 stacked blocks
//
// Same architecture. Different scale.
// ─────────────────────────────────────────

module transformer_deep (
    input  clk,
    input  reset,
    input  start,

    // 8-dim input token embedding
    input  signed [15:0] x0,x1,x2,x3,x4,x5,x6,x7,

    // block 1 weights
    input  signed [7:0]  b1_wq0,b1_wq1,b1_wq2,b1_wq3,
    input  signed [7:0]  b1_wq4,b1_wq5,b1_wq6,b1_wq7,
    input  signed [7:0]  b1_wk0,b1_wk1,b1_wk2,b1_wk3,
    input  signed [7:0]  b1_wk4,b1_wk5,b1_wk6,b1_wk7,
    input  signed [7:0]  b1_wv0,b1_wv1,b1_wv2,b1_wv3,
    input  signed [7:0]  b1_wv4,b1_wv5,b1_wv6,b1_wv7,
    input  signed [7:0]  b1_w1_0,b1_w1_1,b1_w1_2,b1_w1_3,
    input  signed [7:0]  b1_w1_4,b1_w1_5,b1_w1_6,b1_w1_7,
    input  signed [15:0] b1_b1_0,b1_b1_1,b1_b1_2,b1_b1_3,
    input  signed [15:0] b1_b1_4,b1_b1_5,b1_b1_6,b1_b1_7,
    input  signed [7:0]  b1_w2_0,b1_w2_1,b1_w2_2,b1_w2_3,
    input  signed [7:0]  b1_w2_4,b1_w2_5,b1_w2_6,b1_w2_7,
    input  signed [15:0] b1_b2_0,b1_b2_1,b1_b2_2,b1_b2_3,
    input  signed [15:0] b1_b2_4,b1_b2_5,b1_b2_6,b1_b2_7,
    input  signed [7:0]  b1_gamma0,b1_gamma1,b1_gamma2,b1_gamma3,
    input  signed [7:0]  b1_gamma4,b1_gamma5,b1_gamma6,b1_gamma7,
    input  signed [7:0]  b1_beta0,b1_beta1,b1_beta2,b1_beta3,
    input  signed [7:0]  b1_beta4,b1_beta5,b1_beta6,b1_beta7,

    // block 2 weights
    input  signed [7:0]  b2_wq0,b2_wq1,b2_wq2,b2_wq3,
    input  signed [7:0]  b2_wq4,b2_wq5,b2_wq6,b2_wq7,
    input  signed [7:0]  b2_wk0,b2_wk1,b2_wk2,b2_wk3,
    input  signed [7:0]  b2_wk4,b2_wk5,b2_wk6,b2_wk7,
    input  signed [7:0]  b2_wv0,b2_wv1,b2_wv2,b2_wv3,
    input  signed [7:0]  b2_wv4,b2_wv5,b2_wv6,b2_wv7,
    input  signed [7:0]  b2_w1_0,b2_w1_1,b2_w1_2,b2_w1_3,
    input  signed [7:0]  b2_w1_4,b2_w1_5,b2_w1_6,b2_w1_7,
    input  signed [15:0] b2_b1_0,b2_b1_1,b2_b1_2,b2_b1_3,
    input  signed [15:0] b2_b1_4,b2_b1_5,b2_b1_6,b2_b1_7,
    input  signed [7:0]  b2_w2_0,b2_w2_1,b2_w2_2,b2_w2_3,
    input  signed [7:0]  b2_w2_4,b2_w2_5,b2_w2_6,b2_w2_7,
    input  signed [15:0] b2_b2_0,b2_b2_1,b2_b2_2,b2_b2_3,
    input  signed [15:0] b2_b2_4,b2_b2_5,b2_b2_6,b2_b2_7,
    input  signed [7:0]  b2_gamma0,b2_gamma1,b2_gamma2,b2_gamma3,
    input  signed [7:0]  b2_gamma4,b2_gamma5,b2_gamma6,b2_gamma7,
    input  signed [7:0]  b2_beta0,b2_beta1,b2_beta2,b2_beta3,
    input  signed [7:0]  b2_beta4,b2_beta5,b2_beta6,b2_beta7,

    // final output
    output signed [15:0] out0,out1,out2,out3,
    output signed [15:0] out4,out5,out6,out7,

    output block1_done,
    output done
);

    // ── wires between blocks ──
    wire signed [15:0] mid0,mid1,mid2,mid3;
    wire signed [15:0] mid4,mid5,mid6,mid7;

    // ── BLOCK 1 ──
    transformer_block block1 (
        .clk(clk),.reset(reset),.start(start),
        .x0(x0),.x1(x1),.x2(x2),.x3(x3),
        .x4(x4),.x5(x5),.x6(x6),.x7(x7),
        .wq0(b1_wq0),.wq1(b1_wq1),.wq2(b1_wq2),.wq3(b1_wq3),
        .wq4(b1_wq4),.wq5(b1_wq5),.wq6(b1_wq6),.wq7(b1_wq7),
        .wk0(b1_wk0),.wk1(b1_wk1),.wk2(b1_wk2),.wk3(b1_wk3),
        .wk4(b1_wk4),.wk5(b1_wk5),.wk6(b1_wk6),.wk7(b1_wk7),
        .wv0(b1_wv0),.wv1(b1_wv1),.wv2(b1_wv2),.wv3(b1_wv3),
        .wv4(b1_wv4),.wv5(b1_wv5),.wv6(b1_wv6),.wv7(b1_wv7),
        .w1_0(b1_w1_0),.w1_1(b1_w1_1),.w1_2(b1_w1_2),.w1_3(b1_w1_3),
        .w1_4(b1_w1_4),.w1_5(b1_w1_5),.w1_6(b1_w1_6),.w1_7(b1_w1_7),
        .b1_0(b1_b1_0),.b1_1(b1_b1_1),.b1_2(b1_b1_2),.b1_3(b1_b1_3),
        .b1_4(b1_b1_4),.b1_5(b1_b1_5),.b1_6(b1_b1_6),.b1_7(b1_b1_7),
        .w2_0(b1_w2_0),.w2_1(b1_w2_1),.w2_2(b1_w2_2),.w2_3(b1_w2_3),
        .w2_4(b1_w2_4),.w2_5(b1_w2_5),.w2_6(b1_w2_6),.w2_7(b1_w2_7),
        .b2_0(b1_b2_0),.b2_1(b1_b2_1),.b2_2(b1_b2_2),.b2_3(b1_b2_3),
        .b2_4(b1_b2_4),.b2_5(b1_b2_5),.b2_6(b1_b2_6),.b2_7(b1_b2_7),
        .gamma0(b1_gamma0),.gamma1(b1_gamma1),
        .gamma2(b1_gamma2),.gamma3(b1_gamma3),
        .gamma4(b1_gamma4),.gamma5(b1_gamma5),
        .gamma6(b1_gamma6),.gamma7(b1_gamma7),
        .beta0(b1_beta0),.beta1(b1_beta1),
        .beta2(b1_beta2),.beta3(b1_beta3),
        .beta4(b1_beta4),.beta5(b1_beta5),
        .beta6(b1_beta6),.beta7(b1_beta7),
        .out0(mid0),.out1(mid1),.out2(mid2),.out3(mid3),
        .out4(mid4),.out5(mid5),.out6(mid6),.out7(mid7),
        .done(block1_done)
    );

    // ── BLOCK 2 — starts when block 1 done ──
    transformer_block block2 (
        .clk(clk),.reset(reset),.start(block1_done),
        .x0(mid0),.x1(mid1),.x2(mid2),.x3(mid3),
        .x4(mid4),.x5(mid5),.x6(mid6),.x7(mid7),
        .wq0(b2_wq0),.wq1(b2_wq1),.wq2(b2_wq2),.wq3(b2_wq3),
        .wq4(b2_wq4),.wq5(b2_wq5),.wq6(b2_wq6),.wq7(b2_wq7),
        .wk0(b2_wk0),.wk1(b2_wk1),.wk2(b2_wk2),.wk3(b2_wk3),
        .wk4(b2_wk4),.wk5(b2_wk5),.wk6(b2_wk6),.wk7(b2_wk7),
        .wv0(b2_wv0),.wv1(b2_wv1),.wv2(b2_wv2),.wv3(b2_wv3),
        .wv4(b2_wv4),.wv5(b2_wv5),.wv6(b2_wv6),.wv7(b2_wv7),
        .w1_0(b2_w1_0),.w1_1(b2_w1_1),.w1_2(b2_w1_2),.w1_3(b2_w1_3),
        .w1_4(b2_w1_4),.w1_5(b2_w1_5),.w1_6(b2_w1_6),.w1_7(b2_w1_7),
        .b1_0(b2_b1_0),.b1_1(b2_b1_1),.b1_2(b2_b1_2),.b1_3(b2_b1_3),
        .b1_4(b2_b1_4),.b1_5(b2_b1_5),.b1_6(b2_b1_6),.b1_7(b2_b1_7),
        .w2_0(b2_w2_0),.w2_1(b2_w2_1),.w2_2(b2_w2_2),.w2_3(b2_w2_3),
        .w2_4(b2_w2_4),.w2_5(b2_w2_5),.w2_6(b2_w2_6),.w2_7(b2_w2_7),
        .b2_0(b2_b2_0),.b2_1(b2_b2_1),.b2_2(b2_b2_2),.b2_3(b2_b2_3),
        .b2_4(b2_b2_4),.b2_5(b2_b2_5),.b2_6(b2_b2_6),.b2_7(b2_b2_7),
        .gamma0(b2_gamma0),.gamma1(b2_gamma1),
        .gamma2(b2_gamma2),.gamma3(b2_gamma3),
        .gamma4(b2_gamma4),.gamma5(b2_gamma5),
        .gamma6(b2_gamma6),.gamma7(b2_gamma7),
        .beta0(b2_beta0),.beta1(b2_beta1),
        .beta2(b2_beta2),.beta3(b2_beta3),
        .beta4(b2_beta4),.beta5(b2_beta5),
        .beta6(b2_beta6),.beta7(b2_beta7),
        .out0(out0),.out1(out1),.out2(out2),.out3(out3),
        .out4(out4),.out5(out5),.out6(out6),.out7(out7),
        .done(done)
    );

endmodule
