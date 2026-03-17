// ═════════════════════════════════════════════
// HYPERION LANGUAGE MODEL
// Complete end-to-end language model
//
// FULL PIPELINE:
//   token_id
//     → Embedding Table    (token → vector)
//     → Positional Encoding (add position)
//     → 12 Transformer Blocks (GPT-2 architecture)
//     → Output Projection  (vector → logits)
//     → argmax             (logit → next token)
//
// Input:  one token ID (0-15)
// Output: predicted next token ID (0-15)
//
// This is a complete language model.
// GPT-2:    50,257 vocab × 768 dims × 12 blocks
// Hyperion: 16 vocab     × 8 dims   × 12 blocks
// Same architecture. Different scale.
// ═════════════════════════════════════════════

module hyperion_lm (
    input  clk,
    input  reset,
    input  start,
    input  [3:0] token_id,
    input  [2:0] position,

    // all transformer weights (shared across blocks)
    input  signed [7:0]  wq0,wq1,wq2,wq3,wq4,wq5,wq6,wq7,
    input  signed [7:0]  wk0,wk1,wk2,wk3,wk4,wk5,wk6,wk7,
    input  signed [7:0]  wv0,wv1,wv2,wv3,wv4,wv5,wv6,wv7,
    input  signed [7:0]  w1_0,w1_1,w1_2,w1_3,w1_4,w1_5,w1_6,w1_7,
    input  signed [15:0] b1_0,b1_1,b1_2,b1_3,b1_4,b1_5,b1_6,b1_7,
    input  signed [7:0]  w2_0,w2_1,w2_2,w2_3,w2_4,w2_5,w2_6,w2_7,
    input  signed [15:0] b2_0,b2_1,b2_2,b2_3,b2_4,b2_5,b2_6,b2_7,
    input  signed [7:0]  gamma0,gamma1,gamma2,gamma3,
    input  signed [7:0]  gamma4,gamma5,gamma6,gamma7,
    input  signed [7:0]  beta0,beta1,beta2,beta3,
    input  signed [7:0]  beta4,beta5,beta6,beta7,

    // outputs
    output [3:0]          next_token,    // predicted next token
    output signed [15:0]  logit0,logit1,logit2,logit3,
    output signed [15:0]  logit4,logit5,logit6,logit7,
    output signed [15:0]  logit8,logit9,logit10,logit11,
    output signed [15:0]  logit12,logit13,logit14,logit15,
    output done
);

    // ── STAGE 1: embedding lookup ──
    wire signed [15:0] emb0,emb1,emb2,emb3;
    wire signed [15:0] emb4,emb5,emb6,emb7;

    embedding_table emb (
        .clk(clk),.reset(reset),.token_id(token_id),
        .out0(emb0),.out1(emb1),.out2(emb2),.out3(emb3),
        .out4(emb4),.out5(emb5),.out6(emb6),.out7(emb7)
    );

    // ── STAGE 2: positional encoding ──
    wire signed [15:0] pe0,pe1,pe2,pe3;
    wire signed [15:0] pe4,pe5,pe6,pe7;

    positional_encoding pe (
        .clk(clk),.reset(reset),.pos(position),
        .x0(emb0),.x1(emb1),.x2(emb2),.x3(emb3),
        .x4(emb4),.x5(emb5),.x6(emb6),.x7(emb7),
        .out0(pe0),.out1(pe1),.out2(pe2),.out3(pe3),
        .out4(pe4),.out5(pe5),.out6(pe6),.out7(pe7)
    );

    // ── STAGE 3: 12 transformer blocks ──
    wire signed [15:0] tx0,tx1,tx2,tx3;
    wire signed [15:0] tx4,tx5,tx6,tx7;

    hyperion_gpt2_full gpt2 (
        .clk(clk),.reset(reset),.start(start),.pos(position),
        .x0(pe0),.x1(pe1),.x2(pe2),.x3(pe3),
        .x4(pe4),.x5(pe5),.x6(pe6),.x7(pe7),
        .ga_a_b1_wq0(wq0),.ga_a_b1_wq1(wq1),
        .ga_a_b1_wq2(wq2),.ga_a_b1_wq3(wq3),
        .ga_a_b1_wq4(wq4),.ga_a_b1_wq5(wq5),
        .ga_a_b1_wq6(wq6),.ga_a_b1_wq7(wq7),
        .ga_a_b1_wk0(wk0),.ga_a_b1_wk1(wk1),
        .ga_a_b1_wk2(wk2),.ga_a_b1_wk3(wk3),
        .ga_a_b1_wk4(wk4),.ga_a_b1_wk5(wk5),
        .ga_a_b1_wk6(wk6),.ga_a_b1_wk7(wk7),
        .ga_a_b1_wv0(wv0),.ga_a_b1_wv1(wv1),
        .ga_a_b1_wv2(wv2),.ga_a_b1_wv3(wv3),
        .ga_a_b1_wv4(wv4),.ga_a_b1_wv5(wv5),
        .ga_a_b1_wv6(wv6),.ga_a_b1_wv7(wv7),
        .ga_a_b1_w1_0(w1_0),.ga_a_b1_w1_1(w1_1),
        .ga_a_b1_w1_2(w1_2),.ga_a_b1_w1_3(w1_3),
        .ga_a_b1_w1_4(w1_4),.ga_a_b1_w1_5(w1_5),
        .ga_a_b1_w1_6(w1_6),.ga_a_b1_w1_7(w1_7),
        .ga_a_b1_b1_0(b1_0),.ga_a_b1_b1_1(b1_1),
        .ga_a_b1_b1_2(b1_2),.ga_a_b1_b1_3(b1_3),
        .ga_a_b1_b1_4(b1_4),.ga_a_b1_b1_5(b1_5),
        .ga_a_b1_b1_6(b1_6),.ga_a_b1_b1_7(b1_7),
        .ga_a_b1_w2_0(w2_0),.ga_a_b1_w2_1(w2_1),
        .ga_a_b1_w2_2(w2_2),.ga_a_b1_w2_3(w2_3),
        .ga_a_b1_w2_4(w2_4),.ga_a_b1_w2_5(w2_5),
        .ga_a_b1_w2_6(w2_6),.ga_a_b1_w2_7(w2_7),
        .ga_a_b1_b2_0(b2_0),.ga_a_b1_b2_1(b2_1),
        .ga_a_b1_b2_2(b2_2),.ga_a_b1_b2_3(b2_3),
        .ga_a_b1_b2_4(b2_4),.ga_a_b1_b2_5(b2_5),
        .ga_a_b1_b2_6(b2_6),.ga_a_b1_b2_7(b2_7),
        .ga_a_b1_gamma0(gamma0),.ga_a_b1_gamma1(gamma1),
        .ga_a_b1_gamma2(gamma2),.ga_a_b1_gamma3(gamma3),
        .ga_a_b1_gamma4(gamma4),.ga_a_b1_gamma5(gamma5),
        .ga_a_b1_gamma6(gamma6),.ga_a_b1_gamma7(gamma7),
        .ga_a_b1_beta0(beta0),.ga_a_b1_beta1(beta1),
        .ga_a_b1_beta2(beta2),.ga_a_b1_beta3(beta3),
        .ga_a_b1_beta4(beta4),.ga_a_b1_beta5(beta5),
        .ga_a_b1_beta6(beta6),.ga_a_b1_beta7(beta7),
        .out0(tx0),.out1(tx1),.out2(tx2),.out3(tx3),
        .out4(tx4),.out5(tx5),.out6(tx6),.out7(tx7),
        .done(done)
    );

    // ── STAGE 4: output projection ──
    output_projection proj (
        .clk(clk),.reset(reset),
        .x0(tx0),.x1(tx1),.x2(tx2),.x3(tx3),
        .x4(tx4),.x5(tx5),.x6(tx6),.x7(tx7),
        .logit0(logit0),.logit1(logit1),
        .logit2(logit2),.logit3(logit3),
        .logit4(logit4),.logit5(logit5),
        .logit6(logit6),.logit7(logit7),
        .logit8(logit8),.logit9(logit9),
        .logit10(logit10),.logit11(logit11),
        .logit12(logit12),.logit13(logit13),
        .logit14(logit14),.logit15(logit15)
    );

    // ── STAGE 5: argmax — pick highest logit ──
    wire signed [15:0] max01  = (logit0  > logit1)  ? logit0  : logit1;
    wire signed [15:0] max23  = (logit2  > logit3)  ? logit2  : logit3;
    wire signed [15:0] max45  = (logit4  > logit5)  ? logit4  : logit5;
    wire signed [15:0] max67  = (logit6  > logit7)  ? logit6  : logit7;
    wire signed [15:0] max89  = (logit8  > logit9)  ? logit8  : logit9;
    wire signed [15:0] max1011= (logit10 > logit11) ? logit10 : logit11;
    wire signed [15:0] max1213= (logit12 > logit13) ? logit12 : logit13;
    wire signed [15:0] max1415= (logit14 > logit15) ? logit14 : logit15;
    wire signed [15:0] max0123  = (max01   > max23)   ? max01   : max23;
    wire signed [15:0] max4567  = (max45   > max67)   ? max45   : max67;
    wire signed [15:0] max891011= (max89   > max1011) ? max89   : max1011;
    wire signed [15:0] max12_15 = (max1213 > max1415) ? max1213 : max1415;
    wire signed [15:0] maxA = (max0123   > max4567)   ? max0123   : max4567;
    wire signed [15:0] maxB = (max891011 > max12_15)  ? max891011 : max12_15;
    wire signed [15:0] maxval = (maxA > maxB) ? maxA : maxB;

    assign next_token =
        (logit0  == maxval) ? 4'd0  :
        (logit1  == maxval) ? 4'd1  :
        (logit2  == maxval) ? 4'd2  :
        (logit3  == maxval) ? 4'd3  :
        (logit4  == maxval) ? 4'd4  :
        (logit5  == maxval) ? 4'd5  :
        (logit6  == maxval) ? 4'd6  :
        (logit7  == maxval) ? 4'd7  :
        (logit8  == maxval) ? 4'd8  :
        (logit9  == maxval) ? 4'd9  :
        (logit10 == maxval) ? 4'd10 :
        (logit11 == maxval) ? 4'd11 :
        (logit12 == maxval) ? 4'd12 :
        (logit13 == maxval) ? 4'd13 :
        (logit14 == maxval) ? 4'd14 : 4'd15;

endmodule
