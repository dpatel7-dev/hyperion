// ─────────────────────────────────────────
// HYPERION BIAS UNIT
// Adds a learnable bias to each output
// output = input + bias
// Runs between systolic array and ReLU
// Every neuron in GPT has one of these
// ─────────────────────────────────────────

module bias_unit (
    input  clk,
    input  reset,
    input  enable,
    // 16 inputs from systolic array
    input  signed [15:0] in0,  in1,  in2,  in3,
    input  signed [15:0] in4,  in5,  in6,  in7,
    input  signed [15:0] in8,  in9,  in10, in11,
    input  signed [15:0] in12, in13, in14, in15,
    // 16 bias values — one per neuron
    input  signed [15:0] b0,  b1,  b2,  b3,
    input  signed [15:0] b4,  b5,  b6,  b7,
    input  signed [15:0] b8,  b9,  b10, b11,
    input  signed [15:0] b12, b13, b14, b15,
    // 16 outputs = input + bias
    output signed [15:0] out0,  out1,  out2,  out3,
    output signed [15:0] out4,  out5,  out6,  out7,
    output signed [15:0] out8,  out9,  out10, out11,
    output signed [15:0] out12, out13, out14, out15
);
    // when enabled add bias, otherwise pass through
    assign out0  = enable ? (in0  + b0)  : in0;
    assign out1  = enable ? (in1  + b1)  : in1;
    assign out2  = enable ? (in2  + b2)  : in2;
    assign out3  = enable ? (in3  + b3)  : in3;
    assign out4  = enable ? (in4  + b4)  : in4;
    assign out5  = enable ? (in5  + b5)  : in5;
    assign out6  = enable ? (in6  + b6)  : in6;
    assign out7  = enable ? (in7  + b7)  : in7;
    assign out8  = enable ? (in8  + b8)  : in8;
    assign out9  = enable ? (in9  + b9)  : in9;
    assign out10 = enable ? (in10 + b10) : in10;
    assign out11 = enable ? (in11 + b11) : in11;
    assign out12 = enable ? (in12 + b12) : in12;
    assign out13 = enable ? (in13 + b13) : in13;
    assign out14 = enable ? (in14 + b14) : in14;
    assign out15 = enable ? (in15 + b15) : in15;

endmodule