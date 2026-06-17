// ═════════════════════════════════════════════════════
// HYPERION TOP — FPGA top-level wrapper
// Target: Arty A7-35T (Xilinx Artix-7)
//
// This is THE module loaded onto the FPGA.
// It connects:
//   computer → UART RX → Hyperion → UART TX → computer
//
// Flow:
//   1. Computer sends a starting token byte over USB
//   2. Hyperion runs its language model
//   3. Hyperion sends the generated token back over USB
//   4. LEDs show activity
//
// This makes Hyperion a real chip you can talk to.
// ═════════════════════════════════════════════════════

module hyperion_fpga_top (
    input  CLK100MHZ,      // 100MHz board clock
    input  ck_rst,         // reset button (active low on Arty)

    input  uart_txd_in,    // UART from computer (USB)
    output uart_rxd_out,   // UART to computer (USB)

    output [3:0] led,      // 4 status LEDs
    input  [3:0] sw        // 4 slide switches
);

    // ── reset: Arty button is active-low, invert it ──
    wire reset = ~ck_rst;

    // ── UART signals ──
    wire [7:0] rx_data;
    wire       rx_ready;
    reg  [7:0] tx_data;
    reg        tx_start;
    wire       tx_busy;

    uart #(.CLK_FREQ(100_000_000), .BAUD_RATE(115_200)) uart_inst (
        .clk(CLK100MHZ), .reset(reset),
        .tx_data(tx_data), .tx_start(tx_start),
        .tx_busy(tx_busy), .tx_pin(uart_rxd_out),
        .rx_pin(uart_txd_in),
        .rx_data(rx_data), .rx_ready(rx_ready)
    );

    // ─────────────────────────────────────
    // MAIN CONTROL STATE MACHINE
    // ─────────────────────────────────────
    reg [3:0]  state;
    reg [7:0]  input_token;
    reg [7:0]  output_token;
    reg [23:0] work_counter;

    localparam S_IDLE      = 0;  // wait for input byte
    localparam S_COMPUTE   = 1;  // run Hyperion
    localparam S_SEND      = 2;  // send result back
    localparam S_SEND_WAIT = 3;  // wait for TX done
    localparam S_DONE      = 4;

    // LED status indicator
    assign led[0] = (state == S_IDLE);      // ready
    assign led[1] = (state == S_COMPUTE);   // thinking
    assign led[2] = (state == S_SEND) || (state == S_SEND_WAIT); // sending
    assign led[3] = rx_ready;               // byte received flash

    always @(posedge CLK100MHZ) begin
        if (reset) begin
            state        <= S_IDLE;
            tx_start     <= 1'b0;
            tx_data      <= 8'h00;
            input_token  <= 8'h00;
            output_token <= 8'h00;
            work_counter <= 0;
        end else begin
            tx_start <= 1'b0;  // default low — pulse only when needed

            case (state)
                S_IDLE: begin
                    // wait for computer to send a starting token
                    if (rx_ready) begin
                        input_token <= rx_data;
                        work_counter <= 0;
                        state <= S_COMPUTE;
                    end
                end

                S_COMPUTE: begin
                    // run Hyperion language model
                    // (here we use the lm_start/lm_done handshake)
                    work_counter <= work_counter + 1;
                    if (lm_done) begin
                        output_token <= lm_next_token;
                        state <= S_SEND;
                    end
                    // safety timeout — don't hang forever
                    if (work_counter > 24'd10_000_000) begin
                        output_token <= input_token; // echo on timeout
                        state <= S_SEND;
                    end
                end

                S_SEND: begin
                    if (!tx_busy) begin
                        tx_data  <= output_token;
                        tx_start <= 1'b1;
                        state    <= S_SEND_WAIT;
                    end
                end

                S_SEND_WAIT: begin
                    // wait for transmission to finish
                    if (tx_busy == 1'b0 && tx_start == 1'b0)
                        state <= S_DONE;
                end

                S_DONE: begin
                    // ready for next token
                    state <= S_IDLE;
                end
            endcase
        end
    end

    // ─────────────────────────────────────
    // HYPERION LANGUAGE MODEL
    // ─────────────────────────────────────
    wire        lm_start = (state == S_COMPUTE && work_counter == 1);
    wire        lm_done;
    wire [7:0]  lm_next_token;

    hyperion_lm_fpga lm_inst (
        .clk(CLK100MHZ),
        .reset(reset || state == S_IDLE),
        .start(lm_start),
        .input_token(input_token),
        .next_token(lm_next_token),
        .done(lm_done)
    );

endmodule


// ═════════════════════════════════════════════════════
// HYPERION LM — FPGA-friendly language model wrapper
// Simplified single-token inference for the board
// token in → embedding → transformer → token out
// ═════════════════════════════════════════════════════

module hyperion_lm_fpga (
    input        clk,
    input        reset,
    input        start,
    input  [7:0] input_token,
    output [7:0] next_token,
    output       done
);

    reg [3:0]  state;
    reg [7:0]  cycle_count;
    reg [7:0]  token_out;

    localparam L_IDLE    = 0;
    localparam L_EMBED   = 1;
    localparam L_PROCESS = 2;
    localparam L_OUTPUT  = 3;
    localparam L_DONE    = 4;

    assign done = (state == L_DONE);
    assign next_token = token_out;

    // simple embedding: token value seeds the vector
    reg signed [15:0] vec0, vec1, vec2, vec3;

    always @(posedge clk) begin
        if (reset) begin
            state <= L_IDLE;
            cycle_count <= 0;
            token_out <= 0;
        end else begin
            case (state)
                L_IDLE: begin
                    cycle_count <= 0;
                    if (start) state <= L_EMBED;
                end
                L_EMBED: begin
                    // embed: derive a vector from the input token
                    vec0 <= input_token;
                    vec1 <= input_token + 8'd1;
                    vec2 <= input_token + 8'd2;
                    vec3 <= input_token + 8'd3;
                    state <= L_PROCESS;
                end
                L_PROCESS: begin
                    cycle_count <= cycle_count + 1;
                    // simplified transformer step
                    // (full version uses transformer_gpt2)
                    if (cycle_count >= 8'd10) begin
                        state <= L_OUTPUT;
                    end
                end
                L_OUTPUT: begin
                    // argmax: pick next token from processed vector
                    // simplified — real version uses output_projection
                    token_out <= (vec0 + vec1 + vec2 + vec3) >> 2;
                    state <= L_DONE;
                end
                L_DONE: begin
                    state <= L_IDLE;
                end
            endcase
        end
    end

endmodule
