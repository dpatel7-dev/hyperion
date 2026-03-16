// ─────────────────────────────────────────
// WEIGHT UPDATE UNIT TEST
// Verifies w_new = w_old - lr * dw
// ─────────────────────────────────────────

module weight_update_test;

    reg clk, reset, enable;
    reg [7:0] lr_scaled;

    reg signed [7:0]  w0,w1,w2,w3,w4,w5,w6,w7;
    reg signed [7:0]  w8,w9,w10,w11,w12,w13,w14,w15;
    reg signed [15:0] dw0,dw1,dw2,dw3,dw4,dw5,dw6,dw7;
    reg signed [15:0] dw8,dw9,dw10,dw11,dw12,dw13,dw14,dw15;

    wire signed [7:0] w_new0,w_new1,w_new2,w_new3;
    wire signed [7:0] w_new4,w_new5,w_new6,w_new7;
    wire signed [7:0] w_new8,w_new9,w_new10,w_new11;
    wire signed [7:0] w_new12,w_new13,w_new14,w_new15;

    weight_update_unit wuu (
        .clk(clk),.reset(reset),.enable(enable),
        .lr_scaled(lr_scaled),
        .w0(w0),.w1(w1),.w2(w2),.w3(w3),
        .w4(w4),.w5(w5),.w6(w6),.w7(w7),
        .w8(w8),.w9(w9),.w10(w10),.w11(w11),
        .w12(w12),.w13(w13),.w14(w14),.w15(w15),
        .dw0(dw0),.dw1(dw1),.dw2(dw2),.dw3(dw3),
        .dw4(dw4),.dw5(dw5),.dw6(dw6),.dw7(dw7),
        .dw8(dw8),.dw9(dw9),.dw10(dw10),.dw11(dw11),
        .dw12(dw12),.dw13(dw13),.dw14(dw14),.dw15(dw15),
        .w_new0(w_new0),.w_new1(w_new1),
        .w_new2(w_new2),.w_new3(w_new3),
        .w_new4(w_new4),.w_new5(w_new5),
        .w_new6(w_new6),.w_new7(w_new7),
        .w_new8(w_new8),.w_new9(w_new9),
        .w_new10(w_new10),.w_new11(w_new11),
        .w_new12(w_new12),.w_new13(w_new13),
        .w_new14(w_new14),.w_new15(w_new15)
    );

    always #5 clk = ~clk;

    initial begin
        clk=0; reset=1; enable=0;
        #10 reset=0; enable=1;

        // current weights
        w0=10; w1=20; w2=30; w3=40;
        w4=50; w5=60; w6=70; w7=80;
        w8=10; w9=20; w10=30; w11=40;
        w12=50; w13=60; w14=70; w15=80;

        // gradients — positive means weight should decrease
        dw0=40; dw1=0;  dw2=20; dw3=0;
        dw4=16; dw5=0;  dw6=8;  dw7=0;
        dw8=40; dw9=0;  dw10=20; dw11=0;
        dw12=16; dw13=0; dw14=8; dw15=0;

        // lr_scaled=2 means divide gradient by 4 (2^2)
        // so update = dw >> 2
        // dw0=40 → update=10 → w_new0 = 10-10 = 0
        // dw2=20 → update=5  → w_new2 = 30-5  = 25
        lr_scaled = 2;
        #10;

        $display("══════════════════════════════════════════");
        $display("HYPERION WEIGHT UPDATE UNIT");
        $display("w_new = w_old - (dw >> lr_scaled)");
        $display("══════════════════════════════════════════");
        $display("");
        $display("lr_scaled = 2 (effective lr = 1/4)");
        $display("");
        $display("Weight updates (first 4):");
        $display("  w0:  %0d - (%0d>>2=%0d) = %0d (expected 0)",
            w0, dw0, dw0>>2, w_new0);
        $display("  w1:  %0d - (%0d>>2=%0d) = %0d (expected 20)",
            w1, dw1, dw1>>2, w_new1);
        $display("  w2:  %0d - (%0d>>2=%0d) = %0d (expected 25)",
            w2, dw2, dw2>>2, w_new2);
        $display("  w3:  %0d - (%0d>>2=%0d) = %0d (expected 40)",
            w3, dw3, dw3>>2, w_new3);
        $display("");

        if (w_new0==0 && w_new1==20 && w_new2==25 && w_new3==40) begin
            $display("══════════════════════════════════════════");
            $display("Hyperion weight update unit working!");
            $display("Training loop is now COMPLETE:");
            $display("  Forward pass  → hyperion_layer");
            $display("  Backward pass → gradient_unit");
            $display("  Weight update → weight_update_unit");
            $display("Hyperion can train neural networks.");
            $display("══════════════════════════════════════════");
        end else begin
            $display("FAIL — check values");
        end
        $finish;
    end

endmodule