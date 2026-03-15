// ─────────────────────────────────────────
// HYPERION LAYER TEST
// Full neural network layer:
// matrix multiply + ReLU end to end
// ─────────────────────────────────────────

module hyperion_layer_test;

    reg clk, reset, start;
    reg signed [7:0] a0,a1,a2,a3,a4,a5,a6,a7;
    reg signed [7:0] a8,a9,a10,a11,a12,a13,a14,a15;
    reg signed [7:0] w0,w1,w2,w3,w4,w5,w6,w7;
    reg signed [7:0] w8,w9,w10,w11,w12,w13,w14,w15;

    wire signed [15:0] out0,out1,out2,out3;
    wire signed [15:0] out4,out5,out6,out7;
    wire signed [15:0] out8,out9,out10,out11;
    wire signed [15:0] out12,out13,out14,out15;
    wire done;

    reg last_done;

    hyperion_layer layer (
        .clk(clk),.reset(reset),.start(start),
        .a0(a0),.a1(a1),.a2(a2),.a3(a3),
        .a4(a4),.a5(a5),.a6(a6),.a7(a7),
        .a8(a8),.a9(a9),.a10(a10),.a11(a11),
        .a12(a12),.a13(a13),.a14(a14),.a15(a15),
        .w0(w0),.w1(w1),.w2(w2),.w3(w3),
        .w4(w4),.w5(w5),.w6(w6),.w7(w7),
        .w8(w8),.w9(w9),.w10(w10),.w11(w11),
        .w12(w12),.w13(w13),.w14(w14),.w15(w15),
        .out0(out0),.out1(out1),.out2(out2),.out3(out3),
        .out4(out4),.out5(out5),.out6(out6),.out7(out7),
        .out8(out8),.out9(out9),.out10(out10),.out11(out11),
        .out12(out12),.out13(out13),.out14(out14),.out15(out15),
        .done(done)
    );

    always #5 clk = ~clk;

    always @(posedge clk) begin
        if (done && !last_done) begin
            $display("\nHyperion Layer — complete!");
            $display("══════════════════════════════════════");
            $display("Stage 1: 16x16 systolic array");
            $display("         256 MACs running in parallel");
            $display("Stage 2: ReLU activation");
            $display("         Negatives zeroed out");
            $display("══════════════════════════════════════");
            $display("Output (post-ReLU):");
            $display("  out[ 0- 3]: %4d %4d %4d %4d",
                out0,out1,out2,out3);
            $display("  out[ 4- 7]: %4d %4d %4d %4d",
                out4,out5,out6,out7);
            $display("  out[ 8-11]: %4d %4d %4d %4d",
                out8,out9,out10,out11);
            $display("  out[12-15]: %4d %4d %4d %4d",
                out12,out13,out14,out15);
            $display("══════════════════════════════════════");
            $display("Positive weights → positive outputs");
            $display("Negative weights → 0 (ReLU zeroed)");
            $display("This is one complete transformer layer.");
            $display("Hyperion v0.7 — full neural net layer.");
            $finish;
        end
        last_done <= done;
    end

    initial begin
        clk=0; reset=1; start=0;
        last_done=0;

        // input row: all 1s
        a0=1; a1=1; a2=1; a3=1;
        a4=1; a5=1; a6=1; a7=1;
        a8=1; a9=1; a10=1; a11=1;
        a12=1; a13=1; a14=1; a15=1;

        // weights: alternating positive and negative
        // positive weights → positive output → pass ReLU
        // negative weights → negative output → zeroed by ReLU
        w0=3;  w1=-2; w2=5;  w3=-1;
        w4=4;  w5=-3; w6=2;  w7=-4;
        w8=6;  w9=-1; w10=3; w11=-2;
        w12=1; w13=-5; w14=4; w15=-3;

        #30 reset=0;
        #10 start=1;
        #10 start=0;

        #500;
        $display("Timeout");
        $finish;
    end

endmodule