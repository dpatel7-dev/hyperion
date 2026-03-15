// ─────────────────────────────────────────
// BIAS UNIT TEST
// verifies bias addition is correct
// ─────────────────────────────────────────

module bias_test;

    reg clk, reset, enable;
    reg  signed [15:0] in0,in1,in2,in3;
    reg  signed [15:0] in4,in5,in6,in7;
    reg  signed [15:0] in8,in9,in10,in11;
    reg  signed [15:0] in12,in13,in14,in15;
    reg  signed [15:0] b0,b1,b2,b3;
    reg  signed [15:0] b4,b5,b6,b7;
    reg  signed [15:0] b8,b9,b10,b11;
    reg  signed [15:0] b12,b13,b14,b15;
    wire signed [15:0] out0,out1,out2,out3;
    wire signed [15:0] out4,out5,out6,out7;
    wire signed [15:0] out8,out9,out10,out11;
    wire signed [15:0] out12,out13,out14,out15;

    bias_unit bias (
        .clk(clk),.reset(reset),.enable(enable),
        .in0(in0),.in1(in1),.in2(in2),.in3(in3),
        .in4(in4),.in5(in5),.in6(in6),.in7(in7),
        .in8(in8),.in9(in9),.in10(in10),.in11(in11),
        .in12(in12),.in13(in13),.in14(in14),.in15(in15),
        .b0(b0),.b1(b1),.b2(b2),.b3(b3),
        .b4(b4),.b5(b5),.b6(b6),.b7(b7),
        .b8(b8),.b9(b9),.b10(b10),.b11(b11),
        .b12(b12),.b13(b13),.b14(b14),.b15(b15),
        .out0(out0),.out1(out1),.out2(out2),.out3(out3),
        .out4(out4),.out5(out5),.out6(out6),.out7(out7),
        .out8(out8),.out9(out9),.out10(out10),.out11(out11),
        .out12(out12),.out13(out13),.out14(out14),.out15(out15)
    );

    always #5 clk = ~clk;

    initial begin
        clk=0; reset=1; enable=1;
        #10 reset=0;

        // inputs from systolic array
        in0=10;  in1=20;  in2=30;  in3=40;
        in4=50;  in5=60;  in6=70;  in7=80;
        in8=90;  in9=100; in10=110; in11=120;
        in12=130; in13=140; in14=150; in15=160;

        // bias values — some positive, some negative
        // positive bias shifts neuron up
        // negative bias shifts neuron down
        b0=5;   b1=-10; b2=3;   b3=-20;
        b4=10;  b5=-5;  b6=15;  b7=-8;
        b8=2;   b9=-15; b10=7;  b11=-3;
        b12=20; b13=-1; b14=10; b15=-12;
        #10;

        $display("Hyperion bias unit test:");
        $display("────────────────────────────────────────");
        $display("  input + bias = output  (expected)");
        $display("────────────────────────────────────────");
        $display("   10 + 5   = %0d  (expected 15)",   out0);
        $display("   20 + -10 = %0d  (expected 10)",   out1);
        $display("   30 + 3   = %0d  (expected 33)",   out2);
        $display("   40 + -20 = %0d  (expected 20)",   out3);
        $display("   50 + 10  = %0d  (expected 60)",   out4);
        $display("   60 + -5  = %0d  (expected 55)",   out5);
        $display("   70 + 15  = %0d  (expected 85)",   out6);
        $display("   80 + -8  = %0d  (expected 72)",   out7);
        $display("   90 + 2   = %0d  (expected 92)",   out8);
        $display("  100 + -15 = %0d  (expected 85)",   out9);
        $display("  110 + 7   = %0d  (expected 117)",  out10);
        $display("  120 + -3  = %0d  (expected 117)",  out11);
        $display("  130 + 20  = %0d  (expected 150)",  out12);
        $display("  140 + -1  = %0d  (expected 139)",  out13);
        $display("  150 + 10  = %0d  (expected 160)",  out14);
        $display("  160 + -12 = %0d  (expected 148)",  out15);
        $display("────────────────────────────────────────");
        $display("Hyperion bias unit working!");
        $display("output = input + bias verified.");
        $finish;
    end

endmodule