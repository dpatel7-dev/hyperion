// ─────────────────────────────────────────
// HYPERION RELU UNIT
// Applies ReLU activation to all 256
// outputs of the 16x16 systolic array
// ReLU: output = max(0, input)
// Negative values → 0
// Positive values → unchanged
// ─────────────────────────────────────────

module relu_unit (
    input  clk,
    input  reset,
    input  enable,
    // 256 inputs from systolic array
    input  signed [15:0] in00, in01, in02, in03,
    input  signed [15:0] in04, in05, in06, in07,
    input  signed [15:0] in08, in09, in10, in11,
    input  signed [15:0] in12, in13, in14, in15,
    // outputs — activated values
    output signed [15:0] out00, out01, out02, out03,
    output signed [15:0] out04, out05, out06, out07,
    output signed [15:0] out08, out09, out10, out11,
    output signed [15:0] out12, out13, out14, out15
);
    // ReLU is just: if negative set to 0
    // The sign bit is bit 15 — if 1 the number is negative
    assign out00 = (enable && in00[15]) ? 16'sd0 : in00;
    assign out01 = (enable && in01[15]) ? 16'sd0 : in01;
    assign out02 = (enable && in02[15]) ? 16'sd0 : in02;
    assign out03 = (enable && in03[15]) ? 16'sd0 : in03;
    assign out04 = (enable && in04[15]) ? 16'sd0 : in04;
    assign out05 = (enable && in05[15]) ? 16'sd0 : in05;
    assign out06 = (enable && in06[15]) ? 16'sd0 : in06;
    assign out07 = (enable && in07[15]) ? 16'sd0 : in07;
    assign out08 = (enable && in08[15]) ? 16'sd0 : in08;
    assign out09 = (enable && in09[15]) ? 16'sd0 : in09;
    assign out10 = (enable && in10[15]) ? 16'sd0 : in10;
    assign out11 = (enable && in11[15]) ? 16'sd0 : in11;
    assign out12 = (enable && in12[15]) ? 16'sd0 : in12;
    assign out13 = (enable && in13[15]) ? 16'sd0 : in13;
    assign out14 = (enable && in14[15]) ? 16'sd0 : in14;
    assign out15 = (enable && in15[15]) ? 16'sd0 : in15;

endmodule