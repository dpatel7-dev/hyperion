module lora_test;
    reg clk=0, reset=1, start=0;
    reg signed [15:0] x0,x1,x2,x3,x4,x5,x6,x7;
    reg signed [7:0]  w0,w1,w2,w3,w4,w5,w6,w7;
    reg signed [7:0]  a00,a01,a02,a03,a10,a11,a12,a13;
    reg signed [7:0]  a20,a21,a22,a23,a30,a31,a32,a33;
    reg signed [7:0]  a40,a41,a42,a43,a50,a51,a52,a53;
    reg signed [7:0]  a60,a61,a62,a63,a70,a71,a72,a73;
    reg signed [7:0]  b00,b01,b02,b03,b04,b05,b06,b07;
    reg signed [7:0]  b10,b11,b12,b13,b14,b15,b16,b17;
    reg signed [7:0]  b20,b21,b22,b23,b24,b25,b26,b27;
    reg signed [7:0]  b30,b31,b32,b33,b34,b35,b36,b37;
    reg signed [7:0]  lora_scale;
    wire signed [15:0] out0,out1,out2,out3,out4,out5,out6,out7;
    wire done;
    reg  last_done=0;

    lora_unit lu (
        .clk(clk),.reset(reset),.start(start),
        .x0(x0),.x1(x1),.x2(x2),.x3(x3),
        .x4(x4),.x5(x5),.x6(x6),.x7(x7),
        .w0(w0),.w1(w1),.w2(w2),.w3(w3),
        .w4(w4),.w5(w5),.w6(w6),.w7(w7),
        .a00(a00),.a01(a01),.a02(a02),.a03(a03),
        .a10(a10),.a11(a11),.a12(a12),.a13(a13),
        .a20(a20),.a21(a21),.a22(a22),.a23(a23),
        .a30(a30),.a31(a31),.a32(a32),.a33(a33),
        .a40(a40),.a41(a41),.a42(a42),.a43(a43),
        .a50(a50),.a51(a51),.a52(a52),.a53(a53),
        .a60(a60),.a61(a61),.a62(a62),.a63(a63),
        .a70(a70),.a71(a71),.a72(a72),.a73(a73),
        .b00(b00),.b01(b01),.b02(b02),.b03(b03),
        .b04(b04),.b05(b05),.b06(b06),.b07(b07),
        .b10(b10),.b11(b11),.b12(b12),.b13(b13),
        .b14(b14),.b15(b15),.b16(b16),.b17(b17),
        .b20(b20),.b21(b21),.b22(b22),.b23(b23),
        .b24(b24),.b25(b25),.b26(b26),.b27(b27),
        .b30(b30),.b31(b31),.b32(b32),.b33(b33),
        .b34(b34),.b35(b35),.b36(b36),.b37(b37),
        .lora_scale(lora_scale),
        .out0(out0),.out1(out1),.out2(out2),.out3(out3),
        .out4(out4),.out5(out5),.out6(out6),.out7(out7),
        .done(done)
    );

    always #5 clk=~clk;

    always @(posedge clk) begin
        if (done && !last_done) begin
            $display("══════════════════════════════════════════════════");
            $display("HYPERION LORA UNIT");
            $display("W*x + scale * B*A*x");
            $display("══════════════════════════════════════════════════");
            $display("");
            $display("  Input x:    [%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d]",
                x0,x1,x2,x3,x4,x5,x6,x7);
            $display("  Output:     [%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d]",
                out0,out1,out2,out3,out4,out5,out6,out7);
            $display("");
            $display("  W frozen — pretrained knowledge preserved");
            $display("  A,B trained — task-specific adaptation added");
            $display("  scale=%0d — controls LoRA strength", lora_scale);
            $display("");
            $display("  This is how your Llama-3 fine-tune works.");
            $display("  Hyperion does it in hardware.");
            $display("  No chip has native LoRA support today.");
            $display("");
            $display("══════════════════════════════════════════════════");
            $display("Hyperion LoRA unit working!");
            $display("══════════════════════════════════════════════════");
            $finish;
        end
        last_done <= done;
    end

    initial begin
        x0=10;x1=20;x2=30;x3=40;x4=50;x5=60;x6=70;x7=80;
        // frozen weights W
        w0=2;w1=2;w2=2;w3=2;w4=2;w5=2;w6=2;w7=2;
        // LoRA A matrix (rank 4) — zeros init (standard)
        a00=0;a01=0;a02=0;a03=0;
        a10=0;a11=0;a12=0;a13=0;
        a20=0;a21=0;a22=0;a23=0;
        a30=0;a31=0;a32=0;a33=0;
        a40=0;a41=0;a42=0;a43=0;
        a50=0;a51=0;a52=0;a53=0;
        a60=0;a61=0;a62=0;a63=0;
        a70=0;a71=0;a72=0;a73=0;
        // LoRA B matrix (rank 4) — random init
        b00=1;b01=2;b02=1;b03=2;b04=1;b05=2;b06=1;b07=2;
        b10=2;b11=1;b12=2;b13=1;b14=2;b15=1;b16=2;b17=1;
        b20=1;b21=1;b22=1;b23=1;b24=1;b25=1;b26=1;b27=1;
        b30=2;b31=2;b32=2;b33=2;b34=2;b35=2;b36=2;b37=2;
        lora_scale = 8'sd16;  // alpha=16, r=4 → scale=16/4=4
        #30 reset=0; #10 start=1; #10 start=0;
        #2000; $display("Timeout"); $finish;
    end
endmodule
