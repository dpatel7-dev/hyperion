// ─────────────────────────────────────────
// HYPERION LAYERNORM UNIT
// Normalizes activations for stable training
//
// Formula: out = (x - mean) / sqrt(var + eps)
//          then scale by gamma and shift by beta
//
// Used in every transformer:
// GPT, BERT, Gemini — all use LayerNorm
// before attention and before FFN
//
// Integer approximation:
// mean = sum(x) / N
// var  = sum((x - mean)^2) / N
// norm = (x - mean) / isqrt(var + 1)
// ─────────────────────────────────────────

module layernorm_unit (
    input  clk,
    input  reset,
    input  enable,

    // 8 inputs (one vector to normalize)
    input  signed [15:0] x0,x1,x2,x3,
    input  signed [15:0] x4,x5,x6,x7,

    // learnable scale and shift (gamma, beta)
    input  signed [7:0] gamma0,gamma1,gamma2,gamma3,
    input  signed [7:0] gamma4,gamma5,gamma6,gamma7,
    input  signed [7:0] beta0,beta1,beta2,beta3,
    input  signed [7:0] beta4,beta5,beta6,beta7,

    // normalized outputs
    output signed [15:0] out0,out1,out2,out3,
    output signed [15:0] out4,out5,out6,out7
);

    // ── STEP 1: compute mean = sum(x) / 8 ──
    wire signed [18:0] sum_x =
        x0 + x1 + x2 + x3 + x4 + x5 + x6 + x7;
    wire signed [15:0] mean = sum_x >>> 3;  // divide by 8

    // ── STEP 2: center inputs (x - mean) ──
    wire signed [15:0] c0 = x0 - mean;
    wire signed [15:0] c1 = x1 - mean;
    wire signed [15:0] c2 = x2 - mean;
    wire signed [15:0] c3 = x3 - mean;
    wire signed [15:0] c4 = x4 - mean;
    wire signed [15:0] c5 = x5 - mean;
    wire signed [15:0] c6 = x6 - mean;
    wire signed [15:0] c7 = x7 - mean;

    // ── STEP 3: compute variance = sum(c^2) / 8 ──
    wire signed [31:0] sq0 = c0 * c0;
    wire signed [31:0] sq1 = c1 * c1;
    wire signed [31:0] sq2 = c2 * c2;
    wire signed [31:0] sq3 = c3 * c3;
    wire signed [31:0] sq4 = c4 * c4;
    wire signed [31:0] sq5 = c5 * c5;
    wire signed [31:0] sq6 = c6 * c6;
    wire signed [31:0] sq7 = c7 * c7;

    wire signed [34:0] sum_sq =
        sq0 + sq1 + sq2 + sq3 + sq4 + sq5 + sq6 + sq7;
    wire [31:0] variance = sum_sq[34:3];  // divide by 8, unsigned

    // ── STEP 4: integer sqrt approximation ──
    // isqrt using lookup for small values
    // for larger values use bit-shift approximation
    // isqrt(v) ≈ v >> (msb(v)/2)
    // epsilon = 1 to avoid div by zero
    reg [15:0] std_dev;
    always @(*) begin
        if      (variance == 0)          std_dev = 1;
        else if (variance < 4)           std_dev = 1;
        else if (variance < 16)          std_dev = 2;
        else if (variance < 64)          std_dev = 4;
        else if (variance < 256)         std_dev = 8;
        else if (variance < 1024)        std_dev = 16;
        else if (variance < 4096)        std_dev = 32;
        else if (variance < 16384)       std_dev = 64;
        else if (variance < 65536)       std_dev = 128;
        else if (variance < 262144)      std_dev = 256;
        else if (variance < 1048576)     std_dev = 512;
        else if (variance < 4194304)     std_dev = 1024;
        else if (variance < 16777216)    std_dev = 2048;
        else                             std_dev = 4096;
    end

    // ── STEP 5: normalize = centered / std_dev ──
    wire signed [15:0] n0 = (std_dev > 0) ? c0 / $signed({1'b0, std_dev}) : c0;
    wire signed [15:0] n1 = (std_dev > 0) ? c1 / $signed({1'b0, std_dev}) : c1;
    wire signed [15:0] n2 = (std_dev > 0) ? c2 / $signed({1'b0, std_dev}) : c2;
    wire signed [15:0] n3 = (std_dev > 0) ? c3 / $signed({1'b0, std_dev}) : c3;
    wire signed [15:0] n4 = (std_dev > 0) ? c4 / $signed({1'b0, std_dev}) : c4;
    wire signed [15:0] n5 = (std_dev > 0) ? c5 / $signed({1'b0, std_dev}) : c5;
    wire signed [15:0] n6 = (std_dev > 0) ? c6 / $signed({1'b0, std_dev}) : c6;
    wire signed [15:0] n7 = (std_dev > 0) ? c7 / $signed({1'b0, std_dev}) : c7;

    // ── STEP 6: scale and shift (gamma * n + beta) ──
    wire signed [23:0] s0 = $signed(gamma0) * n0 + $signed({beta0, 8'b0});
    wire signed [23:0] s1 = $signed(gamma1) * n1 + $signed({beta1, 8'b0});
    wire signed [23:0] s2 = $signed(gamma2) * n2 + $signed({beta2, 8'b0});
    wire signed [23:0] s3 = $signed(gamma3) * n3 + $signed({beta3, 8'b0});
    wire signed [23:0] s4 = $signed(gamma4) * n4 + $signed({beta4, 8'b0});
    wire signed [23:0] s5 = $signed(gamma5) * n5 + $signed({beta5, 8'b0});
    wire signed [23:0] s6 = $signed(gamma6) * n6 + $signed({beta6, 8'b0});
    wire signed [23:0] s7 = $signed(gamma7) * n7 + $signed({beta7, 8'b0});

    assign out0 = enable ? s0[15:0] : x0;
    assign out1 = enable ? s1[15:0] : x1;
    assign out2 = enable ? s2[15:0] : x2;
    assign out3 = enable ? s3[15:0] : x3;
    assign out4 = enable ? s4[15:0] : x4;
    assign out5 = enable ? s5[15:0] : x5;
    assign out6 = enable ? s6[15:0] : x6;
    assign out7 = enable ? s7[15:0] : x7;

endmodule
