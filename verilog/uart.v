// ═════════════════════════════════════════════════════
// HYPERION UART — serial communication
// Lets Hyperion talk to your computer over USB
//
// UART = Universal Asynchronous Receiver/Transmitter
// The standard way chips talk to computers.
//
// At 100MHz clock, 115200 baud:
//   - RX: receives bytes from computer
//   - TX: sends bytes to computer
//
// This is how you send input to Hyperion
// and read the generated tokens back.
// ═════════════════════════════════════════════════════

module uart #(
    parameter CLK_FREQ  = 100_000_000,  // 100 MHz (Arty A7)
    parameter BAUD_RATE = 115_200
)(
    input  clk,
    input  reset,

    // ── TX: chip → computer ──
    input  [7:0]  tx_data,    // byte to send
    input         tx_start,   // pulse to begin sending
    output reg    tx_busy,    // high while sending
    output reg    tx_pin,     // physical UART TX wire

    // ── RX: computer → chip ──
    input         rx_pin,     // physical UART RX wire
    output reg [7:0] rx_data, // received byte
    output reg    rx_ready    // pulses high when byte received
);

    // clock cycles per bit
    localparam CYCLES_PER_BIT = CLK_FREQ / BAUD_RATE;  // 868 at 100MHz/115200

    // ─────────────────────────────────────
    // TRANSMITTER
    // ─────────────────────────────────────
    reg [3:0]  tx_state;
    reg [15:0] tx_counter;
    reg [2:0]  tx_bit_idx;
    reg [7:0]  tx_shift;

    localparam TX_IDLE  = 0, TX_START = 1, TX_DATA = 2, TX_STOP = 3;

    always @(posedge clk) begin
        if (reset) begin
            tx_state   <= TX_IDLE;
            tx_pin     <= 1'b1;   // idle high
            tx_busy    <= 1'b0;
            tx_counter <= 0;
            tx_bit_idx <= 0;
        end else begin
            case (tx_state)
                TX_IDLE: begin
                    tx_pin  <= 1'b1;
                    tx_busy <= 1'b0;
                    if (tx_start) begin
                        tx_shift <= tx_data;
                        tx_busy  <= 1'b1;
                        tx_state <= TX_START;
                        tx_counter <= 0;
                    end
                end
                TX_START: begin   // start bit = 0
                    tx_pin <= 1'b0;
                    if (tx_counter < CYCLES_PER_BIT - 1)
                        tx_counter <= tx_counter + 1;
                    else begin
                        tx_counter <= 0;
                        tx_bit_idx <= 0;
                        tx_state   <= TX_DATA;
                    end
                end
                TX_DATA: begin    // 8 data bits, LSB first
                    tx_pin <= tx_shift[tx_bit_idx];
                    if (tx_counter < CYCLES_PER_BIT - 1)
                        tx_counter <= tx_counter + 1;
                    else begin
                        tx_counter <= 0;
                        if (tx_bit_idx < 7)
                            tx_bit_idx <= tx_bit_idx + 1;
                        else
                            tx_state <= TX_STOP;
                    end
                end
                TX_STOP: begin    // stop bit = 1
                    tx_pin <= 1'b1;
                    if (tx_counter < CYCLES_PER_BIT - 1)
                        tx_counter <= tx_counter + 1;
                    else begin
                        tx_counter <= 0;
                        tx_state   <= TX_IDLE;
                        tx_busy    <= 1'b0;
                    end
                end
            endcase
        end
    end

    // ─────────────────────────────────────
    // RECEIVER
    // ─────────────────────────────────────
    reg [3:0]  rx_state;
    reg [15:0] rx_counter;
    reg [2:0]  rx_bit_idx;
    reg [7:0]  rx_shift;
    reg        rx_sync1, rx_sync2;  // synchronize async input

    localparam RX_IDLE = 0, RX_START = 1, RX_DATA = 2, RX_STOP = 3;

    // double-flop the async RX pin to avoid metastability
    always @(posedge clk) begin
        rx_sync1 <= rx_pin;
        rx_sync2 <= rx_sync1;
    end

    always @(posedge clk) begin
        if (reset) begin
            rx_state  <= RX_IDLE;
            rx_ready  <= 1'b0;
            rx_counter <= 0;
            rx_bit_idx <= 0;
        end else begin
            rx_ready <= 1'b0;  // default — pulse only for 1 cycle

            case (rx_state)
                RX_IDLE: begin
                    if (rx_sync2 == 1'b0) begin  // start bit detected
                        rx_state   <= RX_START;
                        rx_counter <= 0;
                    end
                end
                RX_START: begin
                    // wait half a bit to sample in the middle
                    if (rx_counter < (CYCLES_PER_BIT/2) - 1)
                        rx_counter <= rx_counter + 1;
                    else begin
                        rx_counter <= 0;
                        rx_bit_idx <= 0;
                        rx_state   <= RX_DATA;
                    end
                end
                RX_DATA: begin
                    if (rx_counter < CYCLES_PER_BIT - 1)
                        rx_counter <= rx_counter + 1;
                    else begin
                        rx_counter <= 0;
                        rx_shift[rx_bit_idx] <= rx_sync2;
                        if (rx_bit_idx < 7)
                            rx_bit_idx <= rx_bit_idx + 1;
                        else
                            rx_state <= RX_STOP;
                    end
                end
                RX_STOP: begin
                    if (rx_counter < CYCLES_PER_BIT - 1)
                        rx_counter <= rx_counter + 1;
                    else begin
                        rx_data  <= rx_shift;
                        rx_ready <= 1'b1;    // byte ready!
                        rx_state <= RX_IDLE;
                    end
                end
            endcase
        end
    end

endmodule
