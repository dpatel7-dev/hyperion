// ─────────────────────────────────────────
// HYPERION 8×8 SYSTOLIC ARRAY
// 64 MAC units running in parallel
// 4× the compute power of v0.5
// ─────────────────────────────────────────

module systolic_array_8x8 (
    input clk,
    input reset,
    input signed [7:0] a0,a1,a2,a3,a4,a5,a6,a7,
    input signed [7:0] b0,b1,b2,b3,b4,b5,b6,b7,
    output signed [15:0] out00,out01,out02,out03,out04,out05,out06,out07,
    output signed [15:0] out10,out11,out12,out13,out14,out15,out16,out17,
    output signed [15:0] out20,out21,out22,out23,out24,out25,out26,out27,
    output signed [15:0] out30,out31,out32,out33,out34,out35,out36,out37,
    output signed [15:0] out40,out41,out42,out43,out44,out45,out46,out47,
    output signed [15:0] out50,out51,out52,out53,out54,out55,out56,out57,
    output signed [15:0] out60,out61,out62,out63,out64,out65,out66,out67,
    output signed [15:0] out70,out71,out72,out73,out74,out75,out76,out77
);
    // Row 0
    mac_unit m00(.clk(clk),.reset(reset),.a(a0),.b(b0),.out(out00));
    mac_unit m01(.clk(clk),.reset(reset),.a(a0),.b(b1),.out(out01));
    mac_unit m02(.clk(clk),.reset(reset),.a(a0),.b(b2),.out(out02));
    mac_unit m03(.clk(clk),.reset(reset),.a(a0),.b(b3),.out(out03));
    mac_unit m04(.clk(clk),.reset(reset),.a(a0),.b(b4),.out(out04));
    mac_unit m05(.clk(clk),.reset(reset),.a(a0),.b(b5),.out(out05));
    mac_unit m06(.clk(clk),.reset(reset),.a(a0),.b(b6),.out(out06));
    mac_unit m07(.clk(clk),.reset(reset),.a(a0),.b(b7),.out(out07));

    // Row 1
    mac_unit m10(.clk(clk),.reset(reset),.a(a1),.b(b0),.out(out10));
    mac_unit m11(.clk(clk),.reset(reset),.a(a1),.b(b1),.out(out11));
    mac_unit m12(.clk(clk),.reset(reset),.a(a1),.b(b2),.out(out12));
    mac_unit m13(.clk(clk),.reset(reset),.a(a1),.b(b3),.out(out13));
    mac_unit m14(.clk(clk),.reset(reset),.a(a1),.b(b4),.out(out14));
    mac_unit m15(.clk(clk),.reset(reset),.a(a1),.b(b5),.out(out15));
    mac_unit m16(.clk(clk),.reset(reset),.a(a1),.b(b6),.out(out16));
    mac_unit m17(.clk(clk),.reset(reset),.a(a1),.b(b7),.out(out17));

    // Row 2
    mac_unit m20(.clk(clk),.reset(reset),.a(a2),.b(b0),.out(out20));
    mac_unit m21(.clk(clk),.reset(reset),.a(a2),.b(b1),.out(out21));
    mac_unit m22(.clk(clk),.reset(reset),.a(a2),.b(b2),.out(out22));
    mac_unit m23(.clk(clk),.reset(reset),.a(a2),.b(b3),.out(out23));
    mac_unit m24(.clk(clk),.reset(reset),.a(a2),.b(b4),.out(out24));
    mac_unit m25(.clk(clk),.reset(reset),.a(a2),.b(b5),.out(out25));
    mac_unit m26(.clk(clk),.reset(reset),.a(a2),.b(b6),.out(out26));
    mac_unit m27(.clk(clk),.reset(reset),.a(a2),.b(b7),.out(out27));

    // Row 3
    mac_unit m30(.clk(clk),.reset(reset),.a(a3),.b(b0),.out(out30));
    mac_unit m31(.clk(clk),.reset(reset),.a(a3),.b(b1),.out(out31));
    mac_unit m32(.clk(clk),.reset(reset),.a(a3),.b(b2),.out(out32));
    mac_unit m33(.clk(clk),.reset(reset),.a(a3),.b(b3),.out(out33));
    mac_unit m34(.clk(clk),.reset(reset),.a(a3),.b(b4),.out(out34));
    mac_unit m35(.clk(clk),.reset(reset),.a(a3),.b(b5),.out(out35));
    mac_unit m36(.clk(clk),.reset(reset),.a(a3),.b(b6),.out(out36));
    mac_unit m37(.clk(clk),.reset(reset),.a(a3),.b(b7),.out(out37));

    // Row 4
    mac_unit m40(.clk(clk),.reset(reset),.a(a4),.b(b0),.out(out40));
    mac_unit m41(.clk(clk),.reset(reset),.a(a4),.b(b1),.out(out41));
    mac_unit m42(.clk(clk),.reset(reset),.a(a4),.b(b2),.out(out42));
    mac_unit m43(.clk(clk),.reset(reset),.a(a4),.b(b3),.out(out43));
    mac_unit m44(.clk(clk),.reset(reset),.a(a4),.b(b4),.out(out44));
    mac_unit m45(.clk(clk),.reset(reset),.a(a4),.b(b5),.out(out45));
    mac_unit m46(.clk(clk),.reset(reset),.a(a4),.b(b6),.out(out46));
    mac_unit m47(.clk(clk),.reset(reset),.a(a4),.b(b7),.out(out47));

    // Row 5
    mac_unit m50(.clk(clk),.reset(reset),.a(a5),.b(b0),.out(out50));
    mac_unit m51(.clk(clk),.reset(reset),.a(a5),.b(b1),.out(out51));
    mac_unit m52(.clk(clk),.reset(reset),.a(a5),.b(b2),.out(out52));
    mac_unit m53(.clk(clk),.reset(reset),.a(a5),.b(b3),.out(out53));
    mac_unit m54(.clk(clk),.reset(reset),.a(a5),.b(b4),.out(out54));
    mac_unit m55(.clk(clk),.reset(reset),.a(a5),.b(b5),.out(out55));
    mac_unit m56(.clk(clk),.reset(reset),.a(a5),.b(b6),.out(out56));
    mac_unit m57(.clk(clk),.reset(reset),.a(a5),.b(b7),.out(out57));

    // Row 6
    mac_unit m60(.clk(clk),.reset(reset),.a(a6),.b(b0),.out(out60));
    mac_unit m61(.clk(clk),.reset(reset),.a(a6),.b(b1),.out(out61));
    mac_unit m62(.clk(clk),.reset(reset),.a(a6),.b(b2),.out(out62));
    mac_unit m63(.clk(clk),.reset(reset),.a(a6),.b(b3),.out(out63));
    mac_unit m64(.clk(clk),.reset(reset),.a(a6),.b(b4),.out(out64));
    mac_unit m65(.clk(clk),.reset(reset),.a(a6),.b(b5),.out(out65));
    mac_unit m66(.clk(clk),.reset(reset),.a(a6),.b(b6),.out(out66));
    mac_unit m67(.clk(clk),.reset(reset),.a(a6),.b(b7),.out(out67));

    // Row 7
    mac_unit m70(.clk(clk),.reset(reset),.a(a7),.b(b0),.out(out70));
    mac_unit m71(.clk(clk),.reset(reset),.a(a7),.b(b1),.out(out71));
    mac_unit m72(.clk(clk),.reset(reset),.a(a7),.b(b2),.out(out72));
    mac_unit m73(.clk(clk),.reset(reset),.a(a7),.b(b3),.out(out73));
    mac_unit m74(.clk(clk),.reset(reset),.a(a7),.b(b4),.out(out74));
    mac_unit m75(.clk(clk),.reset(reset),.a(a7),.b(b5),.out(out75));
    mac_unit m76(.clk(clk),.reset(reset),.a(a7),.b(b6),.out(out76));
    mac_unit m77(.clk(clk),.reset(reset),.a(a7),.b(b7),.out(out77));

endmodule