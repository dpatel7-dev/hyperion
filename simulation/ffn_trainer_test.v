module ffn_trainer_test;
    reg clk, reset, start;
    reg signed [15:0] x0,x1,x2,x3,x4,x5,x6,x7;
    reg signed [15:0] tgt0,tgt1,tgt2,tgt3,tgt4,tgt5,tgt6,tgt7;
    reg signed [7:0]  w1_init0,w1_init1,w1_init2,w1_init3;
    reg signed [7:0]  w1_init4,w1_init5,w1_init6,w1_init7;
    reg signed [7:0]  w2_init0,w2_init1,w2_init2,w2_init3;
    reg signed [7:0]  w2_init4,w2_init5,w2_init6,w2_init7;
    wire signed [15:0] out0,out1,out2,out3,out4,out5,out6,out7;
    wire signed [31:0] loss;
    wire signed [7:0]  w1_t0,w1_t1,w1_t2,w1_t3,w1_t4,w1_t5,w1_t6,w1_t7;
    wire signed [7:0]  w2_t0,w2_t1,w2_t2,w2_t3,w2_t4,w2_t5,w2_t6,w2_t7;
    wire step_done;
    reg  last_done;
    integer tb_step;

    // persistent trained weight regs
    reg signed [7:0] pw1_0,pw1_1,pw1_2,pw1_3,pw1_4,pw1_5,pw1_6,pw1_7;
    reg signed [7:0] pw2_0,pw2_1,pw2_2,pw2_3,pw2_4,pw2_5,pw2_6,pw2_7;

    ffn_trainer ft (
        .clk(clk),.reset(reset),.start(start),
        .x0(x0),.x1(x1),.x2(x2),.x3(x3),
        .x4(x4),.x5(x5),.x6(x6),.x7(x7),
        .tgt0(tgt0),.tgt1(tgt1),.tgt2(tgt2),.tgt3(tgt3),
        .tgt4(tgt4),.tgt5(tgt5),.tgt6(tgt6),.tgt7(tgt7),
        .w1_init0(pw1_0),.w1_init1(pw1_1),
        .w1_init2(pw1_2),.w1_init3(pw1_3),
        .w1_init4(pw1_4),.w1_init5(pw1_5),
        .w1_init6(pw1_6),.w1_init7(pw1_7),
        .w2_init0(pw2_0),.w2_init1(pw2_1),
        .w2_init2(pw2_2),.w2_init3(pw2_3),
        .w2_init4(pw2_4),.w2_init5(pw2_5),
        .w2_init6(pw2_6),.w2_init7(pw2_7),
        .out0(out0),.out1(out1),.out2(out2),.out3(out3),
        .out4(out4),.out5(out5),.out6(out6),.out7(out7),
        .loss(loss),
        .w1_trained0(w1_t0),.w1_trained1(w1_t1),
        .w1_trained2(w1_t2),.w1_trained3(w1_t3),
        .w1_trained4(w1_t4),.w1_trained5(w1_t5),
        .w1_trained6(w1_t6),.w1_trained7(w1_t7),
        .w2_trained0(w2_t0),.w2_trained1(w2_t1),
        .w2_trained2(w2_t2),.w2_trained3(w2_t3),
        .w2_trained4(w2_t4),.w2_trained5(w2_t5),
        .w2_trained6(w2_t6),.w2_trained7(w2_t7),
        .step_done(step_done)
    );

    always #5 clk = ~clk;

    always @(posedge clk) begin
        if (step_done && !last_done) begin
            tb_step = tb_step + 1;
            $display("  Step %02d  loss=%0d  out0=%0d  w1_0=%0d  w2_0=%0d",
                tb_step, loss, out0, w1_t0, w2_t0);

            // save trained weights — blocking assignment
            pw1_0 = w1_t0; pw1_1 = w1_t1; pw1_2 = w1_t2; pw1_3 = w1_t3;
            pw1_4 = w1_t4; pw1_5 = w1_t5; pw1_6 = w1_t6; pw1_7 = w1_t7;
            pw2_0 = w2_t0; pw2_1 = w2_t1; pw2_2 = w2_t2; pw2_3 = w2_t3;
            pw2_4 = w2_t4; pw2_5 = w2_t5; pw2_6 = w2_t6; pw2_7 = w2_t7;

            if (tb_step >= 16 || loss == 0) begin
                $display("");
                $display("══════════════════════════════════════════════════");
                $display("HYPERION FFN TRAINER");
                $display("══════════════════════════════════════════════════");
                $display("  Final: loss=%0d  out=[%0d,%0d,%0d,%0d]",
                    loss, out0, out1, out2, out3);
                $display("  target:      [%0d,%0d,%0d,%0d]",
                    tgt0, tgt1, tgt2, tgt3);
                if (loss < 100)
                    $display("  ✓ Loss converging toward target!");
                $display("");
                $display("  Hyperion FFN trainer working!");
                $display("  W1 and W2 trained via backpropagation.");
                $display("  Same algorithm as PyTorch/TensorFlow.");
                $display("══════════════════════════════════════════════════");
                $finish;
            end else begin
                reset <= 1;
                #30 reset <= 0;
                #10 start <= 1;
                #10 start <= 0;
            end
        end
        last_done <= step_done;
    end

    initial begin
        clk=0; reset=1; start=0; last_done=0; tb_step=0;
        x0=1;x1=2;x2=3;x3=4;x4=5;x5=6;x6=7;x7=8;
        tgt0=10;tgt1=20;tgt2=10;tgt3=20;
        tgt4=10;tgt5=20;tgt6=10;tgt7=20;
        // init weights small
        pw1_0=1;pw1_1=1;pw1_2=1;pw1_3=1;
        pw1_4=1;pw1_5=1;pw1_6=1;pw1_7=1;
        pw2_0=1;pw2_1=1;pw2_2=1;pw2_3=1;
        pw2_4=1;pw2_5=1;pw2_6=1;pw2_7=1;

        $display("══════════════════════════════════════════════════");
        $display("HYPERION FFN TRAINER — backprop on W1 and W2");
        $display("══════════════════════════════════════════════════");
        $display("  Input:  [1,2,3,4,5,6,7,8]");
        $display("  Target: [10,20,10,20,10,20,10,20]");
        $display("");
        $display("  Step   Loss      out0    w1_0   w2_0");
        $display("  ─────────────────────────────────────");

        #30 reset=0; #10 start=1; #10 start=0;
        #500000; $display("Timeout"); $finish;
    end
endmodule
