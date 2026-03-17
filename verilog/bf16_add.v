// ─────────────────────────────────────────
// HYPERION BF16 ADD UNIT
// ─────────────────────────────────────────

module bf16_add (
    input  [15:0] a,
    input  [15:0] b,
    output [15:0] out
);

    wire        sign_a = a[15];
    wire [7:0]  exp_a  = a[14:7];
    wire [6:0]  mant_a = a[6:0];

    wire        sign_b = b[15];
    wire [7:0]  exp_b  = b[14:7];
    wire [6:0]  mant_b = b[6:0];

    // ── align: shift smaller exponent mantissa right ──
    wire        a_larger  = (exp_a >= exp_b);
    wire [7:0]  exp_big   = a_larger ? exp_a  : exp_b;
    wire [7:0]  exp_diff  = a_larger ? exp_a - exp_b : exp_b - exp_a;

    // full mantissa with implicit 1
    wire [7:0]  full_big  = a_larger ? {1'b1, mant_a} : {1'b1, mant_b};
    wire [7:0]  full_sml  = a_larger ? {1'b1, mant_b} : {1'b1, mant_a};
    wire        sign_big  = a_larger ? sign_a : sign_b;
    wire        sign_sml  = a_larger ? sign_b : sign_a;

    // shift smaller mantissa to align
    wire [7:0]  shifted   = (exp_diff >= 8) ? 8'h00 : (full_sml >> exp_diff);

    // ── add or subtract based on signs ──
    wire        same_sign = (sign_big == sign_sml);
    wire [8:0]  sum       = same_sign ? {1'b0,full_big} + {1'b0,shifted}
                                      : {1'b0,full_big} - {1'b0,shifted};
    wire        res_sign  = same_sign ? sign_big
                                      : (full_big >= shifted) ? sign_big : sign_sml;

    // ── normalize result ──
    wire        carry     = sum[8];
    wire [7:0]  norm_mant = carry ? sum[8:1] : sum[7:0];
    wire [8:0]  norm_exp  = carry ? {1'b0,exp_big} + 1 : {1'b0,exp_big};

    wire a_zero = (exp_a == 0);
    wire b_zero = (exp_b == 0);

    assign out =
        a_zero ? b :
        b_zero ? a :
        (sum == 0) ? 16'h0000 :
        {res_sign, norm_exp[7:0], norm_mant[6:0]};

endmodule
