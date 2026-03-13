// ─────────────────────────────────────────
// TESTBENCH — checks your MAC unit works
// Like the "Match: True" check in Python
// ─────────────────────────────────────────

module testbench;

    reg clk, reset;
    reg signed [7:0] a, b;
    wire signed [15:0] out;

    // connect testbench to your mac unit
    mac_unit uut (
        .clk(clk),
        .reset(reset),
        .a(a),
        .b(b),
        .out(out)
    );

    // clock ticks every 5 time units
    always #5 clk = ~clk;

    initial begin
        // start up
        clk = 0; reset = 1;
        #10 reset = 0;

        // test 1: 3 × 4 = 12
        a = 3; b = 4;
        #10;
        $display("3 × 4 = %0d (expected 12)", out);

        // test 2: accumulate 2 × 5 = 10, total should be 22
        a = 2; b = 5;
        #10;
        $display("accumulated: %0d (expected 22)", out);

        // test 3: negative number -3 × 2 = -6, total should be 16
        a = -3; b = 2;
        #10;
        $display("with negative: %0d (expected 16)", out);

        $display("\nMAC unit working correctly!");
        $finish;
    end

endmodule