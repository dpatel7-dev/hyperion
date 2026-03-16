module transformer_deep_test;
    reg clk, reset, start;

    // input
    reg signed [15:0] x0,x1,x2,x3,x4,x5,x6,x7;

    // block 1 weights
    reg signed [7:0]  b1_wq0,b1_wq1,b1_wq2,b1_wq3,b1_wq4,b1_wq5,b1_wq6,b1_wq7;
    reg signed [7:0]  b1_wk0,b1_wk1,b1_wk2,b1_wk3,b1_wk4,b1_wk5,b1_wk6,b1_wk7;
    reg signed [7:0]  b1_wv0,b1_wv1,b1_wv2,b1_wv3,b1_wv4,b1_wv5,b1_wv6,b1_wv7;
    reg signed [7:0]  b1_w1_0,b1_w1_1,b1_w1_2,b1_w1_3,b1_w1_4,b1_w1_5,b1_w1_6,b1_w1_7;
    reg signed [15:0] b1_b1_0,b1_b1_1,b1_b1_2,b1_b1_3,b1_b1_4,b1_b1_5,b1_b1_6,b1_b1_7;
    reg signed [7:0]  b1_w2_0,b1_w2_1,b1_w2_2,b1_w2_3,b1_w2_4,b1_w2_5,b1_w2_6,b1_w2_7;
    reg signed [15:0] b1_b2_0,b1_b2_1,b1_b2_2,b1_b2_3,b1_b2_4,b1_b2_5,b1_b2_6,b1_b2_7;
    reg signed [7:0]  b1_gamma0,b1_gamma1,b1_gamma2,b1_gamma3;
    reg signed [7:0]  b1_gamma4,b1_gamma5,b1_gamma6,b1_gamma7;
    reg signed [7:0]  b1_beta0,b1_beta1,b1_beta2,b1_beta3;
    reg signed [7:0]  b1_beta4,b1_beta5,b1_beta6,b1_beta7;

    // block 2 weights
    reg signed [7:0]  b2_wq0,b2_wq1,b2_wq2,b2_wq3,b2_wq4,b2_wq5,b2_wq6,b2_wq7;
    reg signed [7:0]  b2_wk0,b2_wk1,b2_wk2,b2_wk3,b2_wk4,b2_wk5,b2_wk6,b2_wk7;
    reg signed [7:0]  b2_wv0,b2_wv1,b2_wv2,b2_wv3,b2_wv4,b2_wv5,b2_wv6,b2_wv7;
    reg signed [7:0]  b2_w1_0,b2_w1_1,b2_w1_2,b2_w1_3,b2_w1_4,b2_w1_5,b2_w1_6,b2_w1_7;
    reg signed [15:0] b2_b1_0,b2_b1_1,b2_b1_2,b2_b1_3,b2_b1_4,b2_b1_5,b2_b1_6,b2_b1_7;
    reg signed [7:0]  b2_w2_0,b2_w2_1,b2_w2_2,b2_w2_3,b2_w2_4,b2_w2_5,b2_w2_6,b2_w2_7;
    reg signed [15:0] b2_b2_0,b2_b2_1,b2_b2_2,b2_b2_3,b2_b2_4,b2_b2_5,b2_b2_6,b2_b2_7;
    reg signed [7:0]  b2_gamma0,b2_gamma1,b2_gamma2,b2_gamma3;
    reg signed [7:0]  b2_gamma4,b2_gamma5,b2_gamma6,b2_gamma7;
    reg signed [7:0]  b2_beta0,b2_beta1,b2_beta2,b2_beta3;
    reg signed [7:0]  b2_beta4,b2_beta5,b2_beta6,b2_beta7;

    wire signed [15:0] out0,out1,out2,out3,out4,out5,out6,out7;
    wire block1_done, done;
    reg  last_b1, last_done;

    transformer_deep td (
        .clk(clk),.reset(reset),.start(start),
        .x0(x0),.x1(x1),.x2(x2),.x3(x3),
        .x4(x4),.x5(x5),.x6(x6),.x7(x7),
        .b1_wq0(b1_wq0),.b1_wq1(b1_wq1),.b1_wq2(b1_wq2),.b1_wq3(b1_wq3),
        .b1_wq4(b1_wq4),.b1_wq5(b1_wq5),.b1_wq6(b1_wq6),.b1_wq7(b1_wq7),
        .b1_wk0(b1_wk0),.b1_wk1(b1_wk1),.b1_wk2(b1_wk2),.b1_wk3(b1_wk3),
        .b1_wk4(b1_wk4),.b1_wk5(b1_wk5),.b1_wk6(b1_wk6),.b1_wk7(b1_wk7),
        .b1_wv0(b1_wv0),.b1_wv1(b1_wv1),.b1_wv2(b1_wv2),.b1_wv3(b1_wv3),
        .b1_wv4(b1_wv4),.b1_wv5(b1_wv5),.b1_wv6(b1_wv6),.b1_wv7(b1_wv7),
        .b1_w1_0(b1_w1_0),.b1_w1_1(b1_w1_1),.b1_w1_2(b1_w1_2),.b1_w1_3(b1_w1_3),
        .b1_w1_4(b1_w1_4),.b1_w1_5(b1_w1_5),.b1_w1_6(b1_w1_6),.b1_w1_7(b1_w1_7),
        .b1_b1_0(b1_b1_0),.b1_b1_1(b1_b1_1),.b1_b1_2(b1_b1_2),.b1_b1_3(b1_b1_3),
        .b1_b1_4(b1_b1_4),.b1_b1_5(b1_b1_5),.b1_b1_6(b1_b1_6),.b1_b1_7(b1_b1_7),
        .b1_w2_0(b1_w2_0),.b1_w2_1(b1_w2_1),.b1_w2_2(b1_w2_2),.b1_w2_3(b1_w2_3),
        .b1_w2_4(b1_w2_4),.b1_w2_5(b1_w2_5),.b1_w2_6(b1_w2_6),.b1_w2_7(b1_w2_7),
        .b1_b2_0(b1_b2_0),.b1_b2_1(b1_b2_1),.b1_b2_2(b1_b2_2),.b1_b2_3(b1_b2_3),
        .b1_b2_4(b1_b2_4),.b1_b2_5(b1_b2_5),.b1_b2_6(b1_b2_6),.b1_b2_7(b1_b2_7),
        .b1_gamma0(b1_gamma0),.b1_gamma1(b1_gamma1),
        .b1_gamma2(b1_gamma2),.b1_gamma3(b1_gamma3),
        .b1_gamma4(b1_gamma4),.b1_gamma5(b1_gamma5),
        .b1_gamma6(b1_gamma6),.b1_gamma7(b1_gamma7),
        .b1_beta0(b1_beta0),.b1_beta1(b1_beta1),
        .b1_beta2(b1_beta2),.b1_beta3(b1_beta3),
        .b1_beta4(b1_beta4),.b1_beta5(b1_beta5),
        .b1_beta6(b1_beta6),.b1_beta7(b1_beta7),
        .b2_wq0(b2_wq0),.b2_wq1(b2_wq1),.b2_wq2(b2_wq2),.b2_wq3(b2_wq3),
        .b2_wq4(b2_wq4),.b2_wq5(b2_wq5),.b2_wq6(b2_wq6),.b2_wq7(b2_wq7),
        .b2_wk0(b2_wk0),.b2_wk1(b2_wk1),.b2_wk2(b2_wk2),.b2_wk3(b2_wk3),
        .b2_wk4(b2_wk4),.b2_wk5(b2_wk5),.b2_wk6(b2_wk6),.b2_wk7(b2_wk7),
        .b2_wv0(b2_wv0),.b2_wv1(b2_wv1),.b2_wv2(b2_wv2),.b2_wv3(b2_wv3),
        .b2_wv4(b2_wv4),.b2_wv5(b2_wv5),.b2_wv6(b2_wv6),.b2_wv7(b2_wv7),
        .b2_w1_0(b2_w1_0),.b2_w1_1(b2_w1_1),.b2_w1_2(b2_w1_2),.b2_w1_3(b2_w1_3),
        .b2_w1_4(b2_w1_4),.b2_w1_5(b2_w1_5),.b2_w1_6(b2_w1_6),.b2_w1_7(b2_w1_7),
        .b2_b1_0(b2_b1_0),.b2_b1_1(b2_b1_1),.b2_b1_2(b2_b1_2),.b2_b1_3(b2_b1_3),
        .b2_b1_4(b2_b1_4),.b2_b1_5(b2_b1_5),.b2_b1_6(b2_b1_6),.b2_b1_7(b2_b1_7),
        .b2_w2_0(b2_w2_0),.b2_w2_1(b2_w2_1),.b2_w2_2(b2_w2_2),.b2_w2_3(b2_w2_3),
        .b2_w2_4(b2_w2_4),.b2_w2_5(b2_w2_5),.b2_w2_6(b2_w2_6),.b2_w2_7(b2_w2_7),
        .b2_b2_0(b2_b2_0),.b2_b2_1(b2_b2_1),.b2_b2_2(b2_b2_2),.b2_b2_3(b2_b2_3),
        .b2_b2_4(b2_b2_4),.b2_b2_5(b2_b2_5),.b2_b2_6(b2_b2_6),.b2_b2_7(b2_b2_7),
        .b2_gamma0(b2_gamma0),.b2_gamma1(b2_gamma1),
        .b2_gamma2(b2_gamma2),.b2_gamma3(b2_gamma3),
        .b2_gamma4(b2_gamma4),.b2_gamma5(b2_gamma5),
        .b2_gamma6(b2_gamma6),.b2_gamma7(b2_gamma7),
        .b2_beta0(b2_beta0),.b2_beta1(b2_beta1),
        .b2_beta2(b2_beta2),.b2_beta3(b2_beta3),
        .b2_beta4(b2_beta4),.b2_beta5(b2_beta5),
        .b2_beta6(b2_beta6),.b2_beta7(b2_beta7),
        .out0(out0),.out1(out1),.out2(out2),.out3(out3),
        .out4(out4),.out5(out5),.out6(out6),.out7(out7),
        .block1_done(block1_done),
        .done(done)
    );

    always #5 clk = ~clk;

    always @(posedge clk) begin
        if (block1_done && !last_b1)
            $display("  Block 1 done — passing to block 2...");
        if (done && !last_done) begin
            $display("  Block 2 done!");
            $display("");
            $display("══════════════════════════════════════════");
            $display("HYPERION TRANSFORMER DEEP");
            $display("2 stacked transformer blocks");
            $display("══════════════════════════════════════════");
            $display("");
            $display("Input:  [%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d]",
                x0,x1,x2,x3,x4,x5,x6,x7);
            $display("Output: [%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d]",
                out0,out1,out2,out3,out4,out5,out6,out7);
            $display("");
            $display("Pipeline:");
            $display("  input → [LN→Attn→Res→LN→FFN→Res] → [LN→Attn→Res→LN→FFN→Res] → output");
            $display("            block 1                      block 2");
            $display("");
            $display("GPT-2 small: 12 blocks");
            $display("GPT-3:       96 blocks");
            $display("Hyperion:     2 blocks — same architecture");
            $display("");
            $display("══════════════════════════════════════════");
            $display("Hyperion transformer deep complete!");
            $display("══════════════════════════════════════════");
            $finish;
        end
        last_b1   <= block1_done;
        last_done <= done;
    end

    initial begin
        clk=0; reset=1; start=0;
        last_b1=0; last_done=0;

        x0=10;x1=20;x2=30;x3=40;x4=50;x5=60;x6=70;x7=80;

        // block 1 weights — different from block 2
        b1_wq0=1;b1_wq1=2;b1_wq2=1;b1_wq3=2;b1_wq4=1;b1_wq5=2;b1_wq6=1;b1_wq7=2;
        b1_wk0=1;b1_wk1=1;b1_wk2=1;b1_wk3=1;b1_wk4=1;b1_wk5=1;b1_wk6=1;b1_wk7=1;
        b1_wv0=2;b1_wv1=4;b1_wv2=6;b1_wv3=8;b1_wv4=10;b1_wv5=12;b1_wv6=14;b1_wv7=16;
        b1_w1_0=2;b1_w1_1=3;b1_w1_2=1;b1_w1_3=4;b1_w1_4=2;b1_w1_5=1;b1_w1_6=3;b1_w1_7=2;
        b1_b1_0=5;b1_b1_1=5;b1_b1_2=5;b1_b1_3=5;b1_b1_4=5;b1_b1_5=5;b1_b1_6=5;b1_b1_7=5;
        b1_w2_0=1;b1_w2_1=2;b1_w2_2=1;b1_w2_3=2;b1_w2_4=1;b1_w2_5=2;b1_w2_6=1;b1_w2_7=2;
        b1_b2_0=0;b1_b2_1=0;b1_b2_2=0;b1_b2_3=0;b1_b2_4=0;b1_b2_5=0;b1_b2_6=0;b1_b2_7=0;
        b1_gamma0=1;b1_gamma1=1;b1_gamma2=1;b1_gamma3=1;
        b1_gamma4=1;b1_gamma5=1;b1_gamma6=1;b1_gamma7=1;
        b1_beta0=0;b1_beta1=0;b1_beta2=0;b1_beta3=0;
        b1_beta4=0;b1_beta5=0;b1_beta6=0;b1_beta7=0;

        // block 2 — different weights
        b2_wq0=2;b2_wq1=1;b2_wq2=3;b2_wq3=1;b2_wq4=2;b2_wq5=1;b2_wq6=3;b2_wq7=1;
        b2_wk0=2;b2_wk1=2;b2_wk2=2;b2_wk3=2;b2_wk4=2;b2_wk5=2;b2_wk6=2;b2_wk7=2;
        b2_wv0=1;b2_wv1=2;b2_wv2=3;b2_wv3=4;b2_wv4=5;b2_wv5=6;b2_wv6=7;b2_wv7=8;
        b2_w1_0=3;b2_w1_1=1;b2_w1_2=4;b2_w1_3=2;b2_w1_4=3;b2_w1_5=1;b2_w1_6=2;b2_w1_7=3;
        b2_b1_0=3;b2_b1_1=3;b2_b1_2=3;b2_b1_3=3;b2_b1_4=3;b2_b1_5=3;b2_b1_6=3;b2_b1_7=3;
        b2_w2_0=2;b2_w2_1=1;b2_w2_2=2;b2_w2_3=1;b2_w2_4=2;b2_w2_5=1;b2_w2_6=2;b2_w2_7=1;
        b2_b2_0=0;b2_b2_1=0;b2_b2_2=0;b2_b2_3=0;b2_b2_4=0;b2_b2_5=0;b2_b2_6=0;b2_b2_7=0;
        b2_gamma0=1;b2_gamma1=1;b2_gamma2=1;b2_gamma3=1;
        b2_gamma4=1;b2_gamma5=1;b2_gamma6=1;b2_gamma7=1;
        b2_beta0=0;b2_beta1=0;b2_beta2=0;b2_beta3=0;
        b2_beta4=0;b2_beta5=0;b2_beta6=0;b2_beta7=0;

        #30 reset=0; #10 start=1; #10 start=0;

        $display("Hyperion transformer deep — 2 stacked blocks");
        $display("Input: [10,20,30,40,50,60,70,80]");
        $display("");

        #10000;
        $display("Timeout"); $finish;
    end
endmodule
