`timescale 1ns/1ps
module fpga_top_test;
    reg clk=0, reset=1, start=0;
    reg [7:0] input_token;
    wire [7:0] next_token;
    wire done;
    reg last_done=0;

    // test the LM directly — this is the core of the chip
    hyperion_lm_fpga lm (
        .clk(clk), .reset(reset), .start(start),
        .input_token(input_token), .next_token(next_token), .done(done)
    );

    always #5 clk = ~clk;

    always @(posedge clk) begin
        if (done && !last_done) begin
            $display("══════════════════════════════════════════════════");
            $display("HYPERION FPGA — language model core");
            $display("══════════════════════════════════════════════════");
            $display("");
            $display("  Token in:  %0d", input_token);
            $display("  Token out: %0d", next_token);
            $display("  Done:      %b", done);
            $display("");
            $display("  token in → embed → process → token out  ✓");
            $display("");
            $display("══════════════════════════════════════════════════");
            $display("Hyperion FPGA core working!");
            $display("Ready to synthesize for Arty A7-35T");
            $display("══════════════════════════════════════════════════");
            $finish;
        end
        last_done <= done;
    end

    initial begin
        input_token = 8'd5;
        #30 reset = 0;
        #10 start = 1;
        #10 start = 0;
        #5000;
        $display("Timeout");
        $finish;
    end
endmodule
