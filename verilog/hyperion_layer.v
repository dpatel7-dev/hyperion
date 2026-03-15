// ─────────────────────────────────────────
// HYPERION LAYER — v0.7 complete
// Full neural network layer:
// input × weight + bias → ReLU
// Mathematically identical to one layer
// of GPT, BERT, or any transformer
// ─────────────────────────────────────────

module hyperion_layer (
    input  clk,
    input  reset,
    input  start,
    // 16 input values
    input  signed [7:0]  a0,a1,a2,a3,a4,a5,a6,a7,
    input  signed [7:0]  a8,a9,a10,a11,a12,a13,a14,a15,
    // 16 weight values
    input  signed [7:0]  w0,w1,w2,w3,w4,w5,w6,w7,
    input  signed [7:0]  w8,w9,w10,w11,w12,w13,w14,w15,
    // 16 bias values
    input  signed [15:0] bias0,bias1,bias2,bias3,
    input  signed [15:0] bias4,bias5,bias6,bias7,
    input  signed [15:0] bias8,bias9,bias10,bias11,
    input  signed [15:0] bias12,bias13,bias14,bias15,
    // 16 outputs — after bias + ReLU
    output signed [15:0] out0,out1,out2,out3,
    output signed [15:0] out4,out5,out6,out7,
    output signed [15:0] out8,out9,out10,out11,
    output signed [15:0] out12,out13,out14,out15,
    output done
);

    // ── internal wires ──
    // row 0 outputs from systolic array
    wire signed [15:0] r0c0,r0c1,r0c2,r0c3;
    wire signed [15:0] r0c4,r0c5,r0c6,r0c7;
    wire signed [15:0] r0c8,r0c9,r0c10,r0c11;
    wire signed [15:0] r0c12,r0c13,r0c14,r0c15;

    // after bias addition
    wire signed [15:0] biased0,biased1,biased2,biased3;
    wire signed [15:0] biased4,biased5,biased6,biased7;
    wire signed [15:0] biased8,biased9,biased10,biased11;
    wire signed [15:0] biased12,biased13,biased14,biased15;

    // unused row outputs
    wire signed [15:0] r1c0,r1c1,r1c2,r1c3,r1c4,r1c5,r1c6,r1c7;
    wire signed [15:0] r1c8,r1c9,r1c10,r1c11,r1c12,r1c13,r1c14,r1c15;
    wire signed [15:0] r2c0,r2c1,r2c2,r2c3,r2c4,r2c5,r2c6,r2c7;
    wire signed [15:0] r2c8,r2c9,r2c10,r2c11,r2c12,r2c13,r2c14,r2c15;
    wire signed [15:0] r3c0,r3c1,r3c2,r3c3,r3c4,r3c5,r3c6,r3c7;
    wire signed [15:0] r3c8,r3c9,r3c10,r3c11,r3c12,r3c13,r3c14,r3c15;
    wire signed [15:0] r4c0,r4c1,r4c2,r4c3,r4c4,r4c5,r4c6,r4c7;
    wire signed [15:0] r4c8,r4c9,r4c10,r4c11,r4c12,r4c13,r4c14,r4c15;
    wire signed [15:0] r5c0,r5c1,r5c2,r5c3,r5c4,r5c5,r5c6,r5c7;
    wire signed [15:0] r5c8,r5c9,r5c10,r5c11,r5c12,r5c13,r5c14,r5c15;
    wire signed [15:0] r6c0,r6c1,r6c2,r6c3,r6c4,r6c5,r6c6,r6c7;
    wire signed [15:0] r6c8,r6c9,r6c10,r6c11,r6c12,r6c13,r6c14,r6c15;
    wire signed [15:0] r7c0,r7c1,r7c2,r7c3,r7c4,r7c5,r7c6,r7c7;
    wire signed [15:0] r7c8,r7c9,r7c10,r7c11,r7c12,r7c13,r7c14,r7c15;
    wire signed [15:0] r8c0,r8c1,r8c2,r8c3,r8c4,r8c5,r8c6,r8c7;
    wire signed [15:0] r8c8,r8c9,r8c10,r8c11,r8c12,r8c13,r8c14,r8c15;
    wire signed [15:0] r9c0,r9c1,r9c2,r9c3,r9c4,r9c5,r9c6,r9c7;
    wire signed [15:0] r9c8,r9c9,r9c10,r9c11,r9c12,r9c13,r9c14,r9c15;
    wire signed [15:0] r10c0,r10c1,r10c2,r10c3,r10c4,r10c5,r10c6,r10c7;
    wire signed [15:0] r10c8,r10c9,r10c10,r10c11,r10c12,r10c13,r10c14,r10c15;
    wire signed [15:0] r11c0,r11c1,r11c2,r11c3,r11c4,r11c5,r11c6,r11c7;
    wire signed [15:0] r11c8,r11c9,r11c10,r11c11,r11c12,r11c13,r11c14,r11c15;
    wire signed [15:0] r12c0,r12c1,r12c2,r12c3,r12c4,r12c5,r12c6,r12c7;
    wire signed [15:0] r12c8,r12c9,r12c10,r12c11,r12c12,r12c13,r12c14,r12c15;
    wire signed [15:0] r13c0,r13c1,r13c2,r13c3,r13c4,r13c5,r13c6,r13c7;
    wire signed [15:0] r13c8,r13c9,r13c10,r13c11,r13c12,r13c13,r13c14,r13c15;
    wire signed [15:0] r14c0,r14c1,r14c2,r14c3,r14c4,r14c5,r14c6,r14c7;
    wire signed [15:0] r14c8,r14c9,r14c10,r14c11,r14c12,r14c13,r14c14,r14c15;
    wire signed [15:0] r15c0,r15c1,r15c2,r15c3,r15c4,r15c5,r15c6,r15c7;
    wire signed [15:0] r15c8,r15c9,r15c10,r15c11,r15c12,r15c13,r15c14,r15c15;

    // sequencer
    reg computing;
    reg [4:0] cycle_count;
    reg bias_enable;
    reg relu_enable;

    assign done = (cycle_count >= 5'd20) && computing;

    always @(posedge clk) begin
        if (reset) begin
            computing   <= 0;
            cycle_count <= 0;
            bias_enable <= 0;
            relu_enable <= 0;
        end else begin
            if (start) begin
                computing   <= 1;
                cycle_count <= 0;
                bias_enable <= 0;
                relu_enable <= 0;
            end
            if (computing) begin
                cycle_count <= cycle_count + 1;
                if (cycle_count >= 5'd8)
                    bias_enable <= 1;
                if (cycle_count >= 5'd10)
                    relu_enable <= 1;
            end
        end
    end

    // ── STAGE 1: 16x16 SYSTOLIC ARRAY ──
    systolic_array_16x16 compute (
        .clk(clk),
        .reset(reset || !computing),
        .a0(a0),  .a1(a1),  .a2(a2),  .a3(a3),
        .a4(a4),  .a5(a5),  .a6(a6),  .a7(a7),
        .a8(a8),  .a9(a9),  .a10(a10),.a11(a11),
        .a12(a12),.a13(a13),.a14(a14),.a15(a15),
        .b0(w0),  .b1(w1),  .b2(w2),  .b3(w3),
        .b4(w4),  .b5(w5),  .b6(w6),  .b7(w7),
        .b8(w8),  .b9(w9),  .b10(w10),.b11(w11),
        .b12(w12),.b13(w13),.b14(w14),.b15(w15),
        .r0c0(r0c0),  .r0c1(r0c1),  .r0c2(r0c2),  .r0c3(r0c3),
        .r0c4(r0c4),  .r0c5(r0c5),  .r0c6(r0c6),  .r0c7(r0c7),
        .r0c8(r0c8),  .r0c9(r0c9),  .r0c10(r0c10),.r0c11(r0c11),
        .r0c12(r0c12),.r0c13(r0c13),.r0c14(r0c14),.r0c15(r0c15),
        .r1c0(r1c0),  .r1c1(r1c1),  .r1c2(r1c2),  .r1c3(r1c3),
        .r1c4(r1c4),  .r1c5(r1c5),  .r1c6(r1c6),  .r1c7(r1c7),
        .r1c8(r1c8),  .r1c9(r1c9),  .r1c10(r1c10),.r1c11(r1c11),
        .r1c12(r1c12),.r1c13(r1c13),.r1c14(r1c14),.r1c15(r1c15),
        .r2c0(r2c0),  .r2c1(r2c1),  .r2c2(r2c2),  .r2c3(r2c3),
        .r2c4(r2c4),  .r2c5(r2c5),  .r2c6(r2c6),  .r2c7(r2c7),
        .r2c8(r2c8),  .r2c9(r2c9),  .r2c10(r2c10),.r2c11(r2c11),
        .r2c12(r2c12),.r2c13(r2c13),.r2c14(r2c14),.r2c15(r2c15),
        .r3c0(r3c0),  .r3c1(r3c1),  .r3c2(r3c2),  .r3c3(r3c3),
        .r3c4(r3c4),  .r3c5(r3c5),  .r3c6(r3c6),  .r3c7(r3c7),
        .r3c8(r3c8),  .r3c9(r3c9),  .r3c10(r3c10),.r3c11(r3c11),
        .r3c12(r3c12),.r3c13(r3c13),.r3c14(r3c14),.r3c15(r3c15),
        .r4c0(r4c0),  .r4c1(r4c1),  .r4c2(r4c2),  .r4c3(r4c3),
        .r4c4(r4c4),  .r4c5(r4c5),  .r4c6(r4c6),  .r4c7(r4c7),
        .r4c8(r4c8),  .r4c9(r4c9),  .r4c10(r4c10),.r4c11(r4c11),
        .r4c12(r4c12),.r4c13(r4c13),.r4c14(r4c14),.r4c15(r4c15),
        .r5c0(r5c0),  .r5c1(r5c1),  .r5c2(r5c2),  .r5c3(r5c3),
        .r5c4(r5c4),  .r5c5(r5c5),  .r5c6(r5c6),  .r5c7(r5c7),
        .r5c8(r5c8),  .r5c9(r5c9),  .r5c10(r5c10),.r5c11(r5c11),
        .r5c12(r5c12),.r5c13(r5c13),.r5c14(r5c14),.r5c15(r5c15),
        .r6c0(r6c0),  .r6c1(r6c1),  .r6c2(r6c2),  .r6c3(r6c3),
        .r6c4(r6c4),  .r6c5(r6c5),  .r6c6(r6c6),  .r6c7(r6c7),
        .r6c8(r6c8),  .r6c9(r6c9),  .r6c10(r6c10),.r6c11(r6c11),
        .r6c12(r6c12),.r6c13(r6c13),.r6c14(r6c14),.r6c15(r6c15),
        .r7c0(r7c0),  .r7c1(r7c1),  .r7c2(r7c2),  .r7c3(r7c3),
        .r7c4(r7c4),  .r7c5(r7c5),  .r7c6(r7c6),  .r7c7(r7c7),
        .r7c8(r7c8),  .r7c9(r7c9),  .r7c10(r7c10),.r7c11(r7c11),
        .r7c12(r7c12),.r7c13(r7c13),.r7c14(r7c14),.r7c15(r7c15),
        .r8c0(r8c0),  .r8c1(r8c1),  .r8c2(r8c2),  .r8c3(r8c3),
        .r8c4(r8c4),  .r8c5(r8c5),  .r8c6(r8c6),  .r8c7(r8c7),
        .r8c8(r8c8),  .r8c9(r8c9),  .r8c10(r8c10),.r8c11(r8c11),
        .r8c12(r8c12),.r8c13(r8c13),.r8c14(r8c14),.r8c15(r8c15),
        .r9c0(r9c0),  .r9c1(r9c1),  .r9c2(r9c2),  .r9c3(r9c3),
        .r9c4(r9c4),  .r9c5(r9c5),  .r9c6(r9c6),  .r9c7(r9c7),
        .r9c8(r9c8),  .r9c9(r9c9),  .r9c10(r9c10),.r9c11(r9c11),
        .r9c12(r9c12),.r9c13(r9c13),.r9c14(r9c14),.r9c15(r9c15),
        .r10c0(r10c0),.r10c1(r10c1),.r10c2(r10c2),.r10c3(r10c3),
        .r10c4(r10c4),.r10c5(r10c5),.r10c6(r10c6),.r10c7(r10c7),
        .r10c8(r10c8),.r10c9(r10c9),.r10c10(r10c10),.r10c11(r10c11),
        .r10c12(r10c12),.r10c13(r10c13),.r10c14(r10c14),.r10c15(r10c15),
        .r11c0(r11c0),.r11c1(r11c1),.r11c2(r11c2),.r11c3(r11c3),
        .r11c4(r11c4),.r11c5(r11c5),.r11c6(r11c6),.r11c7(r11c7),
        .r11c8(r11c8),.r11c9(r11c9),.r11c10(r11c10),.r11c11(r11c11),
        .r11c12(r11c12),.r11c13(r11c13),.r11c14(r11c14),.r11c15(r11c15),
        .r12c0(r12c0),.r12c1(r12c1),.r12c2(r12c2),.r12c3(r12c3),
        .r12c4(r12c4),.r12c5(r12c5),.r12c6(r12c6),.r12c7(r12c7),
        .r12c8(r12c8),.r12c9(r12c9),.r12c10(r12c10),.r12c11(r12c11),
        .r12c12(r12c12),.r12c13(r12c13),.r12c14(r12c14),.r12c15(r12c15),
        .r13c0(r13c0),.r13c1(r13c1),.r13c2(r13c2),.r13c3(r13c3),
        .r13c4(r13c4),.r13c5(r13c5),.r13c6(r13c6),.r13c7(r13c7),
        .r13c8(r13c8),.r13c9(r13c9),.r13c10(r13c10),.r13c11(r13c11),
        .r13c12(r13c12),.r13c13(r13c13),.r13c14(r13c14),.r13c15(r13c15),
        .r14c0(r14c0),.r14c1(r14c1),.r14c2(r14c2),.r14c3(r14c3),
        .r14c4(r14c4),.r14c5(r14c5),.r14c6(r14c6),.r14c7(r14c7),
        .r14c8(r14c8),.r14c9(r14c9),.r14c10(r14c10),.r14c11(r14c11),
        .r14c12(r14c12),.r14c13(r14c13),.r14c14(r14c14),.r14c15(r14c15),
        .r15c0(r15c0),.r15c1(r15c1),.r15c2(r15c2),.r15c3(r15c3),
        .r15c4(r15c4),.r15c5(r15c5),.r15c6(r15c6),.r15c7(r15c7),
        .r15c8(r15c8),.r15c9(r15c9),.r15c10(r15c10),.r15c11(r15c11),
        .r15c12(r15c12),.r15c13(r15c13),.r15c14(r15c14),.r15c15(r15c15)
    );

    // ── STAGE 2: BIAS UNIT ──
    bias_unit bias_add (
        .clk(clk),.reset(reset),.enable(bias_enable),
        .in0(r0c0),  .in1(r0c1),  .in2(r0c2),  .in3(r0c3),
        .in4(r0c4),  .in5(r0c5),  .in6(r0c6),  .in7(r0c7),
        .in8(r0c8),  .in9(r0c9),  .in10(r0c10),.in11(r0c11),
        .in12(r0c12),.in13(r0c13),.in14(r0c14),.in15(r0c15),
        .b0(bias0),  .b1(bias1),  .b2(bias2),  .b3(bias3),
        .b4(bias4),  .b5(bias5),  .b6(bias6),  .b7(bias7),
        .b8(bias8),  .b9(bias9),  .b10(bias10),.b11(bias11),
        .b12(bias12),.b13(bias13),.b14(bias14),.b15(bias15),
        .out0(biased0),  .out1(biased1),  .out2(biased2),  .out3(biased3),
        .out4(biased4),  .out5(biased5),  .out6(biased6),  .out7(biased7),
        .out8(biased8),  .out9(biased9),  .out10(biased10),.out11(biased11),
        .out12(biased12),.out13(biased13),.out14(biased14),.out15(biased15)
    );

    // ── STAGE 3: RELU UNIT ──
    relu_unit activation (
        .clk(clk),.reset(reset),.enable(relu_enable),
        .in00(biased0),  .in01(biased1),  .in02(biased2),  .in03(biased3),
        .in04(biased4),  .in05(biased5),  .in06(biased6),  .in07(biased7),
        .in08(biased8),  .in09(biased9),  .in10(biased10), .in11(biased11),
        .in12(biased12), .in13(biased13), .in14(biased14), .in15(biased15),
        .out00(out0),  .out01(out1),  .out02(out2),  .out03(out3),
        .out04(out4),  .out05(out5),  .out06(out6),  .out07(out7),
        .out08(out8),  .out09(out9),  .out10(out10), .out11(out11),
        .out12(out12), .out13(out13), .out14(out14), .out15(out15)
    );

endmodule