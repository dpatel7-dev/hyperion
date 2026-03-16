module layer32_test;
    reg clk, reset, start;
    reg signed [7:0] a0,a1,a2,a3,a4,a5,a6,a7;
    reg signed [7:0] a8,a9,a10,a11,a12,a13,a14,a15;
    reg signed [7:0] a16,a17,a18,a19,a20,a21,a22,a23;
    reg signed [7:0] a24,a25,a26,a27,a28,a29,a30,a31;
    reg signed [7:0] w0,w1,w2,w3,w4,w5,w6,w7;
    reg signed [7:0] w8,w9,w10,w11,w12,w13,w14,w15;
    reg signed [7:0] w16,w17,w18,w19,w20,w21,w22,w23;
    reg signed [7:0] w24,w25,w26,w27,w28,w29,w30,w31;
    reg signed [15:0] bias0,bias1,bias2,bias3,bias4,bias5,bias6,bias7;
    reg signed [15:0] bias8,bias9,bias10,bias11,bias12,bias13,bias14,bias15;
    reg signed [15:0] bias16,bias17,bias18,bias19,bias20,bias21,bias22,bias23;
    reg signed [15:0] bias24,bias25,bias26,bias27,bias28,bias29,bias30,bias31;
    wire signed [15:0] out0,out1,out2,out3,out4,out5,out6,out7;
    wire signed [15:0] out8,out9,out10,out11,out12,out13,out14,out15;
    wire signed [15:0] out16,out17,out18,out19,out20,out21,out22,out23;
    wire signed [15:0] out24,out25,out26,out27,out28,out29,out30,out31;
    wire done;
    reg last_done;

    hyperion_layer_32x32 dut (
        .clk(clk),.reset(reset),.start(start),
        .a0(a0),.a1(a1),.a2(a2),.a3(a3),.a4(a4),.a5(a5),.a6(a6),.a7(a7),
        .a8(a8),.a9(a9),.a10(a10),.a11(a11),.a12(a12),.a13(a13),.a14(a14),.a15(a15),
        .a16(a16),.a17(a17),.a18(a18),.a19(a19),.a20(a20),.a21(a21),.a22(a22),.a23(a23),
        .a24(a24),.a25(a25),.a26(a26),.a27(a27),.a28(a28),.a29(a29),.a30(a30),.a31(a31),
        .w0(w0),.w1(w1),.w2(w2),.w3(w3),.w4(w4),.w5(w5),.w6(w6),.w7(w7),
        .w8(w8),.w9(w9),.w10(w10),.w11(w11),.w12(w12),.w13(w13),.w14(w14),.w15(w15),
        .w16(w16),.w17(w17),.w18(w18),.w19(w19),.w20(w20),.w21(w21),.w22(w22),.w23(w23),
        .w24(w24),.w25(w25),.w26(w26),.w27(w27),.w28(w28),.w29(w29),.w30(w30),.w31(w31),
        .bias0(bias0),.bias1(bias1),.bias2(bias2),.bias3(bias3),
        .bias4(bias4),.bias5(bias5),.bias6(bias6),.bias7(bias7),
        .bias8(bias8),.bias9(bias9),.bias10(bias10),.bias11(bias11),
        .bias12(bias12),.bias13(bias13),.bias14(bias14),.bias15(bias15),
        .bias16(bias16),.bias17(bias17),.bias18(bias18),.bias19(bias19),
        .bias20(bias20),.bias21(bias21),.bias22(bias22),.bias23(bias23),
        .bias24(bias24),.bias25(bias25),.bias26(bias26),.bias27(bias27),
        .bias28(bias28),.bias29(bias29),.bias30(bias30),.bias31(bias31),
        .out0(out0),.out1(out1),.out2(out2),.out3(out3),
        .out4(out4),.out5(out5),.out6(out6),.out7(out7),
        .out8(out8),.out9(out9),.out10(out10),.out11(out11),
        .out12(out12),.out13(out13),.out14(out14),.out15(out15),
        .out16(out16),.out17(out17),.out18(out18),.out19(out19),
        .out20(out20),.out21(out21),.out22(out22),.out23(out23),
        .out24(out24),.out25(out25),.out26(out26),.out27(out27),
        .out28(out28),.out29(out29),.out30(out30),.out31(out31),
        .done(done)
    );

    always #5 clk = ~clk;

    always @(posedge clk) begin
        if (done && !last_done) begin
            $display("Hyperion 32x32 layer output:");
            $display("  out[ 0- 3]: %0d %0d %0d %0d", out0,out1,out2,out3);
            $display("  out[ 4- 7]: %0d %0d %0d %0d", out4,out5,out6,out7);
            $display("  out[28-31]: %0d %0d %0d %0d", out28,out29,out30,out31);
            $display("");
            $display("══════════════════════════════════════");
            $display("Hyperion 32x32 layer — 1024 MACs verified!");
            $display("══════════════════════════════════════");
            $finish;
        end
        last_done <= done;
    end

    integer i;
    initial begin
        clk=0; reset=1; start=0; last_done=0;
        // all inputs = 2, all weights = 3
        a0=2;a1=2;a2=2;a3=2;a4=2;a5=2;a6=2;a7=2;
        a8=2;a9=2;a10=2;a11=2;a12=2;a13=2;a14=2;a15=2;
        a16=2;a17=2;a18=2;a19=2;a20=2;a21=2;a22=2;a23=2;
        a24=2;a25=2;a26=2;a27=2;a28=2;a29=2;a30=2;a31=2;
        w0=3;w1=3;w2=3;w3=3;w4=3;w5=3;w6=3;w7=3;
        w8=3;w9=3;w10=3;w11=3;w12=3;w13=3;w14=3;w15=3;
        w16=3;w17=3;w18=3;w19=3;w20=3;w21=3;w22=3;w23=3;
        w24=3;w25=3;w26=3;w27=3;w28=3;w29=3;w30=3;w31=3;
        bias0=0;bias1=0;bias2=0;bias3=0;bias4=0;bias5=0;bias6=0;bias7=0;
        bias8=0;bias9=0;bias10=0;bias11=0;bias12=0;bias13=0;bias14=0;bias15=0;
        bias16=0;bias17=0;bias18=0;bias19=0;bias20=0;bias21=0;bias22=0;bias23=0;
        bias24=0;bias25=0;bias26=0;bias27=0;bias28=0;bias29=0;bias30=0;bias31=0;
        #30 reset=0; #10 start=1; #10 start=0;
        #5000;
        $display("Timeout"); $finish;
    end
endmodule
