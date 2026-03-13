// ─────────────────────────────────────────
// MAC UNIT — Multiply Accumulate
// The single building block of your AI chip
// This is what your systolic_multiply() 
// function looks like as real hardware
// ─────────────────────────────────────────

module mac_unit (
    input  clk,              // clock — heartbeat of the chip
    input  reset,            // reset everything to zero
    input  signed [7:0] a,   // 8-bit input A
    input  signed [7:0] b,   // 8-bit input B
    output signed [15:0] out // 16-bit result (bigger to avoid overflow)
);

    reg signed [15:0] accumulator;

    always @(posedge clk) begin
        if (reset)
            accumulator <= 0;
        else
            accumulator <= accumulator + (a * b);
    end

    assign out = accumulator;

endmodule