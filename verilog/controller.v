// ─────────────────────────────────────────
// HYPERION CONTROLLER v2
// sequences through 16 weight addresses
// ─────────────────────────────────────────

module controller (
    input  clk,
    input  reset,
    input  start,
    output reg write_enable,
    output reg compute_enable,
    output reg done,
    output reg [2:0] state_out,
    output reg [5:0] load_addr  // current SRAM address being loaded
);

    parameter IDLE    = 3'd0;
    parameter LOAD    = 3'd1;
    parameter COMPUTE = 3'd2;
    parameter OUTPUT  = 3'd3;
    parameter DONE    = 3'd4;

    reg [2:0] state;
    reg [4:0] cycle_count;

    always @(posedge clk) begin
        if (reset) begin
            state          <= IDLE;
            write_enable   <= 0;
            compute_enable <= 0;
            done           <= 0;
            cycle_count    <= 0;
            load_addr      <= 0;
            state_out      <= IDLE;
        end
        else begin
            case (state)

                IDLE: begin
                    done           <= 0;
                    write_enable   <= 0;
                    compute_enable <= 0;
                    cycle_count    <= 0;
                    load_addr      <= 0;
                    if (start)
                        state <= LOAD;
                end

                LOAD: begin
                    write_enable   <= 1;
                    compute_enable <= 0;
                    cycle_count    <= cycle_count + 1;
                    load_addr      <= cycle_count[3:0]; // step address 0-15
                    if (cycle_count >= 5'd19) // 20 cycles to load 16 weights
                        state <= COMPUTE;
                end

                COMPUTE: begin
                    write_enable   <= 0;
                    compute_enable <= 1;
                    cycle_count    <= cycle_count + 1;
                    if (cycle_count >= 5'd23)
                        state <= OUTPUT;
                end

                OUTPUT: begin
                    write_enable   <= 0;
                    compute_enable <= 0;
                    cycle_count    <= cycle_count + 1;
                    if (cycle_count >= 5'd28)
                        state <= DONE;
                end

                DONE: begin
                    done  <= 1;
                    state <= IDLE;
                end

            endcase
            state_out <= state;
        end
    end

endmodule