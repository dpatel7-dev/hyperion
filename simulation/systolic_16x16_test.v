module systolic_16x16_test;

    reg clk, reset;
    reg signed [7:0] a0;
    reg signed [7:0] a1;
    reg signed [7:0] a2;
    reg signed [7:0] a3;
    reg signed [7:0] a4;
    reg signed [7:0] a5;
    reg signed [7:0] a6;
    reg signed [7:0] a7;
    reg signed [7:0] a8;
    reg signed [7:0] a9;
    reg signed [7:0] a10;
    reg signed [7:0] a11;
    reg signed [7:0] a12;
    reg signed [7:0] a13;
    reg signed [7:0] a14;
    reg signed [7:0] a15;
    reg signed [7:0] b0;
    reg signed [7:0] b1;
    reg signed [7:0] b2;
    reg signed [7:0] b3;
    reg signed [7:0] b4;
    reg signed [7:0] b5;
    reg signed [7:0] b6;
    reg signed [7:0] b7;
    reg signed [7:0] b8;
    reg signed [7:0] b9;
    reg signed [7:0] b10;
    reg signed [7:0] b11;
    reg signed [7:0] b12;
    reg signed [7:0] b13;
    reg signed [7:0] b14;
    reg signed [7:0] b15;

    wire signed [15:0] r0c0;
    wire signed [15:0] r0c1;
    wire signed [15:0] r0c2;
    wire signed [15:0] r0c3;
    wire signed [15:0] r0c4;
    wire signed [15:0] r0c5;
    wire signed [15:0] r0c6;
    wire signed [15:0] r0c7;
    wire signed [15:0] r0c8;
    wire signed [15:0] r0c9;
    wire signed [15:0] r0c10;
    wire signed [15:0] r0c11;
    wire signed [15:0] r0c12;
    wire signed [15:0] r0c13;
    wire signed [15:0] r0c14;
    wire signed [15:0] r0c15;
    wire signed [15:0] r1c0;
    wire signed [15:0] r1c1;
    wire signed [15:0] r1c2;
    wire signed [15:0] r1c3;
    wire signed [15:0] r1c4;
    wire signed [15:0] r1c5;
    wire signed [15:0] r1c6;
    wire signed [15:0] r1c7;
    wire signed [15:0] r1c8;
    wire signed [15:0] r1c9;
    wire signed [15:0] r1c10;
    wire signed [15:0] r1c11;
    wire signed [15:0] r1c12;
    wire signed [15:0] r1c13;
    wire signed [15:0] r1c14;
    wire signed [15:0] r1c15;
    wire signed [15:0] r2c0;
    wire signed [15:0] r2c1;
    wire signed [15:0] r2c2;
    wire signed [15:0] r2c3;
    wire signed [15:0] r2c4;
    wire signed [15:0] r2c5;
    wire signed [15:0] r2c6;
    wire signed [15:0] r2c7;
    wire signed [15:0] r2c8;
    wire signed [15:0] r2c9;
    wire signed [15:0] r2c10;
    wire signed [15:0] r2c11;
    wire signed [15:0] r2c12;
    wire signed [15:0] r2c13;
    wire signed [15:0] r2c14;
    wire signed [15:0] r2c15;
    wire signed [15:0] r3c0;
    wire signed [15:0] r3c1;
    wire signed [15:0] r3c2;
    wire signed [15:0] r3c3;
    wire signed [15:0] r3c4;
    wire signed [15:0] r3c5;
    wire signed [15:0] r3c6;
    wire signed [15:0] r3c7;
    wire signed [15:0] r3c8;
    wire signed [15:0] r3c9;
    wire signed [15:0] r3c10;
    wire signed [15:0] r3c11;
    wire signed [15:0] r3c12;
    wire signed [15:0] r3c13;
    wire signed [15:0] r3c14;
    wire signed [15:0] r3c15;
    wire signed [15:0] r4c0;
    wire signed [15:0] r4c1;
    wire signed [15:0] r4c2;
    wire signed [15:0] r4c3;
    wire signed [15:0] r4c4;
    wire signed [15:0] r4c5;
    wire signed [15:0] r4c6;
    wire signed [15:0] r4c7;
    wire signed [15:0] r4c8;
    wire signed [15:0] r4c9;
    wire signed [15:0] r4c10;
    wire signed [15:0] r4c11;
    wire signed [15:0] r4c12;
    wire signed [15:0] r4c13;
    wire signed [15:0] r4c14;
    wire signed [15:0] r4c15;
    wire signed [15:0] r5c0;
    wire signed [15:0] r5c1;
    wire signed [15:0] r5c2;
    wire signed [15:0] r5c3;
    wire signed [15:0] r5c4;
    wire signed [15:0] r5c5;
    wire signed [15:0] r5c6;
    wire signed [15:0] r5c7;
    wire signed [15:0] r5c8;
    wire signed [15:0] r5c9;
    wire signed [15:0] r5c10;
    wire signed [15:0] r5c11;
    wire signed [15:0] r5c12;
    wire signed [15:0] r5c13;
    wire signed [15:0] r5c14;
    wire signed [15:0] r5c15;
    wire signed [15:0] r6c0;
    wire signed [15:0] r6c1;
    wire signed [15:0] r6c2;
    wire signed [15:0] r6c3;
    wire signed [15:0] r6c4;
    wire signed [15:0] r6c5;
    wire signed [15:0] r6c6;
    wire signed [15:0] r6c7;
    wire signed [15:0] r6c8;
    wire signed [15:0] r6c9;
    wire signed [15:0] r6c10;
    wire signed [15:0] r6c11;
    wire signed [15:0] r6c12;
    wire signed [15:0] r6c13;
    wire signed [15:0] r6c14;
    wire signed [15:0] r6c15;
    wire signed [15:0] r7c0;
    wire signed [15:0] r7c1;
    wire signed [15:0] r7c2;
    wire signed [15:0] r7c3;
    wire signed [15:0] r7c4;
    wire signed [15:0] r7c5;
    wire signed [15:0] r7c6;
    wire signed [15:0] r7c7;
    wire signed [15:0] r7c8;
    wire signed [15:0] r7c9;
    wire signed [15:0] r7c10;
    wire signed [15:0] r7c11;
    wire signed [15:0] r7c12;
    wire signed [15:0] r7c13;
    wire signed [15:0] r7c14;
    wire signed [15:0] r7c15;
    wire signed [15:0] r8c0;
    wire signed [15:0] r8c1;
    wire signed [15:0] r8c2;
    wire signed [15:0] r8c3;
    wire signed [15:0] r8c4;
    wire signed [15:0] r8c5;
    wire signed [15:0] r8c6;
    wire signed [15:0] r8c7;
    wire signed [15:0] r8c8;
    wire signed [15:0] r8c9;
    wire signed [15:0] r8c10;
    wire signed [15:0] r8c11;
    wire signed [15:0] r8c12;
    wire signed [15:0] r8c13;
    wire signed [15:0] r8c14;
    wire signed [15:0] r8c15;
    wire signed [15:0] r9c0;
    wire signed [15:0] r9c1;
    wire signed [15:0] r9c2;
    wire signed [15:0] r9c3;
    wire signed [15:0] r9c4;
    wire signed [15:0] r9c5;
    wire signed [15:0] r9c6;
    wire signed [15:0] r9c7;
    wire signed [15:0] r9c8;
    wire signed [15:0] r9c9;
    wire signed [15:0] r9c10;
    wire signed [15:0] r9c11;
    wire signed [15:0] r9c12;
    wire signed [15:0] r9c13;
    wire signed [15:0] r9c14;
    wire signed [15:0] r9c15;
    wire signed [15:0] r10c0;
    wire signed [15:0] r10c1;
    wire signed [15:0] r10c2;
    wire signed [15:0] r10c3;
    wire signed [15:0] r10c4;
    wire signed [15:0] r10c5;
    wire signed [15:0] r10c6;
    wire signed [15:0] r10c7;
    wire signed [15:0] r10c8;
    wire signed [15:0] r10c9;
    wire signed [15:0] r10c10;
    wire signed [15:0] r10c11;
    wire signed [15:0] r10c12;
    wire signed [15:0] r10c13;
    wire signed [15:0] r10c14;
    wire signed [15:0] r10c15;
    wire signed [15:0] r11c0;
    wire signed [15:0] r11c1;
    wire signed [15:0] r11c2;
    wire signed [15:0] r11c3;
    wire signed [15:0] r11c4;
    wire signed [15:0] r11c5;
    wire signed [15:0] r11c6;
    wire signed [15:0] r11c7;
    wire signed [15:0] r11c8;
    wire signed [15:0] r11c9;
    wire signed [15:0] r11c10;
    wire signed [15:0] r11c11;
    wire signed [15:0] r11c12;
    wire signed [15:0] r11c13;
    wire signed [15:0] r11c14;
    wire signed [15:0] r11c15;
    wire signed [15:0] r12c0;
    wire signed [15:0] r12c1;
    wire signed [15:0] r12c2;
    wire signed [15:0] r12c3;
    wire signed [15:0] r12c4;
    wire signed [15:0] r12c5;
    wire signed [15:0] r12c6;
    wire signed [15:0] r12c7;
    wire signed [15:0] r12c8;
    wire signed [15:0] r12c9;
    wire signed [15:0] r12c10;
    wire signed [15:0] r12c11;
    wire signed [15:0] r12c12;
    wire signed [15:0] r12c13;
    wire signed [15:0] r12c14;
    wire signed [15:0] r12c15;
    wire signed [15:0] r13c0;
    wire signed [15:0] r13c1;
    wire signed [15:0] r13c2;
    wire signed [15:0] r13c3;
    wire signed [15:0] r13c4;
    wire signed [15:0] r13c5;
    wire signed [15:0] r13c6;
    wire signed [15:0] r13c7;
    wire signed [15:0] r13c8;
    wire signed [15:0] r13c9;
    wire signed [15:0] r13c10;
    wire signed [15:0] r13c11;
    wire signed [15:0] r13c12;
    wire signed [15:0] r13c13;
    wire signed [15:0] r13c14;
    wire signed [15:0] r13c15;
    wire signed [15:0] r14c0;
    wire signed [15:0] r14c1;
    wire signed [15:0] r14c2;
    wire signed [15:0] r14c3;
    wire signed [15:0] r14c4;
    wire signed [15:0] r14c5;
    wire signed [15:0] r14c6;
    wire signed [15:0] r14c7;
    wire signed [15:0] r14c8;
    wire signed [15:0] r14c9;
    wire signed [15:0] r14c10;
    wire signed [15:0] r14c11;
    wire signed [15:0] r14c12;
    wire signed [15:0] r14c13;
    wire signed [15:0] r14c14;
    wire signed [15:0] r14c15;
    wire signed [15:0] r15c0;
    wire signed [15:0] r15c1;
    wire signed [15:0] r15c2;
    wire signed [15:0] r15c3;
    wire signed [15:0] r15c4;
    wire signed [15:0] r15c5;
    wire signed [15:0] r15c6;
    wire signed [15:0] r15c7;
    wire signed [15:0] r15c8;
    wire signed [15:0] r15c9;
    wire signed [15:0] r15c10;
    wire signed [15:0] r15c11;
    wire signed [15:0] r15c12;
    wire signed [15:0] r15c13;
    wire signed [15:0] r15c14;
    wire signed [15:0] r15c15;

    systolic_array_16x16 sa(
        .clk(clk),.reset(reset),
        .a0(a0),
        .a1(a1),
        .a2(a2),
        .a3(a3),
        .a4(a4),
        .a5(a5),
        .a6(a6),
        .a7(a7),
        .a8(a8),
        .a9(a9),
        .a10(a10),
        .a11(a11),
        .a12(a12),
        .a13(a13),
        .a14(a14),
        .a15(a15),
        .b0(b0),
        .b1(b1),
        .b2(b2),
        .b3(b3),
        .b4(b4),
        .b5(b5),
        .b6(b6),
        .b7(b7),
        .b8(b8),
        .b9(b9),
        .b10(b10),
        .b11(b11),
        .b12(b12),
        .b13(b13),
        .b14(b14),
        .b15(b15),
        .r0c0(r0c0),
        .r0c1(r0c1),
        .r0c2(r0c2),
        .r0c3(r0c3),
        .r0c4(r0c4),
        .r0c5(r0c5),
        .r0c6(r0c6),
        .r0c7(r0c7),
        .r0c8(r0c8),
        .r0c9(r0c9),
        .r0c10(r0c10),
        .r0c11(r0c11),
        .r0c12(r0c12),
        .r0c13(r0c13),
        .r0c14(r0c14),
        .r0c15(r0c15),
        .r1c0(r1c0),
        .r1c1(r1c1),
        .r1c2(r1c2),
        .r1c3(r1c3),
        .r1c4(r1c4),
        .r1c5(r1c5),
        .r1c6(r1c6),
        .r1c7(r1c7),
        .r1c8(r1c8),
        .r1c9(r1c9),
        .r1c10(r1c10),
        .r1c11(r1c11),
        .r1c12(r1c12),
        .r1c13(r1c13),
        .r1c14(r1c14),
        .r1c15(r1c15),
        .r2c0(r2c0),
        .r2c1(r2c1),
        .r2c2(r2c2),
        .r2c3(r2c3),
        .r2c4(r2c4),
        .r2c5(r2c5),
        .r2c6(r2c6),
        .r2c7(r2c7),
        .r2c8(r2c8),
        .r2c9(r2c9),
        .r2c10(r2c10),
        .r2c11(r2c11),
        .r2c12(r2c12),
        .r2c13(r2c13),
        .r2c14(r2c14),
        .r2c15(r2c15),
        .r3c0(r3c0),
        .r3c1(r3c1),
        .r3c2(r3c2),
        .r3c3(r3c3),
        .r3c4(r3c4),
        .r3c5(r3c5),
        .r3c6(r3c6),
        .r3c7(r3c7),
        .r3c8(r3c8),
        .r3c9(r3c9),
        .r3c10(r3c10),
        .r3c11(r3c11),
        .r3c12(r3c12),
        .r3c13(r3c13),
        .r3c14(r3c14),
        .r3c15(r3c15),
        .r4c0(r4c0),
        .r4c1(r4c1),
        .r4c2(r4c2),
        .r4c3(r4c3),
        .r4c4(r4c4),
        .r4c5(r4c5),
        .r4c6(r4c6),
        .r4c7(r4c7),
        .r4c8(r4c8),
        .r4c9(r4c9),
        .r4c10(r4c10),
        .r4c11(r4c11),
        .r4c12(r4c12),
        .r4c13(r4c13),
        .r4c14(r4c14),
        .r4c15(r4c15),
        .r5c0(r5c0),
        .r5c1(r5c1),
        .r5c2(r5c2),
        .r5c3(r5c3),
        .r5c4(r5c4),
        .r5c5(r5c5),
        .r5c6(r5c6),
        .r5c7(r5c7),
        .r5c8(r5c8),
        .r5c9(r5c9),
        .r5c10(r5c10),
        .r5c11(r5c11),
        .r5c12(r5c12),
        .r5c13(r5c13),
        .r5c14(r5c14),
        .r5c15(r5c15),
        .r6c0(r6c0),
        .r6c1(r6c1),
        .r6c2(r6c2),
        .r6c3(r6c3),
        .r6c4(r6c4),
        .r6c5(r6c5),
        .r6c6(r6c6),
        .r6c7(r6c7),
        .r6c8(r6c8),
        .r6c9(r6c9),
        .r6c10(r6c10),
        .r6c11(r6c11),
        .r6c12(r6c12),
        .r6c13(r6c13),
        .r6c14(r6c14),
        .r6c15(r6c15),
        .r7c0(r7c0),
        .r7c1(r7c1),
        .r7c2(r7c2),
        .r7c3(r7c3),
        .r7c4(r7c4),
        .r7c5(r7c5),
        .r7c6(r7c6),
        .r7c7(r7c7),
        .r7c8(r7c8),
        .r7c9(r7c9),
        .r7c10(r7c10),
        .r7c11(r7c11),
        .r7c12(r7c12),
        .r7c13(r7c13),
        .r7c14(r7c14),
        .r7c15(r7c15),
        .r8c0(r8c0),
        .r8c1(r8c1),
        .r8c2(r8c2),
        .r8c3(r8c3),
        .r8c4(r8c4),
        .r8c5(r8c5),
        .r8c6(r8c6),
        .r8c7(r8c7),
        .r8c8(r8c8),
        .r8c9(r8c9),
        .r8c10(r8c10),
        .r8c11(r8c11),
        .r8c12(r8c12),
        .r8c13(r8c13),
        .r8c14(r8c14),
        .r8c15(r8c15),
        .r9c0(r9c0),
        .r9c1(r9c1),
        .r9c2(r9c2),
        .r9c3(r9c3),
        .r9c4(r9c4),
        .r9c5(r9c5),
        .r9c6(r9c6),
        .r9c7(r9c7),
        .r9c8(r9c8),
        .r9c9(r9c9),
        .r9c10(r9c10),
        .r9c11(r9c11),
        .r9c12(r9c12),
        .r9c13(r9c13),
        .r9c14(r9c14),
        .r9c15(r9c15),
        .r10c0(r10c0),
        .r10c1(r10c1),
        .r10c2(r10c2),
        .r10c3(r10c3),
        .r10c4(r10c4),
        .r10c5(r10c5),
        .r10c6(r10c6),
        .r10c7(r10c7),
        .r10c8(r10c8),
        .r10c9(r10c9),
        .r10c10(r10c10),
        .r10c11(r10c11),
        .r10c12(r10c12),
        .r10c13(r10c13),
        .r10c14(r10c14),
        .r10c15(r10c15),
        .r11c0(r11c0),
        .r11c1(r11c1),
        .r11c2(r11c2),
        .r11c3(r11c3),
        .r11c4(r11c4),
        .r11c5(r11c5),
        .r11c6(r11c6),
        .r11c7(r11c7),
        .r11c8(r11c8),
        .r11c9(r11c9),
        .r11c10(r11c10),
        .r11c11(r11c11),
        .r11c12(r11c12),
        .r11c13(r11c13),
        .r11c14(r11c14),
        .r11c15(r11c15),
        .r12c0(r12c0),
        .r12c1(r12c1),
        .r12c2(r12c2),
        .r12c3(r12c3),
        .r12c4(r12c4),
        .r12c5(r12c5),
        .r12c6(r12c6),
        .r12c7(r12c7),
        .r12c8(r12c8),
        .r12c9(r12c9),
        .r12c10(r12c10),
        .r12c11(r12c11),
        .r12c12(r12c12),
        .r12c13(r12c13),
        .r12c14(r12c14),
        .r12c15(r12c15),
        .r13c0(r13c0),
        .r13c1(r13c1),
        .r13c2(r13c2),
        .r13c3(r13c3),
        .r13c4(r13c4),
        .r13c5(r13c5),
        .r13c6(r13c6),
        .r13c7(r13c7),
        .r13c8(r13c8),
        .r13c9(r13c9),
        .r13c10(r13c10),
        .r13c11(r13c11),
        .r13c12(r13c12),
        .r13c13(r13c13),
        .r13c14(r13c14),
        .r13c15(r13c15),
        .r14c0(r14c0),
        .r14c1(r14c1),
        .r14c2(r14c2),
        .r14c3(r14c3),
        .r14c4(r14c4),
        .r14c5(r14c5),
        .r14c6(r14c6),
        .r14c7(r14c7),
        .r14c8(r14c8),
        .r14c9(r14c9),
        .r14c10(r14c10),
        .r14c11(r14c11),
        .r14c12(r14c12),
        .r14c13(r14c13),
        .r14c14(r14c14),
        .r14c15(r14c15),
        .r15c0(r15c0),
        .r15c1(r15c1),
        .r15c2(r15c2),
        .r15c3(r15c3),
        .r15c4(r15c4),
        .r15c5(r15c5),
        .r15c6(r15c6),
        .r15c7(r15c7),
        .r15c8(r15c8),
        .r15c9(r15c9),
        .r15c10(r15c10),
        .r15c11(r15c11),
        .r15c12(r15c12),
        .r15c13(r15c13),
        .r15c14(r15c14),
        .r15c15(r15c15)
    );

    always #5 clk = ~clk;

    initial begin
        clk=0; reset=1;
        #10 reset=0;

        a0=1;
        a1=2;
        a2=3;
        a3=4;
        a4=5;
        a5=6;
        a6=7;
        a7=8;
        a8=9;
        a9=10;
        a10=11;
        a11=12;
        a12=13;
        a13=14;
        a14=15;
        a15=16;
        b0=1;
        b1=2;
        b2=3;
        b3=4;
        b4=5;
        b5=6;
        b6=7;
        b7=8;
        b8=9;
        b9=10;
        b10=11;
        b11=12;
        b12=13;
        b13=14;
        b14=15;
        b15=16;
        #10;

        $display("16x16 Systolic Array — corner check:");
        $display("  r0c0   = %0d (expected 1)",   r0c0);
        $display("  r0c15  = %0d (expected 16)",  r0c15);
        $display("  r8c0   = %0d (expected 9)",   r8c0);
        $display("  r15c15 = %0d (expected 256)", r15c15);
        $display("  r7c7   = %0d (expected 64)",  r7c7);
        $display("");
        $display("256 MAC units running in parallel!");
        $display("Hyperion 16x16 — 4x the compute of v0.6");
        $finish;
    end

endmodule
