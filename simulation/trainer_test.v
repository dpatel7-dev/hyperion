module trainer_test;
    reg clk, reset, start;
    reg signed [7:0]  a0,a1,a2,a3,a4,a5,a6,a7;
    reg signed [7:0]  a8,a9,a10,a11,a12,a13,a14,a15;
    reg signed [15:0] t0,t1,t2,t3,t4,t5,t6,t7;
    reg signed [15:0] t8,t9,t10,t11,t12,t13,t14,t15;
    reg signed [7:0]  w0,w1,w2,w3,w4,w5,w6,w7;
    reg signed [7:0]  w8,w9,w10,w11,w12,w13,w14,w15;
    reg signed [15:0] bias0,bias1,bias2,bias3;
    reg signed [15:0] bias4,bias5,bias6,bias7;
    reg signed [15:0] bias8,bias9,bias10,bias11;
    reg signed [15:0] bias12,bias13,bias14,bias15;
    reg [7:0] lr_scaled;
    wire signed [7:0]  w_new0,w_new1,w_new2,w_new3;
    wire signed [7:0]  w_new4,w_new5,w_new6,w_new7;
    wire signed [7:0]  w_new8,w_new9,w_new10,w_new11;
    wire signed [7:0]  w_new12,w_new13,w_new14,w_new15;
    wire signed [15:0] out0,out1,out2,out3,out4,out5,out6,out7;
    wire signed [15:0] out8,out9,out10,out11,out12,out13,out14,out15;
    wire signed [15:0] loss;
    wire done;
    hyperion_trainer trainer (
        .clk(clk),.reset(reset),.start(start),
        .a0(a0),.a1(a1),.a2(a2),.a3(a3),.a4(a4),.a5(a5),.a6(a6),.a7(a7),
        .a8(a8),.a9(a9),.a10(a10),.a11(a11),.a12(a12),.a13(a13),.a14(a14),.a15(a15),
        .t0(t0),.t1(t1),.t2(t2),.t3(t3),.t4(t4),.t5(t5),.t6(t6),.t7(t7),
        .t8(t8),.t9(t9),.t10(t10),.t11(t11),.t12(t12),.t13(t13),.t14(t14),.t15(t15),
        .w0(w0),.w1(w1),.w2(w2),.w3(w3),.w4(w4),.w5(w5),.w6(w6),.w7(w7),
        .w8(w8),.w9(w9),.w10(w10),.w11(w11),.w12(w12),.w13(w13),.w14(w14),.w15(w15),
        .bias0(bias0),.bias1(bias1),.bias2(bias2),.bias3(bias3),
        .bias4(bias4),.bias5(bias5),.bias6(bias6),.bias7(bias7),
        .bias8(bias8),.bias9(bias9),.bias10(bias10),.bias11(bias11),
        .bias12(bias12),.bias13(bias13),.bias14(bias14),.bias15(bias15),
        .lr_scaled(lr_scaled),
        .w_new0(w_new0),.w_new1(w_new1),.w_new2(w_new2),.w_new3(w_new3),
        .w_new4(w_new4),.w_new5(w_new5),.w_new6(w_new6),.w_new7(w_new7),
        .w_new8(w_new8),.w_new9(w_new9),.w_new10(w_new10),.w_new11(w_new11),
        .w_new12(w_new12),.w_new13(w_new13),.w_new14(w_new14),.w_new15(w_new15),
        .out0(out0),.out1(out1),.out2(out2),.out3(out3),
        .out4(out4),.out5(out5),.out6(out6),.out7(out7),
        .out8(out8),.out9(out9),.out10(out10),.out11(out11),
        .out12(out12),.out13(out13),.out14(out14),.out15(out15),
        .loss(loss),.done(done)
    );
    always #5 clk = ~clk;
    integer step;
    task run_step;
        input integer s;
        begin
            reset=1; #20; reset=0; #10;
            start=1; #10; start=0;
            @(posedge done); #1;
            $display("  Step %0d  loss=%0d  out0=%0d  w0=%0d->%0d",
                s, loss, out0, w0, w_new0);
            w0=w_new0;w1=w_new1;w2=w_new2;w3=w_new3;
            w4=w_new4;w5=w_new5;w6=w_new6;w7=w_new7;
            w8=w_new8;w9=w_new9;w10=w_new10;w11=w_new11;
            w12=w_new12;w13=w_new13;w14=w_new14;w15=w_new15;
            #20;
        end
    endtask
    initial begin
        clk=0; reset=1; start=0;
        lr_scaled=8;   // divide by 128 — gentle updates
        a0=4; a1=0; a2=0; a3=0;
        a4=0; a5=0; a6=0; a7=0;
        a8=0; a9=0; a10=0; a11=0;
        a12=0; a13=0; a14=0; a15=0;
        // out=80 when w0=1 — target 160 means w0 should reach 2
        t0=160; t1=0; t2=0; t3=0;
        t4=0; t5=0; t6=0; t7=0;
        t8=0; t9=0; t10=0; t11=0;
        t12=0; t13=0; t14=0; t15=0;
        w0=1; w1=0; w2=0; w3=0;
        w4=0; w5=0; w6=0; w7=0;
        w8=0; w9=0; w10=0; w11=0;
        w12=0; w13=0; w14=0; w15=0;
        bias0=0;bias1=0;bias2=0;bias3=0;
        bias4=0;bias5=0;bias6=0;bias7=0;
        bias8=0;bias9=0;bias10=0;bias11=0;
        bias12=0;bias13=0;bias14=0;bias15=0;
        #30;
        $display("══════════════════════════════════════");
        $display("HYPERION TRAINER — 20 training steps");
        $display("Input: a0=4  Initial out=80  Target: out0=160");
        $display("w0 should increase from 1 toward 2");
        $display("Loss should decrease toward 0");
        $display("══════════════════════════════════════");
        for (step=0; step<20; step=step+1)
            run_step(step);
        $display("══════════════════════════════════════");
        $display("Hyperion hardware training complete.");
        $display("══════════════════════════════════════");
        $finish;
    end
endmodule
