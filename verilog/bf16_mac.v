// ─────────────────────────────────────────
// HYPERION BF16 MAC UNIT
// Multiply-Accumulate in BF16
// out = out + a * b
// This is the atom of AI training
// ─────────────────────────────────────────

module bf16_mac (
    input  clk,
    input  reset,
    input  enable,
    input  [15:0] a,
    input  [15:0] b,
    output [15:0] out
);
    wire [15:0] product;
    wire [15:0] accumulated;

    bf16_mul mul_unit (.a(a), .b(b), .out(product));
    bf16_add add_unit (.a(out), .b(product), .out(accumulated));

    reg [15:0] acc;
    assign out = acc;

    always @(posedge clk) begin
        if (reset)        acc <= 16'h0000;
        else if (enable)  acc <= accumulated;
    end
endmodule
