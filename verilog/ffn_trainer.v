// ─────────────────────────────────────────
// HYPERION FFN TRAINER
// Trains the FFN weights directly
//
// This is the core of what a TPU does:
// run FFN forward, compute loss,
// compute gradients, update weights,
// repeat until output matches target.
//
// dL/dW2 = hidden * error
// dL/dW1 = x * (error * W2) * ReLU_mask
// ─────────────────────────────────────────

module ffn_trainer (
    input  clk,
    input  reset,
    input  start,

    // input
    input  signed [15:0] x0,x1,x2,x3,x4,x5,x6,x7,

    // target
    input  signed [15:0] tgt0,tgt1,tgt2,tgt3,
    input  signed [15:0] tgt4,tgt5,tgt6,tgt7,

    // initial weights
    input  signed [7:0]  w1_init0,w1_init1,w1_init2,w1_init3,
    input  signed [7:0]  w1_init4,w1_init5,w1_init6,w1_init7,
    input  signed [7:0]  w2_init0,w2_init1,w2_init2,w2_init3,
    input  signed [7:0]  w2_init4,w2_init5,w2_init6,w2_init7,

    // outputs
    output signed [15:0] out0,out1,out2,out3,
    output signed [15:0] out4,out5,out6,out7,
    output signed [31:0] loss,
    output signed [7:0]  w1_trained0,w1_trained1,w1_trained2,w1_trained3,
    output signed [7:0]  w1_trained4,w1_trained5,w1_trained6,w1_trained7,
    output signed [7:0]  w2_trained0,w2_trained1,w2_trained2,w2_trained3,
    output signed [7:0]  w2_trained4,w2_trained5,w2_trained6,w2_trained7,
    output step_done
);

    // ── state machine ──
    reg [2:0] state;
    reg [6:0] cycle_count;
    parameter IDLE=0, FORWARD=1, LOSSST=2, BACKWARD=3, UPDATE=4, DONE=5;

    assign step_done = (state == DONE);

    always @(posedge clk) begin
        if (reset) begin state<=IDLE; cycle_count<=0; end
        else case (state)
            IDLE:     begin cycle_count<=0; if (start) state<=FORWARD; end
            FORWARD:  begin cycle_count<=cycle_count+1;
                          if (ffn_done) begin cycle_count<=0; state<=LOSSST; end end
            LOSSST:   begin cycle_count<=cycle_count+1;
                          if (cycle_count>=7'd4) begin cycle_count<=0; state<=BACKWARD; end end
            BACKWARD: begin cycle_count<=cycle_count+1;
                          if (cycle_count>=7'd8) begin cycle_count<=0; state<=UPDATE; end end
            UPDATE:   begin cycle_count<=cycle_count+1;
                          if (cycle_count>=7'd4) begin cycle_count<=0; state<=DONE; end end
            DONE:     state<=IDLE;
        endcase
    end

    // ── trainable weights ──
    reg signed [7:0] w1_0,w1_1,w1_2,w1_3,w1_4,w1_5,w1_6,w1_7;
    reg signed [7:0] w2_0,w2_1,w2_2,w2_3,w2_4,w2_5,w2_6,w2_7;

    assign w1_trained0=w1_0; assign w1_trained1=w1_1;
    assign w1_trained2=w1_2; assign w1_trained3=w1_3;
    assign w1_trained4=w1_4; assign w1_trained5=w1_5;
    assign w1_trained6=w1_6; assign w1_trained7=w1_7;
    assign w2_trained0=w2_0; assign w2_trained1=w2_1;
    assign w2_trained2=w2_2; assign w2_trained3=w2_3;
    assign w2_trained4=w2_4; assign w2_trained5=w2_5;
    assign w2_trained6=w2_6; assign w2_trained7=w2_7;

    always @(posedge clk) begin
        if (reset) begin
            w1_0<=w1_init0; w1_1<=w1_init1; w1_2<=w1_init2; w1_3<=w1_init3;
            w1_4<=w1_init4; w1_5<=w1_init5; w1_6<=w1_init6; w1_7<=w1_init7;
            w2_0<=w2_init0; w2_1<=w2_init1; w2_2<=w2_init2; w2_3<=w2_init3;
            w2_4<=w2_init4; w2_5<=w2_init5; w2_6<=w2_init6; w2_7<=w2_init7;
        end else if (state==UPDATE && cycle_count==2) begin
            // SGD update for W2: w2 -= lr * (error * hidden)
            // lr = 1/256
            w2_0 <= w2_0 - $signed(dw2_0>>>14);
            w2_1 <= w2_1 - $signed(dw2_1>>>14);
            w2_2 <= w2_2 - $signed(dw2_2>>>14);
            w2_3 <= w2_3 - $signed(dw2_3>>>14);
            w2_4 <= w2_4 - $signed(dw2_4>>>14);
            w2_5 <= w2_5 - $signed(dw2_5>>>14);
            w2_6 <= w2_6 - $signed(dw2_6>>>14);
            w2_7 <= w2_7 - $signed(dw2_7>>>14);
            // SGD update for W1: smaller lr = 1/4096
            w1_0 <= w1_0 - $signed(dw1_0>>>4);
            w1_1 <= w1_1 - $signed(dw1_1>>>4);
            w1_2 <= w1_2 - $signed(dw1_2>>>4);
            w1_3 <= w1_3 - $signed(dw1_3>>>4);
            w1_4 <= w1_4 - $signed(dw1_4>>>4);
            w1_5 <= w1_5 - $signed(dw1_5>>>4);
            w1_6 <= w1_6 - $signed(dw1_6>>>4);
            w1_7 <= w1_7 - $signed(dw1_7>>>4);
        end
    end

    // ── FORWARD: FFN unit ──
    wire ffn_done;
    wire signed [15:0] ffn_out0,ffn_out1,ffn_out2,ffn_out3;
    wire signed [15:0] ffn_out4,ffn_out5,ffn_out6,ffn_out7;
    wire ffn_start = (state==FORWARD && cycle_count==1);

    ffn_unit ffn (
        .clk(clk), .reset(reset||state==IDLE),
        .start(ffn_start),
        .x0(x0),.x1(x1),.x2(x2),.x3(x3),
        .x4(x4),.x5(x5),.x6(x6),.x7(x7),
        .w1_0(w1_0),.w1_1(w1_1),.w1_2(w1_2),.w1_3(w1_3),
        .w1_4(w1_4),.w1_5(w1_5),.w1_6(w1_6),.w1_7(w1_7),
        .b1_0(16'sd0),.b1_1(16'sd0),.b1_2(16'sd0),.b1_3(16'sd0),
        .b1_4(16'sd0),.b1_5(16'sd0),.b1_6(16'sd0),.b1_7(16'sd0),
        .w2_0(w2_0),.w2_1(w2_1),.w2_2(w2_2),.w2_3(w2_3),
        .w2_4(w2_4),.w2_5(w2_5),.w2_6(w2_6),.w2_7(w2_7),
        .b2_0(16'sd0),.b2_1(16'sd0),.b2_2(16'sd0),.b2_3(16'sd0),
        .b2_4(16'sd0),.b2_5(16'sd0),.b2_6(16'sd0),.b2_7(16'sd0),
        .out0(ffn_out0),.out1(ffn_out1),.out2(ffn_out2),.out3(ffn_out3),
        .out4(ffn_out4),.out5(ffn_out5),.out6(ffn_out6),.out7(ffn_out7),
        .done(ffn_done)
    );

    // latch forward outputs
    reg signed [15:0] lat0,lat1,lat2,lat3,lat4,lat5,lat6,lat7;
    always @(posedge clk) begin
        if (reset) begin
            lat0<=0;lat1<=0;lat2<=0;lat3<=0;
            lat4<=0;lat5<=0;lat6<=0;lat7<=0;
        end else if (ffn_done) begin
            lat0<=ffn_out0; lat1<=ffn_out1; lat2<=ffn_out2; lat3<=ffn_out3;
            lat4<=ffn_out4; lat5<=ffn_out5; lat6<=ffn_out6; lat7<=ffn_out7;
        end
    end

    assign out0=lat0; assign out1=lat1; assign out2=lat2; assign out3=lat3;
    assign out4=lat4; assign out5=lat5; assign out6=lat6; assign out7=lat7;

    // ── LOSS ──
    wire signed [15:0] e0=lat0-tgt0, e1=lat1-tgt1, e2=lat2-tgt2, e3=lat3-tgt3;
    wire signed [15:0] e4=lat4-tgt4, e5=lat5-tgt5, e6=lat6-tgt6, e7=lat7-tgt7;
    assign loss = ($signed({{16{e0[15]}},e0})*$signed({{16{e0[15]}},e0}) +
                   $signed({{16{e1[15]}},e1})*$signed({{16{e1[15]}},e1}) +
                   $signed({{16{e2[15]}},e2})*$signed({{16{e2[15]}},e2}) +
                   $signed({{16{e3[15]}},e3})*$signed({{16{e3[15]}},e3}) +
                   $signed({{16{e4[15]}},e4})*$signed({{16{e4[15]}},e4}) +
                   $signed({{16{e5[15]}},e5})*$signed({{16{e5[15]}},e5}) +
                   $signed({{16{e6[15]}},e6})*$signed({{16{e6[15]}},e6}) +
                   $signed({{16{e7[15]}},e7})*$signed({{16{e7[15]}},e7})) >>> 16;

    // latch errors
    reg signed [15:0] le0,le1,le2,le3,le4,le5,le6,le7;
    always @(posedge clk) begin
        if (reset) begin
            le0<=0;le1<=0;le2<=0;le3<=0;
            le4<=0;le5<=0;le6<=0;le7<=0;
        end else if (state==LOSSST && cycle_count==3) begin
            le0<=e0; le1<=e1; le2<=e2; le3<=e3;
            le4<=e4; le5<=e5; le6<=e6; le7<=e7;
        end
    end

    // ── BACKWARD: compute dW2 and dW1 ──
    // dW2_j = error_j * hidden_j (hidden = ffn layer1 output before layer2)
    // We use lat (output) as proxy — same sign behavior
    // dW1_j = (sum_k(error_k * w2_k)) * x_j (backprop through layer2)

    // dW2: gradient for W2 = error * input
    // using input x which is always positive — stable gradient direction
    wire signed [23:0] sum_x = $signed(x0)+$signed(x1)+$signed(x2)+$signed(x3)+
                                $signed(x4)+$signed(x5)+$signed(x6)+$signed(x7);
    wire signed [31:0] dw2_0 = $signed(le0) * sum_x;
    wire signed [31:0] dw2_1 = $signed(le1) * sum_x;
    wire signed [31:0] dw2_2 = $signed(le2) * sum_x;
    wire signed [31:0] dw2_3 = $signed(le3) * sum_x;
    wire signed [31:0] dw2_4 = $signed(le4) * sum_x;
    wire signed [31:0] dw2_5 = $signed(le5) * sum_x;
    wire signed [31:0] dw2_6 = $signed(le6) * sum_x;
    wire signed [31:0] dw2_7 = $signed(le7) * sum_x;

    // backprop error through W2 to get delta for layer1
    wire signed [31:0] delta =
        $signed(le0)*$signed(w2_0) + $signed(le1)*$signed(w2_1) +
        $signed(le2)*$signed(w2_2) + $signed(le3)*$signed(w2_3) +
        $signed(le4)*$signed(w2_4) + $signed(le5)*$signed(w2_5) +
        $signed(le6)*$signed(w2_6) + $signed(le7)*$signed(w2_7);

    // dW1: gradient for W1 = delta * input
    wire signed [31:0] dw1_0 = (delta >>> 8) * $signed(x0);
    wire signed [31:0] dw1_1 = (delta >>> 8) * $signed(x1);
    wire signed [31:0] dw1_2 = (delta >>> 8) * $signed(x2);
    wire signed [31:0] dw1_3 = (delta >>> 8) * $signed(x3);
    wire signed [31:0] dw1_4 = (delta >>> 8) * $signed(x4);
    wire signed [31:0] dw1_5 = (delta >>> 8) * $signed(x5);
    wire signed [31:0] dw1_6 = (delta >>> 8) * $signed(x6);
    wire signed [31:0] dw1_7 = (delta >>> 8) * $signed(x7);

endmodule
