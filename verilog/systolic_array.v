// ─────────────────────────────────────────
// 4×4 SYSTOLIC ARRAY
// 16 MAC units connected together
// This is your chip's core compute engine
// ─────────────────────────────────────────

module systolic_array (
    input clk,
    input reset,
    input signed [7:0] a0, a1, a2, a3,  // row inputs
    input signed [7:0] b0, b1, b2, b3,  // column inputs
    output signed [15:0] out00, out01, out02, out03,
    output signed [15:0] out10, out11, out12, out13,
    output signed [15:0] out20, out21, out22, out23,
    output signed [15:0] out30, out31, out32, out33
);

    // Row 0
    mac_unit m00(.clk(clk),.reset(reset),.a(a0),.b(b0),.out(out00));
    mac_unit m01(.clk(clk),.reset(reset),.a(a0),.b(b1),.out(out01));
    mac_unit m02(.clk(clk),.reset(reset),.a(a0),.b(b2),.out(out02));
    mac_unit m03(.clk(clk),.reset(reset),.a(a0),.b(b3),.out(out03));

    // Row 1
    mac_unit m10(.clk(clk),.reset(reset),.a(a1),.b(b0),.out(out10));
    mac_unit m11(.clk(clk),.reset(reset),.a(a1),.b(b1),.out(out11));
    mac_unit m12(.clk(clk),.reset(reset),.a(a1),.b(b2),.out(out12));
    mac_unit m13(.clk(clk),.reset(reset),.a(a1),.b(b3),.out(out13));

    // Row 2
    mac_unit m20(.clk(clk),.reset(reset),.a(a2),.b(b0),.out(out20));
    mac_unit m21(.clk(clk),.reset(reset),.a(a2),.b(b1),.out(out21));
    mac_unit m22(.clk(clk),.reset(reset),.a(a2),.b(b2),.out(out22));
    mac_unit m23(.clk(clk),.reset(reset),.a(a2),.b(b3),.out(out23));

    // Row 3
    mac_unit m30(.clk(clk),.reset(reset),.a(a3),.b(b0),.out(out30));
    mac_unit m31(.clk(clk),.reset(reset),.a(a3),.b(b1),.out(out31));
    mac_unit m32(.clk(clk),.reset(reset),.a(a3),.b(b2),.out(out32));
    mac_unit m33(.clk(clk),.reset(reset),.a(a3),.b(b3),.out(out33));

endmodule