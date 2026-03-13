// ─────────────────────────────────────────
// HYPERION TOP TEST v6
// loads a full 4x4 weight matrix
// ─────────────────────────────────────────

module hyperion_top_test;

    reg clk, reset, start;
    reg signed [7:0] a0,a1,a2,a3;
    reg signed [7:0] w0,w1,w2,w3;

    wire done;
    wire [2:0] state_out;
    wire signed [15:0] out00,out01,out02,out03;
    wire signed [15:0] out10,out11,out12,out13;
    wire signed [15:0] out20,out21,out22,out23;
    wire signed [15:0] out30,out31,out32,out33;

    reg last_done;

    hyperion_top chip (
        .clk(clk),.reset(reset),.start(start),
        .a0(a0),.a1(a1),.a2(a2),.a3(a3),
        .w0(w0),.w1(w1),.w2(w2),.w3(w3),
        .done(done),
        .state_out(state_out),
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

    always @(posedge clk) begin
        if (done && !last_done) begin
            $display("\nHyperion — full matrix computation complete!");
            $display("────────────────────────────────────────");
            $display("Inputs:  a=[%0d,%0d,%0d,%0d]",a0,a1,a2,a3);
            $display("Weights: w=[%0d,%0d,%0d,%0d]",w0,w1,w2,w3);
            $display("────────────────────────────────────────");
            $display("Output matrix:");
            $display("  Row 0: %4d %4d %4d %4d",
                      out00,out01,out02,out03);
            $display("  Row 1: %4d %4d %4d %4d",
                      out10,out11,out12,out13);
            $display("  Row 2: %4d %4d %4d %4d",
                      out20,out21,out22,out23);
            $display("  Row 3: %4d %4d %4d %4d",
                      out30,out31,out32,out33);
            $display("────────────────────────────────────────");
            $display("Each column should scale by its weight.");
            $display("Col ratios should be 1:2:3:4");
            $display("Row ratios should be 1:2:3:4");
            $display("This is Hyperion running a full AI layer.");
            $finish;
        end
        last_done <= done;
    end

    initial begin
        clk=0; reset=1; start=0;
        last_done=0;

        // inputs: rows scale 1:2:3:4
        a0=1; a1=2; a2=3; a3=4;

        // weights: columns scale 1:2:3:4
        // so output[i][j] = a[i] * w[j] * cycles
        w0=1; w1=2; w2=3; w3=4;

        #30 reset=0;

        $display("Hyperion — full 4x4 weight matrix test");
        $display("Inputs:  [1,2,3,4]");
        $display("Weights: [1,2,3,4]");
        $display("Sending start...\n");

        #10 start=1;
        #10 start=0;

        #2000;
        $display("Timeout");
        $finish;
    end

endmodule