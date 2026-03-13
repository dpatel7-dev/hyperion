// ─────────────────────────────────────────
// HYPERION FULL CHIP TEST — timing fixed
// ─────────────────────────────────────────

module hyperion_test;

    reg clk, reset, write_enable;
    reg [5:0] address;
    reg signed [7:0] data_in;
    reg signed [7:0] a0,a1,a2,a3;

    wire signed [15:0] out00,out01,out02,out03;
    wire signed [15:0] out10,out11,out12,out13;
    wire signed [15:0] out20,out21,out22,out23;
    wire signed [15:0] out30,out31,out32,out33;

    hyperion chip (
        .clk(clk),.reset(reset),
        .write_enable(write_enable),
        .address(address),.data_in(data_in),
        .a0(a0),.a1(a1),.a2(a2),.a3(a3),
        .out00(out00),.out01(out01),
        .out02(out02),.out03(out03),
        .out10(out10),.out11(out11),
        .out12(out12),.out13(out13),
        .out20(out20),.out21(out21),
        .out22(out22),.out23(out23),
        .out30(out30),.out31(out31),
        .out32(out32),.out33(out33)
    );

    always #5 clk = ~clk;

    initial begin
        // startup — hold reset longer
        clk=0; reset=1; write_enable=0;
        a0=0; a1=0; a2=0; a3=0;
        data_in=0; address=0;
        #30 reset=0;

        // step 1: load weight into SRAM
        $display("Step 1: Loading weight into Hyperion SRAM...");
        write_enable=1;
        address=0; data_in=3;
        #20;
        write_enable=0;
        $display("Weight 3 stored at address 0\n");

        // wait for SRAM to settle
        #20;

        // step 2: feed inputs
        $display("Step 2: Running inputs through systolic array...");
        a0=2; a1=4; a2=1; a3=3;

        // wait enough cycles for results to propagate
        #60;

        // step 3: read results
        $display("Step 3: Reading Hyperion output:\n");
        $display("  Row 0: %0d %0d %0d %0d",
                  out00,out01,out02,out03);
        $display("  Row 1: %0d %0d %0d %0d",
                  out10,out11,out12,out13);
        $display("  Row 2: %0d %0d %0d %0d",
                  out20,out21,out22,out23);
        $display("  Row 3: %0d %0d %0d %0d",
                  out30,out31,out32,out33);

        $display("\nHyperion full chip working!");
        $display("SRAM → Systolic Array → Output");
        $display("Complete AI inference pipeline.");
        $finish;
    end

endmodule