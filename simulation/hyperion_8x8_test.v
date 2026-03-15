// ─────────────────────────────────────────
// HYPERION 8x8 FULL CHIP TEST
// 64 MAC units through complete pipeline
// ─────────────────────────────────────────

module hyperion_8x8_test;

    reg clk, reset, start;
    reg signed [7:0] a0,a1,a2,a3,a4,a5,a6,a7;
    reg signed [7:0] w0,w1,w2,w3,w4,w5,w6,w7;

    wire done;
    wire [2:0] state_out;
    wire signed [15:0] out00,out01,out02,out03,out04,out05,out06,out07;
    wire signed [15:0] out10,out11,out12,out13,out14,out15,out16,out17;
    wire signed [15:0] out20,out21,out22,out23,out24,out25,out26,out27;
    wire signed [15:0] out30,out31,out32,out33,out34,out35,out36,out37;
    wire signed [15:0] out40,out41,out42,out43,out44,out45,out46,out47;
    wire signed [15:0] out50,out51,out52,out53,out54,out55,out56,out57;
    wire signed [15:0] out60,out61,out62,out63,out64,out65,out66,out67;
    wire signed [15:0] out70,out71,out72,out73,out74,out75,out76,out77;

    reg last_done;

    hyperion_top_8x8 chip (
        .clk(clk),.reset(reset),.start(start),
        .a0(a0),.a1(a1),.a2(a2),.a3(a3),
        .a4(a4),.a5(a5),.a6(a6),.a7(a7),
        .w0(w0),.w1(w1),.w2(w2),.w3(w3),
        .w4(w4),.w5(w5),.w6(w6),.w7(w7),
        .done(done),.state_out(state_out),
        .out00(out00),.out01(out01),.out02(out02),.out03(out03),
        .out04(out04),.out05(out05),.out06(out06),.out07(out07),
        .out10(out10),.out11(out11),.out12(out12),.out13(out13),
        .out14(out14),.out15(out15),.out16(out16),.out17(out17),
        .out20(out20),.out21(out21),.out22(out22),.out23(out23),
        .out24(out24),.out25(out25),.out26(out26),.out27(out27),
        .out30(out30),.out31(out31),.out32(out32),.out33(out33),
        .out34(out34),.out35(out35),.out36(out36),.out37(out37),
        .out40(out40),.out41(out41),.out42(out42),.out43(out43),
        .out44(out44),.out45(out45),.out46(out46),.out47(out47),
        .out50(out50),.out51(out51),.out52(out52),.out53(out53),
        .out54(out54),.out55(out55),.out56(out56),.out57(out57),
        .out60(out60),.out61(out61),.out62(out62),.out63(out63),
        .out64(out64),.out65(out65),.out66(out66),.out67(out67),
        .out70(out70),.out71(out71),.out72(out72),.out73(out73),
        .out74(out74),.out75(out75),.out76(out76),.out77(out77)
    );

    always #5 clk = ~clk;

    always @(posedge clk) begin
        if (done && !last_done) begin
            $display("\nHyperion 8x8 — computation complete!");
            $display("────────────────────────────────────────────");
            $display("Inputs:  a=[1,2,3,4,5,6,7,8]");
            $display("Weights: w=[1,2,3,4,5,6,7,8]");
            $display("────────────────────────────────────────────");
            $display("Output matrix:");
            $display("  Row 0: %4d%4d%4d%4d%4d%4d%4d%4d",
                out00,out01,out02,out03,out04,out05,out06,out07);
            $display("  Row 1: %4d%4d%4d%4d%4d%4d%4d%4d",
                out10,out11,out12,out13,out14,out15,out16,out17);
            $display("  Row 2: %4d%4d%4d%4d%4d%4d%4d%4d",
                out20,out21,out22,out23,out24,out25,out26,out27);
            $display("  Row 3: %4d%4d%4d%4d%4d%4d%4d%4d",
                out30,out31,out32,out33,out34,out35,out36,out37);
            $display("  Row 4: %4d%4d%4d%4d%4d%4d%4d%4d",
                out40,out41,out42,out43,out44,out45,out46,out47);
            $display("  Row 5: %4d%4d%4d%4d%4d%4d%4d%4d",
                out50,out51,out52,out53,out54,out55,out56,out57);
            $display("  Row 6: %4d%4d%4d%4d%4d%4d%4d%4d",
                out60,out61,out62,out63,out64,out65,out66,out67);
            $display("  Row 7: %4d%4d%4d%4d%4d%4d%4d%4d",
                out70,out71,out72,out73,out74,out75,out76,out77);
            $display("────────────────────────────────────────────");
            $display("64 MAC units. One start signal. Full pipeline.");
            $display("This is Hyperion v0.6.");
            $finish;
        end
        last_done <= done;
    end

    initial begin
        clk=0; reset=1; start=0;
        last_done=0;
        a0=1; a1=2; a2=3; a3=4; a4=5; a5=6; a6=7; a7=8;
        w0=1; w1=2; w2=3; w3=4; w4=5; w5=6; w6=7; w7=8;
        #30 reset=0;
        #10 start=1;
        #10 start=0;
        #2000;
        $display("Timeout");
        $finish;
    end

endmodule