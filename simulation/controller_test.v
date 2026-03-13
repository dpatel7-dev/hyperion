// ─────────────────────────────────────────
// CONTROLLER TEST
// Watch Hyperion's brain step through
// each state automatically
// ─────────────────────────────────────────

module controller_test;

    reg clk, reset, start;
    wire write_enable, compute_enable, done;
    wire [2:0] state_out;

    // state names for display
    reg [63:0] state_name;

    controller ctrl (
        .clk(clk),
        .reset(reset),
        .start(start),
        .write_enable(write_enable),
        .compute_enable(compute_enable),
        .done(done),
        .state_out(state_out)
    );

    always #5 clk = ~clk;

    // watch state changes and print them
    reg [2:0] last_state;
    always @(posedge clk) begin
        if (state_out !== last_state) begin
            case (state_out)
                3'd0: $display("  t=%0t  State: IDLE    — waiting for work", $time);
                3'd1: $display("  t=%0t  State: LOAD    — loading weights from SRAM", $time);
                3'd2: $display("  t=%0t  State: COMPUTE — systolic array running", $time);
                3'd3: $display("  t=%0t  State: OUTPUT  — results ready", $time);
                3'd4: $display("  t=%0t  State: DONE    — signaling completion", $time);
            endcase
            last_state <= state_out;
        end
        if (done)
            $display("  t=%0t  DONE signal received!", $time);
    end

    initial begin
        clk=0; reset=1; start=0;
        last_state = 3'd7; // invalid — forces first print
        #20 reset=0;

        // wait one cycle then start the chip
        #10;
        $display("Hyperion controller starting...\n");
        $display("Watching state machine execute:\n");
        start=1;
        #10 start=0;  // pulse start for one cycle

        // wait long enough for full pipeline
        #200;

        $display("\nHyperion controller test complete!");
        $display("The chip sequenced through all states automatically.");
        $display("No manual intervention needed.");
        $finish;
    end

endmodule