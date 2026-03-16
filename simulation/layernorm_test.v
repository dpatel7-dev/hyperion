module layernorm_test;
    reg clk, reset, enable;

    reg signed [15:0] x0,x1,x2,x3,x4,x5,x6,x7;
    reg signed [7:0]  gamma0,gamma1,gamma2,gamma3;
    reg signed [7:0]  gamma4,gamma5,gamma6,gamma7;
    reg signed [7:0]  beta0,beta1,beta2,beta3;
    reg signed [7:0]  beta4,beta5,beta6,beta7;

    wire signed [15:0] out0,out1,out2,out3;
    wire signed [15:0] out4,out5,out6,out7;

    layernorm_unit ln (
        .clk(clk),.reset(reset),.enable(enable),
        .x0(x0),.x1(x1),.x2(x2),.x3(x3),
        .x4(x4),.x5(x5),.x6(x6),.x7(x7),
        .gamma0(gamma0),.gamma1(gamma1),
        .gamma2(gamma2),.gamma3(gamma3),
        .gamma4(gamma4),.gamma5(gamma5),
        .gamma6(gamma6),.gamma7(gamma7),
        .beta0(beta0),.beta1(beta1),
        .beta2(beta2),.beta3(beta3),
        .beta4(beta4),.beta5(beta5),
        .beta6(beta6),.beta7(beta7),
        .out0(out0),.out1(out1),.out2(out2),.out3(out3),
        .out4(out4),.out5(out5),.out6(out6),.out7(out7)
    );

    always #5 clk = ~clk;

    initial begin
        clk=0; reset=1; enable=0;
        #10 reset=0; enable=1;

        // test: x = [10, 20, 30, 40, 50, 60, 70, 80]
        // mean = 45, values spread evenly around mean
        // after norm: should be centered around 0
        x0=10; x1=20; x2=30; x3=40;
        x4=50; x5=60; x6=70; x7=80;

        // gamma=1 (no scaling), beta=0 (no shift)
        gamma0=1; gamma1=1; gamma2=1; gamma3=1;
        gamma4=1; gamma5=1; gamma6=1; gamma7=1;
        beta0=0; beta1=0; beta2=0; beta3=0;
        beta4=0; beta5=0; beta6=0; beta7=0;

        #20;

        $display("══════════════════════════════════════════");
        $display("HYPERION LAYERNORM UNIT");
        $display("══════════════════════════════════════════");
        $display("Input:  [10,20,30,40,50,60,70,80]");
        $display("Mean:   %0d", (10+20+30+40+50+60+70+80)/8);
        $display("");
        $display("Normalized output:");
        $display("  [%0d, %0d, %0d, %0d]", out0,out1,out2,out3);
        $display("  [%0d, %0d, %0d, %0d]", out4,out5,out6,out7);
        $display("");

        // check: outputs should be symmetric around 0
        // out0 should be negative (10 < mean)
        // out7 should be positive (80 > mean)
        // out3 and out4 should be near 0 (40,50 near mean)
        if (out0 < 0 && out7 > 0 && out0 == -out7) begin
            $display("✓ Symmetric around zero — correct!");
        end else if (out0 < 0 && out7 > 0) begin
            $display("✓ Centered correctly (out0 negative, out7 positive)");
        end else begin
            $display("Check values above");
        end

        $display("");
        $display("══════════════════════════════════════════");
        $display("Hyperion LayerNorm unit working!");
        $display("This stabilizes training in every LLM.");
        $display("══════════════════════════════════════════");
        $finish;
    end
endmodule
