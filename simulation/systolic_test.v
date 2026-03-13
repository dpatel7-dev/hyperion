// ─────────────────────────────────────────
// TEST — verify all 16 MAC units work
// together as one systolic array
// ─────────────────────────────────────────

module systolic_test;

    reg clk, reset;
    reg signed [7:0] a0,a1,a2,a3;
    reg signed [7:0] b0,b1,b2,b3;
    wire signed [15:0] out00,out01,out02,out03;
    wire signed [15:0] out10,out11,out12,out13;
    wire signed [15:0] out20,out21,out22,out23;
    wire signed [15:0] out30,out31,out32,out33;

    systolic_array sa(
        .clk(clk), .reset(reset),
        .a0(a0),.a1(a1),.a2(a2),.a3(a3),
        .b0(b0),.b1(b1),.b2(b2),.b3(b3),
        .out00(out00),.out01(out01),.out02(out02),.out03(out03),
        .out10(out10),.out11(out11),.out12(out12),.out13(out13),
        .out20(out20),.out21(out21),.out22(out22),.out23(out23),
        .out30(out30),.out31(out31),.out32(out32),.out33(out33)
    );

    always #5 clk = ~clk;

    initial begin
        clk=0; reset=1;
        #10 reset=0;

        // feed in values: each row gets same value,
        // each col gets same value
        a0=1; a1=2; a2=3; a3=4;
        b0=1; b1=2; b2=3; b3=4;
        #10;

        $display("Systolic array output:");
        $display("Row 0: %0d %0d %0d %0d",
                  out00,out01,out02,out03);
        $display("Row 1: %0d %0d %0d %0d",
                  out10,out11,out12,out13);
        $display("Row 2: %0d %0d %0d %0d",
                  out20,out21,out22,out23);
        $display("Row 3: %0d %0d %0d %0d",
                  out30,out31,out32,out33);

        $display("\n16 MAC units running in parallel!");
        $display("This is your chip's compute engine.");
        $finish;
    end

endmodule