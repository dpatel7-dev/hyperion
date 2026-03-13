// ─────────────────────────────────────────
// HYPERION TOP v6 — full weight matrix
// 4 SRAM banks feed 4 columns of weights
// ─────────────────────────────────────────

module hyperion_top (
    input  clk,
    input  reset,
    input  start,
    input  signed [7:0] a0,a1,a2,a3,

    // 4 weight inputs — one per column
    input  signed [7:0] w0,w1,w2,w3,

    output done,
    output [2:0] state_out,
    output signed [15:0] out00,out01,out02,out03,
    output signed [15:0] out10,out11,out12,out13,
    output signed [15:0] out20,out21,out22,out23,
    output signed [15:0] out30,out31,out32,out33
);

    wire write_enable;
    wire compute_enable;
    wire [5:0] load_addr;
    reg [2:0] state_prev;
    reg compute_reset;

    // 4 weight snapshots — one per column
    reg signed [7:0] snap0,snap1,snap2,snap3;

    // raw outputs
    wire signed [15:0] raw00,raw01,raw02,raw03;
    wire signed [15:0] raw10,raw11,raw12,raw13;
    wire signed [15:0] raw20,raw21,raw22,raw23;
    wire signed [15:0] raw30,raw31,raw32,raw33;

    // output latches
    reg signed [15:0] lat00,lat01,lat02,lat03;
    reg signed [15:0] lat10,lat11,lat12,lat13;
    reg signed [15:0] lat20,lat21,lat22,lat23;
    reg signed [15:0] lat30,lat31,lat32,lat33;

    assign out00=lat00; assign out01=lat01;
    assign out02=lat02; assign out03=lat03;
    assign out10=lat10; assign out11=lat11;
    assign out12=lat12; assign out13=lat13;
    assign out20=lat20; assign out21=lat21;
    assign out22=lat22; assign out23=lat23;
    assign out30=lat30; assign out31=lat31;
    assign out32=lat32; assign out33=lat33;

    // ── CONTROLLER ──
    controller ctrl (
        .clk(clk),
        .reset(reset),
        .start(start),
        .write_enable(write_enable),
        .compute_enable(compute_enable),
        .done(done),
        .state_out(state_out),
        .load_addr(load_addr)
    );

    // capture all 4 weights during LOAD
    always @(posedge clk) begin
        if (write_enable) begin
            snap0 <= w0;
            snap1 <= w1;
            snap2 <= w2;
            snap3 <= w3;
        end
    end

    // reset logic
    always @(posedge clk) begin
        if (reset)
            compute_reset <= 1;
        else if (compute_enable)
            compute_reset <= 0;
        else if (!compute_enable && !write_enable)
            compute_reset <= 1;
    end

    // track previous state for latch trigger
    always @(posedge clk) begin
        state_prev <= state_out;
    end

    // latch on COMPUTE → OUTPUT transition
    always @(posedge clk) begin
        if (state_prev == 3'd2 && state_out == 3'd3) begin
            lat00<=raw00; lat01<=raw01;
            lat02<=raw02; lat03<=raw03;
            lat10<=raw10; lat11<=raw11;
            lat12<=raw12; lat13<=raw13;
            lat20<=raw20; lat21<=raw21;
            lat22<=raw22; lat23<=raw23;
            lat30<=raw30; lat31<=raw31;
            lat32<=raw32; lat33<=raw33;
        end
    end

    // ── SYSTOLIC ARRAY ──
    // each column gets its own weight
    systolic_array compute (
        .clk(clk),
        .reset(compute_reset),
        .a0(a0),.a1(a1),.a2(a2),.a3(a3),
        .b0(snap0),.b1(snap1),
        .b2(snap2),.b3(snap3),
        .out00(raw00),.out01(raw01),
        .out02(raw02),.out03(raw03),
        .out10(raw10),.out11(raw11),
        .out12(raw12),.out13(raw13),
        .out20(raw20),.out21(raw21),
        .out22(raw22),.out23(raw23),
        .out30(raw30),.out31(raw31),
        .out32(raw32),.out33(raw33)
    );

endmodule