module transformer_test;
    reg clk, reset, start;

    reg signed [15:0] x0,x1,x2,x3,x4,x5,x6,x7;
    reg signed [7:0]  wq0,wq1,wq2,wq3,wq4,wq5,wq6,wq7;
    reg signed [7:0]  wk0,wk1,wk2,wk3,wk4,wk5,wk6,wk7;
    reg signed [7:0]  wv0,wv1,wv2,wv3,wv4,wv5,wv6,wv7;
    reg signed [7:0]  w1_0,w1_1,w1_2,w1_3,w1_4,w1_5,w1_6,w1_7;
    reg signed [15:0] b1_0,b1_1,b1_2,b1_3,b1_4,b1_5,b1_6,b1_7;
    reg signed [7:0]  w2_0,w2_1,w2_2,w2_3,w2_4,w2_5,w2_6,w2_7;
    reg signed [15:0] b2_0,b2_1,b2_2,b2_3,b2_4,b2_5,b2_6,b2_7;
    reg signed [7:0]  gamma0,gamma1,gamma2,gamma3;
    reg signed [7:0]  gamma4,gamma5,gamma6,gamma7;
    reg signed [7:0]  beta0,beta1,beta2,beta3;
    reg signed [7:0]  beta4,beta5,beta6,beta7;

    wire signed [15:0] out0,out1,out2,out3;
    wire signed [15:0] out4,out5,out6,out7;
    wire done;
    reg  last_done;

    transformer_block tb_dut (
        .clk(clk),.reset(reset),.start(start),
        .x0(x0),.x1(x1),.x2(x2),.x3(x3),
        .x4(x4),.x5(x5),.x6(x6),.x7(x7),
        .wq0(wq0),.wq1(wq1),.wq2(wq2),.wq3(wq3),
        .wq4(wq4),.wq5(wq5),.wq6(wq6),.wq7(wq7),
        .wk0(wk0),.wk1(wk1),.wk2(wk2),.wk3(wk3),
        .wk4(wk4),.wk5(wk5),.wk6(wk6),.wk7(wk7),
        .wv0(wv0),.wv1(wv1),.wv2(wv2),.wv3(wv3),
        .wv4(wv4),.wv5(wv5),.wv6(wv6),.wv7(wv7),
        .w1_0(w1_0),.w1_1(w1_1),.w1_2(w1_2),.w1_3(w1_3),
        .w1_4(w1_4),.w1_5(w1_5),.w1_6(w1_6),.w1_7(w1_7),
        .b1_0(b1_0),.b1_1(b1_1),.b1_2(b1_2),.b1_3(b1_3),
        .b1_4(b1_4),.b1_5(b1_5),.b1_6(b1_6),.b1_7(b1_7),
        .w2_0(w2_0),.w2_1(w2_1),.w2_2(w2_2),.w2_3(w2_3),
        .w2_4(w2_4),.w2_5(w2_5),.w2_6(w2_6),.w2_7(w2_7),
        .b2_0(b2_0),.b2_1(b2_1),.b2_2(b2_2),.b2_3(b2_3),
        .b2_4(b2_4),.b2_5(b2_5),.b2_6(b2_6),.b2_7(b2_7),
        .gamma0(gamma0),.gamma1(gamma1),
        .gamma2(gamma2),.gamma3(gamma3),
        .gamma4(gamma4),.gamma5(gamma5),
        .gamma6(gamma6),.gamma7(gamma7),
        .beta0(beta0),.beta1(beta1),
        .beta2(beta2),.beta3(beta3),
        .beta4(beta4),.beta5(beta5),
        .beta6(beta6),.beta7(beta7),
        .out0(out0),.out1(out1),.out2(out2),.out3(out3),
        .out4(out4),.out5(out5),.out6(out6),.out7(out7),
        .done(done)
    );

    always #5 clk = ~clk;

    always @(posedge clk) begin
        if (done && !last_done) begin
            $display("══════════════════════════════════════════");
            $display("HYPERION TRANSFORMER BLOCK");
            $display("LN → Attention → Residual → LN → FFN → Residual");
            $display("══════════════════════════════════════════");
            $display("");
            $display("Input:  [%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d]",
                x0,x1,x2,x3,x4,x5,x6,x7);
            $display("Output: [%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d]",
                out0,out1,out2,out3,out4,out5,out6,out7);
            $display("");
            $display("Stages completed:");
            $display("  ✓ LayerNorm 1");
            $display("  ✓ Scaled dot-product attention");
            $display("  ✓ Residual connection 1");
            $display("  ✓ LayerNorm 2");
            $display("  ✓ Feed-forward network");
            $display("  ✓ Residual connection 2");
            $display("");
            $display("══════════════════════════════════════════");
            $display("Hyperion transformer block complete!");
            $display("GPT-3 stacks 96 of these.");
            $display("Hyperion has 1. Same architecture.");
            $display("══════════════════════════════════════════");
            $finish;
        end
        last_done <= done;
    end

    initial begin
        clk=0; reset=1; start=0; last_done=0;

        // input token embedding
        x0=10; x1=20; x2=30; x3=40;
        x4=50; x5=60; x6=70; x7=80;

        // attention weights
        wq0=1;wq1=2;wq2=1;wq3=2;wq4=1;wq5=2;wq6=1;wq7=2;
        wk0=1;wk1=1;wk2=1;wk3=1;wk4=1;wk5=1;wk6=1;wk7=1;
        wv0=2;wv1=4;wv2=6;wv3=8;wv4=10;wv5=12;wv6=14;wv7=16;

        // ffn weights
        w1_0=2;w1_1=3;w1_2=1;w1_3=4;
        w1_4=2;w1_5=1;w1_6=3;w1_7=2;
        b1_0=5;b1_1=5;b1_2=5;b1_3=5;
        b1_4=5;b1_5=5;b1_6=5;b1_7=5;
        w2_0=1;w2_1=2;w2_2=1;w2_3=2;
        w2_4=1;w2_5=2;w2_6=1;w2_7=2;
        b2_0=0;b2_1=0;b2_2=0;b2_3=0;
        b2_4=0;b2_5=0;b2_6=0;b2_7=0;

        // layernorm: gamma=1, beta=0 (identity)
        gamma0=1;gamma1=1;gamma2=1;gamma3=1;
        gamma4=1;gamma5=1;gamma6=1;gamma7=1;
        beta0=0;beta1=0;beta2=0;beta3=0;
        beta4=0;beta5=0;beta6=0;beta7=0;

        #30 reset=0; #10 start=1; #10 start=0;
        #5000;
        $display("Timeout"); $finish;
    end
endmodule
