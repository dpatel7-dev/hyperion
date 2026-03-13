// ─────────────────────────────────────────
// HYPERION — complete AI chip
// SRAM + Systolic Array connected together
// ─────────────────────────────────────────

module hyperion (
    input clk,
    input reset,

    // memory interface
    input write_enable,
    input [5:0] address,
    input signed [7:0] data_in,

    // compute inputs
    input signed [7:0] a0,a1,a2,a3,

    // outputs
    output signed [15:0] out00,out01,out02,out03,
    output signed [15:0] out10,out11,out12,out13,
    output signed [15:0] out20,out21,out22,out23,
    output signed [15:0] out30,out31,out32,out33
);
    // memory output wire
    wire signed [7:0] weight;

    // SRAM — stores weights
    sram memory (
        .clk(clk),
        .write_enable(write_enable),
        .address(address),
        .data_in(data_in),
        .data_out(weight)
    );

    // Systolic array — does the math
    // weights from SRAM feed into b inputs
    systolic_array compute (
        .clk(clk),
        .reset(reset),
        .a0(a0),.a1(a1),.a2(a2),.a3(a3),
        .b0(weight),.b1(weight),
        .b2(weight),.b3(weight),
        .out00(out00),.out01(out01),
        .out02(out02),.out03(out03),
        .out10(out10),.out11(out11),
        .out12(out12),.out13(out13),
        .out20(out20),.out21(out21),
        .out22(out22),.out23(out23),
        .out30(out30),.out31(out31),
        .out32(out32),.out33(out33)
    );

endmodule