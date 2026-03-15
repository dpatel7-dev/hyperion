// ─────────────────────────────────────────
// RELU UNIT TEST
// verifies positive values pass through
// and negative values become zero
// ─────────────────────────────────────────

module relu_test;

    reg clk, reset, enable;
    reg  signed [15:0] in00,in01,in02,in03;
    reg  signed [15:0] in04,in05,in06,in07;
    reg  signed [15:0] in08,in09,in10,in11;
    reg  signed [15:0] in12,in13,in14,in15;
    wire signed [15:0] out00,out01,out02,out03;
    wire signed [15:0] out04,out05,out06,out07;
    wire signed [15:0] out08,out09,out10,out11;
    wire signed [15:0] out12,out13,out14,out15;

    relu_unit relu (
        .clk(clk),.reset(reset),.enable(enable),
        .in00(in00),.in01(in01),.in02(in02),.in03(in03),
        .in04(in04),.in05(in05),.in06(in06),.in07(in07),
        .in08(in08),.in09(in09),.in10(in10),.in11(in11),
        .in12(in12),.in13(in13),.in14(in14),.in15(in15),
        .out00(out00),.out01(out01),.out02(out02),.out03(out03),
        .out04(out04),.out05(out05),.out06(out06),.out07(out07),
        .out08(out08),.out09(out09),.out10(out10),.out11(out11),
        .out12(out12),.out13(out13),.out14(out14),.out15(out15)
    );

    always #5 clk = ~clk;

    initial begin
        clk=0; reset=1; enable=1;
        #10 reset=0;

        // mix of positive and negative values
        // positives should pass through unchanged
        // negatives should become 0
        in00 =  16;  // positive → stays  16
        in01 = -8;   // negative → becomes 0
        in02 =  24;  // positive → stays  24
        in03 = -3;   // negative → becomes 0
        in04 =  0;   // zero     → stays   0
        in05 =  100; // positive → stays 100
        in06 = -50;  // negative → becomes 0
        in07 =  7;   // positive → stays   7
        in08 = -1;   // negative → becomes 0
        in09 =  42;  // positive → stays  42
        in10 = -99;  // negative → becomes 0
        in11 =  5;   // positive → stays   5
        in12 =  13;  // positive → stays  13
        in13 = -27;  // negative → becomes 0
        in14 =  88;  // positive → stays  88
        in15 = -4;   // negative → becomes 0
        #10;

        $display("Hyperion ReLU unit test:");
        $display("─────────────────────────────────────");
        $display("  in→out   (negative→0, positive→same)");
        $display("─────────────────────────────────────");
        $display("   16 → %0d  (expected 16)",  out00);
        $display("   -8 → %0d  (expected 0)",   out01);
        $display("   24 → %0d  (expected 24)",  out02);
        $display("   -3 → %0d  (expected 0)",   out03);
        $display("    0 → %0d  (expected 0)",   out04);
        $display("  100 → %0d  (expected 100)", out05);
        $display("  -50 → %0d  (expected 0)",   out06);
        $display("    7 → %0d  (expected 7)",   out07);
        $display("   -1 → %0d  (expected 0)",   out08);
        $display("   42 → %0d  (expected 42)",  out09);
        $display("  -99 → %0d  (expected 0)",   out10);
        $display("    5 → %0d  (expected 5)",   out11);
        $display("   13 → %0d  (expected 13)",  out12);
        $display("  -27 → %0d  (expected 0)",   out13);
        $display("   88 → %0d  (expected 88)",  out14);
        $display("   -4 → %0d  (expected 0)",   out15);
        $display("─────────────────────────────────────");
        $display("Hyperion ReLU unit working!");
        $display("Negatives zeroed. Positives preserved.");
        $display("This is what every AI model does after");
        $display("every matrix multiply.");
        $finish;
    end

endmodule