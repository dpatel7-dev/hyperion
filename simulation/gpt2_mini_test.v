module gpt2_mini_test;
    reg clk, reset, start;
    reg signed [15:0] x0,x1,x2,x3,x4,x5,x6,x7;

    // all blocks share same weights for simplicity
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
    wire blocks12_done, done;
    reg  last_12, last_done;
    integer block_count;

    transformer_gpt2_mini gpt2 (
        .clk(clk),.reset(reset),.start(start),
        .x0(x0),.x1(x1),.x2(x2),.x3(x3),
        .x4(x4),.x5(x5),.x6(x6),.x7(x7),
        // all 4 blocks get same weights
        .a_b1_wq0(wq0),.a_b1_wq1(wq1),.a_b1_wq2(wq2),.a_b1_wq3(wq3),
        .a_b1_wq4(wq4),.a_b1_wq5(wq5),.a_b1_wq6(wq6),.a_b1_wq7(wq7),
        .a_b1_wk0(wk0),.a_b1_wk1(wk1),.a_b1_wk2(wk2),.a_b1_wk3(wk3),
        .a_b1_wk4(wk4),.a_b1_wk5(wk5),.a_b1_wk6(wk6),.a_b1_wk7(wk7),
        .a_b1_wv0(wv0),.a_b1_wv1(wv1),.a_b1_wv2(wv2),.a_b1_wv3(wv3),
        .a_b1_wv4(wv4),.a_b1_wv5(wv5),.a_b1_wv6(wv6),.a_b1_wv7(wv7),
        .a_b1_w1_0(w1_0),.a_b1_w1_1(w1_1),.a_b1_w1_2(w1_2),.a_b1_w1_3(w1_3),
        .a_b1_w1_4(w1_4),.a_b1_w1_5(w1_5),.a_b1_w1_6(w1_6),.a_b1_w1_7(w1_7),
        .a_b1_b1_0(b1_0),.a_b1_b1_1(b1_1),.a_b1_b1_2(b1_2),.a_b1_b1_3(b1_3),
        .a_b1_b1_4(b1_4),.a_b1_b1_5(b1_5),.a_b1_b1_6(b1_6),.a_b1_b1_7(b1_7),
        .a_b1_w2_0(w2_0),.a_b1_w2_1(w2_1),.a_b1_w2_2(w2_2),.a_b1_w2_3(w2_3),
        .a_b1_w2_4(w2_4),.a_b1_w2_5(w2_5),.a_b1_w2_6(w2_6),.a_b1_w2_7(w2_7),
        .a_b1_b2_0(b2_0),.a_b1_b2_1(b2_1),.a_b1_b2_2(b2_2),.a_b1_b2_3(b2_3),
        .a_b1_b2_4(b2_4),.a_b1_b2_5(b2_5),.a_b1_b2_6(b2_6),.a_b1_b2_7(b2_7),
        .a_b1_gamma0(gamma0),.a_b1_gamma1(gamma1),
        .a_b1_gamma2(gamma2),.a_b1_gamma3(gamma3),
        .a_b1_gamma4(gamma4),.a_b1_gamma5(gamma5),
        .a_b1_gamma6(gamma6),.a_b1_gamma7(gamma7),
        .a_b1_beta0(beta0),.a_b1_beta1(beta1),
        .a_b1_beta2(beta2),.a_b1_beta3(beta3),
        .a_b1_beta4(beta4),.a_b1_beta5(beta5),
        .a_b1_beta6(beta6),.a_b1_beta7(beta7),
        .a_b2_wq0(wq0),.a_b2_wq1(wq1),.a_b2_wq2(wq2),.a_b2_wq3(wq3),
        .a_b2_wq4(wq4),.a_b2_wq5(wq5),.a_b2_wq6(wq6),.a_b2_wq7(wq7),
        .a_b2_wk0(wk0),.a_b2_wk1(wk1),.a_b2_wk2(wk2),.a_b2_wk3(wk3),
        .a_b2_wk4(wk4),.a_b2_wk5(wk5),.a_b2_wk6(wk6),.a_b2_wk7(wk7),
        .a_b2_wv0(wv0),.a_b2_wv1(wv1),.a_b2_wv2(wv2),.a_b2_wv3(wv3),
        .a_b2_wv4(wv4),.a_b2_wv5(wv5),.a_b2_wv6(wv6),.a_b2_wv7(wv7),
        .a_b2_w1_0(w1_0),.a_b2_w1_1(w1_1),.a_b2_w1_2(w1_2),.a_b2_w1_3(w1_3),
        .a_b2_w1_4(w1_4),.a_b2_w1_5(w1_5),.a_b2_w1_6(w1_6),.a_b2_w1_7(w1_7),
        .a_b2_b1_0(b1_0),.a_b2_b1_1(b1_1),.a_b2_b1_2(b1_2),.a_b2_b1_3(b1_3),
        .a_b2_b1_4(b1_4),.a_b2_b1_5(b1_5),.a_b2_b1_6(b1_6),.a_b2_b1_7(b1_7),
        .a_b2_w2_0(w2_0),.a_b2_w2_1(w2_1),.a_b2_w2_2(w2_2),.a_b2_w2_3(w2_3),
        .a_b2_w2_4(w2_4),.a_b2_w2_5(w2_5),.a_b2_w2_6(w2_6),.a_b2_w2_7(w2_7),
        .a_b2_b2_0(b2_0),.a_b2_b2_1(b2_1),.a_b2_b2_2(b2_2),.a_b2_b2_3(b2_3),
        .a_b2_b2_4(b2_4),.a_b2_b2_5(b2_5),.a_b2_b2_6(b2_6),.a_b2_b2_7(b2_7),
        .a_b2_gamma0(gamma0),.a_b2_gamma1(gamma1),
        .a_b2_gamma2(gamma2),.a_b2_gamma3(gamma3),
        .a_b2_gamma4(gamma4),.a_b2_gamma5(gamma5),
        .a_b2_gamma6(gamma6),.a_b2_gamma7(gamma7),
        .a_b2_beta0(beta0),.a_b2_beta1(beta1),
        .a_b2_beta2(beta2),.a_b2_beta3(beta3),
        .a_b2_beta4(beta4),.a_b2_beta5(beta5),
        .a_b2_beta6(beta6),.a_b2_beta7(beta7),
        .b_b1_wq0(wq0),.b_b1_wq1(wq1),.b_b1_wq2(wq2),.b_b1_wq3(wq3),
        .b_b1_wq4(wq4),.b_b1_wq5(wq5),.b_b1_wq6(wq6),.b_b1_wq7(wq7),
        .b_b1_wk0(wk0),.b_b1_wk1(wk1),.b_b1_wk2(wk2),.b_b1_wk3(wk3),
        .b_b1_wk4(wk4),.b_b1_wk5(wk5),.b_b1_wk6(wk6),.b_b1_wk7(wk7),
        .b_b1_wv0(wv0),.b_b1_wv1(wv1),.b_b1_wv2(wv2),.b_b1_wv3(wv3),
        .b_b1_wv4(wv4),.b_b1_wv5(wv5),.b_b1_wv6(wv6),.b_b1_wv7(wv7),
        .b_b1_w1_0(w1_0),.b_b1_w1_1(w1_1),.b_b1_w1_2(w1_2),.b_b1_w1_3(w1_3),
        .b_b1_w1_4(w1_4),.b_b1_w1_5(w1_5),.b_b1_w1_6(w1_6),.b_b1_w1_7(w1_7),
        .b_b1_b1_0(b1_0),.b_b1_b1_1(b1_1),.b_b1_b1_2(b1_2),.b_b1_b1_3(b1_3),
        .b_b1_b1_4(b1_4),.b_b1_b1_5(b1_5),.b_b1_b1_6(b1_6),.b_b1_b1_7(b1_7),
        .b_b1_w2_0(w2_0),.b_b1_w2_1(w2_1),.b_b1_w2_2(w2_2),.b_b1_w2_3(w2_3),
        .b_b1_w2_4(w2_4),.b_b1_w2_5(w2_5),.b_b1_w2_6(w2_6),.b_b1_w2_7(w2_7),
        .b_b1_b2_0(b2_0),.b_b1_b2_1(b2_1),.b_b1_b2_2(b2_2),.b_b1_b2_3(b2_3),
        .b_b1_b2_4(b2_4),.b_b1_b2_5(b2_5),.b_b1_b2_6(b2_6),.b_b1_b2_7(b2_7),
        .b_b1_gamma0(gamma0),.b_b1_gamma1(gamma1),
        .b_b1_gamma2(gamma2),.b_b1_gamma3(gamma3),
        .b_b1_gamma4(gamma4),.b_b1_gamma5(gamma5),
        .b_b1_gamma6(gamma6),.b_b1_gamma7(gamma7),
        .b_b1_beta0(beta0),.b_b1_beta1(beta1),
        .b_b1_beta2(beta2),.b_b1_beta3(beta3),
        .b_b1_beta4(beta4),.b_b1_beta5(beta5),
        .b_b1_beta6(beta6),.b_b1_beta7(beta7),
        .b_b2_wq0(wq0),.b_b2_wq1(wq1),.b_b2_wq2(wq2),.b_b2_wq3(wq3),
        .b_b2_wq4(wq4),.b_b2_wq5(wq5),.b_b2_wq6(wq6),.b_b2_wq7(wq7),
        .b_b2_wk0(wk0),.b_b2_wk1(wk1),.b_b2_wk2(wk2),.b_b2_wk3(wk3),
        .b_b2_wk4(wk4),.b_b2_wk5(wk5),.b_b2_wk6(wk6),.b_b2_wk7(wk7),
        .b_b2_wv0(wv0),.b_b2_wv1(wv1),.b_b2_wv2(wv2),.b_b2_wv3(wv3),
        .b_b2_wv4(wv4),.b_b2_wv5(wv5),.b_b2_wv6(wv6),.b_b2_wv7(wv7),
        .b_b2_w1_0(w1_0),.b_b2_w1_1(w1_1),.b_b2_w1_2(w1_2),.b_b2_w1_3(w1_3),
        .b_b2_w1_4(w1_4),.b_b2_w1_5(w1_5),.b_b2_w1_6(w1_6),.b_b2_w1_7(w1_7),
        .b_b2_b1_0(b1_0),.b_b2_b1_1(b1_1),.b_b2_b1_2(b1_2),.b_b2_b1_3(b1_3),
        .b_b2_b1_4(b1_4),.b_b2_b1_5(b1_5),.b_b2_b1_6(b1_6),.b_b2_b1_7(b1_7),
        .b_b2_w2_0(w2_0),.b_b2_w2_1(w2_1),.b_b2_w2_2(w2_2),.b_b2_w2_3(w2_3),
        .b_b2_w2_4(w2_4),.b_b2_w2_5(w2_5),.b_b2_w2_6(w2_6),.b_b2_w2_7(w2_7),
        .b_b2_b2_0(b2_0),.b_b2_b2_1(b2_1),.b_b2_b2_2(b2_2),.b_b2_b2_3(b2_3),
        .b_b2_b2_4(b2_4),.b_b2_b2_5(b2_5),.b_b2_b2_6(b2_6),.b_b2_b2_7(b2_7),
        .b_b2_gamma0(gamma0),.b_b2_gamma1(gamma1),
        .b_b2_gamma2(gamma2),.b_b2_gamma3(gamma3),
        .b_b2_gamma4(gamma4),.b_b2_gamma5(gamma5),
        .b_b2_gamma6(gamma6),.b_b2_gamma7(gamma7),
        .b_b2_beta0(beta0),.b_b2_beta1(beta1),
        .b_b2_beta2(beta2),.b_b2_beta3(beta3),
        .b_b2_beta4(beta4),.b_b2_beta5(beta5),
        .b_b2_beta6(beta6),.b_b2_beta7(beta7),
        .out0(out0),.out1(out1),.out2(out2),.out3(out3),
        .out4(out4),.out5(out5),.out6(out6),.out7(out7),
        .blocks12_done(blocks12_done),
        .done(done)
    );

    always #5 clk = ~clk;

    always @(posedge clk) begin
        if (blocks12_done && !last_12) begin
            block_count = block_count + 2;
            $display("  Blocks 1+2 done (%0d/4)", block_count);
        end
        if (done && !last_done) begin
            block_count = 4;
            $display("  Blocks 3+4 done (4/4)");
            $display("");
            $display("══════════════════════════════════════════");
            $display("HYPERION GPT-2 MINI — 4 transformer blocks");
            $display("══════════════════════════════════════════");
            $display("");
            $display("Input:  [%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d]",
                x0,x1,x2,x3,x4,x5,x6,x7);
            $display("Output: [%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d]",
                out0,out1,out2,out3,out4,out5,out6,out7);
            $display("");
            $display("Pipeline:");
            $display("  [Block1] → [Block2] → [Block3] → [Block4]");
            $display("");
            $display("  GPT-2 small:  12 blocks");
            $display("  GPT-3:        96 blocks");
            $display("  Hyperion:      4 blocks — same architecture");
            $display("");
            $display("══════════════════════════════════════════");
            $display("Hyperion GPT-2 mini complete!");
            $display("Halfway to GPT-2 small.");
            $display("══════════════════════════════════════════");
            $finish;
        end
        last_12   <= blocks12_done;
        last_done <= done;
    end

    initial begin
        clk=0; reset=1; start=0;
        last_12=0; last_done=0; block_count=0;

        x0=10;x1=20;x2=30;x3=40;x4=50;x5=60;x6=70;x7=80;

        wq0=1;wq1=2;wq2=1;wq3=2;wq4=1;wq5=2;wq6=1;wq7=2;
        wk0=1;wk1=1;wk2=1;wk3=1;wk4=1;wk5=1;wk6=1;wk7=1;
        wv0=2;wv1=4;wv2=6;wv3=8;wv4=10;wv5=12;wv6=14;wv7=16;
        w1_0=2;w1_1=3;w1_2=1;w1_3=4;w1_4=2;w1_5=1;w1_6=3;w1_7=2;
        b1_0=5;b1_1=5;b1_2=5;b1_3=5;b1_4=5;b1_5=5;b1_6=5;b1_7=5;
        w2_0=1;w2_1=2;w2_2=1;w2_3=2;w2_4=1;w2_5=2;w2_6=1;w2_7=2;
        b2_0=0;b2_1=0;b2_2=0;b2_3=0;b2_4=0;b2_5=0;b2_6=0;b2_7=0;
        gamma0=1;gamma1=1;gamma2=1;gamma3=1;
        gamma4=1;gamma5=1;gamma6=1;gamma7=1;
        beta0=0;beta1=0;beta2=0;beta3=0;
        beta4=0;beta5=0;beta6=0;beta7=0;

        #30 reset=0; #10 start=1; #10 start=0;

        $display("Hyperion GPT-2 mini — 4 transformer blocks");
        $display("Input: [10,20,30,40,50,60,70,80]");
        $display("");

        #20000;
        $display("Timeout"); $finish;
    end
endmodule
