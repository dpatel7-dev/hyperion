// ─────────────────────────────────────────
// SRAM — Static Random Access Memory
// Hyperion's on-chip weight storage
// This is where your neural network weights
// live during inference and training
// ─────────────────────────────────────────

module sram (
    input clk,
    input write_enable,        // 1 = write, 0 = read
    input [5:0] address,       // 64 memory locations (6-bit address)
    input signed [7:0] data_in, // data to write
    output reg signed [7:0] data_out // data to read
);
    // 64 locations of 8-bit storage
    // on a real chip this would be millions of locations
    reg signed [7:0] memory [0:63];

    // initialize all memory to zero
    integer i;
    initial begin
        for (i = 0; i < 64; i = i + 1)
            memory[i] = 0;
    end

    always @(posedge clk) begin
        if (write_enable)
            memory[address] <= data_in;  // write mode
        else
            data_out <= memory[address]; // read mode
    end

endmodule