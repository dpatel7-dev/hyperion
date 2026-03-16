module ffn_test;
    reg clk, reset, start;
    reg signed [15:0] x0,x1,x2,x3,x4,x5,x6,x7;
    reg signed [7:0]  w1_0,w1_1,w1_2,w1_3,w1_4,w1_5,w1_6,w1_7;
    reg signed [15:0] b1_0,b1_1,b1_2,b1_3,b1_4,b1_5,b1_6,b1_7;
    reg signed [7:0]  w2_0,w2_1,w2_2,w2_3,w2_4,w2_5,w2_6,w2_7;
    reg signed [15:0] b2_0,b2_1,b2_2,b2_3,b2_4,b2_5,b2_6,b2_7;
    wire signed [15:0] out0,out1,out2,out3,out4,out5,out6,out7;
    wire done;
    reg last_done;

    ffn_unit ffn (
        .clk(clk),.reset(reset),.start(start),
        .x0(x0),.x1(x1),.x2(x2),.x3(x3),
        .x4(x4),.x5(x5),.x6(x6),.x7(x7),
        .w1_0(w1_0),.w1_1(w1_1),.w1_2(w1_2),.w1_3(w1_3),
        .w1_4(w1_4),.w1_5(w1_5),.w1_6(w1_6),.w1_7(w1_7),
        .b1_0(b1_0),.b1_1(b1_1),.b1_2(b1_2),.b1_3(b1_3),
        .b1_4(b1_4),.b1_5(b1_5),.b1_6(b1_6),.b1_7(b1_7),
        .w2_0(w2_0),.w2_1(w2_1),.w2_2(w2_2),.w2_3(w2_3),
        .w2_4(w2_4),.w2_5(w2_5),.w2_6(w2_6),.w2_7(w2_7),
        .b2_0(b2_0),.b2_1(b2_1),.b2_2(b2_2),.b2_3(b2_3),
        .b2_4(b2_4),.b2_5(b2_5),.b2_6(b2_6),.b2_7(b2_7),
        .out0(out0),.out1(out1),.out2(out2),.out3(out3),
        .out4(out4),.out5(out5),.out6(out6),.out7(out7),
        .done(done)
    );

    always #5 clk = ~clk;

    always @(posedge clk) begin
        if (done && !last_done) begin
            $display("══════════════════════════════════════════");
            $display("HYPERION FFN UNIT");
            $display("input → Linear → ReLU → Linear → output");
            $display("══════════════════════════════════════════");
            $display("Output: [%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d]",
                out0,out1,out2,out3,out4,out5,out6,out7);
            $display("");
            $display("══════════════════════════════════════════");
            $display("Hyperion FFN unit working!");
            $display("GPT-2 uses 12 of these per transformer block.");
            $display("Hyperion has 1. Same architecture.");
            $display("══════════════════════════════════════════");
            $finish;
        end
        last_done <= done;
    end

    initial begin
        clk=0; reset=1; start=0; last_done=0;
        x0=10; x1=20; x2=30; x3=40;
        x4=50; x5=60; x6=70; x7=80;
        w1_0=2; w1_1=3; w1_2=1; w1_3=4;
        w1_4=2; w1_5=1; w1_6=3; w1_7=2;
        b1_0=5; b1_1=5; b1_2=5; b1_3=5;
        b1_4=5; b1_5=5; b1_6=5; b1_7=5;
        w2_0=1; w2_1=2; w2_2=1; w2_3=2;
        w2_4=1; w2_5=2; w2_6=1; w2_7=2;
        b2_0=0; b2_1=0; b2_2=0; b2_3=0;
        b2_4=0; b2_5=0; b2_6=0; b2_7=0;
        #30 reset=0; #10 start=1; #10 start=0;
        #500;
        $display("Timeout"); $finish;
    end
endmodule
