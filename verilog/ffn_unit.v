// HYPERION FFN UNIT v2 — latched outputs
module ffn_unit (
    input  clk, input reset, input start,
    input  signed [15:0] x0,x1,x2,x3,x4,x5,x6,x7,
    input  signed [7:0]  w1_0,w1_1,w1_2,w1_3,w1_4,w1_5,w1_6,w1_7,
    input  signed [15:0] b1_0,b1_1,b1_2,b1_3,b1_4,b1_5,b1_6,b1_7,
    input  signed [7:0]  w2_0,w2_1,w2_2,w2_3,w2_4,w2_5,w2_6,w2_7,
    input  signed [15:0] b2_0,b2_1,b2_2,b2_3,b2_4,b2_5,b2_6,b2_7,
    output signed [15:0] out0,out1,out2,out3,out4,out5,out6,out7,
    output done
);
    reg [2:0] state;
    reg [5:0] cycle_count;
    parameter IDLE=0,LINEAR1=1,RELU=2,LINEAR2=3,LATCH=4,DONE=5;
    assign done = (state == DONE);

    always @(posedge clk) begin
        if (reset) begin state<=IDLE; cycle_count<=0; end
        else case (state)
            IDLE:    begin cycle_count<=0; if (start) state<=LINEAR1; end
            LINEAR1: begin cycle_count<=cycle_count+1; if (cycle_count>=6'd12) begin cycle_count<=0; state<=RELU; end end
            RELU:    begin cycle_count<=cycle_count+1; if (cycle_count>=6'd3)  begin cycle_count<=0; state<=LINEAR2; end end
            LINEAR2: begin cycle_count<=cycle_count+1; if (cycle_count>=6'd12) begin cycle_count<=0; state<=LATCH; end end
            LATCH:   begin cycle_count<=cycle_count+1; if (cycle_count>=6'd3)  begin cycle_count<=0; state<=DONE; end end
            DONE:    state<=IDLE;
        endcase
    end

    // ── layer 1: input dot W1 ──
    wire signed [31:0] l1r0 = x0*$signed(w1_0)+x1*$signed(w1_0)+x2*$signed(w1_0)+x3*$signed(w1_0)+x4*$signed(w1_0)+x5*$signed(w1_0)+x6*$signed(w1_0)+x7*$signed(w1_0);
    wire signed [31:0] l1r1 = x0*$signed(w1_1)+x1*$signed(w1_1)+x2*$signed(w1_1)+x3*$signed(w1_1)+x4*$signed(w1_1)+x5*$signed(w1_1)+x6*$signed(w1_1)+x7*$signed(w1_1);
    wire signed [31:0] l1r2 = x0*$signed(w1_2)+x1*$signed(w1_2)+x2*$signed(w1_2)+x3*$signed(w1_2)+x4*$signed(w1_2)+x5*$signed(w1_2)+x6*$signed(w1_2)+x7*$signed(w1_2);
    wire signed [31:0] l1r3 = x0*$signed(w1_3)+x1*$signed(w1_3)+x2*$signed(w1_3)+x3*$signed(w1_3)+x4*$signed(w1_3)+x5*$signed(w1_3)+x6*$signed(w1_3)+x7*$signed(w1_3);
    wire signed [31:0] l1r4 = x0*$signed(w1_4)+x1*$signed(w1_4)+x2*$signed(w1_4)+x3*$signed(w1_4)+x4*$signed(w1_4)+x5*$signed(w1_4)+x6*$signed(w1_4)+x7*$signed(w1_4);
    wire signed [31:0] l1r5 = x0*$signed(w1_5)+x1*$signed(w1_5)+x2*$signed(w1_5)+x3*$signed(w1_5)+x4*$signed(w1_5)+x5*$signed(w1_5)+x6*$signed(w1_5)+x7*$signed(w1_5);
    wire signed [31:0] l1r6 = x0*$signed(w1_6)+x1*$signed(w1_6)+x2*$signed(w1_6)+x3*$signed(w1_6)+x4*$signed(w1_6)+x5*$signed(w1_6)+x6*$signed(w1_6)+x7*$signed(w1_6);
    wire signed [31:0] l1r7 = x0*$signed(w1_7)+x1*$signed(w1_7)+x2*$signed(w1_7)+x3*$signed(w1_7)+x4*$signed(w1_7)+x5*$signed(w1_7)+x6*$signed(w1_7)+x7*$signed(w1_7);

    wire signed [15:0] l1b0 = l1r0[15:0] + b1_0;
    wire signed [15:0] l1b1 = l1r1[15:0] + b1_1;
    wire signed [15:0] l1b2 = l1r2[15:0] + b1_2;
    wire signed [15:0] l1b3 = l1r3[15:0] + b1_3;
    wire signed [15:0] l1b4 = l1r4[15:0] + b1_4;
    wire signed [15:0] l1b5 = l1r5[15:0] + b1_5;
    wire signed [15:0] l1b6 = l1r6[15:0] + b1_6;
    wire signed [15:0] l1b7 = l1r7[15:0] + b1_7;

    // ── relu ──
    wire signed [15:0] h0 = l1b0[15] ? 16'sd0 : l1b0;
    wire signed [15:0] h1 = l1b1[15] ? 16'sd0 : l1b1;
    wire signed [15:0] h2 = l1b2[15] ? 16'sd0 : l1b2;
    wire signed [15:0] h3 = l1b3[15] ? 16'sd0 : l1b3;
    wire signed [15:0] h4 = l1b4[15] ? 16'sd0 : l1b4;
    wire signed [15:0] h5 = l1b5[15] ? 16'sd0 : l1b5;
    wire signed [15:0] h6 = l1b6[15] ? 16'sd0 : l1b6;
    wire signed [15:0] h7 = l1b7[15] ? 16'sd0 : l1b7;

    // ── layer 2: hidden dot W2 ──
    wire signed [31:0] l2r0 = h0*$signed(w2_0)+h1*$signed(w2_0)+h2*$signed(w2_0)+h3*$signed(w2_0)+h4*$signed(w2_0)+h5*$signed(w2_0)+h6*$signed(w2_0)+h7*$signed(w2_0);
    wire signed [31:0] l2r1 = h0*$signed(w2_1)+h1*$signed(w2_1)+h2*$signed(w2_1)+h3*$signed(w2_1)+h4*$signed(w2_1)+h5*$signed(w2_1)+h6*$signed(w2_1)+h7*$signed(w2_1);
    wire signed [31:0] l2r2 = h0*$signed(w2_2)+h1*$signed(w2_2)+h2*$signed(w2_2)+h3*$signed(w2_2)+h4*$signed(w2_2)+h5*$signed(w2_2)+h6*$signed(w2_2)+h7*$signed(w2_2);
    wire signed [31:0] l2r3 = h0*$signed(w2_3)+h1*$signed(w2_3)+h2*$signed(w2_3)+h3*$signed(w2_3)+h4*$signed(w2_3)+h5*$signed(w2_3)+h6*$signed(w2_3)+h7*$signed(w2_3);
    wire signed [31:0] l2r4 = h0*$signed(w2_4)+h1*$signed(w2_4)+h2*$signed(w2_4)+h3*$signed(w2_4)+h4*$signed(w2_4)+h5*$signed(w2_4)+h6*$signed(w2_4)+h7*$signed(w2_4);
    wire signed [31:0] l2r5 = h0*$signed(w2_5)+h1*$signed(w2_5)+h2*$signed(w2_5)+h3*$signed(w2_5)+h4*$signed(w2_5)+h5*$signed(w2_5)+h6*$signed(w2_5)+h7*$signed(w2_5);
    wire signed [31:0] l2r6 = h0*$signed(w2_6)+h1*$signed(w2_6)+h2*$signed(w2_6)+h3*$signed(w2_6)+h4*$signed(w2_6)+h5*$signed(w2_6)+h6*$signed(w2_6)+h7*$signed(w2_6);
    wire signed [31:0] l2r7 = h0*$signed(w2_7)+h1*$signed(w2_7)+h2*$signed(w2_7)+h3*$signed(w2_7)+h4*$signed(w2_7)+h5*$signed(w2_7)+h6*$signed(w2_7)+h7*$signed(w2_7);

    // ── latch outputs at LATCH state ──
    reg signed [15:0] lat0,lat1,lat2,lat3,lat4,lat5,lat6,lat7;

    always @(posedge clk) begin
        if (reset) begin
            lat0<=0;lat1<=0;lat2<=0;lat3<=0;
            lat4<=0;lat5<=0;lat6<=0;lat7<=0;
        end else if (state==LATCH && cycle_count==0) begin
            lat0 <= l2r0[15:0] + b2_0;
            lat1 <= l2r1[15:0] + b2_1;
            lat2 <= l2r2[15:0] + b2_2;
            lat3 <= l2r3[15:0] + b2_3;
            lat4 <= l2r4[15:0] + b2_4;
            lat5 <= l2r5[15:0] + b2_5;
            lat6 <= l2r6[15:0] + b2_6;
            lat7 <= l2r7[15:0] + b2_7;
        end
    end

    assign out0=lat0; assign out1=lat1;
    assign out2=lat2; assign out3=lat3;
    assign out4=lat4; assign out5=lat5;
    assign out6=lat6; assign out7=lat7;

endmodule
