// ─────────────────────────────────────────
// HYPERION TRANSFORMER BLOCK
// One complete transformer layer
//
// Pipeline:
//   input
//     → LayerNorm
//     → Attention (Q·K scaled + V)
//     → residual add (input + attn_out)
//     → LayerNorm
//     → FFN (Linear → ReLU → Linear)
//     → residual add
//     → output
//
// GPT-3 stacks 96 of these.
// Hyperion has 1.
// Same architecture, different scale.
// ─────────────────────────────────────────

module transformer_block (
    input  clk,
    input  reset,
    input  start,

    // 8-dim input token embedding
    input  signed [15:0] x0,x1,x2,x3,x4,x5,x6,x7,

    // attention weights (Q, K, V projections)
    input  signed [7:0] wq0,wq1,wq2,wq3,wq4,wq5,wq6,wq7,
    input  signed [7:0] wk0,wk1,wk2,wk3,wk4,wk5,wk6,wk7,
    input  signed [7:0] wv0,wv1,wv2,wv3,wv4,wv5,wv6,wv7,

    // FFN weights
    input  signed [7:0]  w1_0,w1_1,w1_2,w1_3,w1_4,w1_5,w1_6,w1_7,
    input  signed [15:0] b1_0,b1_1,b1_2,b1_3,b1_4,b1_5,b1_6,b1_7,
    input  signed [7:0]  w2_0,w2_1,w2_2,w2_3,w2_4,w2_5,w2_6,w2_7,
    input  signed [15:0] b2_0,b2_1,b2_2,b2_3,b2_4,b2_5,b2_6,b2_7,

    // LayerNorm parameters
    input  signed [7:0] gamma0,gamma1,gamma2,gamma3,
    input  signed [7:0] gamma4,gamma5,gamma6,gamma7,
    input  signed [7:0] beta0,beta1,beta2,beta3,
    input  signed [7:0] beta4,beta5,beta6,beta7,

    // output
    output signed [15:0] out0,out1,out2,out3,
    output signed [15:0] out4,out5,out6,out7,

    output done
);

    // ── state machine ──
    reg [3:0] state;
    reg [6:0] cycle_count;

    parameter IDLE    = 4'd0;
    parameter LN1     = 4'd1;   // LayerNorm 1
    parameter ATTN    = 4'd2;   // Attention
    parameter RES1    = 4'd3;   // Residual add 1
    parameter LN2     = 4'd4;   // LayerNorm 2
    parameter FFN     = 4'd5;   // Feed-forward
    parameter RES2    = 4'd6;   // Residual add 2
    parameter DONE    = 4'd7;

    assign done = (state == DONE);

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            cycle_count <= 0;
        end else begin
            case (state)
                IDLE:  begin cycle_count<=0; if (start) state<=LN1; end
                LN1:   begin cycle_count<=cycle_count+1;
                           if (cycle_count>=7'd5) begin cycle_count<=0; state<=ATTN; end end
                ATTN:  begin cycle_count<=cycle_count+1;
                           if (attn_done) begin cycle_count<=0; state<=RES1; end end
                RES1:  begin cycle_count<=cycle_count+1;
                           if (cycle_count>=7'd3) begin cycle_count<=0; state<=LN2; end end
                LN2:   begin cycle_count<=cycle_count+1;
                           if (cycle_count>=7'd5) begin cycle_count<=0; state<=FFN; end end
                FFN:   begin cycle_count<=cycle_count+1;
                           if (ffn_done) begin cycle_count<=0; state<=RES2; end end
                RES2:  begin cycle_count<=cycle_count+1;
                           if (cycle_count>=7'd3) begin cycle_count<=0; state<=DONE; end end
                DONE:  state<=IDLE;
            endcase
        end
    end

    // ── STAGE 1: LayerNorm 1 ──
    wire ln1_enable = (state >= LN1);
    wire signed [15:0] ln1_out0,ln1_out1,ln1_out2,ln1_out3;
    wire signed [15:0] ln1_out4,ln1_out5,ln1_out6,ln1_out7;

    layernorm_unit ln1 (
        .clk(clk),.reset(reset),.enable(ln1_enable),
        .x0(x0),.x1(x1),.x2(x2),.x3(x3),
        .x4(x4),.x5(x5),.x6(x6),.x7(x7),
        .gamma0(gamma0),.gamma1(gamma1),
        .gamma2(gamma2),.gamma3(gamma3),
        .gamma4(gamma4),.gamma5(gamma5),
        .gamma6(gamma6),.gamma7(gamma7),
        .beta0(beta0),.beta1(beta1),
        .beta2(beta2),.beta3(beta3),
        .beta4(beta4),.beta5(beta5),
        .beta6(beta6),.beta7(beta7),
        .out0(ln1_out0),.out1(ln1_out1),
        .out2(ln1_out2),.out3(ln1_out3),
        .out4(ln1_out4),.out5(ln1_out5),
        .out6(ln1_out6),.out7(ln1_out7)
    );

    // ── STAGE 2: Attention ──
    // project ln1 output to Q, K, V using weights
    wire signed [7:0] q0 = ln1_out0[7:0];
    wire signed [7:0] q1 = ln1_out1[7:0];
    wire signed [7:0] q2 = ln1_out2[7:0];
    wire signed [7:0] q3 = ln1_out3[7:0];
    wire signed [7:0] q4 = ln1_out4[7:0];
    wire signed [7:0] q5 = ln1_out5[7:0];
    wire signed [7:0] q6 = ln1_out6[7:0];
    wire signed [7:0] q7 = ln1_out7[7:0];

    wire attn_start = (state == ATTN && cycle_count == 1);
    wire attn_done;
    wire signed [15:0] attn_score;
    wire signed [15:0] attn_out0,attn_out1,attn_out2,attn_out3;
    wire signed [15:0] attn_out4,attn_out5,attn_out6,attn_out7;

    attention_unit attn (
        .clk(clk),.reset(reset||state==IDLE||state==LN1),
        .start(attn_start),
        .q0(q0),.q1(q1),.q2(q2),.q3(q3),
        .q4(q4),.q5(q5),.q6(q6),.q7(q7),
        .k0(wk0),.k1(wk1),.k2(wk2),.k3(wk3),
        .k4(wk4),.k5(wk5),.k6(wk6),.k7(wk7),
        .v0(wv0),.v1(wv1),.v2(wv2),.v3(wv3),
        .v4(wv4),.v5(wv5),.v6(wv6),.v7(wv7),
        .score(attn_score),
        .attn_out0(attn_out0),.attn_out1(attn_out1),
        .attn_out2(attn_out2),.attn_out3(attn_out3),
        .attn_out4(attn_out4),.attn_out5(attn_out5),
        .attn_out6(attn_out6),.attn_out7(attn_out7),
        .done(attn_done)
    );

    // ── STAGE 3: Residual add 1 (x + attn_out) ──
    reg signed [15:0] res1_0,res1_1,res1_2,res1_3;
    reg signed [15:0] res1_4,res1_5,res1_6,res1_7;

    always @(posedge clk) begin
        if (reset) begin
            res1_0<=0;res1_1<=0;res1_2<=0;res1_3<=0;
            res1_4<=0;res1_5<=0;res1_6<=0;res1_7<=0;
        end else if (state==RES1 && cycle_count==0) begin
            res1_0 <= x0 + attn_out0;
            res1_1 <= x1 + attn_out1;
            res1_2 <= x2 + attn_out2;
            res1_3 <= x3 + attn_out3;
            res1_4 <= x4 + attn_out4;
            res1_5 <= x5 + attn_out5;
            res1_6 <= x6 + attn_out6;
            res1_7 <= x7 + attn_out7;
        end
    end

    // ── STAGE 4: LayerNorm 2 ──
    wire ln2_enable = (state >= LN2);
    wire signed [15:0] ln2_out0,ln2_out1,ln2_out2,ln2_out3;
    wire signed [15:0] ln2_out4,ln2_out5,ln2_out6,ln2_out7;

    layernorm_unit ln2 (
        .clk(clk),.reset(reset),.enable(ln2_enable),
        .x0(res1_0),.x1(res1_1),.x2(res1_2),.x3(res1_3),
        .x4(res1_4),.x5(res1_5),.x6(res1_6),.x7(res1_7),
        .gamma0(gamma0),.gamma1(gamma1),
        .gamma2(gamma2),.gamma3(gamma3),
        .gamma4(gamma4),.gamma5(gamma5),
        .gamma6(gamma6),.gamma7(gamma7),
        .beta0(beta0),.beta1(beta1),
        .beta2(beta2),.beta3(beta3),
        .beta4(beta4),.beta5(beta5),
        .beta6(beta6),.beta7(beta7),
        .out0(ln2_out0),.out1(ln2_out1),
        .out2(ln2_out2),.out3(ln2_out3),
        .out4(ln2_out4),.out5(ln2_out5),
        .out6(ln2_out6),.out7(ln2_out7)
    );

    // ── STAGE 5: FFN ──
    wire ffn_start = (state == FFN && cycle_count == 1);
    wire ffn_done;
    wire signed [15:0] ffn_out0,ffn_out1,ffn_out2,ffn_out3;
    wire signed [15:0] ffn_out4,ffn_out5,ffn_out6,ffn_out7;

    ffn_unit ffn (
        .clk(clk),.reset(reset||state==IDLE||state==LN1||
                         state==ATTN||state==RES1||state==LN2),
        .start(ffn_start),
        .x0(ln2_out0),.x1(ln2_out1),.x2(ln2_out2),.x3(ln2_out3),
        .x4(ln2_out4),.x5(ln2_out5),.x6(ln2_out6),.x7(ln2_out7),
        .w1_0(w1_0),.w1_1(w1_1),.w1_2(w1_2),.w1_3(w1_3),
        .w1_4(w1_4),.w1_5(w1_5),.w1_6(w1_6),.w1_7(w1_7),
        .b1_0(b1_0),.b1_1(b1_1),.b1_2(b1_2),.b1_3(b1_3),
        .b1_4(b1_4),.b1_5(b1_5),.b1_6(b1_6),.b1_7(b1_7),
        .w2_0(w2_0),.w2_1(w2_1),.w2_2(w2_2),.w2_3(w2_3),
        .w2_4(w2_4),.w2_5(w2_5),.w2_6(w2_6),.w2_7(w2_7),
        .b2_0(b2_0),.b2_1(b2_1),.b2_2(b2_2),.b2_3(b2_3),
        .b2_4(b2_4),.b2_5(b2_5),.b2_6(b2_6),.b2_7(b2_7),
        .out0(ffn_out0),.out1(ffn_out1),.out2(ffn_out2),.out3(ffn_out3),
        .out4(ffn_out4),.out5(ffn_out5),.out6(ffn_out6),.out7(ffn_out7),
        .done(ffn_done)
    );

    // ── STAGE 6: Residual add 2 (res1 + ffn_out) ──
    reg signed [15:0] res2_0,res2_1,res2_2,res2_3;
    reg signed [15:0] res2_4,res2_5,res2_6,res2_7;

    always @(posedge clk) begin
        if (reset) begin
            res2_0<=0;res2_1<=0;res2_2<=0;res2_3<=0;
            res2_4<=0;res2_5<=0;res2_6<=0;res2_7<=0;
        end else if (state==RES2 && cycle_count==0) begin
            res2_0 <= res1_0 + ffn_out0;
            res2_1 <= res1_1 + ffn_out1;
            res2_2 <= res1_2 + ffn_out2;
            res2_3 <= res1_3 + ffn_out3;
            res2_4 <= res1_4 + ffn_out4;
            res2_5 <= res1_5 + ffn_out5;
            res2_6 <= res1_6 + ffn_out6;
            res2_7 <= res1_7 + ffn_out7;
        end
    end

    assign out0=res2_0; assign out1=res2_1;
    assign out2=res2_2; assign out3=res2_3;
    assign out4=res2_4; assign out5=res2_5;
    assign out6=res2_6; assign out7=res2_7;

endmodule
