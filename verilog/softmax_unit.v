// ─────────────────────────────────────────
// HYPERION SOFTMAX UNIT
// Converts attention scores to probabilities
//
// Formula: softmax(x_i) = e^x_i / sum(e^x_j)
//
// Hardware approximation:
// exp(x) ≈ piecewise linear lookup
// This is the same technique used in
// Google TPU and Apple Neural Engine.
//
// Output: 8 values that sum to ~256
// (fixed-point, scaled by 256)
// ─────────────────────────────────────────

module softmax_unit (
    input  clk,
    input  reset,
    input  enable,

    // 8 input scores
    input  signed [15:0] x0,x1,x2,x3,x4,x5,x6,x7,

    // 8 output probabilities (scaled by 256)
    output [15:0] out0,out1,out2,out3,
    output [15:0] out4,out5,out6,out7
);

    // ── STEP 1: find max for numerical stability ──
    // subtract max before exp to prevent overflow
    wire signed [15:0] m01 = (x0 > x1) ? x0 : x1;
    wire signed [15:0] m23 = (x2 > x3) ? x2 : x3;
    wire signed [15:0] m45 = (x4 > x5) ? x4 : x5;
    wire signed [15:0] m67 = (x6 > x7) ? x6 : x7;
    wire signed [15:0] m0123 = (m01 > m23) ? m01 : m23;
    wire signed [15:0] m4567 = (m45 > m67) ? m45 : m67;
    wire signed [15:0] xmax  = (m0123 > m4567) ? m0123 : m4567;

    // ── STEP 2: shifted inputs (x - xmax) ──
    wire signed [15:0] s0 = x0 - xmax;
    wire signed [15:0] s1 = x1 - xmax;
    wire signed [15:0] s2 = x2 - xmax;
    wire signed [15:0] s3 = x3 - xmax;
    wire signed [15:0] s4 = x4 - xmax;
    wire signed [15:0] s5 = x5 - xmax;
    wire signed [15:0] s6 = x6 - xmax;
    wire signed [15:0] s7 = x7 - xmax;

    // ── STEP 3: exp approximation ──
    // exp(x) for x <= 0, scaled by 256
    // exp(0)  = 256
    // exp(-1) ≈ 94
    // exp(-2) ≈ 35
    // exp(-3) ≈ 13
    // exp(-4) ≈ 5
    // exp(-5) ≈ 2
    // exp(x<-5) ≈ 1 (floor)
    function [15:0] exp_approx;
        input signed [15:0] v;
        begin
            if      (v >= 0)   exp_approx = 256;
            else if (v >= -1)  exp_approx = 175 + v[7:0];
            else if (v >= -2)  exp_approx = 94;
            else if (v >= -3)  exp_approx = 35;
            else if (v >= -4)  exp_approx = 13;
            else if (v >= -5)  exp_approx = 5;
            else if (v >= -6)  exp_approx = 2;
            else               exp_approx = 1;
        end
    endfunction

    wire [15:0] e0 = exp_approx(s0);
    wire [15:0] e1 = exp_approx(s1);
    wire [15:0] e2 = exp_approx(s2);
    wire [15:0] e3 = exp_approx(s3);
    wire [15:0] e4 = exp_approx(s4);
    wire [15:0] e5 = exp_approx(s5);
    wire [15:0] e6 = exp_approx(s6);
    wire [15:0] e7 = exp_approx(s7);

    // ── STEP 4: sum of exp values ──
    wire [18:0] esum = e0+e1+e2+e3+e4+e5+e6+e7;

    // ── STEP 5: normalize (divide by sum, scale by 256) ──
    // out_i = (e_i * 256) / esum
    assign out0 = enable ? (e0 << 8) / esum : 0;
    assign out1 = enable ? (e1 << 8) / esum : 0;
    assign out2 = enable ? (e2 << 8) / esum : 0;
    assign out3 = enable ? (e3 << 8) / esum : 0;
    assign out4 = enable ? (e4 << 8) / esum : 0;
    assign out5 = enable ? (e5 << 8) / esum : 0;
    assign out6 = enable ? (e6 << 8) / esum : 0;
    assign out7 = enable ? (e7 << 8) / esum : 0;

endmodule
