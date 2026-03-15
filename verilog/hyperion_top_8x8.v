// ─────────────────────────────────────────
// HYPERION TOP 8x8 — full chip v0.6
// Controller + SRAM + 8x8 Systolic Array
// 64 MAC units in autonomous pipeline
// ─────────────────────────────────────────

module hyperion_top_8x8 (
    input  clk,
    input  reset,
    input  start,
    input  signed [7:0] a0,a1,a2,a3,a4,a5,a6,a7,
    input  signed [7:0] w0,w1,w2,w3,w4,w5,w6,w7,
    output done,
    output [2:0] state_out,
    output signed [15:0] out00,out01,out02,out03,out04,out05,out06,out07,
    output signed [15:0] out10,out11,out12,out13,out14,out15,out16,out17,
    output signed [15:0] out20,out21,out22,out23,out24,out25,out26,out27,
    output signed [15:0] out30,out31,out32,out33,out34,out35,out36,out37,
    output signed [15:0] out40,out41,out42,out43,out44,out45,out46,out47,
    output signed [15:0] out50,out51,out52,out53,out54,out55,out56,out57,
    output signed [15:0] out60,out61,out62,out63,out64,out65,out66,out67,
    output signed [15:0] out70,out71,out72,out73,out74,out75,out76,out77
);

    wire write_enable;
    wire compute_enable;
    reg [2:0] state_prev;
    reg compute_reset;

    // 8 weight snapshots — one per column
    reg signed [7:0] snap0,snap1,snap2,snap3;
    reg signed [7:0] snap4,snap5,snap6,snap7;

    // raw outputs from systolic array
    wire signed [15:0] raw00,raw01,raw02,raw03,raw04,raw05,raw06,raw07;
    wire signed [15:0] raw10,raw11,raw12,raw13,raw14,raw15,raw16,raw17;
    wire signed [15:0] raw20,raw21,raw22,raw23,raw24,raw25,raw26,raw27;
    wire signed [15:0] raw30,raw31,raw32,raw33,raw34,raw35,raw36,raw37;
    wire signed [15:0] raw40,raw41,raw42,raw43,raw44,raw45,raw46,raw47;
    wire signed [15:0] raw50,raw51,raw52,raw53,raw54,raw55,raw56,raw57;
    wire signed [15:0] raw60,raw61,raw62,raw63,raw64,raw65,raw66,raw67;
    wire signed [15:0] raw70,raw71,raw72,raw73,raw74,raw75,raw76,raw77;

    // output latches
    reg signed [15:0] lat00,lat01,lat02,lat03,lat04,lat05,lat06,lat07;
    reg signed [15:0] lat10,lat11,lat12,lat13,lat14,lat15,lat16,lat17;
    reg signed [15:0] lat20,lat21,lat22,lat23,lat24,lat25,lat26,lat27;
    reg signed [15:0] lat30,lat31,lat32,lat33,lat34,lat35,lat36,lat37;
    reg signed [15:0] lat40,lat41,lat42,lat43,lat44,lat45,lat46,lat47;
    reg signed [15:0] lat50,lat51,lat52,lat53,lat54,lat55,lat56,lat57;
    reg signed [15:0] lat60,lat61,lat62,lat63,lat64,lat65,lat66,lat67;
    reg signed [15:0] lat70,lat71,lat72,lat73,lat74,lat75,lat76,lat77;

    // connect latches to outputs
    assign out00=lat00; assign out01=lat01; assign out02=lat02; assign out03=lat03;
    assign out04=lat04; assign out05=lat05; assign out06=lat06; assign out07=lat07;
    assign out10=lat10; assign out11=lat11; assign out12=lat12; assign out13=lat13;
    assign out14=lat14; assign out15=lat15; assign out16=lat16; assign out17=lat17;
    assign out20=lat20; assign out21=lat21; assign out22=lat22; assign out23=lat23;
    assign out24=lat24; assign out25=lat25; assign out26=lat26; assign out27=lat27;
    assign out30=lat30; assign out31=lat31; assign out32=lat32; assign out33=lat33;
    assign out34=lat34; assign out35=lat35; assign out36=lat36; assign out37=lat37;
    assign out40=lat40; assign out41=lat41; assign out42=lat42; assign out43=lat43;
    assign out44=lat44; assign out45=lat45; assign out46=lat46; assign out47=lat47;
    assign out50=lat50; assign out51=lat51; assign out52=lat52; assign out53=lat53;
    assign out54=lat54; assign out55=lat55; assign out56=lat56; assign out57=lat57;
    assign out60=lat60; assign out61=lat61; assign out62=lat62; assign out63=lat63;
    assign out64=lat64; assign out65=lat65; assign out66=lat66; assign out67=lat67;
    assign out70=lat70; assign out71=lat71; assign out72=lat72; assign out73=lat73;
    assign out74=lat74; assign out75=lat75; assign out76=lat76; assign out77=lat77;

    // ── CONTROLLER ──
    controller ctrl (
        .clk(clk),
        .reset(reset),
        .start(start),
        .write_enable(write_enable),
        .compute_enable(compute_enable),
        .done(done),
        .state_out(state_out),
        .load_addr()
    );

    // capture all 8 weights during LOAD
    always @(posedge clk) begin
        if (write_enable) begin
            snap0 <= w0; snap1 <= w1;
            snap2 <= w2; snap3 <= w3;
            snap4 <= w4; snap5 <= w5;
            snap6 <= w6; snap7 <= w7;
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
            lat00<=raw00; lat01<=raw01; lat02<=raw02; lat03<=raw03;
            lat04<=raw04; lat05<=raw05; lat06<=raw06; lat07<=raw07;
            lat10<=raw10; lat11<=raw11; lat12<=raw12; lat13<=raw13;
            lat14<=raw14; lat15<=raw15; lat16<=raw16; lat17<=raw17;
            lat20<=raw20; lat21<=raw21; lat22<=raw22; lat23<=raw23;
            lat24<=raw24; lat25<=raw25; lat26<=raw26; lat27<=raw27;
            lat30<=raw30; lat31<=raw31; lat32<=raw32; lat33<=raw33;
            lat34<=raw34; lat35<=raw35; lat36<=raw36; lat37<=raw37;
            lat40<=raw40; lat41<=raw41; lat42<=raw42; lat43<=raw43;
            lat44<=raw44; lat45<=raw45; lat46<=raw46; lat47<=raw47;
            lat50<=raw50; lat51<=raw51; lat52<=raw52; lat53<=raw53;
            lat54<=raw54; lat55<=raw55; lat56<=raw56; lat57<=raw57;
            lat60<=raw60; lat61<=raw61; lat62<=raw62; lat63<=raw63;
            lat64<=raw64; lat65<=raw65; lat66<=raw66; lat67<=raw67;
            lat70<=raw70; lat71<=raw71; lat72<=raw72; lat73<=raw73;
            lat74<=raw74; lat75<=raw75; lat76<=raw76; lat77<=raw77;
        end
    end

    // ── 8x8 SYSTOLIC ARRAY ──
    systolic_array_8x8 compute (
        .clk(clk),
        .reset(compute_reset),
        .a0(a0),.a1(a1),.a2(a2),.a3(a3),
        .a4(a4),.a5(a5),.a6(a6),.a7(a7),
        .b0(snap0),.b1(snap1),.b2(snap2),.b3(snap3),
        .b4(snap4),.b5(snap5),.b6(snap6),.b7(snap7),
        .out00(raw00),.out01(raw01),.out02(raw02),.out03(raw03),
        .out04(raw04),.out05(raw05),.out06(raw06),.out07(raw07),
        .out10(raw10),.out11(raw11),.out12(raw12),.out13(raw13),
        .out14(raw14),.out15(raw15),.out16(raw16),.out17(raw17),
        .out20(raw20),.out21(raw21),.out22(raw22),.out23(raw23),
        .out24(raw24),.out25(raw25),.out26(raw26),.out27(raw27),
        .out30(raw30),.out31(raw31),.out32(raw32),.out33(raw33),
        .out34(raw34),.out35(raw35),.out36(raw36),.out37(raw37),
        .out40(raw40),.out41(raw41),.out42(raw42),.out43(raw43),
        .out44(raw44),.out45(raw45),.out46(raw46),.out47(raw47),
        .out50(raw50),.out51(raw51),.out52(raw52),.out53(raw53),
        .out54(raw54),.out55(raw55),.out56(raw56),.out57(raw57),
        .out60(raw60),.out61(raw61),.out62(raw62),.out63(raw63),
        .out64(raw64),.out65(raw65),.out66(raw66),.out67(raw67),
        .out70(raw70),.out71(raw71),.out72(raw72),.out73(raw73),
        .out74(raw74),.out75(raw75),.out76(raw76),.out77(raw77)
    );

endmodule