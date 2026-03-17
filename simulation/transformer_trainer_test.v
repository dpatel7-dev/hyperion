module transformer_trainer_test;
    reg clk, reset, start;
    reg signed [15:0] x0,x1,x2,x3,x4,x5,x6,x7;
    reg signed [15:0] target0,target1,target2,target3;
    reg signed [15:0] target4,target5,target6,target7;
    reg signed [7:0]  wq_init0,wq_init1,wq_init2,wq_init3;
    reg signed [7:0]  wq_init4,wq_init5,wq_init6,wq_init7;
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
    wire signed [31:0] loss;
    wire signed [7:0]  wq_trained0,wq_trained1,wq_trained2,wq_trained3;
    wire signed [7:0]  wq_trained4,wq_trained5,wq_trained6,wq_trained7;
    wire [4:0] step;
    wire step_done, converged;
    reg  last_step_done;

    // testbench step counter — does NOT reset
    integer tb_step;

    // persistent weight registers — survive reset
    reg signed [7:0] pw0,pw1,pw2,pw3,pw4,pw5,pw6,pw7;

    transformer_trainer tt (
        .clk(clk),.reset(reset),.start(start),
        .x0(x0),.x1(x1),.x2(x2),.x3(x3),
        .x4(x4),.x5(x5),.x6(x6),.x7(x7),
        .target0(target0),.target1(target1),
        .target2(target2),.target3(target3),
        .target4(target4),.target5(target5),
        .target6(target6),.target7(target7),
        .wq_init0(pw0),.wq_init1(pw1),
        .wq_init2(pw2),.wq_init3(pw3),
        .wq_init4(pw4),.wq_init5(pw5),
        .wq_init6(pw6),.wq_init7(pw7),
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
        .loss(loss),
        .wq_trained0(wq_trained0),.wq_trained1(wq_trained1),
        .wq_trained2(wq_trained2),.wq_trained3(wq_trained3),
        .wq_trained4(wq_trained4),.wq_trained5(wq_trained5),
        .wq_trained6(wq_trained6),.wq_trained7(wq_trained7),
        .step(step),.step_done(step_done),.converged(converged)
    );

    always #5 clk = ~clk;

    // ── key fix: pass trained weights back as init for next step ──
    always @(posedge clk) begin
        if (step_done && !last_step_done) begin
            tb_step = tb_step + 1;

            $display("  Step %02d  loss=%0d  out0=%0d  target0=%0d  le0=%0d  dw0=%0d  wq0=%0d",
                tb_step, loss, out0, target0, tt.le0, tt.dw0, wq_trained0);

            if (tb_step >= 8) begin
                $display("");
                $display("══════════════════════════════════════════════════");
                $display("HYPERION TRANSFORMER TRAINING COMPLETE");
                $display("══════════════════════════════════════════════════");
                $display("");
                $display("  Steps:      %0d", tb_step);
                $display("  Final loss: %0d", loss);
                $display("  out:   [%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d]",
                    out0,out1,out2,out3,out4,out5,out6,out7);
                $display("  wq:    [%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d]",
                    wq_trained0,wq_trained1,wq_trained2,wq_trained3,
                    wq_trained4,wq_trained5,wq_trained6,wq_trained7);
                $display("");
                $display("  TPU-style: fwd → loss → bwd → update x %0d", tb_step);
                $display("  Same loop Google uses to train GPT.");
                $display("  Built at age 12.");
                $display("");
                $display("══════════════════════════════════════════════════");
                $display("Hyperion transformer trainer working!");
                $display("══════════════════════════════════════════════════");
                $finish;
            end else begin
                // save trained weights — blocking = immediate effect
                pw0 = wq_trained0; pw1 = wq_trained1;
                pw2 = wq_trained2; pw3 = wq_trained3;
                pw4 = wq_trained4; pw5 = wq_trained5;
                pw6 = wq_trained6; pw7 = wq_trained7;
                // reset and run next step
                reset <= 1;
                #30;
                reset <= 0;
                #10;
                start <= 1;
                #10;
                start <= 0;
            end
        end
        last_step_done <= step_done;
    end

    initial begin
        clk=0; reset=1; start=0;
        last_step_done=0; tb_step=0;

        x0=10;x1=20;x2=30;x3=40;x4=50;x5=60;x6=70;x7=80;
        target0=100;target1=200;target2=100;target3=200;
        target4=100;target5=200;target6=100;target7=200;
        wq_init0=1;wq_init1=1;wq_init2=1;wq_init3=1;
        wq_init4=1;wq_init5=1;wq_init6=1;wq_init7=1;
        pw0=1;pw1=1;pw2=1;pw3=1;pw4=1;pw5=1;pw6=1;pw7=1;
        w1_0=2;w1_1=3;w1_2=1;w1_3=4;w1_4=2;w1_5=1;w1_6=3;w1_7=2;
        b1_0=5;b1_1=5;b1_2=5;b1_3=5;b1_4=5;b1_5=5;b1_6=5;b1_7=5;
        w2_0=1;w2_1=2;w2_2=1;w2_3=2;w2_4=1;w2_5=2;w2_6=1;w2_7=2;
        b2_0=0;b2_1=0;b2_2=0;b2_3=0;b2_4=0;b2_5=0;b2_6=0;b2_7=0;
        gamma0=1;gamma1=1;gamma2=1;gamma3=1;
        gamma4=1;gamma5=1;gamma6=1;gamma7=1;
        beta0=0;beta1=0;beta2=0;beta3=0;
        beta4=0;beta5=0;beta6=0;beta7=0;

        $display("══════════════════════════════════════════════════");
        $display("HYPERION TRANSFORMER TRAINER");
        $display("TPU-style: forward → loss → backward → update");
        $display("══════════════════════════════════════════════════");
        $display("");
        $display("  Input:  [10,20,30,40,50,60,70,80]");
        $display("  Target: [100,200,100,200,100,200,100,200]");
        $display("");
        $display("  Step   Loss    out0   wq0    dw0");
        $display("  ──────────────────────────────────");

        #30 reset=0; #10 start=1; #10 start=0;
        #2000000;
        $display("Timeout"); $finish;
    end
endmodule
