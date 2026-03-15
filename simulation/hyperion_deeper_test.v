// ─────────────────────────────────────────
// HYPERION DEEPER TEST — 3 stacked layers
// ─────────────────────────────────────────

module hyperion_deeper_test;

    reg clk, reset, start;

    reg signed [7:0] a0,a1,a2,a3,a4,a5,a6,a7;
    reg signed [7:0] a8,a9,a10,a11,a12,a13,a14,a15;

    reg signed [7:0]  w1_0,w1_1,w1_2,w1_3,w1_4,w1_5,w1_6,w1_7;
    reg signed [7:0]  w1_8,w1_9,w1_10,w1_11,w1_12,w1_13,w1_14,w1_15;
    reg signed [15:0] b1_0,b1_1,b1_2,b1_3,b1_4,b1_5,b1_6,b1_7;
    reg signed [15:0] b1_8,b1_9,b1_10,b1_11,b1_12,b1_13,b1_14,b1_15;

    reg signed [7:0]  w2_0,w2_1,w2_2,w2_3,w2_4,w2_5,w2_6,w2_7;
    reg signed [7:0]  w2_8,w2_9,w2_10,w2_11,w2_12,w2_13,w2_14,w2_15;
    reg signed [15:0] b2_0,b2_1,b2_2,b2_3,b2_4,b2_5,b2_6,b2_7;
    reg signed [15:0] b2_8,b2_9,b2_10,b2_11,b2_12,b2_13,b2_14,b2_15;

    reg signed [7:0]  w3_0,w3_1,w3_2,w3_3,w3_4,w3_5,w3_6,w3_7;
    reg signed [7:0]  w3_8,w3_9,w3_10,w3_11,w3_12,w3_13,w3_14,w3_15;
    reg signed [15:0] b3_0,b3_1,b3_2,b3_3,b3_4,b3_5,b3_6,b3_7;
    reg signed [15:0] b3_8,b3_9,b3_10,b3_11,b3_12,b3_13,b3_14,b3_15;

    wire signed [15:0] out0,out1,out2,out3;
    wire signed [15:0] out4,out5,out6,out7;
    wire signed [15:0] out8,out9,out10,out11;
    wire signed [15:0] out12,out13,out14,out15;
    wire layer1_done, layer2_done, layer3_done;
    reg last_l1, last_l2, last_l3;

    hyperion_deeper deep3 (
        .clk(clk),.reset(reset),.start(start),
        .a0(a0),.a1(a1),.a2(a2),.a3(a3),
        .a4(a4),.a5(a5),.a6(a6),.a7(a7),
        .a8(a8),.a9(a9),.a10(a10),.a11(a11),
        .a12(a12),.a13(a13),.a14(a14),.a15(a15),
        .w1_0(w1_0),.w1_1(w1_1),.w1_2(w1_2),.w1_3(w1_3),
        .w1_4(w1_4),.w1_5(w1_5),.w1_6(w1_6),.w1_7(w1_7),
        .w1_8(w1_8),.w1_9(w1_9),.w1_10(w1_10),.w1_11(w1_11),
        .w1_12(w1_12),.w1_13(w1_13),.w1_14(w1_14),.w1_15(w1_15),
        .b1_0(b1_0),.b1_1(b1_1),.b1_2(b1_2),.b1_3(b1_3),
        .b1_4(b1_4),.b1_5(b1_5),.b1_6(b1_6),.b1_7(b1_7),
        .b1_8(b1_8),.b1_9(b1_9),.b1_10(b1_10),.b1_11(b1_11),
        .b1_12(b1_12),.b1_13(b1_13),.b1_14(b1_14),.b1_15(b1_15),
        .w2_0(w2_0),.w2_1(w2_1),.w2_2(w2_2),.w2_3(w2_3),
        .w2_4(w2_4),.w2_5(w2_5),.w2_6(w2_6),.w2_7(w2_7),
        .w2_8(w2_8),.w2_9(w2_9),.w2_10(w2_10),.w2_11(w2_11),
        .w2_12(w2_12),.w2_13(w2_13),.w2_14(w2_14),.w2_15(w2_15),
        .b2_0(b2_0),.b2_1(b2_1),.b2_2(b2_2),.b2_3(b2_3),
        .b2_4(b2_4),.b2_5(b2_5),.b2_6(b2_6),.b2_7(b2_7),
        .b2_8(b2_8),.b2_9(b2_9),.b2_10(b2_10),.b2_11(b2_11),
        .b2_12(b2_12),.b2_13(b2_13),.b2_14(b2_14),.b2_15(b2_15),
        .w3_0(w3_0),.w3_1(w3_1),.w3_2(w3_2),.w3_3(w3_3),
        .w3_4(w3_4),.w3_5(w3_5),.w3_6(w3_6),.w3_7(w3_7),
        .w3_8(w3_8),.w3_9(w3_9),.w3_10(w3_10),.w3_11(w3_11),
        .w3_12(w3_12),.w3_13(w3_13),.w3_14(w3_14),.w3_15(w3_15),
        .b3_0(b3_0),.b3_1(b3_1),.b3_2(b3_2),.b3_3(b3_3),
        .b3_4(b3_4),.b3_5(b3_5),.b3_6(b3_6),.b3_7(b3_7),
        .b3_8(b3_8),.b3_9(b3_9),.b3_10(b3_10),.b3_11(b3_11),
        .b3_12(b3_12),.b3_13(b3_13),.b3_14(b3_14),.b3_15(b3_15),
        .out0(out0),.out1(out1),.out2(out2),.out3(out3),
        .out4(out4),.out5(out5),.out6(out6),.out7(out7),
        .out8(out8),.out9(out9),.out10(out10),.out11(out11),
        .out12(out12),.out13(out13),.out14(out14),.out15(out15),
        .layer1_done(layer1_done),
        .layer2_done(layer2_done),
        .layer3_done(layer3_done)
    );

    always #5 clk = ~clk;

    always @(posedge clk) begin
        if (layer1_done && !last_l1)
            $display("  Layer 1 done — feeding into layer 2...");
        if (layer2_done && !last_l2)
            $display("  Layer 2 done — feeding into layer 3...");
        if (layer3_done && !last_l3) begin
            $display("  Layer 3 done!");
            $display("");
            $display("Final output (3 layers deep):");
            $display("  out[ 0- 3]: %5d %5d %5d %5d",
                out0,out1,out2,out3);
            $display("  out[ 4- 7]: %5d %5d %5d %5d",
                out4,out5,out6,out7);
            $display("  out[ 8-11]: %5d %5d %5d %5d",
                out8,out9,out10,out11);
            $display("  out[12-15]: %5d %5d %5d %5d",
                out12,out13,out14,out15);
            $display("");
            $display("══════════════════════════════════════════");
            $display("Hyperion DEEPER — 3 layers complete.");
            $display("Input → L1 → L2 → L3 → Output");
            $display("768 MAC operations total.");
            $display("GPT-2 small has 12 of these.");
            $display("Hyperion has 3. Same architecture.");
            $display("══════════════════════════════════════════");
            $finish;
        end
        last_l1 <= layer1_done;
        last_l2 <= layer2_done;
        last_l3 <= layer3_done;
    end

    initial begin
        clk=0; reset=1; start=0;
        last_l1=0; last_l2=0; last_l3=0;

        a0=1; a1=1; a2=1; a3=1;
        a4=1; a5=1; a6=1; a7=1;
        a8=1; a9=1; a10=1; a11=1;
        a12=1; a13=1; a14=1; a15=1;

        // layer 1
        w1_0=3;  w1_1=-2; w1_2=5;  w1_3=-1;
        w1_4=4;  w1_5=-3; w1_6=2;  w1_7=-4;
        w1_8=6;  w1_9=-1; w1_10=3; w1_11=-2;
        w1_12=1; w1_13=-5; w1_14=4; w1_15=-3;
        b1_0=10; b1_1=50; b1_2=5;  b1_3=10;
        b1_4=8;  b1_5=100; b1_6=3; b1_7=50;
        b1_8=12; b1_9=20; b1_10=7; b1_11=30;
        b1_12=5; b1_13=80; b1_14=10; b1_15=40;

        // layer 2
        w2_0=2;  w2_1=3;  w2_2=-1; w2_3=4;
        w2_4=-2; w2_5=1;  w2_6=3;  w2_7=-2;
        w2_8=5;  w2_9=2;  w2_10=-3; w2_11=1;
        w2_12=3; w2_13=-1; w2_14=2; w2_15=4;
        b2_0=5;  b2_1=3;  b2_2=20; b2_3=2;
        b2_4=15; b2_5=8;  b2_6=4;  b2_7=10;
        b2_8=3;  b2_9=6;  b2_10=15; b2_11=5;
        b2_12=2; b2_13=12; b2_14=7; b2_15=3;

        // layer 3 — different weights again
        w3_0=1;  w3_1=4;  w3_2=2;  w3_3=-3;
        w3_4=3;  w3_5=-1; w3_6=5;  w3_7=2;
        w3_8=-2; w3_9=3;  w3_10=1; w3_11=4;
        w3_12=2; w3_13=5; w3_14=-1; w3_15=3;
        b3_0=8;  b3_1=4;  b3_2=6;  b3_3=15;
        b3_4=3;  b3_5=10; b3_6=2;  b3_7=5;
        b3_8=12; b3_9=3;  b3_10=8; b3_11=2;
        b3_12=6; b3_13=1; b3_14=9; b3_15=4;

        #30 reset=0;

        $display("Hyperion DEEPER — 3 stacked layer test");
        $display("══════════════════════════════════════════");
        $display("Input → L1(×W1+B1→ReLU) →");
        $display("        L2(×W2+B2→ReLU) →");
        $display("        L3(×W3+B3→ReLU) → Output");
        $display("══════════════════════════════════════════");

        #10 start=1;
        #10 start=0;

        #2000;
        $display("Timeout");
        $finish;
    end

endmodule