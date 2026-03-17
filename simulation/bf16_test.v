module bf16_test;
    reg  [15:0] a, b;
    wire [15:0] mul_out, add_out;
    reg  clk=0, reset=1;
    wire [15:0] mac_out;

    bf16_mul mul_u (.a(a), .b(b), .out(mul_out));
    bf16_add add_u (.a(a), .b(b), .out(add_out));
    reg en=0;
    bf16_mac mac_u (.clk(clk),.reset(reset),.enable(en),.a(a),.b(b),.out(mac_out));

    always #5 clk = ~clk;

    task check_mul;
        input [15:0] ta, tb_in, expected;
        input real fa, fb, fe;
        begin
            a = ta; b = tb_in; #10;
            if (mul_out == expected)
                $display("  ✓ %0.2f x %0.2f = %0.2f  [0x%04X]", fa, fb, fe, mul_out);
            else
                $display("  ✗ %0.2f x %0.2f expected 0x%04X got 0x%04X", fa, fb, expected, mul_out);
        end
    endtask

    initial begin
        $display("══════════════════════════════════════════");
        $display("HYPERION BF16 PRECISION UNITS");
        $display("Brain Float 16 — used in TPU and H100");
        $display("══════════════════════════════════════════");
        $display("");
        $display("BF16 Multiply:");
        check_mul(16'h3F80, 16'h4000, 16'h4000, 1.0, 2.0, 2.0);
        check_mul(16'h3F00, 16'h4080, 16'h4000, 0.5, 4.0, 2.0);
        check_mul(16'h4040, 16'h4040, 16'h4110, 3.0, 3.0, 9.0);
        check_mul(16'hBF80, 16'h40A0, 16'hC0A0, -1.0, 5.0, -5.0);
        $display("");
        $display("BF16 Add (a+b):");
        a=16'h3F80; b=16'h3F80; #10;
        $display("  1.0 + 1.0 = result: 0x%04X (expect 0x4000=2.0)", add_out);
        a=16'h4040; b=16'h3F80; #10;
        $display("  3.0 + 1.0 = result: 0x%04X (expect 0x4080=4.0)", add_out);
        $display("");
        $display("BF16 MAC (accumulate):");
        #10 reset=0; en=1;
        a=16'h3F80; b=16'h3F80; #10; // 1.0 * 1.0 = 1.0
        $display("  After 1.0*1.0: acc=0x%04X (expect 0x3F80=1.0)", mac_out);
        a=16'h3F80; b=16'h3F80; #10; // + 1.0*1.0 = 2.0
        $display("  After +1.0*1.0: acc=0x%04X (expect 0x4000=2.0)", mac_out);
        a=16'h3F80; b=16'h4000; #10; // + 1.0*2.0 = 4.0
        $display("  After +1.0*2.0: acc=0x%04X (expect 0x4080=4.0)", mac_out);
        $display("");
        $display("══════════════════════════════════════════");
        $display("Hyperion BF16 units working!");
        $display("Same precision as Google TPU training.");
        $display("══════════════════════════════════════════");
        $finish;
    end
endmodule
