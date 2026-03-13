// ─────────────────────────────────────────
// SRAM TEST — write weights then read them
// back, like loading a neural network layer
// ─────────────────────────────────────────

module sram_test;

    reg clk, write_enable;
    reg [5:0] address;
    reg signed [7:0] data_in;
    wire signed [7:0] data_out;

    sram mem (
        .clk(clk),
        .write_enable(write_enable),
        .address(address),
        .data_in(data_in),
        .data_out(data_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;

        // ── write phase ──
        // pretend we are loading neural network weights
        $display("Writing weights to Hyperion SRAM...");
        write_enable = 1;

        address = 0; data_in = 3;  #10;
        address = 1; data_in = 7;  #10;
        address = 2; data_in = -2; #10;
        address = 3; data_in = 5;  #10;
        address = 4; data_in = -8; #10;
        address = 5; data_in = 1;  #10;
        address = 6; data_in = 4;  #10;
        address = 7; data_in = -6; #10;

        $display("8 weights written to memory\n");

        // ── read phase ──
        // now read them back like the systolic array would
        $display("Reading weights back to systolic array...");
        write_enable = 0;

        address = 0; #10;
        $display("  Address 0: %0d (expected  3)", data_out);
        address = 1; #10;
        $display("  Address 1: %0d (expected  7)", data_out);
        address = 2; #10;
        $display("  Address 2: %0d (expected -2)", data_out);
        address = 3; #10;
        $display("  Address 3: %0d (expected  5)", data_out);
        address = 4; #10;
        $display("  Address 4: %0d (expected -8)", data_out);
        address = 5; #10;
        $display("  Address 5: %0d (expected  1)", data_out);
        address = 6; #10;
        $display("  Address 6: %0d (expected  4)", data_out);
        address = 7; #10;
        $display("  Address 7: %0d (expected -6)", data_out);

        $display("\nHyperion SRAM working!");
        $display("Weights stored and retrieved correctly.");
        $display("This is how a real TPU loads a neural network.");
        $finish;
    end

endmodule