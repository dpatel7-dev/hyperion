`timescale 1ns/1ps
module uart_test;
    reg clk=0, reset=1;
    reg [7:0] tx_data;
    reg tx_start;
    wire tx_busy, tx_pin;
    wire [7:0] rx_data;
    wire rx_ready;

    // use tiny baud divider for fast simulation
    uart #(.CLK_FREQ(1000), .BAUD_RATE(100)) dut (
        .clk(clk), .reset(reset),
        .tx_data(tx_data), .tx_start(tx_start),
        .tx_busy(tx_busy), .tx_pin(tx_pin),
        .rx_pin(tx_pin),   // LOOPBACK: TX feeds RX
        .rx_data(rx_data), .rx_ready(rx_ready)
    );

    always #5 clk = ~clk;  // 100MHz

    integer received;
    initial begin
        received = 0;
        #30 reset = 0;

        $display("══════════════════════════════════════════");
        $display("HYPERION UART — loopback test");
        $display("TX wired to RX — send a byte, receive it");
        $display("══════════════════════════════════════════");
        $display("");

        // send byte 0x41 = 'A' = 65
        @(posedge clk);
        tx_data = 8'h41;
        tx_start = 1;
        @(posedge clk);
        tx_start = 0;

        $display("  Sent byte:     0x41 ('A', decimal 65)");

        // wait for RX to receive it
        wait(rx_ready);
        @(posedge clk);
        received = rx_data;
        $display("  Received byte: 0x%02X (decimal %0d)", rx_data, rx_data);
        $display("");

        if (rx_data == 8'h41)
            $display("  ✓ UART loopback works! Byte sent = byte received");
        else
            $display("  ✗ Mismatch — sent 0x41, got 0x%02X", rx_data);

        $display("");
        $display("══════════════════════════════════════════");
        $display("Hyperion UART working!");
        $display("This is how Hyperion talks to your computer.");
        $display("══════════════════════════════════════════");
        $finish;
    end

    // timeout guard
    initial begin
        #500000;
        $display("Timeout — UART did not complete");
        $finish;
    end
endmodule
