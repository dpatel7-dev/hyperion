// ─────────────────────────────────────────
// HYPERION BF16 MULTIPLY UNIT
// Brain Float 16 — used in Google TPU,
// Nvidia H100, Apple Neural Engine
//
// Format: 1 sign + 8 exponent + 7 mantissa
// Same exponent range as FP32
// Just FP32 with bottom 16 bits dropped
//
// This is the most important number format
// in modern AI training.
// ─────────────────────────────────────────

module bf16_mul (
    input  [15:0] a,    // BF16 input A
    input  [15:0] b,    // BF16 input B
    output [15:0] out   // BF16 result
);

    // ── unpack ──
    wire        sign_a  = a[15];
    wire [7:0]  exp_a   = a[14:7];
    wire [6:0]  mant_a  = a[6:0];   // 7-bit mantissa

    wire        sign_b  = b[15];
    wire [7:0]  exp_b   = b[14:7];
    wire [6:0]  mant_b  = b[6:0];   // 7-bit mantissa

    // ── result sign: XOR of input signs ──
    wire sign_out = sign_a ^ sign_b;

    // ── handle special cases ──
    wire a_zero = (exp_a == 8'h00);
    wire b_zero = (exp_b == 8'h00);
    wire a_inf  = (exp_a == 8'hFF) && (mant_a == 7'h00);
    wire b_inf  = (exp_b == 8'hFF) && (mant_b == 7'h00);
    wire a_nan  = (exp_a == 8'hFF) && (mant_a != 7'h00);
    wire b_nan  = (exp_b == 8'hFF) && (mant_b != 7'h00);

    // ── multiply mantissas (add implicit leading 1) ──
    // {1,mant} = 8-bit × 8-bit = 16-bit product
    wire [7:0]  full_a = {1'b1, mant_a};  // 1.mantissa — explicitly 8 bits
    wire [7:0]  full_b = {1'b1, mant_b};
    wire [15:0] mant_product = {8'h00,full_a} * {8'h00,full_b};  // explicit 16-bit

    // ── add exponents (subtract bias 127) ──
    wire [8:0]  exp_sum = {1'b0, exp_a} + {1'b0, exp_b} - 9'd127;

    // ── normalize: if product bit 15 set, shift right and inc exp ──
    wire        norm_shift = mant_product[15];
    wire [6:0]  mant_out   = norm_shift ? mant_product[14:8]
                                        : mant_product[13:7];
    wire [8:0]  exp_out    = norm_shift ? exp_sum + 1 : exp_sum;

    // ── detect overflow/underflow ──
    // exp_sum is 9-bit unsigned: valid range 1..254
    // if > 255 → overflow, if 0 → underflow
    // we computed: exp_a + exp_b - 127
    // for 1.0*2.0: 127+128-127=128 → fine
    // overflow when exp_sum >= 255 (bit8 set and nonzero lower)
    // underflow when exp_sum wraps negative (bit8 set with borrow)
    wire overflow  = (exp_out >= 9'd255);
    wire underflow = (exp_out == 9'd0) && !(a_zero || b_zero);

    // ── pack result ──
    assign out =
        a_nan || b_nan           ? 16'h7FC0 :  // NaN
        a_zero || b_zero         ? 16'h0000 :  // zero
        a_inf  || b_inf          ? {sign_out, 8'hFF, 7'h00} :  // inf
        overflow                 ? {sign_out, 8'hFF, 7'h00} :  // overflow → inf
        underflow                ? 16'h0000 :  // underflow → 0
        {sign_out, exp_out[7:0], mant_out};    // normal result

endmodule
